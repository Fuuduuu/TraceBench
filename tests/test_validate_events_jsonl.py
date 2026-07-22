import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))


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


V2_SCHEMA_VERSION = "2.0-draft"


def _v2_measurement_payload(**overrides):
    payload = {
        "measurement_id": "meas_000001",
        "measured_at": "2026-06-06T10:00:00Z",
        "target": {
            "target_kind": "component_pin",
            "target_key": "component:Q2:pin:1",
            "display_label": "Q2.1",
            "component_id": "Q2",
            "pin_id": "Q2.1",
        },
        "reading": {
            "mode": "voltage",
            "value": 3.3,
            "unit": "V",
            "display_value": "3.3 V",
        },
        "value_provenance": {
            "measured_value_source": "human_entered",
            "entry_method": "typed",
            "human_verified_as_own_reading": True,
            "context_values_visible": [
                {
                    "context_type": "reference_value",
                    "context_id": "ref_q2_pin1_voltage",
                    "display_value": "3.3 V",
                    "used_as_measured_value": False,
                }
            ],
        },
    }
    payload.update(overrides)
    return payload


def _v2_component_created_payload(**overrides):
    payload = {
        "component_id": "Q2",
        "label": "Q2",
        "component_kind": "unknown",
        "created_context": "human_added_from_measure_sheet",
        "reference_designator": "Q2",
        "template_id_hint": "sot23_hint",
        "footprint_hint": "SOT-23",
    }
    payload.update(overrides)
    return payload


def _v2_component_visual_placement_payload(**overrides):
    payload = {
        "component_id": "Q2",
        "coordinate_space": "board_normalized",
        "board_side": "top",
        "center_x": 0.42,
        "center_y": 0.33,
        "rotation_deg": 0.0,
        "width": 0.12,
        "height": 0.08,
    }
    payload.update(overrides)
    return payload


def _v2_board_outline_payload(**overrides):
    payload = {
        "coordinate_space": "board_normalized",
        "outer_polygon": [
            {"x": 0.1, "y": 0.1},
            {"x": 0.9, "y": 0.1},
            {"x": 0.9, "y": 0.8},
            {"x": 0.1, "y": 0.8},
        ],
    }
    payload.update(overrides)
    return payload


def _v2_event(
    event_id="evt_200001",
    event_type="measurement_recorded",
    payload=None,
    *,
    schema_version=V2_SCHEMA_VERSION,
    created_at="2026-06-06T10:00:01Z",
    project_id="prj_v2_test",
    client_operation_id="op_v2_000001",
    actor_type="human",
    source_type="explicit_user_confirmation",
    confirmed=True,
    **extra_fields,
):
    event = {
        "schema_version": schema_version,
        "event_id": event_id,
        "event_type": event_type,
        "created_at": created_at,
        "project_id": project_id,
        "client_operation_id": client_operation_id,
        "actor": {"type": actor_type, "actor_id": "local_user"},
        "source": {
            "type": source_type,
            "surface": "measure_sheet",
            "action": "save_measurement",
        },
        "confirmation": {
            "confirmed": confirmed,
            "confirmed_at": created_at,
            "label": "Salvesta mootmine",
        },
        "payload": payload if payload is not None else _v2_measurement_payload(),
    }
    if schema_version is None:
        event.pop("schema_version")
    event.update(extra_fields)
    return event


class ValidateV2EventsJsonlTests(unittest.TestCase):
    def test_v2_board_outline_accepts_valid_geometry_variants(self):
        polygons = {
            "clockwise": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.9, "y": 0.1},
                {"x": 0.9, "y": 0.8},
                {"x": 0.1, "y": 0.8},
            ],
            "counter_clockwise": [
                {"x": 0.1, "y": 0.8},
                {"x": 0.9, "y": 0.8},
                {"x": 0.9, "y": 0.1},
                {"x": 0.1, "y": 0.1},
            ],
            "concave": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.9, "y": 0.1},
                {"x": 0.55, "y": 0.4},
                {"x": 0.9, "y": 0.8},
                {"x": 0.1, "y": 0.8},
            ],
        }
        for name, polygon in polygons.items():
            with self.subTest(name=name):
                payload = _v2_board_outline_payload(outer_polygon=polygon)
                if name == "concave":
                    payload.update(physical_width_mm=120.5, physical_height_mm=76.25)
                path = _events_to_temp_jsonl(
                    [_v2_event(event_type="board_outline_confirmed", payload=payload)]
                )

                result = _run_validator(path)

                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_board_outline_rejects_envelope_payload_and_vertex_expansion(self):
        cases = []

        payload = _v2_board_outline_payload(outline_id="outline_1")
        cases.append(("extra_payload", _v2_event(event_type="board_outline_confirmed", payload=payload)))

        payload = _v2_board_outline_payload(coordinate_space="photo_local")
        cases.append(("coordinate_space", _v2_event(event_type="board_outline_confirmed", payload=payload)))

        payload = _v2_board_outline_payload()
        payload.pop("outer_polygon")
        cases.append(("missing_polygon", _v2_event(event_type="board_outline_confirmed", payload=payload)))

        payload = _v2_board_outline_payload()
        payload["outer_polygon"][0]["z"] = 0.0
        cases.append(("extra_vertex", _v2_event(event_type="board_outline_confirmed", payload=payload)))

        cases.extend(
            [
                (
                    "ai_actor",
                    _v2_event(
                        event_type="board_outline_confirmed",
                        payload=_v2_board_outline_payload(),
                        actor_type="ai",
                    ),
                ),
                (
                    "non_explicit_source",
                    _v2_event(
                        event_type="board_outline_confirmed",
                        payload=_v2_board_outline_payload(),
                        source_type="renderer",
                    ),
                ),
                (
                    "not_confirmed",
                    _v2_event(
                        event_type="board_outline_confirmed",
                        payload=_v2_board_outline_payload(),
                        confirmed=False,
                    ),
                ),
                (
                    "status_forbidden",
                    _v2_event(
                        event_type="board_outline_confirmed",
                        payload=_v2_board_outline_payload(),
                        status="accepted",
                    ),
                ),
                (
                    "sequence_forbidden",
                    _v2_event(
                        event_type="board_outline_confirmed",
                        payload=_v2_board_outline_payload(),
                        sequence=1,
                    ),
                ),
            ]
        )

        for name, event in cases:
            with self.subTest(name=name):
                result = _run_validator(_events_to_temp_jsonl([event]))
                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_board_outline_rejects_invalid_numbers_and_unpaired_physical_size(self):
        cases = []
        for name, value in [
            ("coordinate_bool", True),
            ("coordinate_nan", float("nan")),
            ("coordinate_inf", float("inf")),
            ("coordinate_below", -0.01),
            ("coordinate_above", 1.01),
        ]:
            payload = _v2_board_outline_payload()
            payload["outer_polygon"][0]["x"] = value
            cases.append((name, payload))

        for name, overrides in [
            ("width_only", {"physical_width_mm": 100.0}),
            ("height_only", {"physical_height_mm": 60.0}),
            ("physical_bool", {"physical_width_mm": True, "physical_height_mm": 60.0}),
            ("physical_nan", {"physical_width_mm": float("nan"), "physical_height_mm": 60.0}),
            ("physical_inf", {"physical_width_mm": 100.0, "physical_height_mm": float("inf")}),
            ("physical_zero", {"physical_width_mm": 0.0, "physical_height_mm": 60.0}),
            ("physical_negative", {"physical_width_mm": 100.0, "physical_height_mm": -1.0}),
        ]:
            cases.append((name, _v2_board_outline_payload(**overrides)))

        for name, payload in cases:
            with self.subTest(name=name):
                result = _run_validator(
                    _events_to_temp_jsonl(
                        [_v2_event(event_type="board_outline_confirmed", payload=payload)]
                    )
                )
                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_board_outline_rejects_invalid_polygon_topology(self):
        cases = {
            "too_few": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.9, "y": 0.1},
            ],
            "closing_duplicate": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.9, "y": 0.1},
                {"x": 0.9, "y": 0.8},
                {"x": 0.1, "y": 0.1},
            ],
            "duplicate_vertex": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.9, "y": 0.1},
                {"x": 0.9, "y": 0.8},
                {"x": 0.9, "y": 0.1},
                {"x": 0.1, "y": 0.8},
            ],
            "collinear": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.5, "y": 0.5},
                {"x": 0.9, "y": 0.9},
            ],
            "self_crossing": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.9, "y": 0.8},
                {"x": 0.1, "y": 0.8},
                {"x": 0.9, "y": 0.1},
            ],
            "overlapping_non_adjacent_edges": [
                {"x": 0.1, "y": 0.1},
                {"x": 0.9, "y": 0.1},
                {"x": 0.9, "y": 0.8},
                {"x": 0.1, "y": 0.8},
                {"x": 0.7, "y": 0.1},
                {"x": 0.3, "y": 0.1},
            ],
        }
        for name, polygon in cases.items():
            with self.subTest(name=name):
                result = _run_validator(
                    _events_to_temp_jsonl(
                        [
                            _v2_event(
                                event_type="board_outline_confirmed",
                                payload=_v2_board_outline_payload(outer_polygon=polygon),
                            )
                        ]
                    )
                )
                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_board_outline_supersession_accepts_root_and_same_project_chain(self):
        events = [
            _v2_event(
                event_id="evt_200001",
                event_type="board_outline_confirmed",
                payload=_v2_board_outline_payload(),
                client_operation_id="op_outline_001",
            ),
            _v2_event(
                event_id="evt_200002",
                event_type="board_outline_confirmed",
                payload=_v2_board_outline_payload(
                    outer_polygon=[
                        {"x": 0.05, "y": 0.05},
                        {"x": 0.95, "y": 0.05},
                        {"x": 0.95, "y": 0.85},
                        {"x": 0.05, "y": 0.85},
                    ]
                ),
                client_operation_id="op_outline_002",
                supersedes_event_id="evt_200001",
            ),
        ]

        result = _run_validator(_events_to_temp_jsonl(events))

        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_board_outline_supersession_rejects_type_and_project_mismatches(self):
        outline = _v2_event(
            event_id="evt_200001",
            event_type="board_outline_confirmed",
            payload=_v2_board_outline_payload(),
            client_operation_id="op_outline_001",
        )
        measurement = _v2_event(
            event_id="evt_200001",
            event_type="measurement_recorded",
            payload=_v2_measurement_payload(),
            client_operation_id="op_measure_001",
        )
        cases = {
            "outline_to_measurement": [
                measurement,
                _v2_event(
                    event_id="evt_200002",
                    event_type="board_outline_confirmed",
                    payload=_v2_board_outline_payload(),
                    client_operation_id="op_outline_002",
                    supersedes_event_id="evt_200001",
                ),
            ],
            "measurement_to_outline": [
                outline,
                _v2_event(
                    event_id="evt_200002",
                    event_type="measurement_recorded",
                    payload=_v2_measurement_payload(measurement_id="meas_000002"),
                    client_operation_id="op_measure_002",
                    supersedes_event_id="evt_200001",
                ),
            ],
            "cross_project_outline": [
                outline,
                _v2_event(
                    event_id="evt_200002",
                    event_type="board_outline_confirmed",
                    payload=_v2_board_outline_payload(),
                    project_id="prj_other",
                    client_operation_id="op_outline_002",
                    supersedes_event_id="evt_200001",
                ),
            ],
            "future_outline_target": [
                _v2_event(
                    event_id="evt_200001",
                    event_type="board_outline_confirmed",
                    payload=_v2_board_outline_payload(),
                    client_operation_id="op_outline_001",
                    supersedes_event_id="evt_200002",
                ),
                _v2_event(
                    event_id="evt_200002",
                    event_type="board_outline_confirmed",
                    payload=_v2_board_outline_payload(),
                    client_operation_id="op_outline_002",
                ),
            ],
        }
        for name, events in cases.items():
            with self.subTest(name=name):
                result = _run_validator(_events_to_temp_jsonl(events))
                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_valid_measurement_recorded_passes(self):
        path = _events_to_temp_jsonl([_v2_event()])

        result = _run_validator(path)

        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_component_visual_placement_confirmed_passes(self):
        events = [
            _v2_event(
                event_id="evt_200001",
                event_type="component_created",
                payload=_v2_component_created_payload(),
                client_operation_id="op_v2_000001",
            ),
            _v2_event(
                event_id="evt_200002",
                event_type="component_visual_placement_confirmed",
                payload=_v2_component_visual_placement_payload(
                    template_id="sot23_3",
                    source_photo_id="photo_top_001",
                    notes="visual body only",
                ),
                client_operation_id="op_v2_000002",
                created_at="2026-06-06T10:01:00Z",
            ),
        ]
        path = _events_to_temp_jsonl(events)

        result = _run_validator(path)

        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_component_visual_placement_requires_human_confirmation_envelope(self):
        for field, value, expected in [
            ("actor_type", "ai", "actor.type must be 'human'"),
            ("source_type", "automated_import", "source.type must be 'explicit_user_confirmation'"),
            ("confirmed", False, "confirmation.confirmed must be true"),
        ]:
            with self.subTest(field=field):
                events = [
                    _v2_event(
                        event_id="evt_200001",
                        event_type="component_created",
                        payload=_v2_component_created_payload(),
                        client_operation_id="op_v2_000001",
                    ),
                    _v2_event(
                        event_id="evt_200002",
                        event_type="component_visual_placement_confirmed",
                        payload=_v2_component_visual_placement_payload(),
                        client_operation_id="op_v2_000002",
                        **{field: value},
                    ),
                ]
                path = _events_to_temp_jsonl(events)

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0)
                self.assertIn(expected, result.stdout + result.stderr)

    def test_v2_component_visual_placement_rejects_forbidden_semantic_fields(self):
        forbidden_fields = [
            "net_id",
            "pin_id",
            "confirmed_visual_contacts",
            "visual_contact_layout",
            "pads",
            "ai_authored_fact",
            "scale",
        ]
        for field in forbidden_fields:
            with self.subTest(field=field):
                events = [
                    _v2_event(
                        event_id="evt_200001",
                        event_type="component_created",
                        payload=_v2_component_created_payload(),
                        client_operation_id="op_v2_000001",
                    ),
                    _v2_event(
                        event_id="evt_200002",
                        event_type="component_visual_placement_confirmed",
                        payload=_v2_component_visual_placement_payload(**{field: "forbidden"}),
                        client_operation_id="op_v2_000002",
                    ),
                ]
                path = _events_to_temp_jsonl(events)

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0)
                self.assertIn("semantic field is forbidden", result.stdout + result.stderr)

    def test_v2_component_visual_placement_requires_width_and_height(self):
        payload = _v2_component_visual_placement_payload()
        payload.pop("height")
        events = [
            _v2_event(
                event_id="evt_200001",
                event_type="component_created",
                payload=_v2_component_created_payload(),
                client_operation_id="op_v2_000001",
            ),
            _v2_event(
                event_id="evt_200002",
                event_type="component_visual_placement_confirmed",
                payload=payload,
                client_operation_id="op_v2_000002",
            ),
        ]
        path = _events_to_temp_jsonl(events)

        result = _run_validator(path)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("missing payload fields", result.stdout + result.stderr)

    def test_v2_valid_component_update_and_invalidation_passes(self):
        events = [
            _v2_event(
                event_id="evt_200001",
                event_type="component_created",
                payload=_v2_component_created_payload(),
                client_operation_id="op_v2_000001",
            ),
            _v2_event(
                event_id="evt_200002",
                event_type="component_updated",
                payload={
                    "component_id": "Q2",
                    "changes": [
                        {
                            "field": "label",
                            "old_value_observed": "Q2",
                            "new_value": "Q2 suspected area",
                            "change_kind": "replace",
                        }
                    ],
                    "edit_reason": "human_label_clarity",
                },
                client_operation_id="op_v2_000002",
                created_at="2026-06-06T10:01:00Z",
            ),
            _v2_event(
                event_id="evt_200003",
                event_type="event_invalidated",
                payload={
                    "invalidates_event_id": "evt_200002",
                    "target_entity_id": "Q2",
                    "reason": "human_correction",
                    "human_note": "Superseded by later component edit.",
                },
                client_operation_id="op_v2_000003",
                created_at="2026-06-06T10:02:00Z",
            ),
        ]
        path = _events_to_temp_jsonl(events)

        result = _run_validator(path)

        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_alias_event_types_rejected(self):
        aliases = [
            "measurement_saved",
            "component_edited",
            "event_superseded",
            "measurement_updated",
            "replaces_event",
        ]
        for alias in aliases:
            with self.subTest(alias=alias):
                path = _events_to_temp_jsonl([_v2_event(event_type=alias)])

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertIn("rejected V2 event_type alias", result.stdout + result.stderr)

    def test_v2_component_updated_allows_package_hint_and_rejects_unknown_field(self):
        valid_update = _events_to_temp_jsonl(
            [
                _v2_event(
                    event_id="evt_200001",
                    event_type="component_created",
                    payload=_v2_component_created_payload(),
                    client_operation_id="op_v2_000001",
                ),
                _v2_event(
                    event_id="evt_200002",
                    event_type="component_updated",
                    payload={
                        "component_id": "Q2",
                        "changes": [
                            {
                                "field": "package_hint",
                                "old_value_observed": "old package",
                                "new_value": "SOT23",
                                "change_kind": "replace",
                            }
                        ],
                        "edit_reason": "package_hint_normalization",
                    },
                    client_operation_id="op_v2_000002",
                    created_at="2026-06-06T10:01:00Z",
                ),
            ]
        )

        result = _run_validator(valid_update)

        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

        invalid_update = _events_to_temp_jsonl(
            [
                _v2_event(
                    event_id="evt_200001",
                    event_type="component_created",
                    payload=_v2_component_created_payload(),
                    client_operation_id="op_v2_000001",
                ),
                _v2_event(
                    event_id="evt_200002",
                    event_type="component_updated",
                    payload={
                        "component_id": "Q2",
                        "changes": [
                            {
                                "field": "mystery_package_hint",
                                "old_value_observed": "old",
                                "new_value": "new",
                                "change_kind": "replace",
                            }
                        ],
                        "edit_reason": "unknown_field_probe",
                    },
                    client_operation_id="op_v2_000002",
                    created_at="2026-06-06T10:01:00Z",
                ),
            ]
        )
        invalid_result = _run_validator(invalid_update)

        self.assertNotEqual(invalid_result.returncode, 0, invalid_result.stdout + invalid_result.stderr)
        self.assertIn("must be one of", invalid_result.stdout + invalid_result.stderr)

    def test_v2_component_updated_rejects_proof_like_and_prohibited_fields(self):
        cases = [
            ("identity_proof", "forbidden proof field"),
            ("ai_confidence", "is forbidden"),
        ]
        for field, expected in cases:
            with self.subTest(field=field):
                path = _events_to_temp_jsonl(
                    [
                        _v2_event(
                            event_id="evt_200001",
                            event_type="component_created",
                            payload=_v2_component_created_payload(),
                            client_operation_id="op_v2_000001",
                        ),
                        _v2_event(
                            event_id="evt_200002",
                            event_type="component_updated",
                            payload={
                                "component_id": "Q2",
                                "changes": [
                                    {
                                        "field": field,
                                        "old_value_observed": "old",
                                        "new_value": "new",
                                        "change_kind": "replace",
                                    }
                                ],
                                "edit_reason": f"{field}_attempt",
                            },
                            client_operation_id="op_v2_000002",
                        ),
                    ]
                )

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertIn(expected, result.stdout + result.stderr)

    def test_v2_component_updated_still_requires_change_contract_fields(self):
        base_payload = {
            "event_id": "evt_200001",
            "event_type": "component_created",
            "payload": _v2_component_created_payload(),
            "client_operation_id": "op_v2_000001",
        }
        cases = [
            (
                {
                    "component_id": "Q2",
                    "changes": [
                        {
                            "old_value_observed": "Q2",
                            "new_value": "Q2B",
                            "change_kind": "replace",
                        }
                    ],
                    "edit_reason": "missing_field",
                },
                "missing field",
            ),
            (
                {
                    "component_id": "Q2",
                    "changes": [
                        {
                            "field": "",
                            "old_value_observed": "Q2",
                            "new_value": "Q2B",
                            "change_kind": "replace",
                        }
                    ],
                    "edit_reason": "empty_field",
                },
                "field must be non-empty string",
            ),
            (
                {
                    "component_id": "Q2",
                    "changes": [
                        {
                            "field": "label",
                            "new_value": "Q2B",
                            "change_kind": "replace",
                        }
                    ],
                    "edit_reason": "missing_old_value",
                },
                "missing old_value_observed",
            ),
            (
                {
                    "component_id": "Q2",
                    "changes": [
                        {
                            "field": "label",
                            "old_value_observed": "Q2",
                            "change_kind": "replace",
                        }
                    ],
                    "edit_reason": "missing_new_value",
                },
                "missing new_value",
            ),
            (
                {
                    "component_id": "Q2",
                    "changes": [
                        {
                            "field": "label",
                            "old_value_observed": "Q2",
                            "new_value": "Q2B",
                        }
                    ],
                    "edit_reason": "missing_change_kind",
                },
                "missing change_kind",
            ),
            (
                {
                    "component_id": "Q2",
                    "changes": [
                        {
                            "field": "label",
                            "old_value_observed": "Q2",
                            "new_value": "Q2B",
                            "change_kind": "invalid",
                        }
                    ],
                    "edit_reason": "invalid_change_kind",
                },
                "must be one of",
            ),
        ]
        for index, (change_payload, expected) in enumerate(cases):
            with self.subTest(index=index, expected=expected):
                path = _events_to_temp_jsonl(
                    [
                        _v2_event(**base_payload),
                        _v2_event(
                            event_id="evt_200002",
                            event_type="component_updated",
                            payload=change_payload,
                            client_operation_id="op_v2_000002",
                        ),
                    ]
                )

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertIn(expected, result.stdout + result.stderr)

    def test_v2_component_updated_field_allowlist_matches_materializer_projection(self):
        from tools import materialize_known_facts
        from tools import validate_events_jsonl

        self.assertEqual(
            validate_events_jsonl.V2_COMPONENT_UPDATED_ALLOWED_FIELDS,
            set(materialize_known_facts.V2_COMPONENT_FIELDS) - {"component_id"},
        )

    def test_v2_schema_version_fail_closed(self):
        cases = [
            (
                "missing",
                _v2_event(schema_version=None),
                "V2 canonical event requires schema_version",
            ),
            (
                "unsupported",
                _v2_event(schema_version="2.1"),
                "unsupported V2 schema_version",
            ),
            (
                "unknown_event",
                _v2_event(event_type="component_deleted"),
                "unknown V2 event_type",
            ),
        ]
        for name, event, expected in cases:
            with self.subTest(name=name):
                path = _events_to_temp_jsonl([event])

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertIn(expected, result.stdout + result.stderr)

    def test_v2_forbidden_actor_or_source_rejected(self):
        cases = [
            ("ai_actor", {"actor_type": "ai"}),
            ("helper_actor", {"actor_type": "helper"}),
            ("renderer_source", {"source_type": "renderer"}),
            ("reference_image_source", {"source_type": "reference_image"}),
            ("visual_trace_source", {"source_type": "visual_trace"}),
        ]
        for name, kwargs in cases:
            with self.subTest(name=name):
                path = _events_to_temp_jsonl([_v2_event(**kwargs)])

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertTrue(
                    "actor.type must be 'human'" in result.stdout + result.stderr
                    or "source.type must be 'explicit_user_confirmation'" in result.stdout + result.stderr
                )

    def test_v2_measurement_value_provenance_guards(self):
        missing_provenance = _v2_measurement_payload()
        missing_provenance.pop("value_provenance")
        context_promoted = _v2_measurement_payload(
            value_provenance={
                "measured_value_source": "reference_value",
                "human_verified_as_own_reading": False,
            }
        )
        one_tap_promoted = _v2_measurement_payload(
            value_provenance={
                "measured_value_source": "human_confirmed_from_reference",
                "human_verified_as_own_reading": True,
                "one_tap_confirmed": True,
            }
        )
        cases = [
            ("missing", missing_provenance, "measurement_recorded requires value_provenance"),
            ("context_promoted", context_promoted, "context value source cannot be reading.value"),
            ("one_tap", one_tap_promoted, "one-tap context promotion is forbidden"),
        ]
        for name, payload, expected in cases:
            with self.subTest(name=name):
                path = _events_to_temp_jsonl([_v2_event(payload=payload)])

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertIn(expected, result.stdout + result.stderr)

    def test_v2_point_to_point_target_with_dotted_labels_passes(self):
        payload = _v2_measurement_payload(
            target={
                "target_kind": "point_to_point",
                "target_key": "ptp:Q2.1:R17.1",
                "display_label": "Q2.1 -> R17.1",
                "from_target": {
                    "target_kind": "component_pin",
                    "target_key": "component:Q2:pin:1",
                    "display_label": "Q2.1",
                    "component_id": "Q2",
                    "pin_id": "Q2.1",
                },
                "to_target": {
                    "target_kind": "component_pin",
                    "target_key": "component:R17:pin:1",
                    "display_label": "R17.1",
                    "component_id": "R17",
                    "pin_id": "R17.1",
                },
            },
            reading={
                "mode": "continuity",
                "value": True,
                "unit": "beep",
                "display_value": "beep",
            },
        )
        path = _events_to_temp_jsonl([_v2_event(payload=payload)])

        result = _run_validator(path)

        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_v2_prohibited_fields_rejected(self):
        cases = [
            ("ai_confidence", {"ai_confidence": 0.8}),
            ("board_graph_ref", {"board_graph_ref": "board_graph.json"}),
            ("view_state_ref", {"view_state_ref": "view_state.json"}),
            ("reference_image_evidence", {"reference_image_evidence": "refimg_1"}),
            ("visual_trace_net", {"visual_trace_net": "N1"}),
        ]
        for field, extra_payload in cases:
            with self.subTest(field=field):
                payload = _v2_measurement_payload(**extra_payload)
                path = _events_to_temp_jsonl([_v2_event(payload=payload)])

                result = _run_validator(path)

                self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                self.assertIn("prohibited V2 canonical field", result.stdout + result.stderr)

    def test_v2_invalidation_source_boundary_rejected(self):
        event = _v2_event(
            event_id="evt_200002",
            event_type="event_invalidated",
            payload={
                "invalidates_event_id": "evt_200001",
                "target_entity_id": "meas_000001",
                "reason": "helper_cleanup",
            },
            source_type="import_inference",
            client_operation_id="op_v2_000002",
        )
        path = _events_to_temp_jsonl([_v2_event(), event])

        result = _run_validator(path)

        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("source.type must be 'explicit_user_confirmation'", result.stdout + result.stderr)

    def test_v2_self_relation_cycle_rejected(self):
        event = _v2_event(supersedes_event_id="evt_200001")
        path = _events_to_temp_jsonl([event])

        result = _run_validator(path)

        self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("relation cycle", result.stdout + result.stderr)

    def test_legacy_v1_without_schema_version_remains_valid(self):
        events = [
            {
                "event_id": "evt_000001",
                "project_id": "prj_test",
                "sequence": 1,
                "created_at": "2026-01-01T00:00:00Z",
                "actor": {"type": "user", "id": "u1"},
                "event_type": "project_created",
                "status": "accepted",
                "payload": {"name": "legacy project"},
            }
        ]
        path = _events_to_temp_jsonl(events)

        result = _run_validator(path)

        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)


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
