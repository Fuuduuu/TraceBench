import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path
import unittest


def run_materialize(src="samples/pelle_pv20_minimal/events.jsonl"):
    with tempfile.TemporaryDirectory() as tmpdir:
        out = Path(tmpdir) / "known_facts.json"
        result = subprocess.run(
            [sys.executable, "tools/materialize_known_facts.py", src, str(out)],
            text=True,
            capture_output=True,
        )
        if result.returncode != 0:
            raise RuntimeError(result.stdout + result.stderr)
        return json.loads(out.read_text(encoding="utf-8"))


def run_materialize_events(events):
    with tempfile.TemporaryDirectory() as tmpdir:
        temp_path = Path(tmpdir) / "events.jsonl"
        with temp_path.open("w", encoding="utf-8") as handle:
            for event in events:
                handle.write(json.dumps(event) + "\n")
        return run_materialize(temp_path)


def run_materialize_project(events, manifest=None):
    with tempfile.TemporaryDirectory() as tmpdir:
        project_dir = Path(tmpdir) / "project"
        project_dir.mkdir()
        if manifest is not None:
            (project_dir / "manifest.json").write_text(
                json.dumps(manifest, indent=2),
                encoding="utf-8",
            )
        events_path = project_dir / "events.jsonl"
        with events_path.open("w", encoding="utf-8") as handle:
            for event in events:
                handle.write(json.dumps(event) + "\n")
        return run_materialize(events_path)


def _validate_json_schema_subset(value, schema, path="$"):
    errors = []
    schema_type = schema.get("type")

    if schema_type == "object":
        if not isinstance(value, dict):
            return [f"{path}: expected object, got {type(value).__name__}"]
        required = schema.get("required", [])
        for key in required:
            if key not in value:
                errors.append(f"{path}.{key}: missing required property")
        properties = schema.get("properties", {})
        if schema.get("additionalProperties") is False:
            for key in value.keys():
                if key not in properties:
                    errors.append(f"{path}.{key}: additional property is not allowed")
        for key, child_schema in properties.items():
            if key in value:
                errors.extend(_validate_json_schema_subset(value[key], child_schema, f"{path}.{key}"))

    elif schema_type == "array":
        if not isinstance(value, list):
            return [f"{path}: expected array, got {type(value).__name__}"]
        min_items = schema.get("minItems")
        if isinstance(min_items, int) and len(value) < min_items:
            errors.append(f"{path}: expected at least {min_items} items, got {len(value)}")
        item_schema = schema.get("items")
        if isinstance(item_schema, dict):
            for idx, item in enumerate(value):
                errors.extend(_validate_json_schema_subset(item, item_schema, f"{path}[{idx}]"))

    elif schema_type == "string":
        if not isinstance(value, str):
            return [f"{path}: expected string, got {type(value).__name__}"]
        min_length = schema.get("minLength")
        if isinstance(min_length, int) and len(value) < min_length:
            errors.append(f"{path}: expected minLength {min_length}, got {len(value)}")
        pattern = schema.get("pattern")
        if isinstance(pattern, str) and re.fullmatch(pattern, value) is None:
            errors.append(f"{path}: value {value!r} does not match pattern {pattern!r}")

    elif schema_type == "number":
        if not isinstance(value, (int, float)) or isinstance(value, bool):
            return [f"{path}: expected number, got {type(value).__name__}"]
        minimum = schema.get("minimum")
        if isinstance(minimum, (int, float)) and value < minimum:
            errors.append(f"{path}: value {value} is below minimum {minimum}")
        maximum = schema.get("maximum")
        if isinstance(maximum, (int, float)) and value > maximum:
            errors.append(f"{path}: value {value} is above maximum {maximum}")

    if "const" in schema and value != schema["const"]:
        errors.append(f"{path}: expected const {schema['const']!r}, got {value!r}")

    enum_values = schema.get("enum")
    if isinstance(enum_values, list) and value not in enum_values:
        errors.append(f"{path}: value {value!r} not in enum {enum_values!r}")

    return errors


def make_event(
    event_id,
    sequence,
    event_type,
    payload,
    *,
    status="accepted",
    project_id="prj_test",
    actor_type="user",
):
    return {
        "schema_version": "1.0",
        "event_id": event_id,
        "project_id": project_id,
        "sequence": sequence,
        "created_at": "2026-05-27T10:00:00Z",
        "actor": {"type": actor_type, "id": "u1"},
        "event_type": event_type,
        "status": status,
        "payload": payload,
    }


V2_SCHEMA_VERSION = "2.0-draft"


def make_v2_event(
    event_id,
    event_type,
    payload,
    *,
    project_id="prj_v2_test",
    client_operation_id=None,
    created_at="2026-06-06T10:00:00Z",
    **relations,
):
    return {
        "schema_version": V2_SCHEMA_VERSION,
        "event_id": event_id,
        "event_type": event_type,
        "created_at": created_at,
        "project_id": project_id,
        "client_operation_id": client_operation_id or f"op_{event_id}",
        "actor": {"type": "human", "actor_id": "local_user"},
        "source": {
            "type": "explicit_user_confirmation",
            "surface": "measure_sheet",
            "action": event_type,
        },
        "confirmation": {
            "confirmed": True,
            "confirmed_at": created_at,
            "label": "confirmed",
        },
        "payload": payload,
        **relations,
    }


def make_v2_measurement_payload(
    measurement_id,
    *,
    target_key="component:Q2:pin:1",
    display_label="Q2.1",
    component_id="Q2",
    pin_id="Q2.1",
    mode="voltage",
    value=3.3,
    unit="V",
    display_value="3.3 V",
    measured_source="human_entered",
    context_values=None,
):
    return {
        "measurement_id": measurement_id,
        "measured_at": "2026-06-06T10:00:00Z",
        "target": {
            "target_kind": "component_pin",
            "target_key": target_key,
            "display_label": display_label,
            "component_id": component_id,
            "pin_id": pin_id,
        },
        "reading": {
            "mode": mode,
            "value": value,
            "unit": unit,
            "display_value": display_value,
        },
        "value_provenance": {
            "measured_value_source": measured_source,
            "entry_method": "typed",
            "human_verified_as_own_reading": True,
            "context_values_visible": context_values
            if context_values is not None
            else [
                {
                    "context_type": "reference_value",
                    "context_id": "ref_q2_pin1_voltage",
                    "display_value": "3.3 V",
                    "used_as_measured_value": False,
                }
            ],
        },
        "conditions": {"power_state": "on"},
    }


def make_v2_component_payload(**overrides):
    payload = {
        "component_id": "Q2",
        "label": "Q2",
        "component_kind": "unknown",
        "created_context": "human_added_from_measure_sheet",
        "reference_designator": "Q2",
        "pin_count": 3,
        "template_id_hint": "sot23_hint",
        "footprint_hint": "SOT-23",
        "package_hint": "SOT-23 package",
        "side": "top",
        "rough_location": "near connector",
        "rotation_hint": "unknown",
    }
    payload.update(overrides)
    return payload


def make_v2_component_visual_placement_payload(**overrides):
    payload = {
        "component_id": "Q2",
        "coordinate_space": "board_normalized",
        "board_side": "top",
        "center_x": 0.42,
        "center_y": 0.33,
        "rotation_deg": 0.0,
        "width": 0.12,
        "height": 0.08,
    }
    payload.update(overrides)
    return payload


class MaterializeKnownFactsTests(unittest.TestCase):
    def test_v2_measurement_projection_preserves_provenance_and_context(self):
        context_values = [
            {
                "context_type": "reference_value",
                "context_id": "ref_q2_pin1_voltage",
                "display_value": "5.0 V",
                "used_as_measured_value": False,
            },
            {
                "context_type": "helper_suggestion",
                "context_id": "helper_next_check",
                "display_value": "Check Q2.2 next",
                "used_as_measured_value": False,
            },
        ]
        data = run_materialize_events(
            [
                make_v2_event(
                    "evt_200001",
                    "measurement_recorded",
                    make_v2_measurement_payload(
                        "meas_001",
                        value=3.3,
                        display_value="3.3 V",
                        context_values=context_values,
                    ),
                )
            ]
        )

        measurement = next(item for item in data["measurements"] if item["measurement_id"] == "meas_001")
        self.assertEqual(measurement["source_event_id"], "evt_200001")
        self.assertEqual(measurement["target_key"], "component:Q2:pin:1")
        self.assertEqual(measurement["display_label"], "Q2.1")
        self.assertEqual(measurement["mode"], "voltage")
        self.assertEqual(measurement["value"], 3.3)
        self.assertEqual(measurement["unit"], "V")
        self.assertEqual(measurement["value_provenance"]["measured_value_source"], "human_entered")
        self.assertEqual(measurement["value_provenance"]["context_values_visible"], context_values)
        self.assertEqual(measurement["validity_status"], "active")
        self.assertNotEqual(measurement["value"], "5.0 V")
        self.assertNotIn("diagnosis", measurement)
        self.assertNotIn("fault_probability", measurement)
        self.assertNotIn("confirmed_net", measurement)

    def test_v2_component_created_and_updated_projection_preserves_history_and_hints(self):
        data = run_materialize_events(
            [
                make_v2_event(
                    "evt_200001",
                    "component_created",
                    make_v2_component_payload(),
                ),
                make_v2_event(
                    "evt_200002",
                    "component_updated",
                    {
                        "component_id": "Q2",
                        "edit_reason": "marking read from board",
                        "changes": [
                            {
                                "field": "label",
                                "old_value_observed": "Q2",
                                "new_value": "Q2 transistor",
                                "change_kind": "replace",
                            },
                            {
                                "field": "reference_designator",
                                "old_value_observed": "Q2",
                                "new_value": "Q2A",
                                "change_kind": "replace",
                            },
                        ],
                    },
                ),
            ]
        )

        component = next(item for item in data["components"] if item["component_id"] == "Q2")
        self.assertEqual(component["source_event_id"], "evt_200001")
        self.assertEqual(component["label"], "Q2 transistor")
        self.assertEqual(component["reference_designator"], "Q2A")
        self.assertEqual(component["component_kind"], "unknown")
        self.assertEqual(component["template_id_hint"], "sot23_hint")
        self.assertEqual(component["footprint_hint"], "SOT-23")
        self.assertEqual(component["package_hint"], "SOT-23 package")
        self.assertEqual(component["updated_by_event_ids"], ["evt_200002"])
        self.assertEqual(
            [entry["source_event_id"] for entry in component["component_history"]],
            ["evt_200001", "evt_200002"],
        )
        self.assertNotIn("electrical_identity", component)
        self.assertNotIn("net_id", component)
        self.assertNotIn("fault_status", component)

    def test_v2_component_updated_package_hint_projection(self):
        data = run_materialize_events(
            [
                make_v2_event(
                    "evt_200001",
                    "component_created",
                    make_v2_component_payload(
                        package_hint="SOT-23 package",
                    ),
                ),
                make_v2_event(
                    "evt_200002",
                    "component_updated",
                    {
                        "component_id": "Q2",
                        "edit_reason": "normalized package hint",
                        "changes": [
                            {
                                "field": "package_hint",
                                "old_value_observed": "SOT-23 package",
                                "new_value": "SOT23-6 package",
                                "change_kind": "replace",
                            }
                        ],
                    },
                ),
            ]
        )

        component = next(item for item in data["components"] if item["component_id"] == "Q2")
        self.assertEqual(component["package_hint"], "SOT23-6 package")
        self.assertNotIn("confirmed_identity", component)
        self.assertNotIn("net_proof", component)
        self.assertNotIn("ai_proposal_id", component)

    def test_v2_event_invalidated_excludes_active_projection_but_preserves_history(self):
        data = run_materialize_events(
            [
                make_v2_event(
                    "evt_200001",
                    "measurement_recorded",
                    make_v2_measurement_payload("meas_001"),
                ),
                make_v2_event(
                    "evt_200002",
                    "event_invalidated",
                    {
                        "invalidates_event_id": "evt_200001",
                        "target_entity_id": "meas_001",
                        "reason": "mistyped_value",
                        "human_note": "wrong range",
                    },
                ),
            ]
        )

        measurement = next(item for item in data["measurements"] if item["measurement_id"] == "meas_001")
        self.assertEqual(measurement["validity_status"], "invalidated")
        self.assertEqual(measurement["valid_until_event_id"], "evt_200002")
        self.assertEqual(data["event_invalidations"][0]["invalidates_event_id"], "evt_200001")
        self.assertEqual(data["event_invalidations"][0]["source_event_id"], "evt_200002")

    def test_v2_superseded_measurement_resolution_preserves_history(self):
        data = run_materialize_events(
            [
                make_v2_event(
                    "evt_200001",
                    "measurement_recorded",
                    make_v2_measurement_payload("meas_old", value=3.1, display_value="3.1 V"),
                ),
                make_v2_event(
                    "evt_200002",
                    "measurement_recorded",
                    make_v2_measurement_payload("meas_new", value=3.3, display_value="3.3 V"),
                    supersedes_event_id="evt_200001",
                    corrects_event_id="evt_200001",
                ),
            ]
        )

        measurements = {item["source_event_id"]: item for item in data["measurements"]}
        self.assertEqual(measurements["evt_200001"]["validity_status"], "superseded")
        self.assertEqual(measurements["evt_200001"]["valid_until_event_id"], "evt_200002")
        self.assertEqual(measurements["evt_200002"]["validity_status"], "active")
        self.assertEqual(measurements["evt_200002"]["supersedes_event_id"], "evt_200001")
        self.assertEqual(measurements["evt_200002"]["corrects_event_id"], "evt_200001")

    def test_v2_divergent_measurements_surface_conflict_without_latest_wins(self):
        data = run_materialize_events(
            [
                make_v2_event(
                    "evt_200001",
                    "measurement_recorded",
                    make_v2_measurement_payload("meas_001", value=3.1, display_value="3.1 V"),
                ),
                make_v2_event(
                    "evt_200002",
                    "measurement_recorded",
                    make_v2_measurement_payload("meas_002", value=3.4, display_value="3.4 V"),
                ),
            ]
        )

        conflict = data["measurement_conflicts"][0]
        self.assertEqual(conflict["target_key"], "component:Q2:pin:1")
        self.assertEqual(conflict["mode"], "voltage")
        self.assertEqual(conflict["source_event_ids"], ["evt_200001", "evt_200002"])
        statuses = {item["source_event_id"]: item["validity_status"] for item in data["measurements"]}
        self.assertEqual(statuses["evt_200001"], "active_conflict")
        self.assertEqual(statuses["evt_200002"], "active_conflict")

    def test_v2_component_invalidation_surfaces_dependent_measurement_orphan(self):
        data = run_materialize_events(
            [
                make_v2_event(
                    "evt_200001",
                    "component_created",
                    make_v2_component_payload(),
                ),
                make_v2_event(
                    "evt_200002",
                    "measurement_recorded",
                    make_v2_measurement_payload("meas_001"),
                ),
                make_v2_event(
                    "evt_200003",
                    "event_invalidated",
                    {
                        "invalidates_event_id": "evt_200001",
                        "target_entity_id": "Q2",
                        "reason": "wrong_component",
                    },
                ),
            ]
        )

        measurement = next(item for item in data["measurements"] if item["measurement_id"] == "meas_001")
        self.assertEqual(measurement["orphan_status"], "component_invalidated")
        self.assertEqual(measurement["affected_by_event_id"], "evt_200003")
        self.assertEqual(data["orphaned_measurements"][0]["measurement_source_event_id"], "evt_200002")
        self.assertEqual(data["orphaned_measurements"][0]["invalidated_component_id"], "Q2")

    def test_v2_mixed_version_projection_preserves_v1_fixture_behavior(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "measurement_recorded",
                    {
                        "measurement_id": "M1",
                        "mode": "continuity",
                        "from": "Q2.1",
                        "to": "R1.1",
                        "reading": {"kind": "numeric", "value": 0.2, "unit": "ohm"},
                        "power_state": "off",
                    },
                ),
                make_v2_event(
                    "evt_200001",
                    "measurement_recorded",
                    make_v2_measurement_payload("meas_001"),
                ),
            ]
        )

        self.assertTrue(any(item.get("measurement_id") == "M1" for item in data["measurements"]))
        self.assertTrue(any(item.get("measurement_id") == "meas_001" for item in data["measurements"]))

    def test_v2_projection_does_not_generate_forbidden_artifacts(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            out_path = Path(tmpdir) / "known_facts.json"
            event = make_v2_event(
                "evt_200001",
                "measurement_recorded",
                make_v2_measurement_payload("meas_001"),
            )
            events_path.write_text(json.dumps(event) + "\n", encoding="utf-8")

            result = subprocess.run(
                [sys.executable, "tools/materialize_known_facts.py", str(events_path), str(out_path)],
                text=True,
                capture_output=True,
            )

            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            data = json.loads(out_path.read_text(encoding="utf-8"))
            self.assertFalse((Path(tmpdir) / "board_graph.json").exists())
            self.assertFalse((Path(tmpdir) / "view_state.json").exists())
            self.assertNotIn("board_graph", data)
            self.assertNotIn("view_state", data)
            self.assertNotIn("reference_image_evidence", json.dumps(data))

    def test_empty_events_produces_valid_known_facts(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "project"
            project_dir.mkdir()
            manifest_path = project_dir / "manifest.json"
            manifest_path.write_text(
                json.dumps(
                    {
                        "project_id": "prj_empty_001",
                        "schema_version": "1.0",
                        "created_at": "2026-05-25T00:00:00Z",
                    },
                    indent=2,
                ),
                encoding="utf-8",
            )
            events_path = project_dir / "events.jsonl"
            events_path.write_text("", encoding="utf-8")

            data = run_materialize(events_path)
            self.assertEqual(data["project_id"], "prj_empty_001")
            self.assertEqual(data["components"], [])
            self.assertEqual(data["measurements"], [])
            self.assertEqual(data["pins"], [])
            self.assertEqual(data["nets"], [])
            self.assertEqual(data["photos"], [])
            self.assertEqual(data["damage_regions"], [])
            self.assertEqual(data["suspect_regions"], [])
            self.assertEqual(data["visual_traces"], [])
            self.assertEqual(data["excluded_from_fault_candidates"], [])
            self.assertEqual(data["component_pin_index"], {})

    def test_empty_events_known_facts_has_project_id_from_manifest(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "project"
            project_dir.mkdir()
            (project_dir / "manifest.json").write_text(
                json.dumps(
                    {
                        "project_id": "prj_empty_manifest",
                        "schema_version": "1.0",
                        "created_at": "2026-05-25T00:00:00Z",
                    },
                    indent=2,
                ),
                encoding="utf-8",
            )
            (project_dir / "events.jsonl").write_text("", encoding="utf-8")
            data = run_materialize(project_dir / "events.jsonl")
            self.assertEqual(data["project_id"], "prj_empty_manifest")

    def test_empty_events_all_collections_are_empty(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "project"
            project_dir.mkdir()
            (project_dir / "manifest.json").write_text(
                json.dumps(
                    {
                        "project_id": "prj_empty_collections",
                        "schema_version": "1.0",
                        "created_at": "2026-05-25T00:00:00Z",
                    },
                    indent=2,
                ),
                encoding="utf-8",
            )
            (project_dir / "events.jsonl").write_text("", encoding="utf-8")
            data = run_materialize(project_dir / "events.jsonl")
            for key in (
                "components",
                "pins",
                "measurements",
                "nets",
                "photos",
                "damage_regions",
                "suspect_regions",
                "visual_traces",
                "excluded_from_fault_candidates",
            ):
                self.assertEqual(data[key], [])

    def test_empty_events_component_pin_index_is_empty_dict(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "project"
            project_dir.mkdir()
            (project_dir / "manifest.json").write_text(
                json.dumps(
                    {
                        "project_id": "prj_empty_pin_index",
                        "schema_version": "1.0",
                        "created_at": "2026-05-25T00:00:00Z",
                    },
                    indent=2,
                ),
                encoding="utf-8",
            )
            (project_dir / "events.jsonl").write_text("", encoding="utf-8")
            data = run_materialize(project_dir / "events.jsonl")
            self.assertEqual(data["component_pin_index"], {})

    def test_empty_events_without_manifest_uses_unknown_project_id(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            events_path.write_text("", encoding="utf-8")
            data = run_materialize(events_path)
            self.assertEqual(data["project_id"], "unknown")

    def test_whitespace_only_events_is_treated_as_empty(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            project_dir = Path(tmpdir) / "project"
            project_dir.mkdir()
            (project_dir / "manifest.json").write_text(
                json.dumps(
                    {
                        "project_id": "prj_empty_ws",
                        "schema_version": "1.0",
                        "created_at": "2026-05-25T00:00:00Z",
                    },
                    indent=2,
                ),
                encoding="utf-8",
            )
            events_path = project_dir / "events.jsonl"
            events_path.write_text("  \n\n\t\n", encoding="utf-8")
            data = run_materialize(events_path)
            self.assertEqual(data["project_id"], "prj_empty_ws")
            self.assertEqual(data["components"], [])

    def test_materialize_known_facts(self):
        data = run_materialize()
        self.assertEqual(data["project_id"], "prj_pelle_pv20_001")
        self.assertTrue(data["components"])
        self.assertTrue(data["measurements"])

    def test_stale_after_repair_preserved_in_output(self):
        data = run_materialize()
        stale_measurements = [m for m in data["measurements"] if m.get("validity_status") == "stale_after_repair"]
        self.assertTrue(stale_measurements)
        self.assertEqual(stale_measurements[0].get("measurement_id"), "M001")

    def test_stale_validity_status_set_correctly(self):
        data = run_materialize()
        pre = next((m for m in data["measurements"] if m.get("measurement_id") == "M001"), None)
        post = next((m for m in data["measurements"] if m.get("measurement_id") == "M002"), None)
        self.assertIsNotNone(pre)
        self.assertIsNotNone(post)
        self.assertEqual(pre["validity_status"], "stale_after_repair")
        self.assertEqual(pre.get("valid_until_event_id"), "evt_000007")
        self.assertEqual(post["validity_status"], "active")
        self.assertIsNone(post.get("valid_until_event_id"))

    def test_excluded_from_fault_candidates_present(self):
        data = run_materialize()
        excluded = data.get("excluded_from_fault_candidates", [])
        self.assertTrue(any(item.get("footprint_id") == "K1" for item in excluded))

    def test_three_footprints_excluded_from_fault_candidates(self):
        data = run_materialize()
        excluded = data.get("excluded_from_fault_candidates", [])
        excluded_ids = {item.get("footprint_id") for item in excluded}
        self.assertTrue({"K1", "K2", "K3"}.issubset(excluded_ids))

    def test_q2_pins_defined_in_events(self):
        events_path = Path("samples/pelle_pv20_minimal/events.jsonl")
        content = events_path.read_text(encoding="utf-8").splitlines()
        pin_events = []
        for line in content:
            event = json.loads(line)
            if event.get("event_type") == "pin_defined":
                payload = event.get("payload", {})
                if payload.get("component_id") == "Q2":
                    pin_events.append(payload.get("pin_id"))
                    self.assertIn("label", payload)
                    self.assertIn("status", payload)
        self.assertIn("Q2.2", pin_events)
        self.assertIn("Q2.3", pin_events)

    def test_net_confirmation_uses_post_repair_measurement(self):
        data = run_materialize()
        net = next((n for n in data["nets"] if n.get("net_id") == "N1"), None)
        self.assertIsNotNone(net)
        self.assertEqual(net.get("confirmation_basis"), "measured")
        self.assertIn("evt_000008", net.get("confirmed_by_event_ids", []))
        self.assertEqual(net.get("confirmation_basis"), "measured")

    def test_materialize_outputs_pins(self):
        data = run_materialize()
        pins = data.get("pins", [])
        self.assertTrue(pins)
        self.assertTrue(any(item.get("pin_id") == "Q2.1" for item in pins))

    def test_component_updated_materializes(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-22T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2", "marking": "K72", "status": "confirmed"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_updated",
                "status": "accepted",
                "payload": {"component_id": "Q2", "marking": "K73"},
            },
        ]
        data = run_materialize_events(events)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("marking"), "K73")

    def test_component_marked_unknown_status(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-22T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "status": "confirmed",
                    "mpn": "MPSA42",
                    "marking": "K72",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_marked_unknown",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
        ]
        data = run_materialize_events(events)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("status"), "needs_identification")
        self.assertNotIn("mpn", component)
        self.assertNotIn("marking", component)

    def test_remove_component_preserves_component_history(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "status": "identified",
                    "marking": "K72",
                    "mpn": "MPSA42",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "pin_defined",
                "status": "accepted",
                "payload": {"component_id": "Q2", "pin_id": "Q2.1"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-01-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "measurement_recorded",
                "status": "accepted",
                "payload": {
                    "measurement_id": "M1",
                    "mode": "continuity",
                    "from": "Q2.1",
                    "to": "R1.1",
                    "reading": {"kind": "numeric", "value": 0.1, "unit": "ohm"},
                    "power_state": "off",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000004",
                "project_id": "prj_test",
                "sequence": 4,
                "created_at": "2026-01-01T00:03:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA1",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertIsNotNone(component)
        self.assertEqual(component.get("status"), "identified")
        self.assertEqual(component.get("installation_status"), "removed")
        self.assertEqual(component.get("removed_by_event_id"), "evt_000004")
        self.assertIn("marking", component)
        self.assertEqual(component.get("marking"), "K72")
        self.assertIn("mpn", component)
        self.assertEqual(component.get("mpn"), "MPSA42")
        self.assertEqual(len(data.get("pins", [])), 1)
        self.assertIn("Q2.1", {pin.get("pin_id") for pin in data.get("pins", [])})

    def test_remove_component_marks_component_installation_status_removed(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA2",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("installation_status"), "removed")

    def test_remove_component_sets_removed_by_event_id(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA3",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("removed_by_event_id"), "evt_000002")

    def test_remove_component_does_not_change_component_status(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2", "status": "confirmed"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA4",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("status"), "confirmed")

    def test_remove_component_does_not_clear_identity_fields(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "type": "QFN",
                    "package": "SOT-23",
                    "marking": "K72",
                    "mpn": "MPSA42",
                    "status": "confirmed",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA5",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("type"), "QFN")
        self.assertEqual(component.get("package"), "SOT-23")
        self.assertEqual(component.get("marking"), "K72")
        self.assertEqual(component.get("mpn"), "MPSA42")

    def test_remove_component_marks_direct_measurements_stale(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "pin_defined",
                "status": "accepted",
                "payload": {"component_id": "Q2", "pin_id": "Q2.1"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-01-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "measurement_recorded",
                "status": "accepted",
                "payload": {
                    "measurement_id": "M1",
                    "mode": "continuity",
                    "from": "Q2.1",
                    "to": "R1.1",
                    "reading": {"kind": "numeric", "value": 0.1, "unit": "ohm"},
                    "power_state": "off",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000004",
                "project_id": "prj_test",
                "sequence": 4,
                "created_at": "2026-01-01T00:03:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA6",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        measurement = next(item for item in data["measurements"] if item.get("measurement_id") == "M1")
        self.assertEqual(measurement.get("validity_status"), "stale_after_repair")
        self.assertEqual(measurement.get("valid_until_event_id"), "evt_000004")

    def test_remove_component_does_not_delete_pins_or_measurements(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "pin_defined",
                "status": "accepted",
                "payload": {"component_id": "Q2", "pin_id": "Q2.1"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-01-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "measurement_recorded",
                "status": "accepted",
                "payload": {
                    "measurement_id": "M1",
                    "mode": "continuity",
                    "from": "Q2.1",
                    "to": "R1.1",
                    "reading": {"kind": "numeric", "value": 0.1, "unit": "ohm"},
                    "power_state": "off",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000004",
                "project_id": "prj_test",
                "sequence": 4,
                "created_at": "2026-01-01T00:03:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA7",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        self.assertTrue(data["pins"])
        self.assertTrue(data["measurements"])
        self.assertTrue(any(pin.get("pin_id") == "Q2.1" for pin in data["pins"]))
        self.assertTrue(any(measurement.get("measurement_id") == "M1" for measurement in data["measurements"]))

    def test_remove_component_does_not_create_nets_or_measurements(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA8",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        self.assertFalse(data.get("nets"))

    def test_remove_component_does_not_write_board_graph_or_view_state(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            temp_path = Path(tmpdir) / "events.jsonl"
            output_path = Path(tmpdir) / "known_facts.json"
            with temp_path.open("w", encoding="utf-8") as handle:
                handle.write(
                    "\n".join(
                        [
                            json.dumps(
                                {
                                    "schema_version": "1.0",
                                    "event_id": "evt_000001",
                                    "project_id": "prj_test",
                                    "sequence": 1,
                                    "created_at": "2026-01-01T00:00:00Z",
                                    "actor": {"type": "user", "id": "u1"},
                                    "event_type": "component_created",
                                    "status": "accepted",
                                    "payload": {"component_id": "Q2"},
                                }
                            ),
                            "\n",
                            json.dumps(
                                {
                                    "schema_version": "1.0",
                                    "event_id": "evt_000002",
                                    "project_id": "prj_test",
                                    "sequence": 2,
                                    "created_at": "2026-01-01T00:01:00Z",
                                    "actor": {"type": "user", "id": "u1"},
                                    "event_type": "repair_action_recorded",
                                    "status": "accepted",
                                    "payload": {
                                        "repair_action_id": "RA9",
                                        "action_type": "remove_component",
                                        "targets": [{"target_type": "component", "target_id": "Q2"}],
                                        "reason": "remove component",
                                        "invalidation_policy": {
                                            "direct_component_measurements": "stale_after_repair",
                                            "connected_net_measurements": "no_change",
                                        },
                                    },
                                }
                            ),
                        ]
                    )
                )
            result = subprocess.run(
                [
                    sys.executable,
                    "tools/materialize_known_facts.py",
                    str(temp_path),
                    str(output_path),
                ],
                text=True,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((Path(tmpdir) / "board_graph.json").exists())
            self.assertFalse((Path(tmpdir) / "view_state.json").exists())

    def test_remove_component_does_not_mutate_samples_or_assets(self):
        sample_path = Path("samples/pelle_pv20_minimal/events.jsonl")
        known_facts_path = Path("samples/pelle_pv20_minimal/known_facts.json")
        asset_known_facts_path = Path("assets/samples/pelle_pv20_minimal/known_facts.json")

        sample_before = sample_path.read_text(encoding="utf-8")
        known_facts_before = known_facts_path.read_text(encoding="utf-8")
        asset_before = asset_known_facts_path.read_text(encoding="utf-8")
        run_materialize(sample_path)
        self.assertEqual(sample_path.read_text(encoding="utf-8"), sample_before)
        self.assertEqual(known_facts_path.read_text(encoding="utf-8"), known_facts_before)
        self.assertEqual(asset_known_facts_path.read_text(encoding="utf-8"), asset_before)

    def test_component_pin_index_in_output(self):
        data = run_materialize()
        component_pin_index = data.get("component_pin_index")
        self.assertIsInstance(component_pin_index, dict)
        self.assertIn("Q2", component_pin_index)
        self.assertIn("Q2.1", component_pin_index["Q2"])

    def test_q2_pins_are_materialized(self):
        data = run_materialize()
        q2_pins = [item for item in data["pins"] if item.get("component_id") == "Q2"]
        self.assertTrue({pin.get("pin_id") for pin in q2_pins}.issuperset({"Q2.1", "Q2.2", "Q2.3"}))

        q2_2 = next(item for item in q2_pins if item.get("pin_id") == "Q2.2")
        self.assertIsNone(q2_2.get("label"))
        self.assertEqual(q2_2.get("status"), "unknown")

    def test_net_confirmation_uses_stale_measurement(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "measurement_recorded",
                "status": "accepted",
                "payload": {
                    "measurement_id": "M001",
                    "mode": "continuity",
                    "from": "Q2.1",
                    "to": "R1.1",
                    "reading": {"kind": "numeric", "value": 0.1, "unit": "ohm"},
                    "power_state": "off",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-01-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA1",
                    "action_type": "replace_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "replace",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000004",
                "project_id": "prj_test",
                "sequence": 4,
                "created_at": "2026-01-01T00:03:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "Q2.1",
                    "to": "R1.1",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000002"],
                },
            },
        ]
        data = run_materialize_events(events)
        self.assertFalse(any(item.get("net_id") == "N1" for item in data.get("nets", [])))

    def test_photos_list_in_known_facts(self):
        data = run_materialize()
        photos = data.get("photos", [])
        self.assertTrue(photos)
        self.assertTrue(any(photo.get("photo_id") == "photo_top_backlight_001" for photo in photos))

    def test_damage_regions_in_known_facts(self):
        data = run_materialize()
        damage_regions = data.get("damage_regions", [])
        self.assertTrue(damage_regions)
        self.assertTrue(any(region.get("region_id") == "DMG001" for region in damage_regions))

    def test_visual_trace_evidence_type_is_visual_trace(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_backlight_001",
                    "mode": "backlight",
                    "path": "photos/top_backlight_001.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT001",
                    "photo_id": "photo_top_backlight_001",
                    "from_point": {"x": 1, "y": 2},
                    "to_point": {"x": 3, "y": 4},
                    "evidence_type": "visual_trace",
                },
            },
        ]
        data = run_materialize_events(events)
        traces = data.get("visual_traces", [])
        self.assertEqual(len(traces), 1)
        self.assertEqual(traces[0].get("evidence_type"), "visual_trace")

    def test_visual_trace_not_in_nets_list(self):
        data = run_materialize()
        traces = {trace.get("trace_id") for trace in data.get("visual_traces", [])}
        net_trace_ids = {
            net.get("trace_id")
            for net in data.get("nets", [])
            if isinstance(net, dict)
        }
        self.assertFalse(traces.intersection(net_trace_ids))

    def test_component_visual_placements_projection_is_top_level(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-27T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-27T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.4,
                    "center_y": 0.3,
                    "rotation_deg": 0,
                    "scale": 0.2,
                },
            },
        ]
        data = run_materialize_events(events)
        placements = data.get("component_visual_placements", [])
        self.assertEqual(len(placements), 1)
        self.assertEqual(placements[0].get("component_id"), "Q2")
        self.assertEqual(placements[0].get("source_event_id"), "evt_000002")
        self.assertEqual(placements[0].get("status"), "user_confirmed_visual")

    def test_component_visual_placements_uses_latest_accepted_per_component(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-27T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-27T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.2,
                    "center_y": 0.2,
                    "rotation_deg": 0,
                    "scale": 0.1,
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-27T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.7,
                    "center_y": 0.6,
                    "rotation_deg": 15,
                    "width": 0.12,
                    "height": 0.08,
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000004",
                "project_id": "prj_test",
                "sequence": 4,
                "created_at": "2026-05-27T00:03:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "draft",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.1,
                    "center_y": 0.1,
                    "rotation_deg": 0,
                    "scale": 0.05,
                },
            },
        ]
        data = run_materialize_events(events)
        placements = data.get("component_visual_placements", [])
        self.assertEqual(len(placements), 1)
        placement = placements[0]
        self.assertEqual(placement.get("source_event_id"), "evt_000003")
        self.assertNotIn("scale", placement)
        self.assertEqual(placement.get("width"), 0.12)
        self.assertEqual(placement.get("height"), 0.08)

    def test_component_visual_placements_photo_local_keeps_source_photo_id(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-27T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-27T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_backlight_001",
                    "mode": "backlight",
                    "path": "photos/top_backlight_001.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-27T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "photo_local",
                    "board_side": "top",
                    "center_x": 120.0,
                    "center_y": 85.0,
                    "rotation_deg": -10,
                    "scale": 1.1,
                    "source_photo_id": "photo_top_backlight_001",
                },
            },
        ]
        data = run_materialize_events(events)
        placement = data["component_visual_placements"][0]
        self.assertEqual(placement.get("coordinate_space"), "photo_local")
        self.assertEqual(placement.get("source_photo_id"), "photo_top_backlight_001")

    def test_component_visual_placements_board_normalized_has_no_source_photo_id(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-27T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-27T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "bottom",
                    "center_x": 0.5,
                    "center_y": 0.5,
                    "rotation_deg": 0,
                    "scale": 0.15,
                },
            },
        ]
        data = run_materialize_events(events)
        placement = data["component_visual_placements"][0]
        self.assertEqual(placement.get("coordinate_space"), "board_normalized")
        self.assertNotIn("source_photo_id", placement)

    def test_component_visual_placements_template_id_is_projected_as_visual_metadata(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-27T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-27T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.3,
                    "center_y": 0.6,
                    "rotation_deg": 0,
                    "scale": 0.2,
                    "template_id": "sot23_3",
                },
            },
        ]
        data = run_materialize_events(events)
        placement = data["component_visual_placements"][0]
        self.assertEqual(placement.get("template_id"), "sot23_3")

    def test_component_visual_placements_do_not_create_electrical_or_fault_side_effects(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-27T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-27T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "footprint_marked_not_populated",
                "status": "accepted",
                "payload": {
                    "footprint_id": "K1",
                    "population_status": "not_populated",
                    "allowed_in_fault_hypotheses": False,
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-27T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "unknown",
                    "center_x": 0.5,
                    "center_y": 0.5,
                    "rotation_deg": 0,
                    "width": 0.2,
                    "height": 0.1,
                },
            },
        ]
        data = run_materialize_events(events)
        self.assertEqual(data.get("nets"), [])
        self.assertEqual(data.get("measurements"), [])
        self.assertEqual(data.get("excluded_from_fault_candidates"), [{"footprint_id": "K1"}])

    def test_component_visual_placement_is_kept_for_removed_component(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-27T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-27T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.5,
                    "center_y": 0.5,
                    "rotation_deg": 0,
                    "scale": 0.2,
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-27T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA1",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        data = run_materialize_events(events)
        self.assertEqual(len(data.get("component_visual_placements", [])), 1)
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("installation_status"), "removed")

    def test_v2_component_visual_placement_materializes_from_human_confirmation(self):
        events = [
            make_v2_event(
                "evt_200001",
                "component_created",
                make_v2_component_payload(),
                client_operation_id="op_v2_000001",
            ),
            make_v2_event(
                "evt_200002",
                "component_visual_placement_confirmed",
                make_v2_component_visual_placement_payload(template_id="sot23_3"),
                client_operation_id="op_v2_000002",
            ),
        ]

        data = run_materialize_events(events)

        placements = data.get("component_visual_placements", [])
        self.assertEqual(len(placements), 1)
        placement = placements[0]
        self.assertEqual(placement.get("component_id"), "Q2")
        self.assertEqual(placement.get("source_event_id"), "evt_200002")
        self.assertEqual(placement.get("status"), "user_confirmed_visual")
        self.assertEqual(placement.get("width"), 0.12)
        self.assertEqual(placement.get("height"), 0.08)
        self.assertNotIn("scale", placement)
        self.assertEqual(placement.get("template_id"), "sot23_3")

    def test_v2_component_visual_placement_latest_confirmation_wins(self):
        events = [
            make_v2_event(
                "evt_200001",
                "component_created",
                make_v2_component_payload(),
                client_operation_id="op_v2_000001",
            ),
            make_v2_event(
                "evt_200002",
                "component_visual_placement_confirmed",
                make_v2_component_visual_placement_payload(center_x=0.1, center_y=0.2),
                client_operation_id="op_v2_000002",
            ),
            make_v2_event(
                "evt_200003",
                "component_visual_placement_confirmed",
                make_v2_component_visual_placement_payload(
                    center_x=0.7,
                    center_y=0.6,
                    width=0.2,
                    height=0.1,
                ),
                client_operation_id="op_v2_000003",
            ),
        ]

        data = run_materialize_events(events)

        placements = data.get("component_visual_placements", [])
        self.assertEqual(len(placements), 1)
        placement = placements[0]
        self.assertEqual(placement.get("source_event_id"), "evt_200003")
        self.assertEqual(placement.get("center_x"), 0.7)
        self.assertEqual(placement.get("center_y"), 0.6)
        self.assertEqual(placement.get("width"), 0.2)
        self.assertEqual(placement.get("height"), 0.1)

    def test_v2_component_visual_placement_without_human_confirmation_does_not_materialize(self):
        event = make_v2_event(
            "evt_200001",
            "component_visual_placement_confirmed",
            make_v2_component_visual_placement_payload(),
            client_operation_id="op_v2_000001",
        )
        event["confirmation"]["confirmed"] = False

        data = run_materialize_events([event])

        self.assertNotIn("component_visual_placements", data)

    def test_known_facts_schema_includes_component_visual_placements(self):
        schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
        placements = schema.get("properties", {}).get("component_visual_placements")
        self.assertIsInstance(placements, dict)
        item = placements.get("items", {})
        required = set(item.get("required", []))
        self.assertIn("component_id", required)
        self.assertIn("coordinate_space", required)
        self.assertIn("source_event_id", required)
        self.assertIn("status", required)

    def test_known_facts_schema_includes_photo_to_board_alignments(self):
        schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
        alignments = schema.get("properties", {}).get("photo_to_board_alignments")
        self.assertIsInstance(alignments, dict)
        item = alignments.get("items", {})
        required = set(item.get("required", []))
        self.assertIn("alignment_id", required)
        self.assertIn("source_event_id", required)
        self.assertIn("status", required)

    def test_known_facts_schema_photo_alignment_status_enum_locked(self):
        schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
        status_enum = (
            schema.get("properties", {})
            .get("photo_to_board_alignments", {})
            .get("items", {})
            .get("properties", {})
            .get("status", {})
            .get("enum", [])
        )
        self.assertEqual(status_enum, ["user_confirmed_alignment"])

    def test_known_facts_schema_photo_alignment_coordinate_space_from_const(self):
        schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
        const_value = (
            schema.get("properties", {})
            .get("photo_to_board_alignments", {})
            .get("items", {})
            .get("properties", {})
            .get("coordinate_space_from", {})
            .get("const")
        )
        self.assertEqual(const_value, "photo_local")

    def test_known_facts_schema_photo_alignment_board_point_range(self):
        schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
        board_point = (
            schema.get("properties", {})
            .get("photo_to_board_alignments", {})
            .get("items", {})
            .get("properties", {})
            .get("reference_points_board", {})
            .get("items", {})
            .get("properties", {})
            .get("x", {})
        )
        self.assertEqual(board_point.get("minimum"), 0)
        self.assertEqual(board_point.get("maximum"), 1)

    def test_photo_to_board_alignment_projects_accepted_user_event(self):
        events = [
            make_event(
                "evt_100001",
                100001,
                "photo_added",
                {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
            ),
            make_event(
                "evt_100002",
                100002,
                "photo_to_board_alignment_confirmed",
                {
                    "alignment_id": "ALN1001",
                    "source_photo_id": "photo_top_001",
                    "board_side": "top",
                    "coordinate_space_from": "photo_local",
                    "coordinate_space_to": "board_normalized",
                    "reference_points_photo": [{"x": 12.0, "y": 34.0}, {"x": 56.0, "y": 78.0}],
                    "reference_points_board": [{"x": 0.12, "y": 0.34}, {"x": 0.56, "y": 0.78}],
                    "transform_type": "similarity",
                    "alignment_quality_label": "manual_check_ok",
                    "notes": "operator confirmed",
                },
            ),
        ]
        data = run_materialize_events(events)
        self.assertIn("photo_to_board_alignments", data)
        self.assertEqual(len(data["photo_to_board_alignments"]), 1)
        alignment = data["photo_to_board_alignments"][0]
        self.assertEqual(alignment["alignment_id"], "ALN1001")
        self.assertEqual(alignment["source_photo_id"], "photo_top_001")
        self.assertEqual(alignment["board_side"], "top")
        self.assertEqual(alignment["coordinate_space_from"], "photo_local")
        self.assertEqual(alignment["coordinate_space_to"], "board_normalized")
        self.assertEqual(alignment["reference_points_photo"], [{"x": 12.0, "y": 34.0}, {"x": 56.0, "y": 78.0}])
        self.assertEqual(alignment["reference_points_board"], [{"x": 0.12, "y": 0.34}, {"x": 0.56, "y": 0.78}])
        self.assertEqual(alignment["transform_type"], "similarity")
        self.assertEqual(alignment["alignment_quality_label"], "manual_check_ok")
        self.assertEqual(alignment["source_event_id"], "evt_100002")
        self.assertEqual(alignment["status"], "user_confirmed_alignment")
        self.assertEqual(alignment["notes"], "operator confirmed")

    def test_photo_to_board_alignment_omits_notes_when_absent(self):
        events = [
            make_event(
                "evt_100001",
                100001,
                "photo_added",
                {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
            ),
            make_event(
                "evt_100002",
                100002,
                "photo_to_board_alignment_confirmed",
                {
                    "alignment_id": "ALN1002",
                    "source_photo_id": "photo_top_001",
                    "board_side": "bottom",
                    "coordinate_space_from": "photo_local",
                    "coordinate_space_to": "board_normalized",
                    "reference_points_photo": [{"x": 1.0, "y": 2.0}, {"x": 3.0, "y": 4.0}],
                    "reference_points_board": [{"x": 0.1, "y": 0.2}, {"x": 0.3, "y": 0.4}],
                    "transform_type": "affine",
                    "alignment_quality_label": "good",
                },
            ),
        ]
        data = run_materialize_events(events)
        alignment = data["photo_to_board_alignments"][0]
        self.assertNotIn("notes", alignment)

    def test_photo_to_board_alignment_projection_matches_schema_required_fields(self):
        schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
        required = set(
            schema.get("properties", {})
            .get("photo_to_board_alignments", {})
            .get("items", {})
            .get("required", [])
        )
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN1003",
                        "source_photo_id": "photo_top_001",
                        "board_side": "unknown",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 10.0, "y": 10.0}, {"x": 20.0, "y": 20.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                ),
            ]
        )
        alignment = data["photo_to_board_alignments"][0]
        self.assertTrue(required.issubset(set(alignment.keys())))

    def test_photo_to_board_alignment_projection_item_validates_against_known_facts_schema(self):
        schema = json.loads(Path("schemas/known_facts.schema.json").read_text(encoding="utf-8"))
        item_schema = (
            schema.get("properties", {})
            .get("photo_to_board_alignments", {})
            .get("items", {})
        )
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN1004",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 5.0, "y": 6.0}, {"x": 7.0, "y": 8.0}],
                        "reference_points_board": [{"x": 0.05, "y": 0.06}, {"x": 0.07, "y": 0.08}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "manual_ok",
                        "notes": "schema contract test",
                    },
                ),
            ]
        )
        alignment = data["photo_to_board_alignments"][0]
        errors = _validate_json_schema_subset(alignment, item_schema, "$.photo_to_board_alignments[0]")
        self.assertEqual(errors, [], "\n".join(errors))

    def test_photo_to_board_alignments_omitted_when_no_alignment_events_exist(self):
        data = run_materialize_events([make_event("evt_100001", 100001, "component_created", {"component_id": "Q2"})])
        self.assertNotIn("photo_to_board_alignments", data)

    def test_rejected_photo_to_board_alignment_does_not_project(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN2001",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                    status="rejected",
                ),
            ]
        )
        self.assertNotIn("photo_to_board_alignments", data)

    def test_draft_photo_to_board_alignment_does_not_project(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN2002",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                    status="draft",
                ),
            ]
        )
        self.assertNotIn("photo_to_board_alignments", data)

    def test_superseded_photo_to_board_alignment_does_not_project(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN2003",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                    status="superseded",
                ),
            ]
        )
        self.assertNotIn("photo_to_board_alignments", data)

    def test_ai_actor_photo_to_board_alignment_does_not_project(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN3001",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                    actor_type="ai",
                ),
            ]
        )
        self.assertNotIn("photo_to_board_alignments", data)

    def test_system_actor_photo_to_board_alignment_does_not_project(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN3002",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                    actor_type="system",
                ),
            ]
        )
        self.assertNotIn("photo_to_board_alignments", data)

    def test_import_actor_photo_to_board_alignment_does_not_project(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN3003",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                    actor_type="import",
                ),
            ]
        )
        self.assertNotIn("photo_to_board_alignments", data)

    def test_latest_accepted_photo_to_board_alignment_wins_by_alignment_id(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN4001",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 10.0, "y": 10.0}, {"x": 20.0, "y": 20.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "first",
                    },
                ),
                make_event(
                    "evt_100003",
                    100003,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN4001",
                        "source_photo_id": "photo_top_001",
                        "board_side": "bottom",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 11.0, "y": 11.0}, {"x": 21.0, "y": 21.0}],
                        "reference_points_board": [{"x": 0.11, "y": 0.11}, {"x": 0.21, "y": 0.21}],
                        "transform_type": "affine",
                        "alignment_quality_label": "second",
                    },
                ),
            ]
        )
        self.assertEqual(len(data["photo_to_board_alignments"]), 1)
        alignment = data["photo_to_board_alignments"][0]
        self.assertEqual(alignment["board_side"], "bottom")
        self.assertEqual(alignment["transform_type"], "affine")
        self.assertEqual(alignment["alignment_quality_label"], "second")
        self.assertEqual(alignment["source_event_id"], "evt_100003")

    def test_two_photo_to_board_alignment_ids_both_project(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN5001",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "a",
                    },
                ),
                make_event(
                    "evt_100003",
                    100003,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN5002",
                        "source_photo_id": "photo_top_001",
                        "board_side": "bottom",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 3.0, "y": 3.0}, {"x": 4.0, "y": 4.0}],
                        "reference_points_board": [{"x": 0.3, "y": 0.3}, {"x": 0.4, "y": 0.4}],
                        "transform_type": "affine",
                        "alignment_quality_label": "b",
                    },
                ),
            ]
        )
        self.assertEqual(
            {item["alignment_id"] for item in data["photo_to_board_alignments"]},
            {"ALN5001", "ALN5002"},
        )

    def test_photo_to_board_alignment_projection_has_no_side_effect_collections(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN6001",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                ),
            ]
        )
        self.assertEqual(data.get("components"), [])
        self.assertEqual(data.get("pins"), [])
        self.assertEqual(data.get("measurements"), [])
        self.assertEqual(data.get("nets"), [])
        self.assertEqual(data.get("visual_traces"), [])
        self.assertEqual(data.get("damage_regions"), [])
        self.assertEqual(data.get("suspect_regions"), [])
        self.assertEqual(data.get("excluded_from_fault_candidates"), [])

    def test_photo_to_board_alignment_projection_does_not_write_board_graph_or_view_state(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            events_path = Path(tmpdir) / "events.jsonl"
            out_path = Path(tmpdir) / "known_facts.json"
            events = [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "photo_to_board_alignment_confirmed",
                    {
                        "alignment_id": "ALN7001",
                        "source_photo_id": "photo_top_001",
                        "board_side": "top",
                        "coordinate_space_from": "photo_local",
                        "coordinate_space_to": "board_normalized",
                        "reference_points_photo": [{"x": 1.0, "y": 1.0}, {"x": 2.0, "y": 2.0}],
                        "reference_points_board": [{"x": 0.1, "y": 0.1}, {"x": 0.2, "y": 0.2}],
                        "transform_type": "similarity",
                        "alignment_quality_label": "ok",
                    },
                ),
            ]
            with events_path.open("w", encoding="utf-8") as handle:
                for event in events:
                    handle.write(json.dumps(event) + "\n")
            result = subprocess.run(
                [sys.executable, "tools/materialize_known_facts.py", str(events_path), str(out_path)],
                text=True,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((Path(tmpdir) / "board_graph.json").exists())
            self.assertFalse((Path(tmpdir) / "view_state.json").exists())

    def test_pelle_photo_placeholder_materialized(self):
        data = run_materialize()
        self.assertEqual(data.get("suspect_regions", []), [])
        self.assertEqual(data.get("visual_traces", []), [])
        self.assertTrue(any(
            photo.get("photo_id") == "photo_top_backlight_001" and photo.get("mode") == "backlight"
            for photo in data.get("photos", [])
        ))

    def test_non_accepted_component_created_does_not_materialize_component(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "component_created",
                    {"component_id": "Q2", "status": "identified"},
                    status="rejected",
                )
            ]
        )
        self.assertEqual(data["components"], [])

    def test_non_accepted_component_updated_does_not_mutate_component(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "component_created",
                    {"component_id": "Q2", "status": "identified", "marking": "K72"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "component_updated",
                    {"component_id": "Q2", "marking": "K73"},
                    status="rejected",
                ),
            ]
        )
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("marking"), "K72")

    def test_non_accepted_component_marked_unknown_does_not_clear_identity(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "component_created",
                    {
                        "component_id": "Q2",
                        "status": "identified",
                        "mpn": "MPSA42",
                        "marking": "K72",
                    },
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "component_marked_unknown",
                    {"component_id": "Q2"},
                    status="rejected",
                ),
            ]
        )
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(component.get("status"), "identified")
        self.assertEqual(component.get("mpn"), "MPSA42")
        self.assertEqual(component.get("marking"), "K72")

    def test_non_accepted_pin_defined_does_not_materialize_pin(self):
        data = run_materialize_events(
            [
                make_event("evt_100001", 100001, "component_created", {"component_id": "Q2"}),
                make_event(
                    "evt_100002",
                    100002,
                    "pin_defined",
                    {"component_id": "Q2", "pin_id": "Q2.1"},
                    status="rejected",
                ),
            ]
        )
        self.assertEqual(data["pins"], [])

    def test_non_accepted_measurement_recorded_does_not_materialize_measurement(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "measurement_recorded",
                    {
                        "measurement_id": "M1",
                        "mode": "continuity",
                        "from": "Q2.1",
                        "to": "R1.1",
                        "reading": {"kind": "numeric", "value": 0.2, "unit": "ohm"},
                        "power_state": "off",
                    },
                    status="rejected",
                )
            ]
        )
        self.assertEqual(data["measurements"], [])

    def test_non_accepted_net_connection_confirmed_does_not_materialize_net(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "measurement_recorded",
                    {
                        "measurement_id": "M1",
                        "mode": "continuity",
                        "from": "Q2.1",
                        "to": "R1.1",
                        "reading": {"kind": "numeric", "value": 0.2, "unit": "ohm"},
                        "power_state": "off",
                    },
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "net_connection_confirmed",
                    {
                        "net_id": "N1",
                        "from": "Q2.1",
                        "to": "R1.1",
                        "confirmed_by_event_ids": ["evt_100001"],
                    },
                    status="rejected",
                ),
            ]
        )
        self.assertEqual(data["nets"], [])

    def test_non_accepted_photo_added_does_not_materialize_photo(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                    status="rejected",
                )
            ]
        )
        self.assertEqual(data["photos"], [])

    def test_non_accepted_damage_region_does_not_materialize_damage_region(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "damage_region_marked",
                    {
                        "region_id": "DMG1",
                        "photo_id": "photo_top_001",
                        "bbox": {"x": 10, "y": 20, "width": 30, "height": 40},
                        "damage_type": "burn",
                    },
                    status="rejected",
                ),
            ]
        )
        self.assertEqual(data["damage_regions"], [])

    def test_non_accepted_suspect_region_does_not_materialize_suspect_region(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "suspect_region_marked",
                    {
                        "region_id": "SUSP1",
                        "photo_id": "photo_top_001",
                        "bbox": {"x": 15, "y": 25, "width": 35, "height": 45},
                        "reason": "possible short",
                    },
                    status="rejected",
                ),
            ]
        )
        self.assertEqual(data["suspect_regions"], [])

    def test_non_accepted_visual_trace_does_not_materialize_visual_trace(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "photo_added",
                    {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "visual_trace_added",
                    {
                        "trace_id": "VT1",
                        "photo_id": "photo_top_001",
                        "from_point": {"x": 1, "y": 2},
                        "to_point": {"x": 3, "y": 4},
                        "evidence_type": "visual_trace",
                    },
                    status="rejected",
                ),
            ]
        )
        self.assertEqual(data["visual_traces"], [])

    def test_non_accepted_footprint_marked_not_populated_does_not_create_exclusion(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "footprint_marked_not_populated",
                    {"footprint_id": "K1"},
                    status="rejected",
                )
            ]
        )
        self.assertEqual(data["excluded_from_fault_candidates"], [])

    def test_non_accepted_repair_action_remove_component_does_not_remove_component(self):
        data = run_materialize_events(
            [
                make_event("evt_100001", 100001, "component_created", {"component_id": "Q2"}),
                make_event(
                    "evt_100002",
                    100002,
                    "repair_action_recorded",
                    {
                        "repair_action_id": "RA1",
                        "action_type": "remove_component",
                        "targets": [{"target_type": "component", "target_id": "Q2"}],
                        "invalidation_policy": {
                            "direct_component_measurements": "stale_after_repair",
                            "connected_net_measurements": "no_change",
                        },
                    },
                    status="rejected",
                ),
            ]
        )
        component = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertNotEqual(component.get("installation_status"), "removed")

    def test_non_accepted_repair_action_does_not_stale_measurements(self):
        data = run_materialize_events(
            [
                make_event("evt_100001", 100001, "component_created", {"component_id": "Q2"}),
                make_event(
                    "evt_100002",
                    100002,
                    "measurement_recorded",
                    {
                        "measurement_id": "M1",
                        "mode": "continuity",
                        "from": "Q2.1",
                        "to": "R1.1",
                        "reading": {"kind": "numeric", "value": 0.2, "unit": "ohm"},
                        "power_state": "off",
                    },
                ),
                make_event(
                    "evt_100003",
                    100003,
                    "repair_action_recorded",
                    {
                        "repair_action_id": "RA2",
                        "action_type": "remove_component",
                        "targets": [{"target_type": "component", "target_id": "Q2"}],
                        "invalidation_policy": {
                            "direct_component_measurements": "stale_after_repair",
                            "connected_net_measurements": "no_change",
                        },
                    },
                    status="rejected",
                ),
            ]
        )
        measurement = next(item for item in data["measurements"] if item.get("measurement_id") == "M1")
        self.assertEqual(measurement.get("validity_status"), "active")
        self.assertIsNone(measurement.get("valid_until_event_id"))

    def test_non_accepted_component_visual_placement_does_not_materialize(self):
        data = run_materialize_events(
            [
                make_event("evt_100001", 100001, "component_created", {"component_id": "Q2"}),
                make_event(
                    "evt_100002",
                    100002,
                    "component_visual_placement_confirmed",
                    {
                        "component_id": "Q2",
                        "coordinate_space": "board_normalized",
                        "board_side": "top",
                        "center_x": 0.5,
                        "center_y": 0.4,
                        "rotation_deg": 0.0,
                        "scale": 0.2,
                    },
                    status="rejected",
                ),
            ]
        )
        self.assertNotIn("component_visual_placements", data)

    def test_project_id_prefers_manifest_over_events(self):
        manifest = {
            "project_id": "prj_manifest",
            "schema_version": "1.0",
            "created_at": "2026-05-27T00:00:00Z",
        }
        data = run_materialize_project(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "component_created",
                    {"component_id": "Q2"},
                    status="rejected",
                    project_id="prj_rejected",
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "component_created",
                    {"component_id": "Q3"},
                    project_id="prj_accepted",
                ),
            ],
            manifest=manifest,
        )
        self.assertEqual(data["project_id"], "prj_manifest")

    def test_project_id_falls_back_to_first_accepted_event_when_manifest_unknown(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "component_created",
                    {"component_id": "Q2"},
                    status="rejected",
                    project_id="prj_rejected",
                ),
                make_event(
                    "evt_100002",
                    100002,
                    "component_created",
                    {"component_id": "Q3"},
                    project_id="prj_accepted_first",
                ),
                make_event(
                    "evt_100003",
                    100003,
                    "component_created",
                    {"component_id": "Q4"},
                    project_id="prj_accepted_later",
                ),
            ]
        )
        self.assertEqual(data["project_id"], "prj_accepted_first")

    def test_project_id_stays_unknown_when_only_non_accepted_events_exist(self):
        data = run_materialize_events(
            [
                make_event(
                    "evt_100001",
                    100001,
                    "component_created",
                    {"component_id": "Q2"},
                    status="draft",
                    project_id="prj_draft_only",
                )
            ]
        )
        self.assertEqual(data["project_id"], "unknown")


if __name__ == "__main__":
    unittest.main()
