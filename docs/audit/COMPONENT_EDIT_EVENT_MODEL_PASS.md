# COMPONENT_EDIT_EVENT_MODEL_PASS

Status: completed

Lane: SCHEMA_PASS

## Goal

Add V1 component-removal behavior using `repair_action_recorded(action_type="remove_component")` while preserving append-only history and avoiding inferred electrical consequences.

## Scope

Schema/validator/materializer/tests/docs-only implementation.
No Flutter/UI changes.

## Files changed

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

## Validation

- `py -3 tools/validate_all.py`
- `flutter test --reporter expanded`

## Notes

- `remove_component` is supported by schema and runtime validation.
- Component removal is materialized as derived state only:
  - `installation_status: "removed"`
  - `removed_by_event_id: <repair event_id>`
- Existing component records are preserved (no deletion).
- Component identity fields are not cleared for remove operations.
- Direct measurements to removed components are marked stale when policy is `stale_after_repair`.
- `connected_net_measurements` must remain `no_change`.
- `component_removed` event type is not introduced.

## Forbidden surfaces confirmed not changed

- No Flutter/Dart files changed.
- No schema/validator/tooling semantics expanded beyond component removal action.
- No samples/assets mutated.
- No Project ZIP tooling changes.
- No `board_graph.json` or `view_state.json` generation.
- No visual trace → measured net promotion.
- No event-writing implementation.
- No component editing UI.
