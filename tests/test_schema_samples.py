from pathlib import Path
import json
import re
import subprocess
import sys
import unittest


class SchemaSamplesTests(unittest.TestCase):
    def test_schema_sample_files_validate_if_present(self):
        sample_dir = Path("samples")
        event_files = list(sample_dir.rglob("events.jsonl"))
        if not event_files:
            self.skipTest("No events.jsonl files present")
        for event_file in event_files:
            result = subprocess.run(
                [sys.executable, "tools/validate_events_jsonl.py", str(event_file), "schemas/events.schema.json"],
                text=True,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 0, f"{event_file}: {result.stdout + result.stderr}")

    def test_valid_repair_action_has_invalidation_policy(self):
        data = Path("samples/pelle_pv20_minimal/events.jsonl").read_text(encoding="utf-8")
        for line in data.splitlines():
            if not line.strip():
                continue
            event = json.loads(line)
            if event.get("event_type") == "repair_action_recorded":
                payload = event.get("payload", {})
                invalidation = payload.get("invalidation_policy", {})
                self.assertIn("direct_component_measurements", invalidation)
                self.assertIn("connected_net_measurements", invalidation)
                self.assertIn(
                    invalidation["direct_component_measurements"],
                    {"stale_after_repair", "no_change"},
                )
                self.assertIn(
                    invalidation["connected_net_measurements"],
                    {"stale_after_repair", "no_change"},
                )

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
