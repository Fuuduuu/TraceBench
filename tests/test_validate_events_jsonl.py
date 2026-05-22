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
        self.assertEqual(line_count, 13)
        with Path(sample_path).open("r", encoding="utf-8") as handle:
            payload_types = [json.loads(line)["event_type"] for line in handle]
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


if __name__ == "__main__":
    unittest.main()
