#!/usr/bin/env python3
"""Minimal JSONL event validator. Sprint 0 intentionally avoids external deps."""
from __future__ import annotations

import json
import re
import sys
from collections import Counter
from pathlib import Path

REQUIRED_KEYS = {
    "schema_version",
    "event_id",
    "project_id",
    "sequence",
    "created_at",
    "actor",
    "event_type",
    "status",
    "payload",
}

ALLOWED_STATUS = {"draft", "pending_review", "accepted", "rejected", "superseded", "reverted"}
ALLOWED_MODES = {
    "continuity",
    "resistance",
    "voltage_dc",
    "voltage_ac",
    "diode",
    "capacitance",
    "frequency",
}
ALLOWED_POWER_STATES = {"off", "on", "unknown"}
ALLOWED_MEASUREMENT_KINDS = {"numeric", "boolean", "categorical", "over_range"}
ALLOWED_READING_VALUE_TYPES = (float, int, bool, str, type(None))
ALLOWED_ACTOR_TYPES = {"user", "system", "ai", "import"}

REPAIR_TARGET_TYPES = {
    "component",
    "pin",
    "pad",
    "footprint",
    "net",
    "trace",
    "via",
    "connector",
    "area",
}

MEASUREMENT_EVENT = "measurement_recorded"
RESOLVABLE_CONFLICT_TYPES = {
    "measurement_contradiction",
    "net_topology_conflict",
}


def _error(errors: list[str], context: str, message: str) -> None:
    errors.append(f"{context}: {message}")


def _is_event_id(value: str) -> bool:
    return isinstance(value, str) and re.match(r"^evt_[0-9]{6}$", value) is not None


def _validate_envelope(event: dict, line: int, errors: list[str], seen_event_ids: set[str]) -> None:
    context = f"line {line}"
    event_id = event.get("event_id")
    if not isinstance(event_id, str):
        _error(errors, context, "event_id missing or not a string")
        return
    if not _is_event_id(event_id):
        _error(errors, context, f"event_id must match ^evt_[0-9]{6}$, got {event_id!r}")
    if event_id in seen_event_ids:
        _error(errors, context, f"duplicate event_id {event_id!r}")
    seen_event_ids.add(event_id)

    missing = REQUIRED_KEYS - set(event)
    if missing:
        _error(errors, context, f"missing keys: {sorted(missing)}")

    if event.get("schema_version") != "1.0":
        _error(errors, context, f"schema_version must be '1.0', got {event.get('schema_version')!r}")

    if not isinstance(event.get("project_id"), str) or not event["project_id"]:
        _error(errors, context, "project_id must be non-empty string")

    sequence = event.get("sequence")
    if not isinstance(sequence, int):
        _error(errors, context, "sequence must be integer")

    actor = event.get("actor")
    if not isinstance(actor, dict):
        _error(errors, context, "actor must be object")
    else:
        if actor.get("type") not in ALLOWED_ACTOR_TYPES:
            _error(errors, context, f"actor.type must be one of {sorted(ALLOWED_ACTOR_TYPES)!r}")
        actor_id = actor.get("id")
        if not isinstance(actor_id, str) or not actor_id:
            _error(errors, context, "actor.id must be non-empty string")

    payload = event.get("payload")
    if not isinstance(payload, dict):
        _error(errors, context, "payload must be object")


def _validate_measurement(event: dict, line: int, errors: list[str]) -> None:
    context = f"line {line}"
    payload = event["payload"]

    if event.get("actor", {}).get("type") == "ai":
        _error(errors, context, "measurement_recorded actor.type='ai' is forbidden")

    measurement_id = payload.get("measurement_id")
    if not isinstance(measurement_id, str) or not re.match(r"^M[0-9]+$", measurement_id):
        _error(errors, context, f"measurement_id must match ^M[0-9]+$, got {measurement_id!r}")

    if payload.get("mode") not in ALLOWED_MODES:
        _error(errors, context, f"mode must be one of {sorted(ALLOWED_MODES)!r}")
    if not isinstance(payload.get("from"), str) or not payload["from"]:
        _error(errors, context, "from must be non-empty string")
    if not isinstance(payload.get("to"), str) or not payload["to"]:
        _error(errors, context, "to must be non-empty string")
    if payload.get("power_state") not in ALLOWED_POWER_STATES:
        _error(errors, context, f"power_state must be one of {sorted(ALLOWED_POWER_STATES)!r}")

    reading = payload.get("reading")
    if not isinstance(reading, dict):
        _error(errors, context, "measurement_recorded requires reading object")
    else:
        if reading.get("kind") not in ALLOWED_MEASUREMENT_KINDS:
            _error(errors, context, f"reading.kind must be one of {sorted(ALLOWED_MEASUREMENT_KINDS)!r}")
        if "value" not in reading:
            _error(errors, context, "reading.value required")
        elif not isinstance(reading.get("value"), ALLOWED_READING_VALUE_TYPES):
            _error(errors, context, f"reading.value invalid type {type(reading.get('value')).__name__}")
        if "unit" not in reading:
            _error(errors, context, "reading.unit required")
        elif not isinstance(reading.get("unit"), (str, type(None))):
            _error(errors, context, "reading.unit must be string|null")

    for forbidden in ("valid_from_event_id", "valid_until_event_id", "validity_status"):
        if forbidden in payload:
            _error(errors, context, f"raw lifecycle field not allowed in raw payload: {forbidden}")


def _validate_repair_action(payload: dict, line: int, errors: list[str], component_ids: set[str], pin_ids: set[str]) -> None:
    context = f"line {line}"
    targets = payload.get("targets")
    if not isinstance(targets, list) or not targets:
        _error(errors, context, "repair_action_recorded requires non-empty typed targets array")
        return

    for index, target in enumerate(targets, start=1):
        if not isinstance(target, dict):
            _error(errors, context, f"repair target {index} must be object")
            continue
        target_type = target.get("target_type")
        target_id = target.get("target_id")
        if target_type not in REPAIR_TARGET_TYPES:
            _error(errors, context, f"repair target {index} invalid target_type")
        if not isinstance(target_id, str) or not target_id:
            _error(errors, context, f"repair target {index} target_id required")
            continue
        if target_type == "component" and target_id not in component_ids:
            _error(errors, context, f"repair target {index} references unknown component {target_id!r}")
        if target_type == "pin" and target_id not in pin_ids:
            _error(errors, context, f"repair target {index} references unknown pin {target_id!r}")

    invalidation = payload.get("invalidation_policy")
    if not isinstance(invalidation, dict):
        _error(errors, context, "repair_action_recorded requires invalidation_policy object")
        return
    if invalidation.get("direct_component_measurements") not in {"stale_after_repair", "no_change"}:
        _error(errors, context, "direct_component_measurements must be stale_after_repair|no_change")
    if invalidation.get("connected_net_measurements") != "no_change":
        _error(
            errors,
            context,
            "connected_net_measurements must be 'no_change' in V1 until connected-net invalidation is implemented",
        )


def _validate_footprint(payload: dict, line: int, errors: list[str]) -> None:
    context = f"line {line}"
    if payload.get("population_status") != "not_populated":
        _error(errors, context, "footprint_marked_not_populated requires population_status='not_populated'")
    if payload.get("allowed_in_fault_hypotheses") is not False:
        _error(errors, context, "allowed_in_fault_hypotheses must be false")
    if not isinstance(payload.get("footprint_id"), str) or not payload["footprint_id"]:
        _error(errors, context, "footprint_id required")


def _validate_component(payload: dict, line: int, errors: list[str], seen_component_ids: Counter[str]) -> None:
    context = f"line {line}"
    component_id = payload.get("component_id")
    if not isinstance(component_id, str) or not component_id:
        _error(errors, context, "component_created requires component_id")
        return
    if seen_component_ids[component_id]:
        _error(errors, context, f"duplicate component_id {component_id!r}")
    seen_component_ids[component_id] += 1


def _validate_pin(payload: dict, line: int, errors: list[str], component_ids: set[str], seen_pin_ids: Counter[str]) -> None:
    context = f"line {line}"
    component_id = payload.get("component_id")
    pin_id = payload.get("pin_id")
    if component_id not in component_ids:
        _error(errors, context, f"pin_defined component_id {component_id!r} must reference existing component_created")
    if not isinstance(pin_id, str) or not pin_id:
        _error(errors, context, "pin_defined requires pin_id")
        return
    if seen_pin_ids[pin_id]:
        _error(errors, context, f"duplicate pin_id {pin_id!r}")
    seen_pin_ids[pin_id] += 1


def _validate_net_connection(
    payload: dict,
    line: int,
    errors: list[str],
    all_event_ids: set[str],
    measurement_event_ids: set[str],
) -> None:
    context = f"line {line}"
    if payload.get("confirmation_basis") != "measured":
        _error(errors, context, "confirmation_basis must be measured")
    confirmed_by_event_ids = payload.get("confirmed_by_event_ids")
    if not isinstance(confirmed_by_event_ids, list) or not confirmed_by_event_ids:
        _error(errors, context, "confirmed_by_event_ids must be non-empty array")
        return
    for ref in confirmed_by_event_ids:
        if not isinstance(ref, str):
            _error(errors, context, f"confirmed_by_event_id {ref!r} must be string")
            continue
        if ref not in all_event_ids:
            _error(errors, context, f"confirmed_by_event_id {ref!r} does not exist")
        elif ref not in measurement_event_ids:
            _error(errors, context, f"confirmed_by_event_id {ref!r} must point to measurement_recorded")
    if not isinstance(payload.get("from"), str) or not payload["from"]:
        _error(errors, context, "from must be non-empty string")
    if not isinstance(payload.get("to"), str) or not payload["to"]:
        _error(errors, context, "to must be non-empty string")


def _validate_conflict_detected(
    payload: dict,
    line: int,
    errors: list[str],
    seen_conflict_ids: Counter[str],
) -> None:
    context = f"line {line}"
    conflict_id = payload.get("conflict_id")
    if not isinstance(conflict_id, str) or not re.match(r"^CONF[0-9]+$", conflict_id):
        _error(errors, context, "conflict_id must match ^CONF[0-9]+$")
        return
    if seen_conflict_ids[conflict_id]:
        _error(errors, context, f"duplicate conflict_id {conflict_id!r}")
    seen_conflict_ids[conflict_id] += 1

    if payload.get("conflict_type") not in {
        "measurement_contradiction",
        "net_topology_conflict",
        "evidence_quality_conflict",
        "component_identity_conflict",
        "population_status_conflict",
    }:
        _error(errors, context, f"invalid conflict_type {payload.get('conflict_type')!r}")
    between = payload.get("between")
    if not isinstance(between, list) or len(between) < 2:
        _error(errors, context, "between must be array with at least 2 event ids")


def _validate_conflict_resolved(
    payload: dict,
    line: int,
    errors: list[str],
    conflict_type_by_id: dict[str, str],
) -> None:
    context = f"line {line}"
    conflict_id = payload.get("conflict_id")
    if not isinstance(conflict_id, str) or not conflict_id:
        _error(errors, context, "conflict_resolved requires conflict_id")
        return
    if conflict_id not in conflict_type_by_id:
        _error(errors, context, f"conflict_resolved references unknown conflict_id {conflict_id!r}")
        return

    if conflict_type_by_id.get(conflict_id) in RESOLVABLE_CONFLICT_TYPES:
        if payload.get("resolved_by", {}).get("type") == "ai":
            _error(errors, context, "actor.type='ai' cannot resolve measurement/electrical conflicts in V1")

    if payload.get("resolution_type") not in {"accepted_events", "invalidated_events", "superseded_by_repair", "not_a_conflict"}:
        _error(errors, context, f"invalid resolution_type {payload.get('resolution_type')!r}")


def _validate_claim_invalidated(payload: dict, line: int, errors: list[str], all_event_ids: set[str]) -> None:
    context = f"line {line}"
    invalidates_event_id = payload.get("invalidates_event_id")
    if not isinstance(invalidates_event_id, str) or not invalidates_event_id:
        _error(errors, context, "invalidates_event_id required")
    elif invalidates_event_id not in all_event_ids:
        _error(errors, context, f"invalidates_event_id {invalidates_event_id!r} does not exist")

    if payload.get("invalidation_type") not in {
        "superseded",
        "retracted",
        "stale_after_repair",
        "conflict_resolution",
        "user_correction",
    }:
        _error(errors, context, f"invalid invalidation_type {payload.get('invalidation_type')!r}")

    superseded_by = payload.get("superseded_by_event_id")
    if superseded_by is not None and not isinstance(superseded_by, str):
        _error(errors, context, "superseded_by_event_id must be string|null")


def main() -> None:
    if len(sys.argv) < 2:
        print("usage: validate_events_jsonl.py <events.jsonl> [schema.json]")
        raise SystemExit(2)

    path = Path(sys.argv[1])
    if not path.exists():
        print(f"[ERROR] missing file: {path}")
        raise SystemExit(2)

    events: list[tuple[int, dict]] = []
    errors: list[str] = []
    for line_no, line in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
        if not line.strip():
            continue
        try:
            event = json.loads(line)
        except json.JSONDecodeError as exc:
            errors.append(f"line {line_no}: invalid JSON: {exc}")
            continue
        if not isinstance(event, dict):
            errors.append(f"line {line_no}: event must be object")
            continue
        events.append((line_no, event))

    seen_event_ids: set[str] = set()
    all_event_ids: set[str] = set()
    measurement_event_ids: set[str] = set()
    component_ids: set[str] = set()
    pin_ids: set[str] = set()
    component_id_counts: Counter[str] = Counter()
    pin_id_counts: Counter[str] = Counter()
    conflict_id_counts: Counter[str] = Counter()
    conflict_type_by_id: dict[str, str] = {}
    claim_target_count: Counter[str] = Counter()

    for _, event in events:
        event_id = event.get("event_id")
        event_type = event.get("event_type")
        if isinstance(event_id, str) and _is_event_id(event_id):
            all_event_ids.add(event_id)
        if event_type == "component_created":
            component_id = event.get("payload", {}).get("component_id")
            if isinstance(component_id, str):
                component_ids.add(component_id)
        if event_type == "pin_defined":
            pin_id = event.get("payload", {}).get("pin_id")
            if isinstance(pin_id, str):
                pin_ids.add(pin_id)

    last_sequence = 0
    conflict_payloads: list[tuple[dict, int]] = []
    net_payloads: list[tuple[dict, int]] = []
    resolved_payloads: list[tuple[dict, int]] = []
    claim_payloads: list[tuple[dict, int]] = []

    for line_no, event in events:
        _validate_envelope(event, line_no, errors, seen_event_ids)
        sequence = event.get("sequence")
        if not isinstance(sequence, int):
            _error(errors, f"line {line_no}", "sequence must be integer for ordering")
            continue
        if sequence <= last_sequence:
            _error(errors, f"line {line_no}", "sequence must strictly increase")
        else:
            last_sequence = sequence

        event_type = event.get("event_type")
        if event_type == "measurement_recorded":
            event_id = event.get("event_id")
            if isinstance(event_id, str):
                measurement_event_ids.add(event_id)
            _validate_measurement(event, line_no, errors)
            continue

        payload = event.get("payload")
        if not isinstance(payload, dict):
            _error(errors, f"line {line_no}", "payload must be object")
            continue

        if event_type == "repair_action_recorded":
            _validate_repair_action(payload, line_no, errors, component_ids, pin_ids)
            continue

        if event_type == "footprint_marked_not_populated":
            _validate_footprint(payload, line_no, errors)
            continue

        if event_type == "component_created":
            _validate_component(payload, line_no, errors, component_id_counts)
            continue

        if event_type == "pin_defined":
            _validate_pin(payload, line_no, errors, component_ids, pin_id_counts)
            continue

        if event_type == "net_connection_confirmed":
            net_payloads.append((payload, line_no))
            continue

        if event_type == "conflict_detected":
            _validate_conflict_detected(payload, line_no, errors, conflict_id_counts)
            conflict_id = payload.get("conflict_id")
            if isinstance(conflict_id, str):
                conflict_type_by_id[conflict_id] = payload.get("conflict_type", "")
            conflict_payloads.append((payload, line_no))
            continue

        if event_type == "conflict_resolved":
            resolved_payloads.append((payload, line_no))
            continue

        if event_type == "claim_invalidated":
            claim_payloads.append((payload, line_no))
            continue

        if event_type in {
            "project_created",
            "project_metadata_updated",
            "initial_intake_updated",
            "photo_added",
            "photo_reference_points_set",
            "photo_layer_aligned",
            "damage_region_marked",
            "suspect_region_marked",
            "component_updated",
            "component_marked_unknown",
            "visual_trace_added",
            "export_created",
        }:
            continue

        # Unknown event_type values are blocked by schema and should have failed earlier.

    for payload, line_no in net_payloads:
        _validate_net_connection(payload, line_no, errors, all_event_ids, measurement_event_ids)

    for payload, line_no in conflict_payloads:
        between = payload.get("between")
        if isinstance(between, list):
            for ref in between:
                if not isinstance(ref, str):
                    _error(errors, f"line {line_no}", f"between entry must be string, got {ref!r}")
                elif ref not in all_event_ids:
                    _error(errors, f"line {line_no}", f"between references missing event_id {ref!r}")

    for payload, line_no in resolved_payloads:
        _validate_conflict_resolved(payload, line_no, errors, conflict_type_by_id)

    for payload, line_no in claim_payloads:
        _validate_claim_invalidated(payload, line_no, errors, all_event_ids)
        invalidates_event_id = payload.get("invalidates_event_id")
        if isinstance(invalidates_event_id, str):
            claim_target_count[invalidates_event_id] += 1

    for event_id, count in claim_target_count.items():
        if count > 1:
            _error(errors, "global", f"event {event_id!r} invalidated multiple times ({count})")

    if errors:
        for error in errors:
            print(f"[ERROR] {error}")
        print(f"[FAIL] {path} validation FAILED")
        raise SystemExit(1)

    print(f"[OK] {path} validation PASSED")


if __name__ == "__main__":
    main()
