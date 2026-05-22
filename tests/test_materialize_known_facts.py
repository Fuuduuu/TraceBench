import json
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

    def test_materialize_outputs_pins(self):
        data = run_materialize()
        pins = data.get("pins", [])
        self.assertTrue(pins)
        self.assertTrue(any(item.get("pin_id") == "Q2.1" for item in pins))

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

    def test_pelle_photo_placeholder_materialized(self):
        data = run_materialize()
        self.assertEqual(data.get("suspect_regions", []), [])
        self.assertEqual(data.get("visual_traces", []), [])
        self.assertTrue(any(
            photo.get("photo_id") == "photo_top_backlight_001" and photo.get("mode") == "backlight"
            for photo in data.get("photos", [])
        ))


if __name__ == "__main__":
    unittest.main()
