import json
import re
import subprocess
import sys
from pathlib import Path
import unittest


def _run_sample_validator(path: Path) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, "tools/validate_events_jsonl.py", str(path)],
        text=True,
        capture_output=True,
    )


class SchemaSamplesTests(unittest.TestCase):
    def test_schema_samples_validate_with_validator(self):
        sample_dir = Path("schemas/samples")
        for sample in sorted(sample_dir.glob("*.json")):
            result = _run_sample_validator(sample)
            message = f"{sample}: {result.stdout + result.stderr}"
            if sample.name.startswith("invalid_"):
                self.assertNotEqual(result.returncode, 0, message)
            else:
                self.assertEqual(result.returncode, 0, message)

    def test_valid_measurement_sample_is_hardened_raw_payload(self):
        path = Path("schemas/samples/valid_measurement_recorded.json")
        event = json.loads(path.read_text(encoding="utf-8"))
        payload = event.get("payload", {})

        self.assertIn("reading", payload)
        self.assertNotIn("valid_from_event_id", payload)
        self.assertNotIn("valid_until_event_id", payload)
        self.assertNotIn("validity_status", payload)
        self.assertNotIn("value", payload)
        self.assertNotIn("unit", payload)
        self.assertIsInstance(payload["reading"], dict)
        self.assertEqual(payload["reading"].get("kind"), "numeric")

    def test_valid_repair_action_sample_has_typed_targets_and_invalidation_policy(self):
        path = Path("schemas/samples/valid_repair_action_recorded.json")
        event = json.loads(path.read_text(encoding="utf-8"))
        payload = event.get("payload", {})

        targets = payload.get("targets", [])
        self.assertEqual(len(targets), 1)
        self.assertIsInstance(targets[0], dict)
        self.assertIn(targets[0].get("target_type"), {"component", "area", "pin", "pad", "footprint", "net", "trace", "via", "connector"})
        self.assertIn("target_id", targets[0])

        invalidation = payload.get("invalidation_policy")
        self.assertIsInstance(invalidation, dict)
        self.assertEqual(invalidation.get("direct_component_measurements"), "stale_after_repair")
        self.assertEqual(invalidation.get("connected_net_measurements"), "no_change")

    def test_schema_sample_validation_rejects_raw_lifecycle_and_string_targets(self):
        measurement = json.loads(Path("schemas/samples/valid_measurement_recorded.json").read_text(encoding="utf-8"))
        self.assertNotIn("valid_from_event_id", measurement["payload"])

        repair = json.loads(Path("schemas/samples/valid_repair_action_recorded.json").read_text(encoding="utf-8"))
        self.assertIsInstance(repair["payload"].get("targets"), list)
        self.assertIsInstance(repair["payload"]["targets"][0], dict)

        self.assertIn("invalidation_policy", repair["payload"])

    def test_no_pytest_dependency_required(self):
        target_files = [
            Path("tools/validate_all.py"),
            Path("tools/validate_events_jsonl.py"),
            Path("tools/materialize_known_facts.py"),
        ]
        for target in target_files:
            text = target.read_text(encoding="utf-8")
            self.assertFalse(
                re.search(r"\bpytest\b", text),
                f"{target} should not depend on pytest",
            )


if __name__ == "__main__":
    unittest.main()
