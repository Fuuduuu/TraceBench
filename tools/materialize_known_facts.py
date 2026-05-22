#!/usr/bin/env python3
"""Create a minimal known_facts.json skeleton from events.jsonl."""
from __future__ import annotations
import json
import sys
from pathlib import Path

if len(sys.argv) != 3:
    print("usage: materialize_known_facts.py <events.jsonl> <output.json>")
    raise SystemExit(2)

events_path = Path(sys.argv[1])
out_path = Path(sys.argv[2])
components = []
measurements = []
nets = []
project_id = "unknown"

for line in events_path.read_text(encoding="utf-8").splitlines():
    if not line.strip():
        continue
    e = json.loads(line)
    project_id = e.get("project_id", project_id)
    payload = e.get("payload", {})
    if e.get("event_type") == "component_created":
        components.append(payload)
    elif e.get("event_type") == "measurement_recorded":
        measurements.append(payload)
    elif e.get("event_type") == "net_connection_confirmed":
        nets.append(payload)

known = {
    "project_id": project_id,
    "components": components,
    "measurements": measurements,
    "nets": nets,
}
out_path.write_text(json.dumps(known, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
print(f"[OK] wrote {out_path}")
