#!/usr/bin/env python3
"""Create a minimal known_facts.json materialized state from events.jsonl."""
from __future__ import annotations

import copy
import json
import sys
from pathlib import Path

V2_SCHEMA_VERSION = "2.0-draft"
V2_RELATION_FIELDS = (
    "origin_event_id",
    "corrects_event_id",
    "supersedes_event_id",
    "invalidates_event_id",
)
V2_COMPONENT_FIELDS = (
    "component_id",
    "label",
    "component_kind",
    "human_note",
    "created_context",
    "reference_designator",
    "pin_count",
    "template_id_hint",
    "footprint_hint",
    "package_hint",
    "side",
    "rough_location",
    "rotation_hint",
)


def _is_v2_event(event: dict) -> bool:
    return event.get("schema_version") == V2_SCHEMA_VERSION


def _manifest_project_id(events_path: Path) -> str:
    manifest_path = events_path.parent / "manifest.json"
    if not manifest_path.exists():
        return "unknown"

    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, OSError):
        return "unknown"

    if not isinstance(manifest, dict):
        return "unknown"
    project_id = manifest.get("project_id")
    if not isinstance(project_id, str) or not project_id.strip():
        return "unknown"
    return project_id.strip()


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


def _v2_copy_relation_fields(event: dict, target: dict) -> None:
    for field in V2_RELATION_FIELDS:
        value = event.get(field)
        if isinstance(value, str) and value:
            target[field] = value


def _v2_component_from_payload(payload: dict, event_id: str) -> dict:
    component = {
        key: copy.deepcopy(payload[key])
        for key in V2_COMPONENT_FIELDS
        if key in payload
    }
    component["source_event_id"] = event_id
    component["valid_from_event_id"] = event_id
    component["valid_until_event_id"] = None
    component["validity_status"] = "active"
    component["updated_by_event_ids"] = []
    component["component_history"] = [
        {
            "source_event_id": event_id,
            "event_type": "component_created",
            "payload": copy.deepcopy(payload),
        }
    ]
    return component


def _v2_apply_component_update(component: dict, payload: dict, event_id: str) -> None:
    changes = payload.get("changes")
    if not isinstance(changes, list):
        return

    for change in changes:
        if not isinstance(change, dict):
            continue
        field = change.get("field")
        if field not in V2_COMPONENT_FIELDS or field == "component_id":
            continue
        component[field] = copy.deepcopy(change.get("new_value"))

    component.setdefault("updated_by_event_ids", []).append(event_id)
    component.setdefault("component_history", []).append(
        {
            "source_event_id": event_id,
            "event_type": "component_updated",
            "edit_reason": payload.get("edit_reason"),
            "changes": copy.deepcopy(changes),
        }
    )


def _v2_measurement_from_payload(payload: dict, event: dict) -> dict:
    event_id = event.get("event_id")
    target = payload.get("target", {})
    reading = payload.get("reading", {})
    materialized = {
        "measurement_id": payload.get("measurement_id"),
        "target": copy.deepcopy(target),
        "reading": copy.deepcopy(reading),
        "value_provenance": copy.deepcopy(payload.get("value_provenance", {})),
        "source_event_id": event_id,
        "origin_event_id": event.get("origin_event_id") or event_id,
        "valid_from_event_id": event_id,
        "valid_until_event_id": None,
        "validity_status": "active",
    }
    if isinstance(target, dict):
        for key in ("target_kind", "target_key", "display_label", "component_id", "pin_id"):
            if key in target:
                materialized[key] = copy.deepcopy(target[key])
    if isinstance(reading, dict):
        for key in ("mode", "value", "unit", "display_value", "state"):
            if key in reading:
                materialized[key] = copy.deepcopy(reading[key])
    for key in ("measured_at", "conditions", "operator_note"):
        if key in payload:
            materialized[key] = copy.deepcopy(payload[key])
    _v2_copy_relation_fields(event, materialized)
    return materialized


def _v2_target_references_component(target: object, component_id: str) -> bool:
    if isinstance(target, dict):
        if target.get("component_id") == component_id:
            return True
        target_key = target.get("target_key")
        if isinstance(target_key, str) and target_key.startswith(f"component:{component_id}:"):
            return True
        for key in ("target", "from_target", "to_target"):
            if _v2_target_references_component(target.get(key), component_id):
                return True
    if isinstance(target, list):
        return any(_v2_target_references_component(item, component_id) for item in target)
    return False


def _v2_stable_signature(value: object) -> str:
    return json.dumps(value, sort_keys=True, ensure_ascii=False, separators=(",", ":"))


def _v2_measurement_conflict_key(measurement: dict) -> tuple[object, object, str]:
    return (
        measurement.get("target_key"),
        measurement.get("mode"),
        _v2_stable_signature(measurement.get("conditions", {})),
    )


def _v2_measurement_value_signature(measurement: dict) -> tuple[object, object, object, object]:
    return (
        measurement.get("value"),
        measurement.get("unit"),
        measurement.get("display_value"),
        measurement.get("state"),
    )


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
    manifest_project_id = _manifest_project_id(events_path)
    project_id = manifest_project_id

    if not raw_events:
        known = {
            "project_id": project_id,
            "components": [],
            "pins": [],
            "measurements": [],
            "nets": [],
            "photos": [],
            "damage_regions": [],
            "suspect_regions": [],
            "visual_traces": [],
            "excluded_from_fault_candidates": [],
            "component_pin_index": {},
        }
        out_path.write_text(json.dumps(known, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        print(f"[OK] wrote {out_path}")
        return 0

    components: list[dict] = []
    measurements: list[dict] = []
    nets: list[dict] = []
    pins: list[dict] = []
    photos: list[dict] = []
    damage_regions: list[dict] = []
    suspect_regions: list[dict] = []
    visual_traces: list[dict] = []
    photo_to_board_alignments_by_id: dict[str, tuple[int, dict]] = {}
    component_visual_placements_by_component: dict[str, tuple[int, dict]] = {}
    excluded_from_fault_candidates: list[dict] = []
    project_id = manifest_project_id
    accepted_project_id_locked = project_id != "unknown"
    event_sequence_by_id: dict[str, int] = {}
    measurement_by_event: dict[str, dict] = {}
    v2_component_by_id: dict[str, dict] = {}
    v2_component_create_event_by_id: dict[str, str] = {}
    v2_measurement_by_event: dict[str, dict] = {}
    event_invalidations: list[dict] = []
    orphaned_measurements: list[dict] = []

    for event in raw_events:
        event_id = event.get("event_id")
        sequence = event.get("sequence")

        if _is_v2_event(event):
            if not isinstance(event_id, str):
                continue

            if not accepted_project_id_locked:
                event_project_id = event.get("project_id")
                if isinstance(event_project_id, str) and event_project_id.strip():
                    project_id = event_project_id.strip()
                    accepted_project_id_locked = True

            payload = event.get("payload", {})
            if not isinstance(payload, dict):
                continue
            event_type = event.get("event_type")

            if event_type == "component_created":
                component_id = payload.get("component_id")
                if not isinstance(component_id, str) or not component_id:
                    continue
                component = _v2_component_from_payload(payload, event_id)
                components.append(component)
                v2_component_by_id[component_id] = component
                v2_component_create_event_by_id[event_id] = component_id
                continue

            if event_type == "component_updated":
                component_id = payload.get("component_id")
                if not isinstance(component_id, str):
                    continue
                component = v2_component_by_id.get(component_id)
                if component is None:
                    component = next(
                        (
                            item
                            for item in components
                            if isinstance(item, dict) and item.get("component_id") == component_id
                        ),
                        None,
                    )
                if component is not None:
                    _v2_apply_component_update(component, payload, event_id)
                continue

            if event_type == "measurement_recorded":
                measurement = _v2_measurement_from_payload(payload, event)
                measurements.append(measurement)
                v2_measurement_by_event[event_id] = measurement

                supersedes_event_id = event.get("supersedes_event_id")
                if isinstance(supersedes_event_id, str):
                    superseded = v2_measurement_by_event.get(supersedes_event_id)
                    if superseded is not None:
                        superseded["validity_status"] = "superseded"
                        superseded["valid_until_event_id"] = event_id
                continue

            if event_type == "event_invalidated":
                invalidates_event_id = payload.get("invalidates_event_id") or event.get("invalidates_event_id")
                invalidation = {
                    "source_event_id": event_id,
                    "invalidates_event_id": invalidates_event_id,
                    "target_entity_id": payload.get("target_entity_id"),
                    "reason": payload.get("reason"),
                }
                if "human_note" in payload:
                    invalidation["human_note"] = payload.get("human_note")
                _v2_copy_relation_fields(event, invalidation)
                event_invalidations.append(invalidation)

                if isinstance(invalidates_event_id, str):
                    measurement = v2_measurement_by_event.get(invalidates_event_id)
                    if measurement is not None:
                        measurement["validity_status"] = "invalidated"
                        measurement["valid_until_event_id"] = event_id

                    component_id = v2_component_create_event_by_id.get(invalidates_event_id)
                    if component_id is None:
                        target_entity_id = payload.get("target_entity_id")
                        if isinstance(target_entity_id, str):
                            component_id = target_entity_id

                    if isinstance(component_id, str):
                        component = v2_component_by_id.get(component_id)
                        if component is not None:
                            component["validity_status"] = "invalidated"
                            component["valid_until_event_id"] = event_id
                        for candidate in v2_measurement_by_event.values():
                            if not _v2_target_references_component(candidate.get("target"), component_id):
                                continue
                            candidate["orphan_status"] = "component_invalidated"
                            candidate["affected_by_event_id"] = event_id
                            orphaned_measurements.append(
                                {
                                    "measurement_source_event_id": candidate.get("source_event_id"),
                                    "measurement_id": candidate.get("measurement_id"),
                                    "invalidated_component_event_id": invalidates_event_id,
                                    "invalidated_component_id": component_id,
                                    "invalidation_event_id": event_id,
                                    "reason": payload.get("reason"),
                                }
                            )
                continue

            continue

        if event.get("status") != "accepted":
            continue

        if not accepted_project_id_locked:
            event_project_id = event.get("project_id")
            if isinstance(event_project_id, str) and event_project_id.strip():
                project_id = event_project_id.strip()
                accepted_project_id_locked = True

        payload = event.get("payload", {})
        event_type = event.get("event_type")
        if isinstance(event_id, str) and isinstance(sequence, int):
            event_sequence_by_id[event_id] = sequence

        if event_type == "component_created":
            components.append(copy.deepcopy(payload))
            continue

        if event_type == "component_updated":
            if not isinstance(payload, dict):
                continue
            component_id = payload.get("component_id")
            if isinstance(component_id, str):
                for comp in components:
                    if comp.get("component_id") == component_id:
                        for key, value in payload.items():
                            if key != "component_id":
                                comp[key] = value
                        break
            continue

        if event_type == "component_marked_unknown":
            if not isinstance(payload, dict):
                continue
            component_id = payload.get("component_id")
            if isinstance(component_id, str):
                for comp in components:
                    if comp.get("component_id") == component_id:
                        comp["status"] = "needs_identification"
                        comp.pop("mpn", None)
                        comp.pop("marking", None)
                        break
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
            valid_references = []
            if isinstance(confirmed_by, list):
                for ref in confirmed_by:
                    if not isinstance(ref, str):
                        continue
                    measurement = measurement_by_event.get(ref)
                    if measurement is None:
                        continue
                    valid_references.append(ref)
                    if _is_stale_at_sequence(
                        measurement,
                        event_sequence,
                        event_sequence_by_id,
                    ):
                        references_stale = True
                        break

            if references_stale or not valid_references:
                # Conservative safety behavior for V1:
                # Nets in this projection require active measured basis.
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

        if event_type == "component_visual_placement_confirmed":
            actor = event.get("actor")
            if not isinstance(actor, dict) or actor.get("type") != "user":
                continue
            if not isinstance(payload, dict):
                continue
            if not isinstance(event_id, str):
                continue
            component_id = payload.get("component_id")
            if not isinstance(component_id, str) or not component_id:
                continue

            placement = {
                "component_id": component_id,
                "coordinate_space": payload.get("coordinate_space"),
                "board_side": payload.get("board_side"),
                "center_x": payload.get("center_x"),
                "center_y": payload.get("center_y"),
                "rotation_deg": payload.get("rotation_deg"),
                "source_event_id": event_id,
                "status": "user_confirmed_visual",
            }
            if "scale" in payload:
                placement["scale"] = payload.get("scale")
            else:
                if "width" in payload:
                    placement["width"] = payload.get("width")
                if "height" in payload:
                    placement["height"] = payload.get("height")
            if "source_photo_id" in payload:
                placement["source_photo_id"] = payload.get("source_photo_id")
            if "template_id" in payload:
                placement["template_id"] = payload.get("template_id")

            placement_sequence = sequence if isinstance(sequence, int) else -1
            previous = component_visual_placements_by_component.get(component_id)
            if previous is None or placement_sequence >= previous[0]:
                component_visual_placements_by_component[component_id] = (placement_sequence, placement)
            continue

        if event_type == "photo_to_board_alignment_confirmed":
            actor = event.get("actor")
            if not isinstance(actor, dict) or actor.get("type") != "user":
                continue
            if not isinstance(payload, dict):
                continue
            if not isinstance(event_id, str):
                continue
            alignment_id = payload.get("alignment_id")
            if not isinstance(alignment_id, str) or not alignment_id:
                continue

            alignment = {
                "alignment_id": alignment_id,
                "source_photo_id": payload.get("source_photo_id"),
                "board_side": payload.get("board_side"),
                "coordinate_space_from": payload.get("coordinate_space_from"),
                "coordinate_space_to": payload.get("coordinate_space_to"),
                "reference_points_photo": payload.get("reference_points_photo"),
                "reference_points_board": payload.get("reference_points_board"),
                "transform_type": payload.get("transform_type"),
                "alignment_quality_label": payload.get("alignment_quality_label"),
                "source_event_id": event_id,
                "status": "user_confirmed_alignment",
            }
            if "notes" in payload:
                alignment["notes"] = payload.get("notes")

            alignment_sequence = sequence if isinstance(sequence, int) else -1
            previous = photo_to_board_alignments_by_id.get(alignment_id)
            if previous is None or alignment_sequence >= previous[0]:
                photo_to_board_alignments_by_id[alignment_id] = (alignment_sequence, alignment)
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
            action_type = payload.get("action_type")

            if action_type == "remove_component":
                for target in targets:
                    if not isinstance(target, dict):
                        continue
                    if target.get("target_type") != "component":
                        continue
                    target_id = target.get("target_id")
                    for component in components:
                        if component.get("component_id") == target_id:
                            component["installation_status"] = "removed"
                            component["removed_by_event_id"] = event_id
                            break

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

    component_visual_placements = [
        value[1]
        for value in sorted(
            component_visual_placements_by_component.values(),
            key=lambda item: str(item[1].get("component_id", "")),
        )
    ]
    photo_to_board_alignments = [
        value[1]
        for value in sorted(
            photo_to_board_alignments_by_id.values(),
            key=lambda item: str(item[1].get("alignment_id", "")),
        )
    ]
    measurement_conflicts: list[dict] = []
    active_v2_by_conflict_key: dict[tuple[object, object, str], list[dict]] = {}
    for measurement in v2_measurement_by_event.values():
        if measurement.get("validity_status") != "active":
            continue
        active_v2_by_conflict_key.setdefault(
            _v2_measurement_conflict_key(measurement),
            [],
        ).append(measurement)

    for grouped_measurements in active_v2_by_conflict_key.values():
        value_signatures = {
            _v2_measurement_value_signature(measurement)
            for measurement in grouped_measurements
        }
        if len(grouped_measurements) <= 1 or len(value_signatures) <= 1:
            continue
        for measurement in grouped_measurements:
            measurement["validity_status"] = "active_conflict"
        measurement_conflicts.append(
            {
                "conflict_type": "measurement_divergence",
                "target_key": grouped_measurements[0].get("target_key"),
                "display_label": grouped_measurements[0].get("display_label"),
                "mode": grouped_measurements[0].get("mode"),
                "source_event_ids": [
                    measurement.get("source_event_id")
                    for measurement in grouped_measurements
                    if isinstance(measurement.get("source_event_id"), str)
                ],
            }
        )

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
    if component_visual_placements:
        known["component_visual_placements"] = component_visual_placements
    if photo_to_board_alignments:
        known["photo_to_board_alignments"] = photo_to_board_alignments
    if event_invalidations:
        known["event_invalidations"] = event_invalidations
    if measurement_conflicts:
        known["measurement_conflicts"] = measurement_conflicts
    if orphaned_measurements:
        known["orphaned_measurements"] = orphaned_measurements
    component_pin_index = {}
    for pin in pins:
        component_id = pin.get("component_id")
        pin_id = pin.get("pin_id")
        if not isinstance(component_id, str) or not isinstance(pin_id, str):
            continue
        component_pin_index.setdefault(component_id, [])
        if pin_id not in component_pin_index[component_id]:
            component_pin_index[component_id].append(pin_id)

    known["component_pin_index"] = component_pin_index

    visual_trace_ids = {
        vt.get("trace_id")
        for vt in visual_traces
        if isinstance(vt, dict) and vt.get("trace_id")
    }
    for net in nets:
        endpoints = {str(net.get("from", "")), str(net.get("to", ""))}
        net_trace_id = str(net.get("trace_id", ""))
        for visual_trace_id in visual_trace_ids:
            if visual_trace_id in endpoints or visual_trace_id == net_trace_id:
                print(
                    f"[WARN] invariant_violation: visual_trace {visual_trace_id!r} "
                    f"found in measured net {net.get('net_id')!r}",
                    file=sys.stderr,
                )

    excluded_ids = {
        excluded.get("footprint_id")
        for excluded in excluded_from_fault_candidates
        if isinstance(excluded, dict) and excluded.get("footprint_id")
    }
    for net in nets:
        from_endpoint = str(net.get("from", ""))
        to_endpoint = str(net.get("to", ""))
        for excluded_id in excluded_ids:
            if (
                from_endpoint == excluded_id
                or to_endpoint == excluded_id
                or from_endpoint.startswith(f"{excluded_id}.")
                or to_endpoint.startswith(f"{excluded_id}.")
            ):
                print(
                    f"[WARN] invariant_violation: not_populated {excluded_id!r} "
                    f"in measured net {net.get('net_id')!r}",
                    file=sys.stderr,
                )

    for visual_trace in visual_traces:
        if isinstance(visual_trace, dict) and visual_trace.get("evidence_type") == "measured":
            print(
                "[WARN] invariant_violation: visual_trace "
                f"{visual_trace.get('trace_id')!r} has evidence_type='measured'",
                file=sys.stderr,
            )

    out_path.write_text(json.dumps(known, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"[OK] wrote {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
