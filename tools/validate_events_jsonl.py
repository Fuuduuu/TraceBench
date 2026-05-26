#!/usr/bin/env python3
"""Minimal JSONL event validator. Sprint 0 intentionally avoids external deps."""
from __future__ import annotations

import json
import re
import sys
from collections import Counter
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_SCHEMA_PATH = ROOT / "schemas" / "events.schema.json"

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
ALLOWED_PIN_STATUS = {"unknown", "user_confirmed_visual", "source_imported_unverified", "datasheet_confirmed"}
ALLOWED_COMPONENT_STATUS = {"needs_identification", "identified", "confirmed", "suspect", "verified_good"}
ALLOWED_NET_EVIDENCE_TYPES = {"user_confirmed_visual", "source_imported_unverified", "datasheet_confirmed"}
ALLOWED_PHOTO_MODES = {"normal", "backlight", "macro", "side_light"}
ALLOWED_DAMAGE_TYPES = {
    "burn",
    "corrosion",
    "physical_break",
    "solder_bridge",
    "missing_component",
    "lifted_pad",
    "unknown",
}
ALLOWED_DAMAGE_SEVERITY = {"minor", "moderate", "severe"}
ALLOWED_SUSPECT_PRIORITY = {"low", "medium", "high"}
ALLOWED_VISUAL_TRACE_CONFIDENCE = {"low", "medium", "high"}
ALLOWED_VISUAL_TRACE_LAYER = {"top", "bottom", "inner_unknown"}
ALLOWED_PHOTO_LAYERS = {"top", "bottom", "side", "detail"}
ALLOWED_PLACEMENT_COORDINATE_SPACES = {"board_normalized", "photo_local"}
ALLOWED_PLACEMENT_BOARD_SIDES = {"top", "bottom", "unknown"}
PLACEMENT_FORBIDDEN_FIELDS = {
    "status",
    "proposal_status",
    "ai_proposal_id",
    "confidence",
    "confidence_score",
    "component_identity",
    "component_type",
    "mpn",
    "pin_mapping",
    "trace_id",
    "net_id",
    "measurement_id",
    "fault_candidate",
    "repair_conclusion",
    "electrical_class",
    "template_assignment_event_id",
}

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
ALLOWED_REPAIR_ACTION_TYPES = {
    "replace_component",
    "remove_component",
    "rework_solder",
    "clean_board",
    "bypass_trace",
    "cut_trace",
    "other",
}
REMOVE_COMPONENT_ONLY_TARGET_TYPES = {"component"}
REMOVE_COMPONENT_FORBIDDEN_KEYS = {
    "after",
    "replacement_component_id",
    "replacement_component",
    "replacement",
    "donor_origin",
    "new_marking",
    "mpn",
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


def _is_iso_datetime(value: str) -> bool:
    if not isinstance(value, str) or not value:
        return False
    candidate = value
    if value.endswith("Z"):
        candidate = value[:-1] + "+00:00"
    try:
        datetime.fromisoformat(candidate)
    except ValueError:
        return False
    return True


def _is_valid_image_path(path: str) -> bool:
    if not path.startswith("photos/"):
        return False
    lower = path.lower()
    return lower.endswith((".jpg", ".jpeg", ".png", ".webp"))


def _is_hex64(value: str) -> bool:
    return bool(re.fullmatch(r"[0-9a-fA-F]{64}", value))


def _load_schema_constraints(
    schema_path: Path | None,
) -> tuple[set[str], set[str], set[str]]:
    schema = None
    if schema_path is None:
        schema_path = DEFAULT_SCHEMA_PATH
    if schema_path.exists():
        try:
            schema = json.loads(schema_path.read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError):
            schema = None
    if not isinstance(schema, dict):
        return set(["project_created", "project_metadata_updated", "initial_intake_updated", "photo_added", "photo_reference_points_set", "photo_layer_aligned", "damage_region_marked", "suspect_region_marked", "component_created", "component_updated", "component_marked_unknown", "footprint_marked_not_populated", "pin_defined", "visual_trace_added", "component_visual_placement_confirmed", "measurement_recorded", "net_connection_confirmed", "repair_action_recorded", "claim_invalidated", "conflict_detected", "conflict_resolved", "export_created"]), set(ALLOWED_STATUS), set(REQUIRED_KEYS)

    allowed_event_types = set(
        schema.get("properties", {}).get("event_type", {}).get("enum", []) or []
    )
    allowed_statuses = set(
        schema.get("properties", {}).get("status", {}).get("enum", []) or []
    )
    envelope_keys = set(schema.get("properties", {}).keys())
    if not allowed_event_types:
        allowed_event_types = set([
            "project_created",
            "project_metadata_updated",
            "initial_intake_updated",
            "photo_added",
            "photo_reference_points_set",
            "photo_layer_aligned",
            "damage_region_marked",
            "suspect_region_marked",
            "component_created",
            "component_updated",
            "component_marked_unknown",
            "footprint_marked_not_populated",
            "pin_defined",
            "visual_trace_added",
            "component_visual_placement_confirmed",
            "measurement_recorded",
            "net_connection_confirmed",
            "repair_action_recorded",
            "claim_invalidated",
            "conflict_detected",
            "conflict_resolved",
            "export_created",
        ])
    if not allowed_statuses:
        allowed_statuses = set(ALLOWED_STATUS)
    if not envelope_keys:
        envelope_keys = set(REQUIRED_KEYS)
    return allowed_event_types, allowed_statuses, envelope_keys


def _validate_envelope(
    event: dict,
    line: int,
    errors: list[str],
    seen_event_ids: set[str],
    allowed_event_types: set[str],
    allowed_statuses: set[str],
    allowed_envelope_keys: set[str],
) -> None:
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

    extra_keys = sorted(set(event) - set(allowed_envelope_keys))
    if extra_keys:
        _error(errors, context, f"unexpected top-level field(s): {extra_keys}")

    missing = REQUIRED_KEYS - set(event)
    if missing:
        _error(errors, context, f"missing keys: {sorted(missing)}")

    if event.get("schema_version") != "1.0":
        _error(errors, context, f"schema_version must be '1.0', got {event.get('schema_version')!r}")

    if not isinstance(event.get("project_id"), str) or not event["project_id"]:
        _error(errors, context, "project_id must be non-empty string")

    if not isinstance(event.get("created_at"), str) or not event["created_at"]:
        _error(errors, context, "created_at must be non-empty string")
    elif not _is_iso_datetime(event["created_at"]):
        _error(errors, context, f"created_at must be ISO-like datetime, got {event['created_at']!r}")

    event_type = event.get("event_type")
    if event_type not in allowed_event_types:
        _error(errors, context, f"unknown event_type: {event_type!r}")

    if event.get("status") not in allowed_statuses:
        _error(errors, context, f"status must be one of {sorted(allowed_statuses)!r}")

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

    sequence = event.get("sequence")
    if not isinstance(sequence, int):
        _error(errors, context, "sequence must be integer")


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

    for forbidden in ("value", "unit", "valid_from_event_id", "valid_until_event_id", "validity_status"):
        if forbidden in payload:
            _error(errors, context, f"raw lifecycle field not allowed in raw payload: {forbidden}")


def _validate_repair_action(
    payload: dict,
    line: int,
    errors: list[str],
    component_ids: set[str],
    component_sequences: dict[str, int],
    pin_ids: set[str],
    sequence: int,
) -> None:
    context = f"line {line}"
    action_type = payload.get("action_type")
    if action_type not in ALLOWED_REPAIR_ACTION_TYPES:
        _error(errors, context, f"repair_action_recorded action_type {action_type!r} not supported")

    if action_type == "remove_component" and "after" in payload:
        _error(errors, context, "repair_action_recorded(action_type=remove_component) must not contain after")

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
            continue
        if action_type == "remove_component":
            if target_type not in REMOVE_COMPONENT_ONLY_TARGET_TYPES:
                _error(
                    errors,
                    context,
                    "remove_component target_type must be component",
                )
                continue
            if "target_id" not in target:
                _error(errors, context, "repair target 1 target_id required")
        if not isinstance(target_id, str) or not target_id:
            _error(errors, context, f"repair target {index} target_id required")
            continue
        if target_type == "component" and component_ids and target_id not in component_ids:
            _error(errors, context, f"repair target {index} references unknown component {target_id!r}")
        if (
            action_type == "remove_component"
            and target_type == "component"
            and target_id in component_sequences
            and component_sequences[target_id] >= sequence
        ):
            _error(
                errors,
                context,
                f"repair target {index} references component {target_id!r} created later than this action",
            )
        if target_type == "pin" and target_id not in pin_ids:
            _error(errors, context, f"repair target {index} references unknown pin {target_id!r}")
        if action_type == "remove_component":
            for key in REMOVE_COMPONENT_FORBIDDEN_KEYS:
                if key in payload:
                    _error(
                        errors,
                        context,
                        f"repair_action_recorded(action_type=remove_component) must not contain {key}",
                    )

    invalidation = payload.get("invalidation_policy")
    if not isinstance(invalidation, dict):
        _error(errors, context, "repair_action_recorded requires invalidation_policy object")
        return
    direct_component_measurements = invalidation.get("direct_component_measurements")
    if action_type == "remove_component":
        if direct_component_measurements != "stale_after_repair":
            _error(
                errors,
                context,
                "direct_component_measurements must be 'stale_after_repair' for remove_component",
            )
    elif direct_component_measurements not in {"stale_after_repair", "no_change"}:
        _error(errors, context, "direct_component_measurements must be stale_after_repair|no_change")

    if action_type == "remove_component" and invalidation.get("connected_net_measurements") != "no_change":
        _error(
            errors,
            context,
            "connected_net_measurements must be 'no_change' for remove_component",
        )
    elif invalidation.get("connected_net_measurements") != "no_change":
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

    status = payload.get("status")
    if status is not None and status not in ALLOWED_COMPONENT_STATUS:
        _error(errors, context, f"component_created status must be one of {sorted(ALLOWED_COMPONENT_STATUS)!r}")


def _validate_bbox(context: str, bbox: dict, errors: list[str]) -> None:
    if not isinstance(bbox, dict):
        _error(errors, context, "bbox must be object")
        return
    for key in ("x", "y", "width", "height"):
        if not isinstance(bbox.get(key), (int, float)):
            _error(errors, context, f"bbox.{key} must be number")
    if not isinstance(bbox.get("width"), (int, float)) or bbox.get("width") <= 0:
        _error(errors, context, "bbox.width must be positive number")
    if not isinstance(bbox.get("height"), (int, float)) or bbox.get("height") <= 0:
        _error(errors, context, "bbox.height must be positive number")


def _validate_photo_added(
    payload: dict,
    line: int,
    errors: list[str],
    seen_photo_ids: Counter[str],
    actor_type: str | None,
) -> None:
    context = f"line {line}"
    if actor_type == "ai":
        _error(errors, context, "photo_added actor.type='ai' is forbidden")

    photo_id = payload.get("photo_id")
    if not isinstance(photo_id, str) or not re.match(r"^photo_[a-z0-9_]+$", photo_id):
        _error(errors, context, "photo_id must match ^photo_[a-z0-9_]+$")
    elif seen_photo_ids[photo_id]:
        _error(errors, context, f"duplicate photo_id {photo_id!r}")
    seen_photo_ids[photo_id] += 1

    if payload.get("mode") not in ALLOWED_PHOTO_MODES:
        _error(errors, context, f"photo_added mode must be one of {sorted(ALLOWED_PHOTO_MODES)!r}")

    path = payload.get("path")
    if not isinstance(path, str) or not path:
        _error(errors, context, "photo_added requires path")
    elif not _is_valid_image_path(path):
        _error(
            errors,
            context,
            "photo_added path must start with photos/ and use allowed image extension",
        )

    sha256 = payload.get("sha256")
    if sha256 is not None:
        if not isinstance(sha256, str) or not _is_hex64(sha256):
            _error(errors, context, "sha256 must be a 64-character hexadecimal string when present")

    layer = payload.get("layer")
    if layer is not None and layer not in ALLOWED_PHOTO_LAYERS:
        _error(errors, context, f"photo_added layer must be one of {sorted(ALLOWED_PHOTO_LAYERS)!r}")


def _validate_damage_region_marked(
    payload: dict,
    line: int,
    errors: list[str],
    photo_ids: set[str],
    seen_region_ids: Counter[str],
    actor_type: str | None,
) -> None:
    context = f"line {line}"
    if actor_type == "ai":
        _error(errors, context, "damage_region_marked actor.type='ai' is forbidden")

    region_id = payload.get("region_id")
    if not isinstance(region_id, str) or not re.match(r"^DMG[0-9]+$", region_id):
        _error(errors, context, "region_id must match ^DMG[0-9]+$")
    elif seen_region_ids[region_id]:
        _error(errors, context, f"duplicate region_id {region_id!r}")
    seen_region_ids[region_id] += 1

    photo_id = payload.get("photo_id")
    if not isinstance(photo_id, str) or not photo_id:
        _error(errors, context, "photo_id required")
    elif photo_id not in photo_ids:
        _error(errors, context, f"damage_region_marked photo_id must reference existing photo_added photo_id, got {photo_id!r}")

    _validate_bbox(context, payload.get("bbox"), errors)

    if payload.get("damage_type") not in ALLOWED_DAMAGE_TYPES:
        _error(errors, context, f"damage_type must be one of {sorted(ALLOWED_DAMAGE_TYPES)!r}")

    severity = payload.get("severity")
    if severity is not None and severity not in ALLOWED_DAMAGE_SEVERITY:
        _error(errors, context, f"severity must be one of {sorted(ALLOWED_DAMAGE_SEVERITY)!r}")


def _validate_suspect_region_marked(
    payload: dict,
    line: int,
    errors: list[str],
    photo_ids: set[str],
    seen_region_ids: Counter[str],
    actor_type: str | None,
) -> None:
    context = f"line {line}"
    if actor_type == "ai":
        _error(errors, context, "suspect_region_marked actor.type='ai' is forbidden")

    region_id = payload.get("region_id")
    if not isinstance(region_id, str) or not re.match(r"^SUSP[0-9]+$", region_id):
        _error(errors, context, "region_id must match ^SUSP[0-9]+$")
    elif seen_region_ids[region_id]:
        _error(errors, context, f"duplicate region_id {region_id!r}")
    seen_region_ids[region_id] += 1

    photo_id = payload.get("photo_id")
    if not isinstance(photo_id, str) or not photo_id:
        _error(errors, context, "photo_id required")
    elif photo_id not in photo_ids:
        _error(errors, context, f"suspect_region_marked photo_id must reference existing photo_added photo_id, got {photo_id!r}")

    _validate_bbox(context, payload.get("bbox"), errors)

    reason = payload.get("reason")
    if not isinstance(reason, str) or not reason:
        _error(errors, context, "reason required")

    priority = payload.get("priority")
    if priority is not None and priority not in ALLOWED_SUSPECT_PRIORITY:
        _error(errors, context, f"priority must be one of {sorted(ALLOWED_SUSPECT_PRIORITY)!r}")


def _validate_visual_trace_added(
    payload: dict,
    line: int,
    errors: list[str],
    photo_ids: set[str],
    seen_trace_ids: Counter[str],
    actor_type: str | None,
) -> None:
    context = f"line {line}"
    if actor_type == "ai":
        _error(errors, context, "visual_trace_added actor.type='ai' is forbidden")

    trace_id = payload.get("trace_id")
    if not isinstance(trace_id, str) or not re.match(r"^VT[0-9]+$", trace_id):
        _error(errors, context, "trace_id must match ^VT[0-9]+$")
    elif seen_trace_ids[trace_id]:
        _error(errors, context, f"duplicate trace_id {trace_id!r}")
    seen_trace_ids[trace_id] += 1

    photo_id = payload.get("photo_id")
    if not isinstance(photo_id, str) or not photo_id:
        _error(errors, context, "photo_id required")
    elif photo_id not in photo_ids:
        _error(errors, context, f"visual_trace_added photo_id must reference existing photo_added photo_id, got {photo_id!r}")

    for field in ("confirmation_basis", "confirmed_by_event_ids", "net_id"):
        if field in payload:
            _error(errors, context, f"visual_trace_added must not include {field}")

    from_point = payload.get("from_point")
    to_point = payload.get("to_point")
    if not isinstance(from_point, dict):
        _error(errors, context, "from_point must be object")
    else:
        for key in ("x", "y"):
            if not isinstance(from_point.get(key), (int, float)):
                _error(errors, context, f"from_point.{key} must be number")

    if not isinstance(to_point, dict):
        _error(errors, context, "to_point must be object")
    else:
        for key in ("x", "y"):
            if not isinstance(to_point.get(key), (int, float)):
                _error(errors, context, f"to_point.{key} must be number")

    if payload.get("evidence_type") != "visual_trace":
        _error(errors, context, "evidence_type must be 'visual_trace'")

    confidence = payload.get("confidence")
    if confidence is not None and confidence not in ALLOWED_VISUAL_TRACE_CONFIDENCE:
        _error(errors, context, f"confidence must be one of {sorted(ALLOWED_VISUAL_TRACE_CONFIDENCE)!r}")

    layer = payload.get("layer")
    if layer is not None and layer not in ALLOWED_VISUAL_TRACE_LAYER:
        _error(errors, context, f"layer must be one of {sorted(ALLOWED_VISUAL_TRACE_LAYER)!r}")


def _validate_component_visual_placement_confirmed(
    payload: dict,
    line: int,
    errors: list[str],
    actor_type: str | None,
    sequence: int,
    component_sequences: dict[str, int],
    photo_sequences: dict[str, int],
) -> None:
    context = f"line {line}"
    if actor_type != "user":
        _error(
            errors,
            context,
            "component_visual_placement_confirmed actor.type must be 'user' in V1",
        )

    component_id = payload.get("component_id")
    if not isinstance(component_id, str) or not component_id:
        _error(errors, context, "component_id required")
    elif component_id not in component_sequences:
        _error(errors, context, f"component_id {component_id!r} must reference prior component_created")
    elif component_sequences[component_id] >= sequence:
        _error(errors, context, f"component_id {component_id!r} must not be forward reference")

    coordinate_space = payload.get("coordinate_space")
    if coordinate_space not in ALLOWED_PLACEMENT_COORDINATE_SPACES:
        if coordinate_space == "graph_layout":
            _error(errors, context, "graph_layout is not allowed as canonical coordinate_space")
        else:
            _error(
                errors,
                context,
                f"coordinate_space must be one of {sorted(ALLOWED_PLACEMENT_COORDINATE_SPACES)!r}",
            )

    board_side = payload.get("board_side")
    if board_side not in ALLOWED_PLACEMENT_BOARD_SIDES:
        _error(errors, context, f"board_side must be one of {sorted(ALLOWED_PLACEMENT_BOARD_SIDES)!r}")

    center_x = payload.get("center_x")
    center_y = payload.get("center_y")
    if not isinstance(center_x, (int, float)):
        _error(errors, context, "center_x must be numeric")
    if not isinstance(center_y, (int, float)):
        _error(errors, context, "center_y must be numeric")

    rotation_deg = payload.get("rotation_deg")
    if not isinstance(rotation_deg, (int, float)):
        _error(errors, context, "rotation_deg must be numeric")
    else:
        if rotation_deg < -180 or rotation_deg >= 180:
            _error(errors, context, "rotation_deg must satisfy -180 <= rotation_deg < 180")

    has_scale = "scale" in payload
    has_width = "width" in payload
    has_height = "height" in payload
    if has_scale and (has_width or has_height):
        _error(errors, context, "exactly one sizing mode required: scale xor (width+height)")
    if not has_scale and not (has_width and has_height):
        _error(errors, context, "exactly one sizing mode required: scale xor (width+height)")
    if has_width != has_height:
        _error(errors, context, "width and height must be provided together")

    if has_scale:
        scale = payload.get("scale")
        if not isinstance(scale, (int, float)) or scale <= 0:
            _error(errors, context, "scale must be numeric > 0")

    if has_width and has_height:
        width = payload.get("width")
        height = payload.get("height")
        if not isinstance(width, (int, float)) or width <= 0:
            _error(errors, context, "width must be numeric > 0")
        if not isinstance(height, (int, float)) or height <= 0:
            _error(errors, context, "height must be numeric > 0")

    source_photo_id = payload.get("source_photo_id")
    if coordinate_space == "photo_local":
        if not isinstance(source_photo_id, str) or not source_photo_id:
            _error(errors, context, "photo_local requires non-empty source_photo_id")
        else:
            if source_photo_id not in photo_sequences:
                _error(errors, context, f"source_photo_id {source_photo_id!r} must reference prior photo_added")
            elif photo_sequences[source_photo_id] >= sequence:
                _error(errors, context, f"source_photo_id {source_photo_id!r} must not be forward reference")

        if isinstance(center_x, (int, float)) and center_x < 0:
            _error(errors, context, "photo_local center_x must be >= 0")
        if isinstance(center_y, (int, float)) and center_y < 0:
            _error(errors, context, "photo_local center_y must be >= 0")
    elif coordinate_space == "board_normalized":
        if source_photo_id is not None:
            _error(errors, context, "board_normalized must not include source_photo_id in V1")
        if isinstance(center_x, (int, float)) and (center_x < 0 or center_x > 1):
            _error(errors, context, "board_normalized center_x must be within 0..1")
        if isinstance(center_y, (int, float)) and (center_y < 0 or center_y > 1):
            _error(errors, context, "board_normalized center_y must be within 0..1")
        if has_width and has_height:
            width = payload.get("width")
            height = payload.get("height")
            if isinstance(width, (int, float)) and width > 1:
                _error(errors, context, "board_normalized width must be <= 1")
            if isinstance(height, (int, float)) and height > 1:
                _error(errors, context, "board_normalized height must be <= 1")

    for field in PLACEMENT_FORBIDDEN_FIELDS:
        if field in payload:
            _error(errors, context, f"forbidden placement field present: {field}")

    template_id = payload.get("template_id")
    if template_id is not None and (not isinstance(template_id, str) or not template_id):
        _error(errors, context, "template_id must be non-empty string when present")


def _validate_pin(
    payload: dict,
    line: int,
    errors: list[str],
    component_ids: set[str],
    seen_pin_ids: Counter[str],
) -> None:
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

    status = payload.get("status")
    if status is not None:
        if status not in ALLOWED_PIN_STATUS:
            _error(errors, context, f"pin_defined status must be one of {sorted(ALLOWED_PIN_STATUS)!r}")


def _validate_net_connection(
    payload: dict,
    line: int,
    errors: list[str],
    all_event_ids: set[str],
    measurement_event_ids: set[str],
) -> None:
    context = f"line {line}"
    if not isinstance(payload.get("net_id"), str) or not payload.get("net_id"):
        _error(errors, context, "net_connection_confirmed requires non-empty net_id")
    if payload.get("confirmation_basis") != "measured":
        _error(errors, context, "confirmation_basis must be measured")
    if payload.get("status") == "measured":
        _error(errors, context, "status 'measured' is not allowed in net_connection_confirmed payload")
    if payload.get("evidence_type") in ALLOWED_NET_EVIDENCE_TYPES:
        _error(
            errors,
            context,
            "evidence_type must not be user/source/datasheet evidence for measured net confirmations",
        )
    if "evidence" in payload:
        _error(errors, context, "evidence field is not allowed for measurement-backed net_confirmation")
    if "evidence_ids" in payload:
        _error(errors, context, "evidence_ids field is not allowed for measurement-backed net_confirmation")

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

    schema_path = Path(sys.argv[2]) if len(sys.argv) >= 3 else None
    allowed_event_types, allowed_statuses, allowed_envelope_keys = _load_schema_constraints(schema_path)

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
    photo_ids: set[str] = set()
    photo_sequence_by_id: dict[str, int] = {}
    seen_photo_ids: Counter[str] = Counter()
    region_ids: Counter[str] = Counter()
    trace_ids: Counter[str] = Counter()
    component_id_counts: Counter[str] = Counter()
    pin_id_counts: Counter[str] = Counter()
    conflict_id_counts: Counter[str] = Counter()
    conflict_type_by_id: dict[str, str] = {}
    claim_target_count: Counter[str] = Counter()
    component_sequence_by_id: dict[str, int] = {}

    for _, event in events:
        event_id = event.get("event_id")
        event_type = event.get("event_type")
        event_status = event.get("status")
        if isinstance(event_id, str) and _is_event_id(event_id):
            all_event_ids.add(event_id)
        if event_type == "component_created":
            component_id = event.get("payload", {}).get("component_id")
            sequence = event.get("sequence")
            if isinstance(component_id, str):
                component_ids.add(component_id)
                if event_status == "accepted" and isinstance(sequence, int) and event_id:
                    component_sequence_by_id[component_id] = sequence
        if event_type == "pin_defined":
            pin_id = event.get("payload", {}).get("pin_id")
            if isinstance(pin_id, str):
                pin_ids.add(pin_id)
        if event_type == "photo_added":
            photo_id = event.get("payload", {}).get("photo_id")
            sequence = event.get("sequence")
            if isinstance(photo_id, str):
                photo_ids.add(photo_id)
                if event_status == "accepted" and isinstance(sequence, int):
                    photo_sequence_by_id[photo_id] = sequence
        if event_type == "measurement_recorded" and isinstance(event_id, str):
            measurement_event_ids.add(event_id)

    last_sequence = 0
    conflict_payloads: list[tuple[dict, int]] = []
    net_payloads: list[tuple[dict, int]] = []
    resolved_payloads: list[tuple[dict, int]] = []
    claim_payloads: list[tuple[dict, int]] = []

    for line_no, event in events:
        _validate_envelope(
            event,
            line_no,
            errors,
            seen_event_ids,
            allowed_event_types,
            allowed_statuses,
            allowed_envelope_keys,
        )
        sequence = event.get("sequence")
        if not isinstance(sequence, int):
            _error(errors, f"line {line_no}", "sequence must be integer for ordering")
            continue
        if sequence <= last_sequence:
            _error(errors, f"line {line_no}", "sequence must strictly increase")
        else:
            last_sequence = sequence

        event_type = event.get("event_type")
        if event_type not in allowed_event_types:
            continue

        payload = event.get("payload")
        if not isinstance(payload, dict):
            _error(errors, f"line {line_no}", "payload must be object")
            continue

        if event_type == MEASUREMENT_EVENT:
            _validate_measurement(event, line_no, errors)
            continue

        if event_type == "repair_action_recorded":
            _validate_repair_action(
                payload,
                line_no,
                errors,
                component_ids,
                component_sequence_by_id,
                pin_ids,
                sequence,
            )
            continue

        if event_type == "footprint_marked_not_populated":
            _validate_footprint(payload, line_no, errors)
            continue

        if event_type == "component_created":
            _validate_component(payload, line_no, errors, component_id_counts)
            continue

        if event_type == "photo_added":
            _validate_photo_added(payload, line_no, errors, seen_photo_ids, event.get("actor", {}).get("type"))
            continue

        if event_type == "damage_region_marked":
            _validate_damage_region_marked(
                payload,
                line_no,
                errors,
                photo_ids,
                region_ids,
                event.get("actor", {}).get("type"),
            )
            continue

        if event_type == "suspect_region_marked":
            _validate_suspect_region_marked(
                payload,
                line_no,
                errors,
                photo_ids,
                region_ids,
                event.get("actor", {}).get("type"),
            )
            continue

        if event_type == "visual_trace_added":
            _validate_visual_trace_added(
                payload,
                line_no,
                errors,
                photo_ids,
                trace_ids,
                event.get("actor", {}).get("type"),
            )
            continue

        if event_type == "component_visual_placement_confirmed":
            _validate_component_visual_placement_confirmed(
                payload,
                line_no,
                errors,
                event.get("actor", {}).get("type"),
                sequence,
                component_sequence_by_id,
                photo_sequence_by_id,
            )
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
            "photo_reference_points_set",
            "photo_layer_aligned",
            "component_updated",
            "component_marked_unknown",
            "export_created",
        }:
            continue

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
