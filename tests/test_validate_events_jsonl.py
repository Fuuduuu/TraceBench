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


if __name__ == "__main__":
    unittest.main()
