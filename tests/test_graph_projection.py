import json
import subprocess
import sys
import tempfile
from pathlib import Path
import unittest

try:
    from tests.test_materialize_known_facts import run_materialize, run_materialize_events
except ModuleNotFoundError:  # pragma: no cover - discovery fallback
    from test_materialize_known_facts import run_materialize, run_materialize_events


def run_materialize_events_with_stderr(events):
    with tempfile.TemporaryDirectory() as tmpdir:
        temp_path = Path(tmpdir) / "events.jsonl"
        temp_out = Path(tmpdir) / "known_facts.json"
        with temp_path.open("w", encoding="utf-8") as handle:
            for event in events:
                handle.write(json.dumps(event) + "\n")
        result = subprocess.run(
            [sys.executable, "tools/materialize_known_facts.py", str(temp_path), str(temp_out)],
            text=True,
            capture_output=True,
        )
        if result.returncode != 0:
            raise RuntimeError(result.stdout + result.stderr)
        data = json.loads(temp_out.read_text(encoding="utf-8"))
        return data, result.stderr


class GraphProjectionMaterializationTests(unittest.TestCase):
    def test_visual_trace_not_in_nets(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
                "sequence": 1,
                "created_at": "2026-05-22T00:00:00Z",
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
                "event_id": "evt_000002",
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT001",
                    "photo_id": "photo_top_001",
                    "from_point": {"x": 0, "y": 0},
                    "to_point": {"x": 10, "y": 10},
                    "evidence_type": "visual_trace",
                },
            },
        ]
        data = run_materialize_events(events)
        self.assertFalse(data["nets"])

    def test_visual_trace_evidence_type_is_visual_trace_not_measured(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
                "sequence": 1,
                "created_at": "2026-05-22T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_002",
                    "mode": "normal",
                    "path": "photos/top_002.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT002",
                    "photo_id": "photo_top_002",
                    "from_point": {"x": 1, "y": 1},
                    "to_point": {"x": 2, "y": 2},
                    "evidence_type": "visual_trace",
                    "from_component": "Q2",
                    "to_component": "R1",
                },
            },
        ]
        data = run_materialize_events(events)
        traces = data.get("visual_traces", [])
        self.assertEqual(len(traces), 1)
        self.assertEqual(traces[0].get("evidence_type"), "visual_trace")
        self.assertNotEqual(traces[0].get("evidence_type"), "measured")

    def test_not_populated_not_in_measured_net_endpoints(self):
        data = run_materialize()
        excluded = {
            item.get("footprint_id")
            for item in data.get("excluded_from_fault_candidates", [])
            if isinstance(item, dict)
        }
        for net in data.get("nets", []):
            frm = str(net.get("from", ""))
            to = str(net.get("to", ""))
            for footprint_id in excluded:
                if (
                    frm == footprint_id
                    or to == footprint_id
                    or frm.startswith(f"{footprint_id}.")
                    or to.startswith(f"{footprint_id}.")
                ):
                    self.fail(f"not_populated footprint {footprint_id} appears in net endpoint")

    def test_stale_measurement_preserved_after_repair(self):
        data = run_materialize()
        stale_measurements = [
            m for m in data.get("measurements", [])
            if m.get("validity_status") == "stale_after_repair"
        ]
        self.assertTrue(stale_measurements)
        self.assertEqual(stale_measurements[0].get("measurement_id"), "M001")

    def test_component_updated_patches_existing_component(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
                "sequence": 1,
                "created_at": "2026-05-22T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2", "status": "identified", "marking": "K72"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_updated",
                "status": "accepted",
                "payload": {
                    "component_id": "Q2",
                    "marking": "K73",
                },
            },
        ]
        data = run_materialize_events(events)
        q2 = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(q2.get("marking"), "K73")

    def test_component_updated_preserves_unpatched_fields(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
                "sequence": 1,
                "created_at": "2026-05-22T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2", "package": "SOT-23", "status": "identified"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_updated",
                "status": "accepted",
                "payload": {"component_id": "Q2", "status": "needs_identification"},
            },
        ]
        data = run_materialize_events(events)
        q2 = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(q2.get("package"), "SOT-23")
        self.assertEqual(q2.get("status"), "needs_identification")

    def test_component_marked_unknown_clears_identity_fields(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
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
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_marked_unknown",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
        ]
        data = run_materialize_events(events)
        q2 = next(item for item in data["components"] if item.get("component_id") == "Q2")
        self.assertEqual(q2.get("status"), "needs_identification")
        self.assertNotIn("mpn", q2)
        self.assertNotIn("marking", q2)

    def test_component_pin_index_correct_for_q2(self):
        data = run_materialize()
        component_pin_index = data.get("component_pin_index", {})
        self.assertIn("Q2", component_pin_index)
        self.assertEqual(component_pin_index["Q2"], ["Q2.1", "Q2.2", "Q2.3"])

    def test_measured_net_requires_measurement_recorded(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
                "sequence": 1,
                "created_at": "2026-05-22T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_003",
                    "mode": "normal",
                    "path": "photos/top_003.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-22T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT010",
                    "photo_id": "photo_top_003",
                    "from_point": {"x": 0, "y": 0},
                    "to_point": {"x": 1, "y": 1},
                    "evidence_type": "visual_trace",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_graph",
                "sequence": 3,
                "created_at": "2026-05-22T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "Q2.1",
                    "to": "R17.1",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000002"],
                },
            },
        ]
        data = run_materialize_events(events)
        self.assertFalse(data.get("nets"))

    def test_adjacency_q2_pins_in_component_pin_index(self):
        data = run_materialize()
        pin_index = data.get("component_pin_index", {})
        self.assertIn("Q2", pin_index)
        self.assertIn("Q2.1", pin_index["Q2"])
        self.assertIn("Q2.2", pin_index["Q2"])
        self.assertIn("Q2.3", pin_index["Q2"])

    def test_remove_component_does_not_promote_visual_trace_to_measured_net(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
                "sequence": 1,
                "created_at": "2026-05-23T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2", "status": "identified"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-23T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "photo_added",
                "status": "accepted",
                "payload": {
                    "photo_id": "photo_top_004",
                    "mode": "normal",
                    "path": "photos/top_004.jpg",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000003",
                "project_id": "prj_graph",
                "sequence": 3,
                "created_at": "2026-05-23T00:02:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "visual_trace_added",
                "status": "accepted",
                "payload": {
                    "trace_id": "VT300",
                    "photo_id": "photo_top_004",
                    "from_point": {"x": 1, "y": 1},
                    "to_point": {"x": 3, "y": 3},
                    "evidence_type": "visual_trace",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000004",
                "project_id": "prj_graph",
                "sequence": 4,
                "created_at": "2026-05-23T00:03:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "net_connection_confirmed",
                "status": "accepted",
                "payload": {
                    "net_id": "N1",
                    "from": "VT300",
                    "to": "Q2.1",
                    "confirmation_basis": "measured",
                    "confirmed_by_event_ids": ["evt_000001"],
                    "trace_id": "VT300",
                },
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000005",
                "project_id": "prj_graph",
                "sequence": 5,
                "created_at": "2026-05-23T00:04:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA-REMOVE-1",
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
        nets = data.get("nets", [])
        visual_trace_ids = {
            trace.get("trace_id")
            for trace in data.get("visual_traces", [])
            if isinstance(trace, dict)
        }
        for net in nets:
            self.assertNotIn(net.get("trace_id"), visual_trace_ids)
            self.assertNotIn(str(net.get("from", "")), visual_trace_ids)
            self.assertNotIn(str(net.get("to", "")), visual_trace_ids)

    def test_remove_component_does_not_require_board_graph_or_view_state(self):
        events = [
            {
                "schema_version": "1.0",
                "event_id": "evt_000001",
                "project_id": "prj_graph",
                "sequence": 1,
                "created_at": "2026-05-23T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "component_created",
                "status": "accepted",
                "payload": {"component_id": "Q2"},
            },
            {
                "schema_version": "1.0",
                "event_id": "evt_000002",
                "project_id": "prj_graph",
                "sequence": 2,
                "created_at": "2026-05-23T00:01:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "repair_action_recorded",
                "status": "accepted",
                "payload": {
                    "repair_action_id": "RA-REMOVE-2",
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
        with tempfile.TemporaryDirectory() as tmpdir:
            temp_path = Path(tmpdir) / "events.jsonl"
            output_path = Path(tmpdir) / "known_facts.json"
            with temp_path.open("w", encoding="utf-8") as handle:
                for event in events:
                    handle.write(json.dumps(event) + "\n")

            result = subprocess.run(
                [sys.executable, "tools/materialize_known_facts.py", str(temp_path), str(output_path)],
                text=True,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((Path(tmpdir) / "board_graph.json").exists())
            self.assertFalse((Path(tmpdir) / "view_state.json").exists())
