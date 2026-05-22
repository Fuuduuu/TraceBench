import json
import subprocess
import sys
import tempfile
from pathlib import Path
import unittest


def run_materialize(src= "samples/pelle_pv20_minimal/events.jsonl"):
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


class MaterializeKnownFactsTests(unittest.TestCase):
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

    def test_net_confirmation_uses_post_repair_measurement(self):
        data = run_materialize()
        net = next((n for n in data["nets"] if n.get("net_id") == "N1"), None)
        self.assertIsNotNone(net)
        self.assertEqual(net.get("confirmation_basis"), "measured")
        self.assertIn("evt_000008", net.get("confirmed_by_event_ids", []))
        self.assertEqual(net.get("confirmation_basis"), "measured")


if __name__ == "__main__":
    unittest.main()
