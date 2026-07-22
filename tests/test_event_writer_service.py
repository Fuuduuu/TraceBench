import json
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from tools.event_writer_service import (
    EventAppendError,
    EventValidationError,
    EventWriterError,
    EventWriterService,
    IdempotencyConflictError,
    LockConflictError,
    append_v2_event,
)


V2_SCHEMA_VERSION = "2.0-draft"


def _v2_measurement_payload(**overrides):
    payload = {
        "measurement_id": "meas_900001",
        "measured_at": "2026-06-06T10:00:00Z",
        "target": {
            "target_kind": "component_pin",
            "target_key": "component:Q2:pin:1",
            "display_label": "Q2.1",
            "component_id": "Q2",
            "pin_id": "Q2.1",
        },
        "reading": {
            "mode": "voltage",
            "value": 3.3,
            "unit": "V",
            "display_value": "3.3 V",
        },
        "value_provenance": {
            "measured_value_source": "human_entered",
            "entry_method": "typed",
            "human_verified_as_own_reading": True,
            "context_values_visible": [],
        },
        "conditions": {"power_state": "on"},
    }
    payload.update(overrides)
    return payload


def _v2_component_payload(**overrides):
    payload = {
        "component_id": "Q2",
        "label": "Q2",
        "component_kind": "unknown",
        "created_context": "human_added_from_measure_sheet",
    }
    payload.update(overrides)
    return payload


def _v2_board_outline_payload(**overrides):
    payload = {
        "coordinate_space": "board_normalized",
        "outer_polygon": [
            {"x": 0.1, "y": 0.1},
            {"x": 0.9, "y": 0.1},
            {"x": 0.9, "y": 0.8},
            {"x": 0.1, "y": 0.8},
        ],
    }
    payload.update(overrides)
    return payload


def _v2_event(
    event_id="evt_900001",
    event_type="measurement_recorded",
    payload=None,
    *,
    project_id="prj_writer_test",
    client_operation_id="op_writer_001",
    created_at="2026-06-06T10:00:01Z",
    actor_type="human",
    source_type="explicit_user_confirmation",
    confirmed=True,
    **relations,
):
    return {
        "schema_version": V2_SCHEMA_VERSION,
        "event_id": event_id,
        "event_type": event_type,
        "created_at": created_at,
        "project_id": project_id,
        "client_operation_id": client_operation_id,
        "actor": {"type": actor_type, "actor_id": "local_user"},
        "source": {
            "type": source_type,
            "surface": "writer_service_test",
            "action": event_type,
        },
        "confirmation": {
            "confirmed": confirmed,
            "confirmed_at": created_at,
            "label": "confirmed",
        },
        "payload": payload if payload is not None else _v2_measurement_payload(),
        **relations,
    }


def _read_events(path: Path):
    if not path.exists():
        return []
    return [
        json.loads(line)
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]


class EventWriterServiceTests(unittest.TestCase):
    def test_valid_board_outline_append_and_idempotency(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            candidate = _v2_event(
                event_type="board_outline_confirmed",
                payload=_v2_board_outline_payload(
                    physical_width_mm=120.5,
                    physical_height_mm=76.25,
                ),
            )

            first = append_v2_event(events_path, candidate)
            second = append_v2_event(events_path, candidate)

            self.assertTrue(first.appended)
            self.assertFalse(second.appended)
            self.assertEqual(second.status, "existing")
            self.assertEqual(_read_events(events_path), [candidate])

    def test_invalid_board_outline_rejected_before_append(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            events_path.write_text("", encoding="utf-8")
            candidate = _v2_event(
                event_type="board_outline_confirmed",
                payload=_v2_board_outline_payload(
                    outer_polygon=[
                        {"x": 0.1, "y": 0.1},
                        {"x": 0.9, "y": 0.8},
                        {"x": 0.1, "y": 0.8},
                        {"x": 0.9, "y": 0.1},
                    ]
                ),
            )

            with self.assertRaises(EventValidationError):
                append_v2_event(events_path, candidate)

            self.assertEqual(events_path.read_text(encoding="utf-8"), "")

    def test_valid_v2_event_append(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            candidate = _v2_event()

            result = append_v2_event(events_path, candidate)

            self.assertTrue(result.appended)
            self.assertEqual(result.status, "appended")
            self.assertEqual(_read_events(events_path), [candidate])

    def test_invalid_event_rejected_before_append(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            events_path.write_text("", encoding="utf-8")
            candidate = _v2_event(actor_type="ai")

            with self.assertRaises(EventValidationError):
                append_v2_event(events_path, candidate)

            self.assertEqual(events_path.read_text(encoding="utf-8"), "")

    def test_append_only_preserves_existing_events(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            existing = _v2_event(
                event_id="evt_900001",
                event_type="component_created",
                payload=_v2_component_payload(),
                client_operation_id="op_writer_001",
            )
            original_line = json.dumps(existing, sort_keys=True, separators=(",", ":"))
            events_path.write_text(original_line + "\n", encoding="utf-8")
            candidate = _v2_event(
                event_id="evt_900002",
                event_type="component_updated",
                payload={
                    "component_id": "Q2",
                    "changes": [
                        {
                            "field": "label",
                            "old_value_observed": "Q2",
                            "new_value": "Q2 inspected",
                            "change_kind": "replace",
                        }
                    ],
                    "edit_reason": "human_label_clarity",
                },
                client_operation_id="op_writer_002",
                created_at="2026-06-06T10:01:00Z",
            )

            append_v2_event(events_path, candidate)

            lines = events_path.read_text(encoding="utf-8").splitlines()
            self.assertEqual(lines[0], original_line)
            self.assertEqual(_read_events(events_path), [existing, candidate])

    def test_idempotent_duplicate_operation_returns_existing_without_append(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            existing = _v2_event(event_id="evt_900001")
            append_v2_event(events_path, existing)
            duplicate = _v2_event(
                event_id="evt_900002",
                created_at="2026-06-06T10:00:02Z",
            )

            result = append_v2_event(events_path, duplicate)

            self.assertFalse(result.appended)
            self.assertEqual(result.status, "existing")
            self.assertEqual(result.event, existing)
            self.assertEqual(_read_events(events_path), [existing])

    def test_same_client_operation_id_with_different_payload_rejects_conflict(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            existing = _v2_event(event_id="evt_900001")
            append_v2_event(events_path, existing)
            conflict = _v2_event(
                event_id="evt_900002",
                payload=_v2_measurement_payload(
                    value=5.0,
                    display_value="5.0 V",
                ),
            )

            with self.assertRaises(IdempotencyConflictError):
                append_v2_event(events_path, conflict)

            self.assertEqual(_read_events(events_path), [existing])

    def test_repeated_call_produces_one_event(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            candidate = _v2_event()

            append_v2_event(events_path, candidate)
            append_v2_event(events_path, candidate)

            self.assertEqual(_read_events(events_path), [candidate])

    def test_retry_after_failed_append_can_succeed(self):
        class FailingOnceWriter(EventWriterService):
            failed = False

            def _append_event_line(self, event_line: str) -> None:
                if not self.failed:
                    self.failed = True
                    raise OSError("simulated append failure")
                super()._append_event_line(event_line)

        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            candidate = _v2_event()

            with self.assertRaises(EventAppendError):
                FailingOnceWriter(events_path).append(candidate)
            self.assertEqual(_read_events(events_path), [])

            result = append_v2_event(events_path, candidate)

            self.assertTrue(result.appended)
            self.assertEqual(_read_events(events_path), [candidate])

    def test_lock_single_writer_guard_rejects_conflict(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            lock_path = Path(f"{events_path}.lock")
            lock_path.write_text("held\n", encoding="utf-8")

            with self.assertRaises(LockConflictError):
                append_v2_event(events_path, _v2_event())

            self.assertEqual(_read_events(events_path), [])
            self.assertTrue(lock_path.exists())

    def test_readback_verification_returns_appended_event(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            candidate = _v2_event()

            result = append_v2_event(events_path, candidate)

            self.assertEqual(result.event, candidate)
            self.assertEqual(_read_events(events_path)[-1], candidate)

    def test_existing_v1_project_remains_compatible(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            sample_path = Path("samples/pelle_pv20_minimal/events.jsonl")
            original = sample_path.read_text(encoding="utf-8")
            events_path.write_text(original, encoding="utf-8")
            candidate = _v2_event(
                event_id="evt_900001",
                project_id="pelle_pv20_minimal",
                client_operation_id="op_writer_legacy_001",
            )

            append_v2_event(events_path, candidate)

            lines = events_path.read_text(encoding="utf-8").splitlines()
            self.assertEqual(lines[: len(original.splitlines())], original.splitlines())
            self.assertEqual(_read_events(events_path)[-1], candidate)

    def test_helper_authored_event_not_appended(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            candidate = _v2_event(actor_type="helper")

            with self.assertRaises(EventValidationError):
                append_v2_event(events_path, candidate)

            self.assertEqual(_read_events(events_path), [])

    def test_forbidden_artifacts_are_not_generated(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir)
            events_path = project_dir / "events.jsonl"

            append_v2_event(events_path, _v2_event())

            self.assertFalse((project_dir / "board_graph.json").exists())
            self.assertFalse((project_dir / "view_state.json").exists())
            self.assertFalse((project_dir / "known_facts.json").exists())

    def test_writer_rejects_non_events_jsonl_target(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            target = Path(tmpdir) / "known_facts.json"

            with self.assertRaises(EventWriterError):
                append_v2_event(target, _v2_event())


if __name__ == "__main__":
    unittest.main()
