#!/usr/bin/env python3
"""Create a minimal known_facts.json materialized state from events.jsonl."""
from __future__ import annotations

import copy
import json
import sys
from pathlib import Path

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


def _is_stale_at_sequence(
    measurement: dict,
    event_sequence: int,
    event_sequence_by_id: dict[str, int],
) -> bool:
    valid_until = measurement.get("valid_until_event_id")
    if valid_until is None:
        return False
    end_sequence = event_sequence_by_id.get(valid_until)
    if end_sequence is None:
        return False
    return event_sequence >= end_sequence


def _load_events(events_path: Path) -> list[dict]:
    events: list[dict] = []
    for line in events_path.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        events.append(json.loads(line))
    return events


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: materialize_known_facts.py <events.jsonl> <output.json>")
        return 2

    events_path = Path(sys.argv[1])
    out_path = Path(sys.argv[2])
    if not events_path.exists():
        print(f"[ERROR] missing events file: {events_path}")
        return 2

    raw_events = _load_events(events_path)
    if not raw_events:
        print(f"[ERROR] no events found: {events_path}")
        return 2

    components: list[dict] = []
    measurements: list[dict] = []
    nets: list[dict] = []
    pins: list[dict] = []
    photos: list[dict] = []
    damage_regions: list[dict] = []
    suspect_regions: list[dict] = []
    visual_traces: list[dict] = []
    excluded_from_fault_candidates: list[dict] = []
    project_id = "unknown"
    event_sequence_by_id: dict[str, int] = {}
    measurement_by_event: dict[str, dict] = {}

    for event in raw_events:
        project_id = event.get("project_id", project_id)
        payload = event.get("payload", {})
        event_type = event.get("event_type")
        event_id = event.get("event_id")
        sequence = event.get("sequence")
        if isinstance(event_id, str) and isinstance(sequence, int):
            event_sequence_by_id[event_id] = sequence

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
            if isinstance(event_id, str):
                measurement_by_event[event_id] = materialized
            continue

        if event_type == "net_connection_confirmed":
            materialized = copy.deepcopy(payload)
            materialized.setdefault("confirmation_basis", "measured")
            materialized.setdefault("verification_level", "measured")
            event_sequence = event.get("sequence")
            if not isinstance(event_sequence, int):
                continue

            confirmed_by = materialized.get("confirmed_by_event_ids", [])
            references_stale = False
            for ref in confirmed_by:
                if not isinstance(ref, str):
                    continue
                measurement = measurement_by_event.get(ref)
                if measurement is None:
                    continue
                if _is_stale_at_sequence(measurement, event_sequence, event_sequence_by_id):
                    references_stale = True
                    break

            if references_stale:
                # Conservative safety behavior for V1:
                # stale measurements cannot be the basis of a current measured net.
                continue

            nets.append(materialized)
            continue

        if event_type == "photo_added":
            materialized = copy.deepcopy(payload)
            entry = {
                "photo_id": materialized.get("photo_id"),
                "mode": materialized.get("mode"),
                "path": materialized.get("path"),
            }
            for key in ("notes", "sha256", "source_device", "exif_stripped", "layer"):
                if key in materialized:
                    entry[key] = materialized[key]
            photos.append(entry)
            continue

        if event_type == "damage_region_marked":
            materialized = copy.deepcopy(payload)
            entry = {
                "region_id": materialized.get("region_id"),
                "photo_id": materialized.get("photo_id"),
                "bbox": materialized.get("bbox"),
                "damage_type": materialized.get("damage_type"),
            }
            for key in ("notes", "severity", "affects_components"):
                if key in materialized:
                    entry[key] = materialized[key]
            damage_regions.append(entry)
            continue

        if event_type == "suspect_region_marked":
            materialized = copy.deepcopy(payload)
            entry = {
                "region_id": materialized.get("region_id"),
                "photo_id": materialized.get("photo_id"),
                "bbox": materialized.get("bbox"),
                "reason": materialized.get("reason"),
            }
            for key in ("notes", "affects_components", "priority"):
                if key in materialized:
                    entry[key] = materialized[key]
            suspect_regions.append(entry)
            continue

        if event_type == "visual_trace_added":
            materialized = copy.deepcopy(payload)
            entry = {
                "trace_id": materialized.get("trace_id"),
                "photo_id": materialized.get("photo_id"),
                "from_point": materialized.get("from_point"),
                "to_point": materialized.get("to_point"),
                "evidence_type": materialized.get("evidence_type"),
            }
            for key in (
                "from_component",
                "to_component",
                "from_pin",
                "to_pin",
                "confidence",
                "layer",
                "notes",
            ):
                if key in materialized:
                    entry[key] = materialized[key]
            visual_traces.append(entry)
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

        if event_type == "pin_defined":
            if payload:
                pins.append(copy.deepcopy(payload))
            continue
        # Other event types intentionally not materialized yet.

    known = {
        "project_id": project_id,
        "components": components,
        "pins": pins,
        "measurements": measurements,
        "nets": nets,
        "photos": photos,
        "damage_regions": damage_regions,
        "suspect_regions": suspect_regions,
        "visual_traces": visual_traces,
        "excluded_from_fault_candidates": excluded_from_fault_candidates,
    }
    out_path.write_text(json.dumps(known, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"[OK] wrote {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
