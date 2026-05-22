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


if __name__ == "__main__":
    unittest.main()
