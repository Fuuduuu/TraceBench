import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


def _run_validator(events_jsonl: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, "tools/validate_events_jsonl.py", events_jsonl],
        text=True,
        capture_output=True,
    )


def _events_to_temp_jsonl(events):
    with tempfile.NamedTemporaryFile(mode="w", suffix=".jsonl", delete=False, encoding="utf-8") as handle:
        for event in events:
            handle.write(json.dumps(event) + "\n")
        return handle.name


class ValidateEventsJsonlTests(unittest.TestCase):
    def test_pelle_sample_validates(self):
        result = subprocess.run(
            [
                sys.executable,
                "tools/validate_events_jsonl.py",
                "samples/pelle_pv20_minimal/events.jsonl",
                "schemas/events.schema.json",
            ],
            text=True,
            capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_ai_actor_measurement_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "ai", "id": "ai_1"},
                "event_type": "measurement_recorded",
                "status": "accepted",
                "payload": {
                    "measurement_id": "M1",
                    "mode": "continuity",
                    "from": "A1",
                    "to": "A2",
                    "reading": {"kind": "numeric", "value": 0.1, "unit": "ohm"},
                    "power_state": "off",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("actor.type='ai' is forbidden", result.stdout + result.stderr)

    def test_photo_added_valid_passes(self):
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
                    "layer": "top",
                    "notes": "Backlight",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_photo_added_ai_actor_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "ai", "id": "ai_1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_backlight_001",
                    "mode": "backlight",
                    "path": "photos/top_backlight_001.jpg",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("photo_added actor.type='ai' is forbidden", result.stdout + result.stderr)

    def test_photo_added_invalid_path_rejected(self):
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
                    "photo_id": "photo_front",
                    "mode": "backlight",
                    "path": "notphotos/image.txt",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("path must start with photos/ and use allowed image extension", result.stdout + result.stderr)

    def test_net_confirmed_without_measurement_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "x"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "A1",
                    "to": "A2",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000001"],
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must point to measurement_recorded", result.stdout + result.stderr)

    def test_pin_defined_without_label_allowed(self):
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
                "payload": {"component_id": "Q2", "status": "needs_identification"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "pin_defined",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "pin_id": "Q2.1",
                    "status": "unknown",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_repair_without_invalidation_policy_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA1",
                    "action_type": "replace_component",
                    "targets": [{"target_type": "component", "target_id": "C1"}],
                    "reason": "replace",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_damage_region_requires_photo_id_cross_reference(self):
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
                "event_type": "damage_region_marked",
                "status": "accepted",
                "payload": {
                    "region_id": "DMG001",
                    "photo_id": "photo_top_backlight_001",
                    "bbox": {"x": 1, "y": 2, "width": 3, "height": 4},
                    "damage_type": "burn",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_damage_region_unknown_photo_id_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "damage_region_marked",
                "status": "accepted",
                "payload": {
                    "region_id": "DMG001",
                    "photo_id": "photo_missing",
                    "bbox": {"x": 1, "y": 2, "width": 3, "height": 4},
                    "damage_type": "burn",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference existing photo_added photo_id", result.stdout + result.stderr)

    def test_visual_trace_requires_photo_id(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT001",
                    "photo_id": "photo_missing",
                    "from_point": {"x": 1, "y": 2},
                    "to_point": {"x": 3, "y": 4},
                    "evidence_type": "visual_trace",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference existing photo_added photo_id", result.stdout + result.stderr)

    def test_visual_trace_with_measured_evidence_type_rejected(self):
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
                    "evidence_type": "measured",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("evidence_type must be 'visual_trace'", result.stdout + result.stderr)

    def test_visual_trace_not_usable_as_net_confirmation(self):
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
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "A1",
                    "to": "A2",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000002"],
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must point to measurement_recorded", result.stdout + result.stderr)

    def test_not_populated_const_false_enforced(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "footprint_marked_not_populated",
                "status": "accepted",
                "payload": {
                    "footprint_id": "F1",
                    "population_status": "not_populated",
                    "allowed_in_fault_hypotheses": True,
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("allowed_in_fault_hypotheses must be false", result.stdout + result.stderr)

    def test_measurement_raw_lifecycle_fields_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "measurement_recorded",
                "status": "accepted",
                "payload": {
                    "measurement_id": "M1",
                    "mode": "continuity",
                    "from": "A1",
                    "to": "A2",
                    "reading": {"kind": "numeric", "value": 0.1, "unit": "ohm"},
                    "power_state": "off",
                    "validity_status": "active",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("raw lifecycle field", result.stdout + result.stderr)

    def test_component_without_designator_allowed(self):
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
                "payload": {"component_id": "C1"},
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_repair_string_target_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA1",
                    "action_type": "replace_component",
                    "targets": ["Q2"],
                    "reason": "replace",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("repair target 1 must be object", result.stdout + result.stderr)

    def test_repair_unknown_component_target_rejected(self):
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
                "payload": {"component_id": "KNOWN"},
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
                    "repair_action_id": "RA1",
                    "action_type": "replace_component",
                    "targets": [{"target_type": "component", "target_id": "UNKNOWN"}],
                    "reason": "replace",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("references unknown component", result.stdout + result.stderr)

    def test_valid_remove_component_repair_action_passes(self):
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
                "payload": {"component_id": "Q2", "status": "identified"},
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
                "payload": {
                    "component_id": "Q2",
                    "pin_id": "Q2.1",
                    "label": "PA",
                },
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
                    "reading": {"kind": "numeric", "value": 12.0, "unit": "ohm"},
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
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_remove_component_requires_component_target(self):
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
                "payload": {"component_id": "Q2", "status": "identified"},
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
                    "targets": [{"target_type": "pin", "target_id": "Q2.1"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("target_type must be component", result.stdout + result.stderr)

    def test_remove_component_unknown_component_rejected(self):
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
                "payload": {"component_id": "KNOWN"},
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
                    "targets": [{"target_type": "component", "target_id": "UNKNOWN"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("references unknown component", result.stdout + result.stderr)

    def test_remove_component_rejects_forward_component_reference(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
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
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("created later than this action", result.stdout + result.stderr)

    def test_remove_component_requires_direct_measurements_stale_policy(self):
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
                    "repair_action_id": "RA5",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "no_change",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("direct_component_measurements must be 'stale_after_repair' for remove_component", result.stdout + result.stderr)

    def test_remove_component_connected_net_policy_must_remain_no_change(self):
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
                    "repair_action_id": "RA6",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "stale_after_repair",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("connected_net_measurements must be 'no_change' for remove_component", result.stdout + result.stderr)

    def test_remove_component_rejects_after_payload(self):
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
                    "repair_action_id": "RA7",
                    "action_type": "remove_component",
                    "targets": [{"target_type": "component", "target_id": "Q2"}],
                    "reason": "remove component",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                    "after": {"phase": "complete"},
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must not contain after", result.stdout + result.stderr)

    def test_component_removed_event_type_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_removed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("unknown event_type", result.stdout + result.stderr)

    def test_pelle_sample_with_expansion_validates(self):
        sample_path = "samples/pelle_pv20_minimal/events.jsonl"
        result = subprocess.run(
            [
                sys.executable,
                "tools/validate_events_jsonl.py",
                sample_path,
                "schemas/events.schema.json",
            ],
            text=True,
            capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        line_count = sum(1 for _ in Path(sample_path).read_text(encoding="utf-8").splitlines())
        self.assertEqual(line_count, 15)
        with Path(sample_path).open("r", encoding="utf-8") as handle:
            payload_types = [json.loads(line)["event_type"] for line in handle]
        self.assertIn("photo_added", payload_types)
        self.assertIn("damage_region_marked", payload_types)
        self.assertIn("footprint_marked_not_populated", payload_types)
        self.assertIn("pin_defined", payload_types)

    def test_connected_net_stale_policy_rejected_until_implemented(self):
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
                "payload": {"component_id": "C1"},
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
                    "repair_action_id": "RA1",
                    "action_type": "replace_component",
                    "targets": [{"target_type": "component", "target_id": "C1"}],
                    "reason": "replace",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "stale_after_repair",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("connected_net_measurements must be 'no_change' in V1", result.stdout + result.stderr)

    def test_duplicate_event_id_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "first"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "duplicate"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("duplicate event_id", result.stdout + result.stderr)

    def test_non_monotonic_sequence_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "first"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-01-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "non-monotonic"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("sequence must strictly increase", result.stdout + result.stderr)

    def test_unknown_event_type_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "impossible_event",
                "status": "accepted",
                "payload": {},
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("unknown event_type", result.stdout + result.stderr)

    def test_invalid_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "bogus",
                "payload": {"name": "x"},
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("status must be one of", result.stdout + result.stderr)

    def test_envelope_extra_field_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "x"},
                "unexpected": "boom",
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("unexpected top-level field(s)", result.stdout + result.stderr)

    def test_pin_status_measured_rejected(self):
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
                "payload": {"component_id": "Q1", "status": "needs_identification"},
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
                "payload": {
                    "component_id": "Q1",
                    "pin_id": "Q1.1",
                    "status": "measured",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("pin_defined status must be one of", result.stdout + result.stderr)

    def test_net_confirmed_with_visual_evidence_type_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "x"},
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
                    "from": "A1",
                    "to": "A2",
                    "reading": {"kind": "numeric", "value": 0.2, "unit": "ohm"},
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
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "A1",
                    "to": "A2",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000002"],
                    "evidence_type": "user_confirmed_visual",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("evidence_type must not be user/source/datasheet evidence", result.stdout + result.stderr)

    def test_net_confirmed_missing_net_id_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "x"},
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
                    "from": "A1",
                    "to": "A2",
                    "reading": {"kind": "numeric", "value": 0.2, "unit": "ohm"},
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
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "",
                    "from": "A1",
                    "to": "A2",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000002"],
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("requires non-empty net_id", result.stdout + result.stderr)

    def test_measurement_legacy_value_unit_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "measurement_recorded",
                "status": "accepted",
                "payload": {
                    "measurement_id": "M001",
                    "mode": "continuity",
                    "from": "A1",
                    "to": "A2",
                    "value": 12.3,
                    "unit": "ohm",
                    "reading": {"kind": "numeric", "value": 12.3, "unit": "ohm"},
                    "power_state": "off",
                },
            }
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("raw lifecycle field not allowed in raw payload: value", result.stdout + result.stderr)

    def test_component_visual_placement_board_normalized_with_scale_passes(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
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
                    "scale": 1.0,
                    "template_id": "sot23_3",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_component_visual_placement_board_normalized_with_width_height_passes(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "bottom",
                    "center_x": 0.25,
                    "center_y": 0.75,
                    "rotation_deg": -45,
                    "width": 0.2,
                    "height": 0.1,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_component_visual_placement_photo_local_with_source_photo_passes(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_001",
                    "mode": "normal",
                    "path": "photos/top_001.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "photo_local",
                    "board_side": "unknown",
                    "center_x": 120.0,
                    "center_y": 80.0,
                    "rotation_deg": 12.5,
                    "width": 18.0,
                    "height": 10.0,
                    "source_photo_id": "photo_top_001",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_component_visual_placement_missing_required_field_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.3,
                    "rotation_deg": 0,
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_component_visual_placement_both_sizing_modes_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.4,
                    "center_y": 0.6,
                    "rotation_deg": 0,
                    "scale": 1.0,
                    "width": 0.2,
                    "height": 0.2,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("exactly one sizing mode required", result.stdout + result.stderr)

    def test_component_visual_placement_neither_sizing_mode_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.4,
                    "center_y": 0.6,
                    "rotation_deg": 0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("exactly one sizing mode required", result.stdout + result.stderr)

    def test_component_visual_placement_ai_actor_rejected(self):
        self._assert_component_visual_placement_actor_rejected("ai")

    def test_component_visual_placement_system_actor_rejected(self):
        self._assert_component_visual_placement_actor_rejected("system")

    def test_component_visual_placement_import_actor_rejected(self):
        self._assert_component_visual_placement_actor_rejected("import")

    def _assert_component_visual_placement_actor_rejected(self, actor_type):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": actor_type, "id": f"{actor_type}_1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.5,
                    "center_y": 0.5,
                    "rotation_deg": 0,
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("actor.type must be 'user' in V1", result.stdout + result.stderr)

    def test_component_visual_placement_graph_layout_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "graph_layout",
                    "board_side": "top",
                    "center_x": 0.5,
                    "center_y": 0.5,
                    "rotation_deg": 0,
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("graph_layout is not allowed", result.stdout + result.stderr)

    def test_component_visual_placement_board_normalized_out_of_range_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 1.2,
                    "center_y": 0.5,
                    "rotation_deg": 0,
                    "width": 1.2,
                    "height": 0.1,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("board_normalized center_x must be within 0..1", result.stdout + result.stderr)

    def test_component_visual_placement_board_normalized_with_source_photo_id_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
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
                    "scale": 1.0,
                    "source_photo_id": "photo_top_001",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("board_normalized must not include source_photo_id", result.stdout + result.stderr)

    def test_component_visual_placement_photo_local_without_source_photo_id_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "photo_local",
                    "board_side": "top",
                    "center_x": 20,
                    "center_y": 30,
                    "rotation_deg": 0,
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("photo_local requires non-empty source_photo_id", result.stdout + result.stderr)

    def test_component_visual_placement_photo_local_unknown_source_photo_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "photo_local",
                    "board_side": "top",
                    "center_x": 20,
                    "center_y": 30,
                    "rotation_deg": 0,
                    "scale": 1.0,
                    "source_photo_id": "photo_missing",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior photo_added", result.stdout + result.stderr)

    def test_component_visual_placement_source_photo_forward_reference_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "photo_local",
                    "board_side": "top",
                    "center_x": 20,
                    "center_y": 30,
                    "rotation_deg": 0,
                    "scale": 1.0,
                    "source_photo_id": "photo_top_001",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_001",
                    "mode": "normal",
                    "path": "photos/top_001.jpg",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must not be forward reference", result.stdout + result.stderr)

    def test_component_visual_placement_unknown_component_id_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior component_created", result.stdout + result.stderr)

    def test_component_visual_placement_rejected_component_created_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "rejected",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
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
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior component_created", result.stdout + result.stderr)

    def test_component_visual_placement_rejected_component_created_status_draft(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "draft",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
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
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior component_created", result.stdout + result.stderr)

    def test_component_visual_placement_photo_local_rejected_photo_added_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "rejected",
                "payload": {
                    "photo_id": "photo_top_001",
                    "mode": "normal",
                    "path": "photos/top_001.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "photo_local",
                    "board_side": "top",
                    "center_x": 20,
                    "center_y": 30,
                    "rotation_deg": 0,
                    "scale": 1.0,
                    "source_photo_id": "photo_top_001",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior photo_added", result.stdout + result.stderr)

    def test_component_visual_placement_photo_local_rejected_photo_added_status_draft(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "draft",
                "payload": {
                    "photo_id": "photo_top_001",
                    "mode": "normal",
                    "path": "photos/top_001.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "photo_local",
                    "board_side": "top",
                    "center_x": 20,
                    "center_y": 30,
                    "rotation_deg": 0,
                    "scale": 1.0,
                    "source_photo_id": "photo_top_001",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior photo_added", result.stdout + result.stderr)

    def test_component_visual_placement_component_updated_alone_does_not_satisfy_component_existence(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_updated",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
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
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior component_created", result.stdout + result.stderr)

    def test_component_visual_placement_component_marked_unknown_alone_does_not_satisfy_component_existence(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_marked_unknown",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
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
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior component_created", result.stdout + result.stderr)

    def test_component_visual_placement_component_forward_reference_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                    "scale": 1.0,
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must not be forward reference", result.stdout + result.stderr)

    def test_component_visual_placement_side_effect_field_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
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
                    "scale": 1.0,
                    "measurement_id": "M1",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("forbidden placement field present", result.stdout + result.stderr)

    def test_component_visual_placement_template_id_opaque_string_accepted(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.2,
                    "center_y": 0.3,
                    "rotation_deg": 5,
                    "scale": 1.1,
                    "template_id": "soic_8",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_component_visual_placement_template_assignment_event_id_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.2,
                    "center_y": 0.3,
                    "rotation_deg": 5,
                    "scale": 1.1,
                    "template_assignment_event_id": "evt_123456",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_component_visual_placement_after_component_removed_allowed(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-05-01T00:00:00Z",
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
                "created_at": "2026-05-01T00:01:00Z",
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
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-05-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_visual_placement_confirmed",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "coordinate_space": "board_normalized",
                    "board_side": "top",
                    "center_x": 0.2,
                    "center_y": 0.3,
                    "rotation_deg": 0,
                    "scale": 1.0,
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_pin_defined_rejected_component_created_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "rejected",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "pin_defined",
                "status": "accepted",
                "payload": {"component_id": "Q2", "pin_id": "Q2.1", "status": "unknown"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference existing component_created", result.stdout + result.stderr)

    def test_component_updated_rejected_component_created_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "rejected",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_updated",
                "status": "accepted",
                "payload": {"component_id": "Q2", "marking": "K72"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("prior accepted component_created", result.stdout + result.stderr)

    def test_component_marked_unknown_rejected_component_created_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "rejected",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_marked_unknown",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("prior accepted component_created", result.stdout + result.stderr)

    def test_component_updated_component_forward_reference_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_updated",
                "status": "accepted",
                "payload": {"component_id": "Q2", "marking": "K72"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must not be forward reference", result.stdout + result.stderr)

    def test_repair_action_component_target_rejected_component_created_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "rejected",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
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
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("unknown component", result.stdout + result.stderr)

    def test_damage_region_rejected_photo_added_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "rejected",
                "payload": {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "damage_region_marked",
                "status": "accepted",
                "payload": {
                    "region_id": "DMG001",
                    "photo_id": "photo_top_001",
                    "bbox": {"x": 1, "y": 2, "width": 3, "height": 4},
                    "damage_type": "burn",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference existing photo_added photo_id", result.stdout + result.stderr)

    def test_suspect_region_rejected_photo_added_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "rejected",
                "payload": {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "suspect_region_marked",
                "status": "accepted",
                "payload": {
                    "region_id": "SUSP001",
                    "photo_id": "photo_top_001",
                    "bbox": {"x": 1, "y": 2, "width": 3, "height": 4},
                    "reason": "visual anomaly",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference existing photo_added photo_id", result.stdout + result.stderr)

    def test_visual_trace_rejected_photo_added_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "rejected",
                "payload": {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT001",
                    "photo_id": "photo_top_001",
                    "from_point": {"x": 1, "y": 2},
                    "to_point": {"x": 3, "y": 4},
                    "evidence_type": "visual_trace",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference existing photo_added photo_id", result.stdout + result.stderr)

    def test_visual_trace_photo_forward_reference_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT001",
                    "photo_id": "photo_top_001",
                    "from_point": {"x": 1, "y": 2},
                    "to_point": {"x": 3, "y": 4},
                    "evidence_type": "visual_trace",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {"photo_id": "photo_top_001", "mode": "normal", "path": "photos/top_001.jpg"},
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must not be forward reference", result.stdout + result.stderr)

    def test_net_confirmed_with_rejected_measurement_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "measurement_recorded",
                "status": "rejected",
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
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "Q2.1",
                    "to": "R1.1",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000001"],
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must point to measurement_recorded", result.stdout + result.stderr)

    def test_net_confirmed_with_accepted_measurement_passes(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
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
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "Q2.1",
                    "to": "R1.1",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000001"],
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_net_confirmed_measurement_forward_reference_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
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
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
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
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must not be forward reference", result.stdout + result.stderr)

    def test_repair_action_pin_target_rejected_pin_defined_status_rejected(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
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
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "pin_defined",
                "status": "rejected",
                "payload": {"component_id": "Q2", "pin_id": "Q2.1", "status": "unknown"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-06-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA1",
                    "action_type": "replace_component",
                    "targets": [{"target_type": "pin", "target_id": "Q2.1"}],
                    "reason": "rework",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("unknown pin", result.stdout + result.stderr)

    def test_repair_action_pin_target_with_accepted_pin_defined_passes(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
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
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "pin_defined",
                "status": "accepted",
                "payload": {"component_id": "Q2", "pin_id": "Q2.1", "status": "unknown"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_test",
                "sequence": 3,
                "created_at": "2026-06-01T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA1",
                    "action_type": "replace_component",
                    "targets": [{"target_type": "pin", "target_id": "Q2.1"}],
                    "reason": "rework",
                    "invalidation_policy": {
                        "direct_component_measurements": "stale_after_repair",
                        "connected_net_measurements": "no_change",
                    },
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_claim_invalidated_may_reference_rejected_event_for_audit_metadata(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-06-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "rejected",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_test",
                "sequence": 2,
                "created_at": "2026-06-01T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "claim_invalidated",
                "status": "accepted",
                "payload": {
                    "invalidates_event_id": "evt_000001",
                    "reason": "audit cleanup",
                    "invalidation_type": "retracted",
                },
            },
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def _photo_alignment_photo_added_event(
        self,
        *,
        event_id: str = "evt_000001",
        sequence: int = 1,
        status: str = "accepted",
        photo_id: str = "photo_alignment_001",
    ) -> dict:
        return {
            "schema_version": "1.0",
            "event_id": event_id,
            "project_id": "prj_test",
            "sequence": sequence,
            "created_at": "2026-05-29T00:00:00Z",
            "actor": {"type": "user", "id": "u1"},
            "event_type": "photo_added",
            "status": status,
            "payload": {
                "photo_id": photo_id,
                "mode": "normal",
                "path": "photos/alignment_001.jpg",
                "layer": "top",
            },
        }

    def _photo_alignment_confirmed_event(
        self,
        *,
        event_id: str = "evt_000002",
        sequence: int = 2,
        actor_type: str = "user",
        source_photo_id: str = "photo_alignment_001",
        payload_overrides: dict | None = None,
    ) -> dict:
        payload = {
            "alignment_id": "ALN1",
            "source_photo_id": source_photo_id,
            "board_side": "top",
            "coordinate_space_from": "photo_local",
            "coordinate_space_to": "board_normalized",
            "reference_points_photo": [{"x": 10.0, "y": 20.0}, {"x": 110.0, "y": 220.0}],
            "reference_points_board": [{"x": 0.1, "y": 0.2}, {"x": 0.9, "y": 0.8}],
            "transform_type": "similarity",
            "alignment_quality_label": "manual_check",
        }
        if payload_overrides:
            payload.update(payload_overrides)
        return {
            "schema_version": "1.0",
            "event_id": event_id,
            "project_id": "prj_test",
            "sequence": sequence,
            "created_at": "2026-05-29T00:01:00Z",
            "actor": {"type": actor_type, "id": f"{actor_type}_1"},
            "event_type": "photo_to_board_alignment_confirmed",
            "status": "accepted",
            "payload": payload,
        }

    def test_photo_alignment_similarity_with_two_pairs_passes(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_photo_alignment_affine_with_three_pairs_passes(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(
                payload_overrides={
                    "transform_type": "affine",
                    "reference_points_photo": [
                        {"x": 10.0, "y": 20.0},
                        {"x": 110.0, "y": 220.0},
                        {"x": 300.0, "y": 400.0},
                    ],
                    "reference_points_board": [
                        {"x": 0.1, "y": 0.2},
                        {"x": 0.9, "y": 0.8},
                        {"x": 0.5, "y": 0.6},
                    ],
                }
            ),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_photo_alignment_ai_actor_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(actor_type="ai"),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("actor.type must be 'user'", result.stdout + result.stderr)

    def test_photo_alignment_system_actor_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(actor_type="system"),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("actor.type must be 'user'", result.stdout + result.stderr)

    def test_photo_alignment_missing_alignment_id_rejected(self):
        alignment = self._photo_alignment_confirmed_event()
        alignment["payload"].pop("alignment_id")
        events = [self._photo_alignment_photo_added_event(), alignment]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("alignment_id", result.stdout + result.stderr)

    def test_photo_alignment_missing_source_photo_id_rejected(self):
        alignment = self._photo_alignment_confirmed_event()
        alignment["payload"].pop("source_photo_id")
        events = [self._photo_alignment_photo_added_event(), alignment]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("source_photo_id", result.stdout + result.stderr)

    def test_photo_alignment_missing_transform_type_rejected(self):
        alignment = self._photo_alignment_confirmed_event()
        alignment["payload"].pop("transform_type")
        events = [self._photo_alignment_photo_added_event(), alignment]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("transform_type", result.stdout + result.stderr)

    def test_photo_alignment_empty_alignment_quality_label_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"alignment_quality_label": ""}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("alignment_quality_label", result.stdout + result.stderr)

    def test_photo_alignment_unknown_source_photo_id_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(source_photo_id="photo_unknown_001"),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior accepted photo_added", result.stdout + result.stderr)

    def test_photo_alignment_forward_source_photo_id_rejected(self):
        events = [
            self._photo_alignment_confirmed_event(event_id="evt_000001", sequence=1),
            self._photo_alignment_photo_added_event(event_id="evt_000002", sequence=2),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must not be forward reference", result.stdout + result.stderr)

    def test_photo_alignment_non_accepted_source_photo_id_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(status="rejected"),
            self._photo_alignment_confirmed_event(),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must reference prior accepted photo_added", result.stdout + result.stderr)

    def test_photo_alignment_coordinate_space_from_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"coordinate_space_from": "board_normalized"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("coordinate_space_from must be 'photo_local'", result.stdout + result.stderr)

    def test_photo_alignment_coordinate_space_to_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"coordinate_space_to": "photo_local"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("coordinate_space_to must be 'board_normalized'", result.stdout + result.stderr)

    def test_photo_alignment_graph_layout_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"coordinate_space_from": "graph_layout"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("graph_layout is not allowed", result.stdout + result.stderr)

    def test_photo_alignment_unequal_reference_lengths_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(
                payload_overrides={"reference_points_board": [{"x": 0.1, "y": 0.2}]}
            ),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("must have equal length", result.stdout + result.stderr)

    def test_photo_alignment_affine_too_few_pairs_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"transform_type": "affine"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("affine requires at least 3", result.stdout + result.stderr)

    def test_photo_alignment_similarity_too_few_pairs_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(
                payload_overrides={
                    "reference_points_photo": [{"x": 10.0, "y": 20.0}],
                    "reference_points_board": [{"x": 0.1, "y": 0.2}],
                }
            ),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("similarity requires at least 2", result.stdout + result.stderr)

    def test_photo_alignment_board_point_out_of_range_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(
                payload_overrides={
                    "reference_points_board": [{"x": 1.2, "y": 0.2}, {"x": 0.9, "y": 0.8}]
                }
            ),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("reference_points_board[1].x must be within 0..1", result.stdout + result.stderr)

    def test_photo_alignment_photo_point_negative_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(
                payload_overrides={
                    "reference_points_photo": [{"x": -1.0, "y": 20.0}, {"x": 110.0, "y": 220.0}]
                }
            ),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("reference_points_photo[1].x must be >= 0", result.stdout + result.stderr)

    def test_photo_alignment_unknown_transform_type_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"transform_type": "homography_candidate"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("transform_type must be one of", result.stdout + result.stderr)

    def test_photo_alignment_forbidden_net_id_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"net_id": "N1"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("forbidden alignment field present: net_id", result.stdout + result.stderr)

    def test_photo_alignment_forbidden_confidence_score_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"confidence_score": 0.9}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("forbidden alignment field present: confidence_score", result.stdout + result.stderr)

    def test_photo_alignment_forbidden_component_id_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"component_id": "Q2"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("forbidden alignment field present: component_id", result.stdout + result.stderr)

    def test_photo_alignment_forbidden_pin_id_rejected(self):
        events = [
            self._photo_alignment_photo_added_event(),
            self._photo_alignment_confirmed_event(payload_overrides={"pin_id": "Q2.1"}),
        ]
        path = _events_to_temp_jsonl(events)
        result = _run_validator(path)
        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("forbidden alignment field present: pin_id", result.stdout + result.stderr)


if __name__ == "__main__":
    unittest.main()
