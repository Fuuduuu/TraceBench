#!/usr/bin/env python3
"""Windows-friendly, stdlib-only validation aggregator for Sprint 0."""

from __future__ import annotations

import json
import subprocess
import sys
import unittest
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
VALIDATE_PROJECT_STATE = ROOT / "tools" / "validate_project_state.py"
VALIDATE_EVENTS = ROOT / "tools" / "validate_events_jsonl.py"
MATERIALIZE_KNOWN_FACTS = ROOT / "tools" / "materialize_known_facts.py"
EXPORT_PROJECT_ZIP = ROOT / "tools" / "export_project_zip.py"
IMPORT_PROJECT_ZIP = ROOT / "tools" / "import_project_zip.py"
VALIDATE_PROJECT_ZIP = ROOT / "tools" / "validate_project_zip.py"
EVENT_SCHEMA = ROOT / "schemas" / "events.schema.json"
KNOWN_FACTS_OUT = ROOT / ".codex" / "known_facts.json"
TEST_DIR = ROOT / "tests"

SAMPLE_PELLE_DIR = ROOT / "samples" / "pelle_pv20_minimal"
SAMPLE_POSITIVE_DIR = ROOT / "samples" / "board_canvas_positive_smoke"

VALIDATION_FIXTURES = (
    {
        "name": "pelle_pv20_minimal",
        "sample_dir": SAMPLE_PELLE_DIR,
        "events_path": SAMPLE_PELLE_DIR / "events.jsonl",
        "known_facts_out": KNOWN_FACTS_OUT,
        "expect_nets_empty": False,
        "expect_photo_alignment_metadata_only": False,
    },
    {
        "name": "board_canvas_positive_smoke",
        "sample_dir": SAMPLE_POSITIVE_DIR,
        "events_path": SAMPLE_POSITIVE_DIR / "events.jsonl",
        "known_facts_out": ROOT / ".codex" / "known_facts_board_canvas_positive_smoke.json",
        "expect_nets_empty": True,
        "expect_photo_alignment_metadata_only": True,
    },
)


def run_script(script: Path, args: list[str]) -> int:
    cmd = [sys.executable, str(script), *map(str, args)]
    result = subprocess.run(cmd, cwd=str(ROOT), text=True)
    return result.returncode


def assert_fixture_invariants(
    fixture_name: str,
    known_facts_path: Path,
    *,
    expect_nets_empty: bool,
    expect_photo_alignment_metadata_only: bool,
) -> list[str]:
    issues: list[str] = []
    try:
        payload = json.loads(known_facts_path.read_text(encoding="utf-8"))
    except Exception as exc:
        return [f"{fixture_name}: failed to parse materialized known_facts ({exc})"]

    if expect_nets_empty and payload.get("nets") != []:
        issues.append(f"{fixture_name}: expected nets: []")

    if "board_graph" in payload:
        issues.append(f"{fixture_name}: forbidden board_graph projection key present")
    if "view_state" in payload:
        issues.append(f"{fixture_name}: forbidden view_state projection key present")

    visual_traces = payload.get("visual_traces", [])
    for trace in visual_traces:
        if isinstance(trace, dict) and trace.get("evidence_type") != "visual_trace":
            issues.append(
                f"{fixture_name}: visual_trace evidence_type must remain visual_trace"
            )
            break

    if expect_photo_alignment_metadata_only:
        alignments = payload.get("photo_to_board_alignments", [])
        if not alignments:
            issues.append(f"{fixture_name}: expected photo_to_board_alignments to be present")
        forbidden_alignment_fields = {
            "matrix",
            "transform_matrix",
            "homography_matrix",
            "affine_matrix",
            "similarity_matrix",
            "computed_transform",
        }
        for index, alignment in enumerate(alignments):
            if not isinstance(alignment, dict):
                issues.append(
                    f"{fixture_name}: alignment item at index {index} is not an object"
                )
                continue
            found = forbidden_alignment_fields.intersection(alignment.keys())
            if found:
                issues.append(
                    f"{fixture_name}: alignment item at index {index} contains forbidden computed fields {sorted(found)}"
                )
    return issues


def run_unittest_discovery() -> bool:
    if not TEST_DIR.exists():
        print("[SKIP] tests directory missing; skipping unittest discovery")
        return True

    loader = unittest.TestLoader()
    suite = loader.discover(str(TEST_DIR), pattern="test*.py")
    if suite.countTestCases() == 0:
        print("[SKIP] no unittest-compatible tests discovered")
        return True

    print("[RUN] unittest discovery")
    result = unittest.TextTestRunner(verbosity=2).run(suite)
    return result.wasSuccessful()


def main() -> int:
    failures: list[str] = []

    if not VALIDATE_PROJECT_STATE.exists():
        failures.append(f"missing script: {VALIDATE_PROJECT_STATE}")
    else:
        if run_script(VALIDATE_PROJECT_STATE, []) != 0:
            failures.append("validate_project_state.py")

    if not VALIDATE_EVENTS.exists():
        failures.append(f"missing script: {VALIDATE_EVENTS}")
    if not MATERIALIZE_KNOWN_FACTS.exists():
        failures.append(f"missing script: {MATERIALIZE_KNOWN_FACTS}")

    for script_path in (EXPORT_PROJECT_ZIP, IMPORT_PROJECT_ZIP, VALIDATE_PROJECT_ZIP):
        if not script_path.exists():
            failures.append(f"missing script: {script_path}")

    if not failures:
        for fixture in VALIDATION_FIXTURES:
            name = fixture["name"]
            sample_dir: Path = fixture["sample_dir"]
            events_path: Path = fixture["events_path"]
            known_facts_out: Path = fixture["known_facts_out"]
            if not sample_dir.exists():
                failures.append(f"{name}: missing sample directory {sample_dir}")
                continue
            if not events_path.exists():
                failures.append(f"{name}: missing events file {events_path}")
                continue

            if run_script(VALIDATE_EVENTS, [events_path, EVENT_SCHEMA]) != 0:
                failures.append(f"{name}: validate_events_jsonl.py")
                continue

            known_facts_out.parent.mkdir(parents=True, exist_ok=True)
            if run_script(MATERIALIZE_KNOWN_FACTS, [events_path, known_facts_out]) != 0:
                failures.append(f"{name}: materialize_known_facts.py")
                continue

            failures.extend(
                assert_fixture_invariants(
                    name,
                    known_facts_out,
                    expect_nets_empty=bool(fixture["expect_nets_empty"]),
                    expect_photo_alignment_metadata_only=bool(
                        fixture["expect_photo_alignment_metadata_only"]
                    ),
                )
            )

    if not run_unittest_discovery():
        failures.append("unittest discovery")

    if not failures:
        for fixture in VALIDATION_FIXTURES:
            name = fixture["name"]
            sample_dir: Path = fixture["sample_dir"]
            with tempfile.TemporaryDirectory() as tmp_dir:
                zip_path = Path(tmp_dir) / f"{name}.zip"
                imported_path = Path(tmp_dir) / f"{name}_imported"
                if run_script(EXPORT_PROJECT_ZIP, [sample_dir, zip_path]) != 0:
                    failures.append(f"{name}: export_project_zip.py")
                elif run_script(VALIDATE_PROJECT_ZIP, [zip_path]) != 0:
                    failures.append(f"{name}: validate_project_zip.py")
                elif run_script(IMPORT_PROJECT_ZIP, [zip_path, imported_path]) != 0:
                    failures.append(f"{name}: import_project_zip.py")

    if failures:
        print("[FAIL] validate_all.py failed:")
        for item in failures:
            print(f" - {item}")
        return 1

    print("[OK] validate_all.py PASSED")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
