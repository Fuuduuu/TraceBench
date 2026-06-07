#!/usr/bin/env python3
"""Append-only V2 canonical event writer service."""
from __future__ import annotations

import json
import os
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
VALIDATE_EVENTS = ROOT / "tools" / "validate_events_jsonl.py"


class EventWriterError(Exception):
    """Base writer-service failure."""


class EventValidationError(EventWriterError):
    """Candidate event or resulting stream failed existing validation."""


class IdempotencyConflictError(EventWriterError):
    """A client operation ID was reused for a different operation payload."""


class LockConflictError(EventWriterError):
    """The project event stream is already locked for writing."""


class EventAppendError(EventWriterError):
    """The durable append did not complete."""


class AppendVerificationError(EventWriterError):
    """Append completed, but readback validation could not prove success."""


@dataclass(frozen=True)
class EventWriteResult:
    status: str
    event: dict
    events_path: Path
    appended: bool


class _EventFileLock:
    def __init__(self, events_path: Path) -> None:
        self.events_path = events_path
        self.lock_path = Path(f"{events_path}.lock")
        self._fd: int | None = None

    def __enter__(self) -> "_EventFileLock":
        flags = os.O_CREAT | os.O_EXCL | os.O_WRONLY
        try:
            self._fd = os.open(str(self.lock_path), flags)
        except FileExistsError as exc:
            raise LockConflictError(f"event writer lock is already held: {self.lock_path}") from exc
        with os.fdopen(self._fd, "w", encoding="utf-8") as handle:
            self._fd = None
            handle.write(f"pid={os.getpid()}\n")
            handle.flush()
            os.fsync(handle.fileno())
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        if self._fd is not None:
            os.close(self._fd)
            self._fd = None
        try:
            self.lock_path.unlink()
        except FileNotFoundError:
            pass


def _canonical_json(value: object) -> str:
    return json.dumps(value, sort_keys=True, ensure_ascii=False, separators=(",", ":"))


def _operation_fingerprint(event: dict) -> str:
    # Idempotent retries may regenerate transport/event metadata. The operation
    # comparison keeps the human-confirmed payload, actor/source/confirmation
    # decision, project, event type, schema, and relation fields stable.
    normalized = {
        key: value
        for key, value in event.items()
        if key not in {"event_id", "created_at"}
    }
    confirmation = normalized.get("confirmation")
    if isinstance(confirmation, dict):
        normalized = dict(normalized)
        normalized["confirmation"] = {
            key: value
            for key, value in confirmation.items()
            if key != "confirmed_at"
        }
    return _canonical_json(normalized)


class EventWriterService:
    def __init__(self, events_path: Path | str) -> None:
        self.events_path = Path(events_path)

    def append(self, candidate_event: dict) -> EventWriteResult:
        if not isinstance(candidate_event, dict):
            raise EventValidationError("candidate event must be an object")
        self._ensure_canonical_target()

        existing_events = self._load_events()
        existing_event = self._idempotent_existing_event(existing_events, candidate_event)
        if existing_event is not None:
            return EventWriteResult(
                status="existing",
                event=existing_event,
                events_path=self.events_path,
                appended=False,
            )

        self._validate_stream_with_candidate(existing_events, candidate_event)

        with _EventFileLock(self.events_path):
            locked_events = self._load_events()
            existing_event = self._idempotent_existing_event(locked_events, candidate_event)
            if existing_event is not None:
                return EventWriteResult(
                    status="existing",
                    event=existing_event,
                    events_path=self.events_path,
                    appended=False,
                )

            self._validate_stream_with_candidate(locked_events, candidate_event)
            event_line = _canonical_json(candidate_event)
            try:
                self._append_event_line(event_line)
            except OSError as exc:
                raise EventAppendError(f"failed to append event to {self.events_path}: {exc}") from exc

            appended_event = self._verify_readback(candidate_event)
            return EventWriteResult(
                status="appended",
                event=appended_event,
                events_path=self.events_path,
                appended=True,
            )

    def _ensure_canonical_target(self) -> None:
        if self.events_path.name != "events.jsonl":
            raise EventWriterError(f"writer target must be events.jsonl, got {self.events_path.name!r}")
        if not self.events_path.parent.exists():
            raise EventWriterError(f"project directory does not exist: {self.events_path.parent}")

    def _load_events(self) -> list[dict]:
        if not self.events_path.exists():
            return []
        events: list[dict] = []
        for line_no, line in enumerate(self.events_path.read_text(encoding="utf-8").splitlines(), start=1):
            if not line.strip():
                continue
            try:
                event = json.loads(line)
            except json.JSONDecodeError as exc:
                raise EventValidationError(f"existing events.jsonl has invalid JSON at line {line_no}: {exc}") from exc
            if not isinstance(event, dict):
                raise EventValidationError(f"existing events.jsonl line {line_no} is not an object")
            events.append(event)
        return events

    def _idempotent_existing_event(self, existing_events: list[dict], candidate_event: dict) -> dict | None:
        operation_id = candidate_event.get("client_operation_id")
        if not isinstance(operation_id, str) or not operation_id:
            return None
        for event in existing_events:
            if event.get("client_operation_id") != operation_id:
                continue
            if _operation_fingerprint(event) != _operation_fingerprint(candidate_event):
                raise IdempotencyConflictError(
                    f"client_operation_id {operation_id!r} already exists with different payload"
                )
            return event
        return None

    def _validate_stream_with_candidate(self, existing_events: list[dict], candidate_event: dict) -> None:
        with tempfile.NamedTemporaryFile(mode="w", suffix=".jsonl", delete=False, encoding="utf-8") as handle:
            temp_path = Path(handle.name)
            for event in existing_events:
                handle.write(_canonical_json(event) + "\n")
            handle.write(_canonical_json(candidate_event) + "\n")
        try:
            result = subprocess.run(
                [sys.executable, str(VALIDATE_EVENTS), str(temp_path)],
                cwd=str(ROOT),
                text=True,
                capture_output=True,
            )
        finally:
            try:
                temp_path.unlink()
            except FileNotFoundError:
                pass
        if result.returncode != 0:
            detail = (result.stdout + result.stderr).strip()
            raise EventValidationError(detail or "candidate event failed validation")

    def _validate_current_stream(self) -> None:
        result = subprocess.run(
            [sys.executable, str(VALIDATE_EVENTS), str(self.events_path)],
            cwd=str(ROOT),
            text=True,
            capture_output=True,
        )
        if result.returncode != 0:
            detail = (result.stdout + result.stderr).strip()
            raise AppendVerificationError(detail or "events.jsonl failed readback validation")

    def _append_event_line(self, event_line: str) -> None:
        needs_leading_newline = False
        if self.events_path.exists() and self.events_path.stat().st_size > 0:
            with self.events_path.open("rb") as handle:
                handle.seek(-1, os.SEEK_END)
                needs_leading_newline = handle.read(1) != b"\n"

        payload = event_line.encode("utf-8") + b"\n"
        if needs_leading_newline:
            payload = b"\n" + payload

        with self.events_path.open("ab") as handle:
            handle.write(payload)
            handle.flush()
            os.fsync(handle.fileno())

    def _verify_readback(self, candidate_event: dict) -> dict:
        events = self._load_events()
        if not events:
            raise AppendVerificationError("events.jsonl is empty after append")
        appended_event = events[-1]
        if _canonical_json(appended_event) != _canonical_json(candidate_event):
            raise AppendVerificationError("last event in events.jsonl does not match candidate event")
        self._validate_current_stream()
        return appended_event


def append_v2_event(events_path: Path | str, candidate_event: dict) -> EventWriteResult:
    return EventWriterService(events_path).append(candidate_event)


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: event_writer_service.py <events.jsonl> <candidate_event.json>")
        return 2
    candidate_path = Path(sys.argv[2])
    try:
        candidate = json.loads(candidate_path.read_text(encoding="utf-8"))
        result = append_v2_event(Path(sys.argv[1]), candidate)
    except EventWriterError as exc:
        print(f"[ERROR] {exc}")
        return 1
    except (OSError, json.JSONDecodeError) as exc:
        print(f"[ERROR] {exc}")
        return 1
    print(f"[OK] {result.status}: {result.event.get('event_id')}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
