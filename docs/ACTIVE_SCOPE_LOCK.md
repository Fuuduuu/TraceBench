# ACTIVE_SCOPE_LOCK.md

## Current pass

`COMPONENT_EDIT_EVENT_MODEL_PASS`

## Goal

Add component removal semantics through repair_action_recorded(action_type="remove_component") in
schema/validator/materializer/tests/docs without changing UI or project ZIP tooling.

## Allowed surfaces

- schemas/events.schema.json
- tools/validate_events_jsonl.py
- tools/materialize_known_facts.py
- tests/test_validate_events_jsonl.py
- tests/test_materialize_known_facts.py
- tests/test_graph_projection.py
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/COMPONENT_EDIT_EVENT_MODEL_PASS.md

## Forbidden surfaces

- `lib/**`
- `test/**` Flutter tests
- `pubspec.yaml`
- `pubspec.lock`
- Project ZIP tooling/files
- `schemas/known_facts.schema.json` (unless explicit schema rejection requires minimal additive change)
- `samples/**`
- `assets/**`
- `board_graph.json`
- `view_state.json`
- `event-writing` implementation
- component editing UI
- event-writing implementation
- flutter code changes
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview workflows
- BLE multimeter
- cloud sync
- schema connected-net invalidation behavior changes
- event envelope semantic changes

## Verify

- py -3 tools\validate_all.py
- flutter test --reporter expanded
