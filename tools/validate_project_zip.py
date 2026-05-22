#!/usr/bin/env python3
"""Validate a TraceBench Project ZIP file or extracted project directory."""
from __future__ import annotations

import json
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VALIDATE_EVENTS = ROOT / "tools" / "validate_events_jsonl.py"
EVENTS_SCHEMA = ROOT / "schemas" / "events.schema.json"
REQUIRED_FILES = [
    "manifest.json",
    "events.jsonl",
    "known_facts.json",
    "metadata/schema_versions.json",
    "exports/customer_report.md",
]


def _load_json(path: Path, *, label: str, errors: list[str]) -> dict | None:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        errors.append(f"missing {label}: {path}")
        return None
    except json.JSONDecodeError as exc:
        errors.append(f"invalid JSON in {label}: {path}: {exc}")
        return None
    if not isinstance(data, dict):
        errors.append(f"{label} must be object: {path}")
        return None
    return data


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


def _validate_manifest(manifest_path: Path, errors: list[str]) -> bool:
    manifest = _load_json(manifest_path, label="manifest.json", errors=errors)
    if manifest is None:
        return False
    missing = [key for key in ("project_id", "schema_version", "created_at") if key not in manifest]
    if missing:
        errors.append(f"manifest.json missing required fields: {', '.join(missing)}")
        return False
    return True


def _validate_known_facts(known_facts_path: Path, errors: list[str]) -> bool:
    known_facts = _load_json(known_facts_path, label="known_facts.json", errors=errors)
    return known_facts is not None


def _validate_metadata(metadata_path: Path, errors: list[str]) -> bool:
    metadata = _load_json(metadata_path, label="metadata/schema_versions.json", errors=errors)
    return metadata is not None


def _validate_paths(base: Path, errors: list[str], in_zip: bool = False) -> list[str]:
    if in_zip:
        with zipfile.ZipFile(base, "r") as zf:
            names = {name.rstrip("/") for name in zf.namelist()}
    else:
        names = {str(p.relative_to(base)).replace("\\", "/") for p in base.rglob("*") if p.is_file()}

    missing = [path for path in REQUIRED_FILES if path not in names]
    if missing:
        errors.extend(f"missing required path: {path}" for path in missing)

    if not any(name.startswith("device_profiles/") or name == "device_profiles" for name in names):
        errors.append("missing required path: device_profiles/")

    return names if not missing else []


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
            with zipfile.ZipFile(path, "r") as zf:
                zf.extractall(temp_path)
            _validate_paths(temp_path, errors)
            if errors:
                for error in errors:
                    print(f"[ERROR] {error}")
                print(f"[FAIL] {path} validation FAILED")
                return 1

            manifest_path = temp_path / "manifest.json"
            events_path = temp_path / "events.jsonl"
            known_facts_path = temp_path / "known_facts.json"
            metadata_path = temp_path / "metadata" / "schema_versions.json"

            if not _validate_manifest(manifest_path, errors):
                pass
            if not _validate_known_facts(known_facts_path, errors):
                pass
            if not _validate_metadata(metadata_path, errors):
                pass
            if not _run_events_validation(events_path, errors):
                pass

            if errors:
                for error in errors:
                    print(f"[ERROR] {error}")
                print(f"[FAIL] {path} validation FAILED")
                return 1

            print(f"[OK] {path} validation PASSED")
            return 0
    else:
        if not path.is_dir():
            print(f"[ERROR] expected zip or directory, got: {path}")
            return 2
        _validate_paths(path, errors)
        if errors:
            for error in errors:
                print(f"[ERROR] {error}")
            print(f"[FAIL] {path} validation FAILED")
            return 1
        manifest_path = path / "manifest.json"
        events_path = path / "events.jsonl"
        known_facts_path = path / "known_facts.json"
        metadata_path = path / "metadata" / "schema_versions.json"

        if not _validate_manifest(manifest_path, errors):
            pass
        if not _validate_known_facts(known_facts_path, errors):
            pass
        if not _validate_metadata(metadata_path, errors):
            pass
        if not _run_events_validation(events_path, errors):
            pass

        if errors:
            for error in errors:
                print(f"[ERROR] {error}")
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
