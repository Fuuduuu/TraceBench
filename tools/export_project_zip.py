#!/usr/bin/env python3
"""Export a TraceBench project directory into a deterministic V1 Project ZIP."""
from __future__ import annotations

import subprocess
import sys
import zipfile
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[1]
MATERIALIZE_SCRIPT = ROOT / "tools" / "materialize_known_facts.py"
REPO_DEVICE_PROFILES = ROOT / "device_profiles"

DEFAULT_SCHEMA_VERSIONS = {
    "events_schema": "1.0",
    "known_facts_schema": "1.0",
    "project_manifest_schema": "1.0",
    "project_zip_contract": "1.0",
}

REQUIRED_INPUT_FILES = (
    "manifest.json",
    "events.jsonl",
)
FORBIDDEN_EXPORT_FILES = {"board_graph.json", "view_state.json"}

EXCLUDED_DIR_PARTS = {".git", ".codex", ".tracebench_local", "__pycache__", "logs"}


def _is_excluded_path(path: Path, base: Path) -> bool:
    rel_parts = path.relative_to(base).parts
    if any(part in EXCLUDED_DIR_PARTS for part in rel_parts):
        return True
    name = path.name
    if name in {".env"}:
        return True
    lowered = name.lower()
    if lowered.endswith((".pyc", ".zip", ".log")):
        return True
    if name.startswith(".") and path.parent == base:
        return True
    return False


def _needs_materialize(events_path: Path, known_facts_path: Path) -> bool:
    if not known_facts_path.exists():
        return True
    return known_facts_path.stat().st_mtime < events_path.stat().st_mtime


def _materialize_known_facts(project_dir: Path) -> bool:
    events_path = project_dir / "events.jsonl"
    known_facts_path = project_dir / "known_facts.json"
    result = subprocess.run(
        [sys.executable, str(MATERIALIZE_SCRIPT), str(events_path), str(known_facts_path)],
        cwd=str(ROOT),
        text=True,
    )
    return result.returncode == 0


def _ensure_schema_metadata(project_dir: Path) -> None:
    metadata_path = project_dir / "metadata" / "schema_versions.json"
    if metadata_path.exists():
        return
    metadata_path.parent.mkdir(parents=True, exist_ok=True)
    import json

    metadata_path.write_text(
        __import__("json").dumps(DEFAULT_SCHEMA_VERSIONS, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )


def _ensure_customer_report(project_dir: Path) -> None:
    report_path = project_dir / "exports" / "customer_report.md"
    if report_path.exists():
        return
    manifest_path = project_dir / "manifest.json"
    project_id = "unknown"
    if manifest_path.exists():
        import json

        try:
            manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
            project_id = manifest.get("project_id", project_id)
        except Exception:
            project_id = "unknown"

    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(
        f"# TraceBench Project Report\n\nProject: {project_id}\n\nNo customer report was present at export time.\n",
        encoding="utf-8",
    )


def _collect_files(base_dir: Path, arc_prefix: str = "") -> Iterable[tuple[Path, str]]:
    if not base_dir.exists():
        return []

    base_dir = base_dir.resolve()
    collected: list[tuple[Path, str]] = []
    for path in sorted(base_dir.rglob("*")):
        if path.is_symlink():
            raise ValueError(f"refusing to export symlinked path: {path}")
        if not path.is_file():
            continue
        if _is_excluded_path(path, base_dir):
            continue
        if path.name in FORBIDDEN_EXPORT_FILES:
            continue
        rel = path.relative_to(base_dir)
        arc_name = str((Path(arc_prefix) / rel).as_posix()) if arc_prefix else str(rel.as_posix())
        collected.append((path, arc_name))
    return collected


def _validate_inputs(project_dir: Path) -> list[str]:
    errors: list[str] = []
    for rel in REQUIRED_INPUT_FILES:
        if not (project_dir / rel).exists():
            errors.append(f"missing required file: {rel}")
    return errors


def export_project_zip(project_dir: Path, output_zip: Path) -> int:
    if not project_dir.exists() or not project_dir.is_dir():
        print(f"[ERROR] project_dir does not exist: {project_dir}")
        return 2

    errors = _validate_inputs(project_dir)
    if errors:
        for item in errors:
            print(f"[ERROR] {item}")
        return 2

    if _needs_materialize(project_dir / "events.jsonl", project_dir / "known_facts.json"):
        if not _materialize_known_facts(project_dir):
            print("[ERROR] failed to materialize known_facts.json")
            return 1

    _ensure_schema_metadata(project_dir)
    _ensure_customer_report(project_dir)

    files: list[tuple[Path, str]] = []
    try:
        files.extend(_collect_files(project_dir))
    except ValueError as exc:
        print(f"[ERROR] {exc}")
        return 1

    profiles_source = project_dir / "device_profiles"
    if not profiles_source.exists():
        profiles_source = REPO_DEVICE_PROFILES
    if profiles_source.exists():
        try:
            files.extend((path, arc_name) for path, arc_name in _collect_files(profiles_source, "device_profiles"))
        except ValueError as exc:
            print(f"[ERROR] {exc}")
            return 1

    required = {
        "manifest.json",
        "events.jsonl",
        "known_facts.json",
        "metadata/schema_versions.json",
        "exports/customer_report.md",
    }

    output_zip.parent.mkdir(parents=True, exist_ok=True)
    output_zip = output_zip.resolve()

    with zipfile.ZipFile(output_zip, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        for source, arc_name in sorted(files, key=lambda item: item[1]):
            if _is_excluded_path(source, source.parent):
                continue
            zf.write(source, arc_name)

    with zipfile.ZipFile(output_zip, "r") as zf:
        names = {name.rstrip("/") for name in zf.namelist()}

    if not required.issubset(names):
        missing = sorted(required - names)
        print(f"[ERROR] export missing required files: {', '.join(missing)}")
        return 1

    has_device_profiles = any(name.startswith("device_profiles/") for name in names)
    if not has_device_profiles:
        print("[ERROR] export missing required directory: device_profiles/")
        return 1

    print(f"[OK] wrote {output_zip}")
    return 0


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: python tools/export_project_zip.py <project_dir> <output_zip>")
        return 2

    return export_project_zip(Path(sys.argv[1]), Path(sys.argv[2]))


if __name__ == "__main__":
    raise SystemExit(main())


