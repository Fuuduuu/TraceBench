#!/usr/bin/env python3
"""Windows-friendly, stdlib-only validation aggregator for Sprint 0."""

from __future__ import annotations

import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
VALIDATE_PROJECT_STATE = ROOT / "tools" / "validate_project_state.py"
VALIDATE_EVENTS = ROOT / "tools" / "validate_events_jsonl.py"
MATERIALIZE_KNOWN_FACTS = ROOT / "tools" / "materialize_known_facts.py"
EVENTS_JSONL = ROOT / "samples" / "pelle_pv20_minimal" / "events.jsonl"
EVENT_SCHEMA = ROOT / "schemas" / "events.schema.json"
KNOWN_FACTS_OUT = ROOT / ".codex" / "known_facts.json"
TEST_DIR = ROOT / "tests"


def run_script(script: Path, args: list[str]) -> int:
    cmd = [sys.executable, str(script), *map(str, args)]
    result = subprocess.run(cmd, cwd=str(ROOT), text=True)
    return result.returncode


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
    else:
        if run_script(
            VALIDATE_EVENTS,
            [EVENTS_JSONL, EVENT_SCHEMA],
        ) != 0:
            failures.append("validate_events_jsonl.py")

    if not MATERIALIZE_KNOWN_FACTS.exists():
        failures.append(f"missing script: {MATERIALIZE_KNOWN_FACTS}")
    else:
        KNOWN_FACTS_OUT.parent.mkdir(parents=True, exist_ok=True)
        if run_script(MATERIALIZE_KNOWN_FACTS, [EVENTS_JSONL, KNOWN_FACTS_OUT]) != 0:
            failures.append("materialize_known_facts.py")

    if not run_unittest_discovery():
        failures.append("unittest discovery")

    if failures:
        print("[FAIL] validate_all.py failed:")
        for item in failures:
            print(f" - {item}")
        return 1

    print("[OK] validate_all.py PASSED")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
