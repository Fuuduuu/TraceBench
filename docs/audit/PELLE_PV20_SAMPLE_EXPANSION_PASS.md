# PELLE_PV20_SAMPLE_EXPANSION_PASS

Status: completed
Lane: SAMPLE_PASS
Goal: expand Pelle PV20 minimal sample with population-excluded footprints and unlabeled Q2 pin definitions.

Scope:
- samples/pelle_pv20_minimal/events.jsonl
- samples/pelle_pv20_minimal/known_facts.json
- docs/ACTIVE_SCOPE_LOCK.md
- tests/test_materialize_known_facts.py
- tests/test_validate_events_jsonl.py
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md

Events added (append only):
- evt_000010: footprint_marked_not_populated (K2)
- evt_000011: footprint_marked_not_populated (K3)
- evt_000012: pin_defined (Q2.2)
- evt_000013: pin_defined (Q2.3)

Tests added:
- test_three_footprints_excluded_from_fault_candidates
- test_q2_pins_defined_in_events
- test_pin_defined_without_label_allowed
- test_pelle_sample_with_expansion_validates

Materialization expectations confirmed:
- excluded_from_fault_candidates now includes K1, K2, and K3
- M001 remains stale_after_repair with valid_until_event_id evt_000007
- M002 remains active
- N1 remains confirmed by evt_000008

Verification:
- py -3 tools\materialize_known_facts.py samples\pelle_pv20_minimal\events.jsonl samples\pelle_pv20_minimal\known_facts.json
- py -3 tools\validate_all.py

Out-of-scope (intentionally not added):
- C12, R4, D14, D5-D9, IC1
- OK1 damage_region_marked
- K6 repair history
- Q2 functional role / mains-sense claim
- Q2→MCU net connection
- photo-flow events
- fault probability
- UI / AI / OCR / CV
- source search
- KiCad export
