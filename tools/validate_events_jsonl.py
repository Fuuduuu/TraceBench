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
ALLOWED_ALIGNMENT_BOARD_SIDES = {"top", "bottom", "unknown"}
ALIGNMENT_ALLOWED_TRANSFORM_TYPES = {"similarity", "affine"}
ALIGNMENT_MINIMUM_PAIRS = {"similarity": 2, "affine": 3}
ALIGNMENT_FORBIDDEN_FIELDS = {
    "net_id",
    "measurement_id",
    "fault_id",
    "component_identity",
    "identity_status",
    "ai_proposal_id",
    "proposal_status",
    "confidence_score",
    "confirmed_net",
    "confirmed_fault",
    "repair_conclusion",
    "component_id",
    "component_ids",
    "pin_id",
    "pin_ids",
    "trace_id",
}
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
V2_SCHEMA_VERSION = "2.0-draft"
V2_EVENT_TYPES = {
    "measurement_recorded",
    "component_created",
    "component_updated",
    "component_visual_placement_confirmed",
    "event_invalidated",
}
V2_REJECTED_ALIASES = {
    "measurement_saved",
    "component_edited",
    "event_superseded",
    "measurement_updated",
    "replaces_event",
}
V2_REQUIRED_KEYS = {
    "schema_version",
    "event_id",
    "event_type",
    "created_at",
    "project_id",
    "client_operation_id",
    "actor",
    "source",
    "confirmation",
    "payload",
}
V2_RELATION_FIELDS = {
    "origin_event_id",
    "corrects_event_id",
    "supersedes_event_id",
    "invalidates_event_id",
}
V2_SHAPE_MARKER_KEYS = {"client_operation_id", "source", "confirmation"}
V2_ALLOWED_MODE_UNITS = {
    "voltage": "V",
    "resistance": "\u03a9",
    "diode": "diode",
    "continuity": "beep",
    "current": "A",
}
V2_ALLOWED_READING_STATES = {"OL", "over_range", "under_range", "unstable", "not_measured"}
V2_ALLOWED_TARGET_KINDS = {
    "component",
    "component_pin",
    "board_point",
    "point_to_point",
    "unknown",
}
V2_ALLOWED_MEASURED_VALUE_SOURCES = {
    "human_entered",
    "human_confirmed_from_reference",
    "human_confirmed_from_candidate",
}
V2_CONTEXT_VALUE_TYPES = {
    "helper_suggestion",
    "reference_value",
    "candidate_value",
    "note_value",
    "source_research_value",
}
V2_ONE_TAP_PROMOTION_FIELDS = {
    "one_tap_confirmed",
    "one_tap_confirmation",
    "auto_promoted",
    "context_value_promoted",
    "promoted_without_second_confirmation",
    "promoted_without_confirmation",
}
V2_CHANGE_KINDS = {"set", "replace", "clear", "mark_unknown", "correct_typo"}
V2_PROHIBITED_FIELDS = {
    "ai_confidence",
    "probability",
    "diagnosis",
    "fault_probability",
    "auto_detected",
    "ocr_text_as_fact",
    "cv_component_match",
    "photo_proof",
    "visual_trace_net",
    "template_identity",
    "board_graph_ref",
    "view_state_ref",
    "reference_image_evidence",
    "local_storage_source",
    "damage_proves_fault",
    "suspect_probability",
}
V2_COMPONENT_PROOF_FIELDS = {
    "identity_proof",
    "net_proof",
    "fault_proof",
    "probability_proof",
    "confirmed_identity",
    "confirmed_net",
    "confirmed_fault",
    "pin_map_proof",
}
V2_COMPONENT_CREATED_ALLOWED_FIELDS = {
    "component_id",
    "label",
    "component_kind",
    "created_context",
    "reference_designator",
    "pin_count",
    "package_hint",
    "footprint_hint",
    "template_id_hint",
    "side",
    "rough_location",
    "rotation_hint",
    "human_note",
}
V2_COMPONENT_UPDATED_ALLOWED_FIELDS = frozenset(
    V2_COMPONENT_CREATED_ALLOWED_FIELDS - {"component_id"},
)
V2_PLACEMENT_REQUIRED_FIELDS = {
    "component_id",
    "coordinate_space",
    "board_side",
    "center_x",
    "center_y",
    "rotation_deg",
    "width",
    "height",
}
V2_PLACEMENT_ALLOWED_FIELDS = V2_PLACEMENT_REQUIRED_FIELDS | {
    "template_id",
    "source_photo_id",
    "notes",
}
V2_PLACEMENT_FORBIDDEN_FIELDS = {
    "ai_authored_fact",
    "ai_confidence",
    "ai_fact_id",
    "ai_generated",
    "ai_proposal_id",
    "confirmedVisualContacts",
    "confirmed_contact_layout",
    "confirmed_net",
    "confirmed_visual_contacts",
    "connectivity",
    "contact_layout",
    "contact_pads",
    "contacts",
    "electrical_connectivity",
    "from_pin",
    "legs",
    "measurement_pin_id",
    "measurement_pin_identity",
    "net_connection",
    "net_connections",
    "net_id",
    "net_identity",
    "net_name",
    "pad_layout",
    "pads",
    "pinAnchors",
    "pin_anchors",
    "pin_id",
    "pin_identity",
    "pin_map",
    "pins",
    "scale",
    "to_pin",
    "trace_id",
    "visualContacts",
    "visual_contact_layout",
    "visual_contacts",
    "visual_pad_layout",
}
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
        return set(["project_created", "project_metadata_updated", "initial_intake_updated", "photo_added", "photo_reference_points_set", "photo_layer_aligned", "photo_to_board_alignment_confirmed", "damage_region_marked", "suspect_region_marked", "component_created", "component_updated", "component_marked_unknown", "footprint_marked_not_populated", "pin_defined", "visual_trace_added", "component_visual_placement_confirmed", "measurement_recorded", "net_connection_confirmed", "repair_action_recorded", "claim_invalidated", "conflict_detected", "conflict_resolved", "export_created"]), set(ALLOWED_STATUS), set(REQUIRED_KEYS)

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
            "photo_to_board_alignment_confirmed",
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
    if "schema_version" not in event:
        missing.discard("schema_version")
    if missing:
        _error(errors, context, f"missing keys: {sorted(missing)}")

    if "schema_version" in event and event.get("schema_version") != "1.0":
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


def _is_v2_shaped_event(event: dict) -> bool:
    schema_version = event.get("schema_version")
    if schema_version == V2_SCHEMA_VERSION:
        return True
    if isinstance(schema_version, str) and schema_version != "1.0":
        return True
    return bool(V2_SHAPE_MARKER_KEYS.intersection(event.keys()))


def _iter_v2_prohibited_fields(value) -> list[str]:
    found: list[str] = []
    if isinstance(value, dict):
        for key, nested in value.items():
            if key in V2_PROHIBITED_FIELDS:
                found.append(key)
            found.extend(_iter_v2_prohibited_fields(nested))
    elif isinstance(value, list):
        for item in value:
            found.extend(_iter_v2_prohibited_fields(item))
    return found


def _validate_v2_string_field(event: dict, field: str, context: str, errors: list[str]) -> None:
    value = event.get(field)
    if not isinstance(value, str) or not value:
        _error(errors, context, f"{field} must be non-empty string")


def _validate_v2_relation_fields(
    event: dict,
    context: str,
    errors: list[str],
    prior_event_ids: set[str],
) -> None:
    event_id = event.get("event_id")
    for field in sorted(V2_RELATION_FIELDS):
        if field not in event:
            continue
        ref = event.get(field)
        if not isinstance(ref, str) or not ref:
            _error(errors, context, f"{field} must be non-empty string")
            continue
        if ref == event_id:
            _error(errors, context, f"relation cycle detected for {field}")
            continue
        if ref not in prior_event_ids:
            _error(errors, context, f"{field} references missing or future event {ref!r}")


def _validate_v2_target(
    target: dict,
    context: str,
    errors: list[str],
    *,
    nested: bool = False,
) -> None:
    if not isinstance(target, dict):
        _error(errors, context, "target must be object")
        return
    target_kind = target.get("target_kind")
    if target_kind not in V2_ALLOWED_TARGET_KINDS:
        _error(errors, context, f"target_kind must be one of {sorted(V2_ALLOWED_TARGET_KINDS)!r}")
    for field in ("target_key", "display_label"):
        if not isinstance(target.get(field), str) or not target[field]:
            _error(errors, context, f"{field} must be non-empty string")
    if "pin_id" in target and (not isinstance(target.get("pin_id"), str) or not target["pin_id"]):
        _error(errors, context, "pin_id must be non-empty string when present")
    if "component_id" in target and (
        not isinstance(target.get("component_id"), str) or not target["component_id"]
    ):
        _error(errors, context, "component_id must be non-empty string when present")

    if target_kind == "point_to_point":
        for endpoint in ("from_target", "to_target"):
            if endpoint not in target:
                _error(errors, context, f"point_to_point target requires {endpoint}")
            else:
                _validate_v2_target(
                    target[endpoint],
                    f"{context}.{endpoint}",
                    errors,
                    nested=True,
                )
    elif not nested:
        for endpoint in ("from_target", "to_target"):
            if endpoint in target:
                _error(errors, context, f"{endpoint} is allowed only for point_to_point targets")


def _validate_v2_reading(reading: dict, context: str, errors: list[str]) -> None:
    if not isinstance(reading, dict):
        _error(errors, context, "measurement_recorded requires reading object")
        return
    mode = reading.get("mode")
    unit = reading.get("unit")
    if mode not in V2_ALLOWED_MODE_UNITS:
        _error(errors, context, f"reading.mode must be one of {sorted(V2_ALLOWED_MODE_UNITS)!r}")
    elif unit != V2_ALLOWED_MODE_UNITS[mode]:
        _error(errors, context, f"reading.unit must be {V2_ALLOWED_MODE_UNITS[mode]!r} for mode {mode!r}")
    if "unit" not in reading:
        _error(errors, context, "reading.unit required")
    if not isinstance(reading.get("display_value"), str) or not reading["display_value"]:
        _error(errors, context, "reading.display_value required")
    state = reading.get("state")
    if state is not None and state not in V2_ALLOWED_READING_STATES:
        _error(errors, context, f"reading.state must be one of {sorted(V2_ALLOWED_READING_STATES)!r}")
    if "value" not in reading and state not in V2_ALLOWED_READING_STATES:
        _error(errors, context, "reading.value required")
    elif "value" in reading and not isinstance(reading.get("value"), ALLOWED_READING_VALUE_TYPES):
        _error(errors, context, f"reading.value invalid type {type(reading.get('value')).__name__}")


def _validate_v2_value_provenance(
    provenance: dict,
    reading: dict,
    context: str,
    errors: list[str],
) -> None:
    if not isinstance(provenance, dict):
        _error(errors, context, "measurement_recorded requires value_provenance")
        return
    measured_source = provenance.get("measured_value_source", provenance.get("source"))
    if measured_source in V2_CONTEXT_VALUE_TYPES and "value" in reading:
        _error(errors, context, "context value source cannot be reading.value")
    elif measured_source not in V2_ALLOWED_MEASURED_VALUE_SOURCES:
        _error(
            errors,
            context,
            f"value_provenance.measured_value_source must be one of {sorted(V2_ALLOWED_MEASURED_VALUE_SOURCES)!r}",
        )

    if measured_source in {"human_confirmed_from_reference", "human_confirmed_from_candidate"}:
        if provenance.get("human_verified_as_own_reading") is not True:
            _error(errors, context, "human-confirmed context value requires human_verified_as_own_reading=true")

    for field in V2_ONE_TAP_PROMOTION_FIELDS:
        if provenance.get(field):
            _error(errors, context, "one-tap context promotion is forbidden")

    contexts = provenance.get("context_values_visible", [])
    if contexts is None:
        return
    if not isinstance(contexts, list):
        _error(errors, context, "context_values_visible must be array when present")
        return
    for index, item in enumerate(contexts, start=1):
        if not isinstance(item, dict):
            _error(errors, context, f"context_values_visible[{index}] must be object")
            continue
        context_type = item.get("context_type", item.get("type"))
        if context_type not in V2_CONTEXT_VALUE_TYPES:
            _error(errors, context, f"context_values_visible[{index}].context_type is not allowed")
        if item.get("used_as_measured_value") is True and measured_source == "human_entered":
            _error(errors, context, "context value source cannot be reading.value")


def _validate_v2_measurement(payload: dict, context: str, errors: list[str]) -> None:
    required = {"measurement_id", "measured_at", "target", "reading", "value_provenance"}
    missing = required - set(payload)
    if missing:
        _error(errors, context, f"measurement_recorded missing payload fields: {sorted(missing)}")
    if not isinstance(payload.get("measurement_id"), str) or not payload.get("measurement_id"):
        _error(errors, context, "measurement_id must be non-empty string")
    measured_at = payload.get("measured_at")
    if not isinstance(measured_at, str) or not _is_iso_datetime(measured_at):
        _error(errors, context, "measured_at must be ISO-like datetime")
    _validate_v2_target(payload.get("target"), context, errors)
    reading = payload.get("reading")
    if isinstance(reading, dict):
        _validate_v2_reading(reading, context, errors)
    else:
        _error(errors, context, "measurement_recorded requires reading object")
        reading = {}
    _validate_v2_value_provenance(payload.get("value_provenance"), reading, context, errors)


def _validate_v2_component_created(
    payload: dict,
    context: str,
    errors: list[str],
    component_ids: set[str],
) -> None:
    required = {"component_id", "label", "component_kind", "created_context"}
    missing = required - set(payload)
    if missing:
        _error(errors, context, f"component_created missing payload fields: {sorted(missing)}")
    extra = sorted(set(payload) - V2_COMPONENT_CREATED_ALLOWED_FIELDS)
    for field in extra:
        _error(errors, context, f"component_created unexpected field: {field}")
    for field in sorted(V2_COMPONENT_PROOF_FIELDS.intersection(payload.keys())):
        _error(errors, context, f"component_created proof field is forbidden: {field}")
    component_id = payload.get("component_id")
    if not isinstance(component_id, str) or not component_id:
        _error(errors, context, "component_created requires component_id")
        return
    if component_id in component_ids:
        _error(errors, context, f"duplicate V2 component_id {component_id!r}")
    component_ids.add(component_id)
    for field in ("label", "component_kind", "created_context"):
        if not isinstance(payload.get(field), str) or not payload[field]:
            _error(errors, context, f"component_created {field} must be non-empty string")


def _validate_v2_component_updated(
    payload: dict,
    context: str,
    errors: list[str],
    component_ids: set[str],
) -> None:
    required = {"component_id", "changes", "edit_reason"}
    missing = required - set(payload)
    if missing:
        _error(errors, context, f"component_updated missing payload fields: {sorted(missing)}")
    component_id = payload.get("component_id")
    if not isinstance(component_id, str) or not component_id:
        _error(errors, context, "component_updated requires component_id")
    elif component_ids and component_id not in component_ids:
        _error(errors, context, f"component_updated component_id {component_id!r} must reference prior component_created")
    if not isinstance(payload.get("edit_reason"), str) or not payload.get("edit_reason"):
        _error(errors, context, "component_updated edit_reason must be non-empty string")
    changes = payload.get("changes")
    if not isinstance(changes, list) or not changes:
        _error(errors, context, "component_updated requires non-empty changes")
        return
    for index, change in enumerate(changes, start=1):
        if not isinstance(change, dict):
            _error(errors, context, f"component_updated changes[{index}] must be object")
            continue
        for field in ("field", "old_value_observed", "new_value", "change_kind"):
            if field not in change:
                _error(errors, context, f"component_updated changes[{index}] missing {field}")
        field = change.get("field")
        if not isinstance(field, str) or not field:
            _error(errors, context, f"component_updated changes[{index}].field must be non-empty string")
        else:
            if field not in V2_COMPONENT_UPDATED_ALLOWED_FIELDS:
                _error(
                    errors,
                    context,
                    f"component_updated changes[{index}].field must be one of "
                    f"{sorted(V2_COMPONENT_UPDATED_ALLOWED_FIELDS)!r}",
                )
            if field in V2_COMPONENT_PROOF_FIELDS:
                _error(
                    errors,
                    context,
                    f"component_updated changes[{index}].field is forbidden proof field: {field}",
                )
            if field in V2_PROHIBITED_FIELDS:
                _error(
                    errors,
                    context,
                    f"component_updated changes[{index}].field is forbidden: {field}",
                )
        if change.get("change_kind") not in V2_CHANGE_KINDS:
            _error(
                errors,
                context,
                f"component_updated changes[{index}].change_kind must be one of {sorted(V2_CHANGE_KINDS)!r}",
            )


def _validate_v2_component_visual_placement_confirmed(
    payload: dict,
    context: str,
    errors: list[str],
    component_ids: set[str],
) -> None:
    missing = V2_PLACEMENT_REQUIRED_FIELDS - set(payload)
    if missing:
        _error(
            errors,
            context,
            f"component_visual_placement_confirmed missing payload fields: {sorted(missing)}",
        )

    for field in sorted(set(payload) - V2_PLACEMENT_ALLOWED_FIELDS):
        _error(errors, context, f"component_visual_placement_confirmed unexpected field: {field}")
    for field in sorted(V2_PLACEMENT_FORBIDDEN_FIELDS.intersection(payload.keys())):
        _error(
            errors,
            context,
            f"component_visual_placement_confirmed semantic field is forbidden: {field}",
        )

    component_id = payload.get("component_id")
    if not isinstance(component_id, str) or not component_id:
        _error(errors, context, "component_visual_placement_confirmed requires component_id")
    elif component_id not in component_ids:
        _error(
            errors,
            context,
            f"component_visual_placement_confirmed component_id {component_id!r} must reference prior component_created",
        )

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
    elif rotation_deg < -180 or rotation_deg >= 180:
        _error(errors, context, "rotation_deg must satisfy -180 <= rotation_deg < 180")

    width = payload.get("width")
    height = payload.get("height")
    if not isinstance(width, (int, float)) or width <= 0:
        _error(errors, context, "width must be numeric > 0")
    if not isinstance(height, (int, float)) or height <= 0:
        _error(errors, context, "height must be numeric > 0")

    if coordinate_space == "photo_local":
        if isinstance(center_x, (int, float)) and center_x < 0:
            _error(errors, context, "photo_local center_x must be >= 0")
        if isinstance(center_y, (int, float)) and center_y < 0:
            _error(errors, context, "photo_local center_y must be >= 0")
    elif coordinate_space == "board_normalized":
        if isinstance(center_x, (int, float)) and (center_x < 0 or center_x > 1):
            _error(errors, context, "board_normalized center_x must be within 0..1")
        if isinstance(center_y, (int, float)) and (center_y < 0 or center_y > 1):
            _error(errors, context, "board_normalized center_y must be within 0..1")
        if isinstance(width, (int, float)) and width > 1:
            _error(errors, context, "board_normalized width must be <= 1")
        if isinstance(height, (int, float)) and height > 1:
            _error(errors, context, "board_normalized height must be <= 1")

    template_id = payload.get("template_id")
    if template_id is not None and (not isinstance(template_id, str) or not template_id):
        _error(errors, context, "template_id must be non-empty string when present")
    source_photo_id = payload.get("source_photo_id")
    if source_photo_id is not None and (not isinstance(source_photo_id, str) or not source_photo_id):
        _error(errors, context, "source_photo_id must be non-empty string when present")
    notes = payload.get("notes")
    if notes is not None and not isinstance(notes, str):
        _error(errors, context, "notes must be string when present")


def _validate_v2_event_invalidated(
    payload: dict,
    context: str,
    errors: list[str],
    prior_event_ids: set[str],
) -> None:
    required = {"invalidates_event_id", "target_entity_id", "reason"}
    missing = required - set(payload)
    if missing:
        _error(errors, context, f"event_invalidated missing payload fields: {sorted(missing)}")
    invalidates = payload.get("invalidates_event_id")
    if not isinstance(invalidates, str) or not invalidates:
        _error(errors, context, "event_invalidated invalidates_event_id must be non-empty string")
    elif invalidates not in prior_event_ids:
        _error(errors, context, f"event_invalidated invalidates_event_id {invalidates!r} must reference prior event")
    for field in ("target_entity_id", "reason"):
        if not isinstance(payload.get(field), str) or not payload[field]:
            _error(errors, context, f"event_invalidated {field} must be non-empty string")
    if "human_note" in payload and not isinstance(payload.get("human_note"), str):
        _error(errors, context, "event_invalidated human_note must be string when present")


def _validate_v2_event(
    event: dict,
    line: int,
    errors: list[str],
    seen_event_ids: set[str],
    component_ids: set[str],
) -> None:
    context = f"line {line}"
    prior_event_ids = set(seen_event_ids)

    missing = V2_REQUIRED_KEYS - set(event)
    if "schema_version" not in event:
        _error(errors, context, "V2 canonical event requires schema_version")
        missing.discard("schema_version")
    if missing:
        _error(errors, context, f"V2 event missing envelope fields: {sorted(missing)}")

    schema_version = event.get("schema_version")
    if schema_version is not None and schema_version != V2_SCHEMA_VERSION:
        _error(errors, context, f"unsupported V2 schema_version {schema_version!r}")

    event_id = event.get("event_id")
    if not isinstance(event_id, str):
        _error(errors, context, "event_id missing or not a string")
    elif not _is_event_id(event_id):
        _error(errors, context, f"event_id must match ^evt_[0-9]{{6}}$, got {event_id!r}")
    else:
        if event_id in prior_event_ids:
            _error(errors, context, f"duplicate event_id {event_id!r}")
        seen_event_ids.add(event_id)

    allowed_top_level = V2_REQUIRED_KEYS | V2_RELATION_FIELDS
    extra_keys = sorted(set(event) - allowed_top_level)
    if extra_keys:
        _error(errors, context, f"unexpected V2 top-level field(s): {extra_keys}")

    for field in ("project_id", "client_operation_id"):
        _validate_v2_string_field(event, field, context, errors)
    created_at = event.get("created_at")
    if not isinstance(created_at, str) or not created_at:
        _error(errors, context, "created_at must be non-empty string")
    elif not _is_iso_datetime(created_at):
        _error(errors, context, f"created_at must be ISO-like datetime, got {created_at!r}")

    event_type = event.get("event_type")
    if event_type in V2_REJECTED_ALIASES:
        _error(errors, context, f"rejected V2 event_type alias: {event_type!r}")
    elif event_type not in V2_EVENT_TYPES:
        _error(errors, context, f"unknown V2 event_type: {event_type!r}")

    actor = event.get("actor")
    if not isinstance(actor, dict):
        _error(errors, context, "actor must be object")
    elif actor.get("type") != "human":
        _error(errors, context, "actor.type must be 'human'")

    source = event.get("source")
    if not isinstance(source, dict):
        _error(errors, context, "source must be object")
    elif source.get("type") != "explicit_user_confirmation":
        _error(errors, context, "source.type must be 'explicit_user_confirmation'")

    confirmation = event.get("confirmation")
    if not isinstance(confirmation, dict):
        _error(errors, context, "confirmation must be object")
    elif confirmation.get("confirmed") is not True:
        _error(errors, context, "confirmation.confirmed must be true")

    payload = event.get("payload")
    if not isinstance(payload, dict):
        _error(errors, context, "payload must be object")
        return

    for field in sorted(set(_iter_v2_prohibited_fields(event))):
        _error(errors, context, f"prohibited V2 canonical field present: {field}")

    _validate_v2_relation_fields(event, context, errors, prior_event_ids)

    if event_type == "measurement_recorded":
        _validate_v2_measurement(payload, context, errors)
    elif event_type == "component_created":
        _validate_v2_component_created(payload, context, errors, component_ids)
    elif event_type == "component_updated":
        _validate_v2_component_updated(payload, context, errors, component_ids)
    elif event_type == "component_visual_placement_confirmed":
        _validate_v2_component_visual_placement_confirmed(payload, context, errors, component_ids)
    elif event_type == "event_invalidated":
        _validate_v2_event_invalidated(payload, context, errors, prior_event_ids)


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
    all_component_ids_by_create_event: set[str],
    accepted_component_sequence_by_id: dict[str, int],
    all_pin_ids_by_define_event: set[str],
    accepted_pin_sequence_by_id: dict[str, int],
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
        if (
            target_type == "component"
            and (accepted_component_sequence_by_id or all_component_ids_by_create_event)
            and target_id not in accepted_component_sequence_by_id
        ):
            _error(errors, context, f"repair target {index} references unknown component {target_id!r}")
        if (
            action_type == "remove_component"
            and target_type == "component"
            and target_id in accepted_component_sequence_by_id
            and accepted_component_sequence_by_id[target_id] >= sequence
        ):
            _error(
                errors,
                context,
                f"repair target {index} references component {target_id!r} created later than this action",
            )
        if target_type == "pin":
            if (
                (accepted_pin_sequence_by_id or all_pin_ids_by_define_event)
                and target_id not in accepted_pin_sequence_by_id
            ):
                _error(errors, context, f"repair target {index} references unknown pin {target_id!r}")
            elif (
                target_id in accepted_pin_sequence_by_id
                and accepted_pin_sequence_by_id[target_id] >= sequence
            ):
                _error(
                    errors,
                    context,
                    f"repair target {index} references pin {target_id!r} defined later than this action",
                )
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


def _validate_component_reference_by_accepted_create(
    payload: dict,
    line: int,
    errors: list[str],
    sequence: int,
    accepted_component_sequence_by_id: dict[str, int],
    event_type: str,
) -> None:
    context = f"line {line}"
    component_id = payload.get("component_id")
    if not isinstance(component_id, str) or not component_id:
        _error(errors, context, f"{event_type} requires component_id")
    elif component_id not in accepted_component_sequence_by_id:
        _error(
            errors,
            context,
            f"{event_type} component_id {component_id!r} must reference prior accepted component_created",
        )
    elif accepted_component_sequence_by_id[component_id] >= sequence:
        _error(errors, context, f"{event_type} component_id {component_id!r} must not be forward reference")


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


def _validate_photo_to_board_alignment_confirmed(
    payload: dict,
    line: int,
    errors: list[str],
    actor_type: str | None,
    sequence: int,
    accepted_photo_sequence_by_id: dict[str, int],
    seen_alignment_ids: Counter[str],
) -> None:
    context = f"line {line}"
    if actor_type != "user":
        _error(errors, context, "photo_to_board_alignment_confirmed actor.type must be 'user' in V1")

    alignment_id = payload.get("alignment_id")
    if not isinstance(alignment_id, str) or not re.match(r"^ALN[0-9]+$", alignment_id):
        _error(errors, context, "alignment_id must match ^ALN[0-9]+$")
    elif seen_alignment_ids[alignment_id]:
        _error(errors, context, f"duplicate alignment_id {alignment_id!r}")
    if isinstance(alignment_id, str):
        seen_alignment_ids[alignment_id] += 1

    for field in ALIGNMENT_FORBIDDEN_FIELDS:
        if field in payload:
            _error(errors, context, f"forbidden alignment field present: {field}")

    source_photo_id = payload.get("source_photo_id")
    if not isinstance(source_photo_id, str) or not re.match(r"^photo_[a-z0-9_]+$", source_photo_id):
        _error(errors, context, "source_photo_id must match ^photo_[a-z0-9_]+$")
    elif source_photo_id not in accepted_photo_sequence_by_id:
        _error(errors, context, f"source_photo_id {source_photo_id!r} must reference prior accepted photo_added")
    elif accepted_photo_sequence_by_id[source_photo_id] >= sequence:
        _error(errors, context, f"source_photo_id {source_photo_id!r} must not be forward reference")

    board_side = payload.get("board_side")
    if board_side not in ALLOWED_ALIGNMENT_BOARD_SIDES:
        _error(errors, context, f"board_side must be one of {sorted(ALLOWED_ALIGNMENT_BOARD_SIDES)!r}")

    coordinate_space_from = payload.get("coordinate_space_from")
    coordinate_space_to = payload.get("coordinate_space_to")
    if coordinate_space_from != "photo_local":
        if coordinate_space_from == "graph_layout":
            _error(errors, context, "graph_layout is not allowed as canonical coordinate_space")
        else:
            _error(errors, context, "coordinate_space_from must be 'photo_local'")
    if coordinate_space_to != "board_normalized":
        if coordinate_space_to == "graph_layout":
            _error(errors, context, "graph_layout is not allowed as canonical coordinate_space")
        else:
            _error(errors, context, "coordinate_space_to must be 'board_normalized'")

    transform_type = payload.get("transform_type")
    if transform_type not in ALIGNMENT_ALLOWED_TRANSFORM_TYPES:
        _error(
            errors,
            context,
            f"transform_type must be one of {sorted(ALIGNMENT_ALLOWED_TRANSFORM_TYPES)!r}",
        )

    alignment_quality_label = payload.get("alignment_quality_label")
    if not isinstance(alignment_quality_label, str) or not alignment_quality_label.strip():
        _error(errors, context, "alignment_quality_label must be non-empty string")

    notes = payload.get("notes")
    if notes is not None and not isinstance(notes, str):
        _error(errors, context, "notes must be string when present")

    reference_points_photo = payload.get("reference_points_photo")
    reference_points_board = payload.get("reference_points_board")

    if not isinstance(reference_points_photo, list):
        _error(errors, context, "reference_points_photo must be array")
    if not isinstance(reference_points_board, list):
        _error(errors, context, "reference_points_board must be array")

    if isinstance(reference_points_photo, list):
        if len(reference_points_photo) < 2:
            _error(errors, context, "reference_points_photo must contain at least 2 points")
        for index, point in enumerate(reference_points_photo, start=1):
            if not isinstance(point, dict):
                _error(errors, context, f"reference_points_photo[{index}] must be object")
                continue
            x = point.get("x")
            y = point.get("y")
            if not isinstance(x, (int, float)):
                _error(errors, context, f"reference_points_photo[{index}].x must be number")
            elif x < 0:
                _error(errors, context, f"reference_points_photo[{index}].x must be >= 0")
            if not isinstance(y, (int, float)):
                _error(errors, context, f"reference_points_photo[{index}].y must be number")
            elif y < 0:
                _error(errors, context, f"reference_points_photo[{index}].y must be >= 0")

    if isinstance(reference_points_board, list):
        if len(reference_points_board) < 2:
            _error(errors, context, "reference_points_board must contain at least 2 points")
        for index, point in enumerate(reference_points_board, start=1):
            if not isinstance(point, dict):
                _error(errors, context, f"reference_points_board[{index}] must be object")
                continue
            x = point.get("x")
            y = point.get("y")
            if not isinstance(x, (int, float)):
                _error(errors, context, f"reference_points_board[{index}].x must be number")
            elif x < 0 or x > 1:
                _error(errors, context, f"reference_points_board[{index}].x must be within 0..1")
            if not isinstance(y, (int, float)):
                _error(errors, context, f"reference_points_board[{index}].y must be number")
            elif y < 0 or y > 1:
                _error(errors, context, f"reference_points_board[{index}].y must be within 0..1")

    if isinstance(reference_points_photo, list) and isinstance(reference_points_board, list):
        if len(reference_points_photo) != len(reference_points_board):
            _error(errors, context, "reference_points_photo and reference_points_board must have equal length")
        required_pairs = ALIGNMENT_MINIMUM_PAIRS.get(transform_type)
        if required_pairs is not None and len(reference_points_photo) < required_pairs:
            _error(errors, context, f"{transform_type} requires at least {required_pairs} reference point pairs")


def _validate_damage_region_marked(
    payload: dict,
    line: int,
    errors: list[str],
    sequence: int,
    accepted_photo_sequence_by_id: dict[str, int],
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
    elif photo_id not in accepted_photo_sequence_by_id:
        _error(errors, context, f"damage_region_marked photo_id must reference existing photo_added photo_id, got {photo_id!r}")
    elif accepted_photo_sequence_by_id[photo_id] >= sequence:
        _error(errors, context, f"damage_region_marked photo_id {photo_id!r} must not be forward reference")

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
    sequence: int,
    accepted_photo_sequence_by_id: dict[str, int],
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
    elif photo_id not in accepted_photo_sequence_by_id:
        _error(errors, context, f"suspect_region_marked photo_id must reference existing photo_added photo_id, got {photo_id!r}")
    elif accepted_photo_sequence_by_id[photo_id] >= sequence:
        _error(errors, context, f"suspect_region_marked photo_id {photo_id!r} must not be forward reference")

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
    sequence: int,
    accepted_photo_sequence_by_id: dict[str, int],
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
    elif photo_id not in accepted_photo_sequence_by_id:
        _error(errors, context, f"visual_trace_added photo_id must reference existing photo_added photo_id, got {photo_id!r}")
    elif accepted_photo_sequence_by_id[photo_id] >= sequence:
        _error(errors, context, f"visual_trace_added photo_id {photo_id!r} must not be forward reference")

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
    sequence: int,
    accepted_component_sequence_by_id: dict[str, int],
    seen_pin_ids: Counter[str],
) -> None:
    context = f"line {line}"
    component_id = payload.get("component_id")
    pin_id = payload.get("pin_id")
    if component_id not in accepted_component_sequence_by_id:
        _error(errors, context, f"pin_defined component_id {component_id!r} must reference existing component_created")
    elif accepted_component_sequence_by_id[component_id] >= sequence:
        _error(errors, context, f"pin_defined component_id {component_id!r} must not be forward reference")
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
    sequence: int,
    all_event_ids: set[str],
    accepted_measurement_sequence_by_event_id: dict[str, int],
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
        elif ref not in accepted_measurement_sequence_by_event_id:
            _error(errors, context, f"confirmed_by_event_id {ref!r} must point to measurement_recorded")
        elif accepted_measurement_sequence_by_event_id[ref] >= sequence:
            _error(errors, context, f"confirmed_by_event_id {ref!r} must not be forward reference")

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
    all_component_ids_by_create_event: set[str] = set()
    all_pin_ids_by_define_event: set[str] = set()
    accepted_measurement_sequence_by_event_id: dict[str, int] = {}
    accepted_component_sequence_by_id: dict[str, int] = {}
    accepted_pin_sequence_by_id: dict[str, int] = {}
    accepted_photo_sequence_by_id: dict[str, int] = {}
    seen_photo_ids: Counter[str] = Counter()
    region_ids: Counter[str] = Counter()
    trace_ids: Counter[str] = Counter()
    alignment_id_counts: Counter[str] = Counter()
    component_id_counts: Counter[str] = Counter()
    pin_id_counts: Counter[str] = Counter()
    conflict_id_counts: Counter[str] = Counter()
    conflict_type_by_id: dict[str, str] = {}
    claim_target_count: Counter[str] = Counter()
    v2_component_ids: set[str] = set()
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
                all_component_ids_by_create_event.add(component_id)
            if event_status == "accepted" and isinstance(component_id, str) and isinstance(sequence, int) and event_id:
                accepted_component_sequence_by_id[component_id] = sequence
        if event_type == "pin_defined":
            pin_id = event.get("payload", {}).get("pin_id")
            sequence = event.get("sequence")
            if isinstance(pin_id, str):
                all_pin_ids_by_define_event.add(pin_id)
            if event_status == "accepted" and isinstance(pin_id, str) and isinstance(sequence, int):
                accepted_pin_sequence_by_id[pin_id] = sequence
        if event_type == "photo_added":
            photo_id = event.get("payload", {}).get("photo_id")
            sequence = event.get("sequence")
            if event_status == "accepted" and isinstance(photo_id, str) and isinstance(sequence, int):
                accepted_photo_sequence_by_id[photo_id] = sequence
        if (
            event_type == "measurement_recorded"
            and event_status == "accepted"
            and isinstance(event_id, str)
            and isinstance(event.get("sequence"), int)
        ):
            accepted_measurement_sequence_by_event_id[event_id] = event["sequence"]

    last_sequence = 0
    conflict_payloads: list[tuple[dict, int]] = []
    net_payloads: list[tuple[dict, int, int]] = []
    resolved_payloads: list[tuple[dict, int]] = []
    claim_payloads: list[tuple[dict, int]] = []

    for line_no, event in events:
        if _is_v2_shaped_event(event):
            _validate_v2_event(event, line_no, errors, seen_event_ids, v2_component_ids)
            continue

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
                all_component_ids_by_create_event,
                accepted_component_sequence_by_id,
                all_pin_ids_by_define_event,
                accepted_pin_sequence_by_id,
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

        if event_type == "photo_to_board_alignment_confirmed":
            _validate_photo_to_board_alignment_confirmed(
                payload,
                line_no,
                errors,
                event.get("actor", {}).get("type"),
                sequence,
                accepted_photo_sequence_by_id,
                alignment_id_counts,
            )
            continue

        if event_type == "damage_region_marked":
            _validate_damage_region_marked(
                payload,
                line_no,
                errors,
                sequence,
                accepted_photo_sequence_by_id,
                region_ids,
                event.get("actor", {}).get("type"),
            )
            continue

        if event_type == "suspect_region_marked":
            _validate_suspect_region_marked(
                payload,
                line_no,
                errors,
                sequence,
                accepted_photo_sequence_by_id,
                region_ids,
                event.get("actor", {}).get("type"),
            )
            continue

        if event_type == "visual_trace_added":
            _validate_visual_trace_added(
                payload,
                line_no,
                errors,
                sequence,
                accepted_photo_sequence_by_id,
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
                accepted_component_sequence_by_id,
                accepted_photo_sequence_by_id,
            )
            continue

        if event_type == "pin_defined":
            _validate_pin(payload, line_no, errors, sequence, accepted_component_sequence_by_id, pin_id_counts)
            continue

        if event_type == "net_connection_confirmed":
            net_payloads.append((payload, line_no, sequence))
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
            "export_created",
        }:
            continue

        if event_type == "component_updated":
            _validate_component_reference_by_accepted_create(
                payload,
                line_no,
                errors,
                sequence,
                accepted_component_sequence_by_id,
                "component_updated",
            )
            continue

        if event_type == "component_marked_unknown":
            _validate_component_reference_by_accepted_create(
                payload,
                line_no,
                errors,
                sequence,
                accepted_component_sequence_by_id,
                "component_marked_unknown",
            )
            continue

    for payload, line_no, sequence in net_payloads:
        _validate_net_connection(
            payload,
            line_no,
            errors,
            sequence,
            all_event_ids,
            accepted_measurement_sequence_by_event_id,
        )

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
