#!/usr/bin/env python3
"""Read-only minimal validator for docs/PROJECT_STATE.yml."""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "docs" / "PROJECT_STATE.yml"
REQUIRED = ["project", "scope", "architecture", "invariants", "validation", "debug"]
FORBIDDEN = ["api_key", "secret", "token", "password", "tenant_id", "client_id"]

text = STATE.read_text(encoding="utf-8") if STATE.exists() else ""
errors = []
for key in REQUIRED:
    if not re.search(rf"(?m)^{re.escape(key)}\s*:", text):
        errors.append(f"missing {key}")
for key in FORBIDDEN:
    if re.search(rf"(?im)^\s*{re.escape(key)}\s*:", text):
        errors.append(f"forbidden key {key}")
if "project_state_is_snapshot_only" not in text:
    errors.append("missing project_state_is_snapshot_only invariant")

if errors:
    for e in errors:
        print(f"[ERROR] {e}")
    sys.exit(1)
print("[OK] PROJECT_STATE.yml validation PASSED")
