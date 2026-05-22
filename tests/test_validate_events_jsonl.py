import json
import subprocess
import sys
import tempfile
import unittest


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


if __name__ == "__main__":
    unittest.main()
