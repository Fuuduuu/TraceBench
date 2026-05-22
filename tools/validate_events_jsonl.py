#!/usr/bin/env python3
"""Minimal JSONL event validator. Sprint 0 intentionally avoids external deps."""
from __future__ import annotations
import json
import re
import sys
from pathlib import Path

if len(sys.argv) < 2:
    print("usage: validate_events_jsonl.py <events.jsonl> [schema.json]")
    raise SystemExit(2)

path = Path(sys.argv[1])
errors: list[str] = []
last_seq = 0
seen = set()
allowed_status = {"draft", "pending_review", "accepted", "rejected", "superseded", "reverted"}
required = {"schema_version", "event_id", "project_id", "sequence", "created_at", "actor", "event_type", "status", "payload"}

for lineno, line in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
    if not line.strip():
        continue
    try:
        event = json.loads(line)
    except json.JSONDecodeError as exc:
        errors.append(f"line {lineno}: invalid JSON: {exc}")
        continue
    missing = required - set(event)
    if missing:
        errors.append(f"line {lineno}: missing {sorted(missing)}")
    if event.get("schema_version") != "1.0":
        errors.append(f"line {lineno}: schema_version must be 1.0")
    if not re.match(r"^evt_[0-9]{6}$", str(event.get("event_id", ""))):
        errors.append(f"line {lineno}: invalid event_id")
    if event.get("event_id") in seen:
        errors.append(f"line {lineno}: duplicate event_id")
    seen.add(event.get("event_id"))
    seq = event.get("sequence")
    if not isinstance(seq, int) or seq <= last_seq:
        errors.append(f"line {lineno}: sequence must increase")
    if isinstance(seq, int):
        last_seq = seq
    if event.get("status") not in allowed_status:
        errors.append(f"line {lineno}: invalid status")

# Evidence floor smoke check: an AI actor may not create measured facts.
    payload = event.get("payload", {})
    if event.get("actor", {}).get("type") == "ai" and payload.get("status") == "measured":
        errors.append(f"line {lineno}: AI actor may not create measured status")

if errors:
    for e in errors:
        print(f"[ERROR] {e}")
    raise SystemExit(1)
print(f"[OK] {path} validation PASSED")
