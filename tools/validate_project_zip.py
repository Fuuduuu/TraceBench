#!/usr/bin/env python3
"""Validate a TraceBench Project ZIP file or extracted project directory."""
from __future__ import annotations

import json
import os
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MATERIALIZE_SCRIPT = ROOT / "tools" / "materialize_known_facts.py"
VALIDATE_EVENTS = ROOT / "tools" / "validate_events_jsonl.py"
EVENTS_SCHEMA = ROOT / "schemas" / "events.schema.json"
REQUIRED_FILES = [
    "manifest.json",
    "events.jsonl",
    "known_facts.json",
    "metadata/schema_versions.json",
    "exports/customer_report.md",
]
FORBIDDEN_PATH_PARTS = {".git", ".codex", "__pycache__", ".env", "logs"}


def _safe_member_name(name: str) -> bool:
    if not name:
        return False
    if name.startswith(("/", "\\")):
        return False
    normalized = name.replace("\\", "/")
    parts = Path(normalized).parts
    if ".." in parts:
        return False
    if any(part in FORBIDDEN_PATH_PARTS for part in parts):
        return False
    return True


def _safe_extract_member(zf: zipfile.ZipFile, member: zipfile.ZipInfo, destination: Path) -> bool:
    if not _safe_member_name(member.filename):
        return False
    raw_name = member.filename.replace("\\", "/")
    target = (destination / raw_name).resolve()
    if not str(target).startswith(str(destination.resolve()) + os.sep):
        return False

    if member.is_dir() or raw_name.endswith("/"):
        target.mkdir(parents=True, exist_ok=True)
        return True

    target.parent.mkdir(parents=True, exist_ok=True)
    with zf.open(member) as source, target.open("wb") as output:
        output.write(source.read())
    return True


def _run_json_load(path: Path, label: str, errors: list[str]) -> dict | None:
    try:
        payload = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        errors.append(f"missing {label}: {path}")
        return None
    except json.JSONDecodeError as exc:
        errors.append(f"invalid JSON in {label}: {path}: {exc}")
        return None
    if not isinstance(payload, dict):
        errors.append(f"{label} must be object: {path}")
        return None
    return payload


def _run_events_validation(events_path: Path, errors: list[str]) -> bool:
    result = subprocess.run(
        [sys.executable, str(VALIDATE_EVENTS), str(events_path), str(EVENTS_SCHEMA)],
        cwd=str(ROOT),
        text=True,
    )
    if result.returncode != 0:
        errors.append("events.jsonl failed validation")
        return False
    return True


def _validate_manifest(manifest: dict | None, errors: list[str]) -> str | None:
    if manifest is None:
        return None
    required = {"project_id", "schema_version", "created_at"}
    missing = sorted(required - set(manifest))
    if missing:
        errors.append(f"manifest.json missing required fields: {', '.join(missing)}")
        return None
    return manifest.get("project_id")


def _validate_known_facts(base: Path, errors: list[str]) -> dict | None:
    return _run_json_load(base / "known_facts.json", "known_facts.json", errors)


def _validate_metadata(base: Path, errors: list[str]) -> bool:
    return _run_json_load(base / "metadata" / "schema_versions.json", "metadata/schema_versions.json", errors) is not None


def _validate_paths(names: set[str], errors: list[str]) -> bool:
    missing = [path for path in REQUIRED_FILES if path not in names]
    if missing:
        errors.extend(f"missing required path: {path}" for path in sorted(missing))
        return False
    if not any(name.startswith("device_profiles/") for name in names):
        errors.append("missing required path: device_profiles/")
        return False
    return True


def _validate_project_directory(base_path: Path, errors: list[str]) -> bool:
    names = {
        str(path.relative_to(base_path)).replace("\\", "/")
        for path in base_path.rglob("*")
        if path.is_file()
    }
    if not _validate_paths(names, errors):
        return False

    manifest = _run_json_load(base_path / "manifest.json", "manifest.json", errors)
    manifest_project_id = _validate_manifest(manifest, errors)
    if not _run_events_validation(base_path / "events.jsonl", errors):
        pass
    _validate_known_facts(base_path, errors)
    if not _validate_metadata(base_path, errors):
        pass
    if manifest_project_id is not None:
        _validate_project_id_consistency(base_path, manifest_project_id, errors)
        _regenerated_known_facts_matches(base_path, errors)
    return not errors


def _canonical_json(value: object) -> str:
    return json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False)


def _project_id_from_events(base: Path) -> list[str]:
    ids = []
    seen = set()
    for line in (base / "events.jsonl").read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        project_id = event.get("project_id")
        if isinstance(project_id, str) and project_id not in seen:
            seen.add(project_id)
            ids.append(project_id)
    return ids


def _validate_project_id_consistency(base: Path, manifest_project_id: str | None, errors: list[str]) -> bool:
    if manifest_project_id is None:
        return False

    manifest_and_events = {manifest_project_id}
    for project_id in _project_id_from_events(base):
        manifest_and_events.add(project_id)

    known_facts = _run_json_load(base / "known_facts.json", "known_facts.json", errors)
    if known_facts is None:
        return False
    known_project_id = known_facts.get("project_id")
    if isinstance(known_project_id, str):
        manifest_and_events.add(known_project_id)

    if len(manifest_and_events) != 1:
        errors.append("project_id mismatch across manifest, events, and known_facts.json")
        return False
    return True


def _regenerated_known_facts_matches(base: Path, errors: list[str]) -> bool:
    with tempfile.TemporaryDirectory() as temp_dir:
        generated_path = Path(temp_dir) / "known_facts.json"
        result = subprocess.run(
            [sys.executable, str(MATERIALIZE_SCRIPT), str(base / "events.jsonl"), str(generated_path)],
            cwd=str(ROOT),
            text=True,
        )
        if result.returncode != 0:
            errors.append("unable to regenerate known_facts.json for validation")
            return False
        generated = _run_json_load(generated_path, "generated known_facts", errors)
        provided = _run_json_load(base / "known_facts.json", "known_facts.json", errors)
        if generated is None or provided is None:
            return False
        if _canonical_json(generated) != _canonical_json(provided):
            errors.append("known_facts.json does not match materialization output")
            return False
    return True


def _extract_zip_to_temp(zip_path: Path, destination: Path, errors: list[str]) -> bool:
    try:
        with zipfile.ZipFile(zip_path, "r") as zf:
            member_names = set()
            for member in zf.infolist():
                if not _safe_member_name(member.filename):
                    errors.append(f"rejected unsafe zip member: {member.filename}")
                    return False
                if not _safe_extract_member(zf, member, destination):
                    errors.append(f"rejected unsafe extraction target for: {member.filename}")
                    return False
                member_names.add(member.filename.rstrip("/"))
            if not _validate_paths(member_names, errors):
                return False
    except zipfile.BadZipFile:
        errors.append(f"invalid zip file: {zip_path}")
        return False
    return True


def validate_project_zip(source: Path) -> int:
    if not source.exists():
        print(f"[ERROR] missing project zip or directory: {source}")
        return 2

    errors: list[str] = []
    path = source.resolve()
    is_zip = path.is_file() and path.suffix.lower() == ".zip"

    if is_zip:
        if not zipfile.is_zipfile(path):
            print(f"[ERROR] not a valid zip: {path}")
            return 2
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            if not _extract_zip_to_temp(path, temp_path, errors):
                for message in errors:
                    print(f"[ERROR] {message}")
                print(f"[FAIL] {path} validation FAILED")
                return 1
            if not _validate_project_directory(temp_path, errors):
                for message in errors:
                    print(f"[ERROR] {message}")
                print(f"[FAIL] {path} validation FAILED")
                return 1
            print(f"[OK] {source} validation PASSED")
            return 0
    else:
        if not path.is_dir():
            print(f"[ERROR] expected zip or directory, got: {path}")
            return 2
        if not _validate_project_directory(path, errors):
            for message in errors:
                print(f"[ERROR] {message}")
            print(f"[FAIL] {source} validation FAILED")
            return 1
        print(f"[OK] {source} validation PASSED")
        return 0


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: python tools/validate_project_zip.py <project_zip_or_dir>")
        return 2
    return validate_project_zip(Path(sys.argv[1]))


if __name__ == "__main__":
    raise SystemExit(main())
