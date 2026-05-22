#!/usr/bin/env python3
"""Create a minimal known_facts.json skeleton from events.jsonl."""
from __future__ import annotations

import copy
import json
import sys
from pathlib import Path

REPAIR_DIRECT_TARGET_TYPES = {"component", "pin"}


def _measurement_matches_target(measurement: dict, target: dict) -> bool:
    if target.get("target_type") == "pin":
        return (
            measurement.get("from") == target.get("target_id")
            or measurement.get("to") == target.get("target_id")
        )
    if target.get("target_type") == "component":
        cid = str(target.get("target_id"))
        return (
            measurement.get("from") == cid
            or measurement.get("to") == cid
            or str(measurement.get("from", "")).startswith(f"{cid}.")
            or str(measurement.get("to", "")).startswith(f"{cid}.")
        )
    return False


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: materialize_known_facts.py <events.jsonl> <output.json>")
        return 2

    events_path = Path(sys.argv[1])
    out_path = Path(sys.argv[2])
    if not events_path.exists():
        print(f"[ERROR] missing events file: {events_path}")
        return 2

    events = events_path.read_text(encoding="utf-8").splitlines()

    components: list[dict] = []
    measurements: list[dict] = []
    nets: list[dict] = []
    excluded_from_fault_candidates: list[dict] = []
    project_id = "unknown"

    for line in events:
        if not line.strip():
            continue
        event = json.loads(line)
        project_id = event.get("project_id", project_id)
        payload = event.get("payload", {})
        event_type = event.get("event_type")
        event_id = event.get("event_id")

        if event_type == "component_created":
            components.append(copy.deepcopy(payload))
            continue

        if event_type == "measurement_recorded":
            materialized = copy.deepcopy(payload)
            materialized["origin_event_id"] = event_id
            materialized["valid_from_event_id"] = event_id
            materialized["valid_until_event_id"] = None
            materialized["validity_status"] = "active"
            measurements.append(materialized)
            continue

        if event_type == "net_connection_confirmed":
            materialized = copy.deepcopy(payload)
            materialized.setdefault("confirmation_basis", "measured")
            materialized.setdefault("verification_level", "measured")
            nets.append(materialized)
            continue

        if event_type == "footprint_marked_not_populated":
            entry = {
                "footprint_id": payload.get("footprint_id"),
            }
            if "designator" in payload:
                entry["designator"] = payload.get("designator")
            if entry not in excluded_from_fault_candidates:
                excluded_from_fault_candidates.append(entry)
            continue

        if event_type == "repair_action_recorded":
            targets = payload.get("targets", [])
            policy = payload.get("invalidation_policy", {})
            direct_policy = policy.get("direct_component_measurements")

            if direct_policy != "stale_after_repair":
                continue
            for measurement in measurements:
                if measurement.get("validity_status") != "active":
                    continue
                for target in targets:
                    if not isinstance(target, dict):
                        continue
                    if _measurement_matches_target(measurement, target):
                        measurement["validity_status"] = "stale_after_repair"
                        measurement["valid_until_event_id"] = event_id
                        break
            continue
        # Other event types intentionally not materialized yet.

    known = {
        "project_id": project_id,
        "components": components,
        "measurements": measurements,
        "nets": nets,
        "excluded_from_fault_candidates": excluded_from_fault_candidates,
    }
    out_path.write_text(json.dumps(known, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"[OK] wrote {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
