# PROTECTED_SURFACES.md

Changing these requires a dedicated protected-surface pass:

- event envelope semantics
- evidence status lifecycle
- Visual/Layout Graph vs Electrical Net Graph boundary
- evidence floor rule
- `valid_from_event_id` / `valid_until_event_id`
- repair action semantics
- `stale_after_repair` invalidation logic
- conflict workflow
- `not_populated` semantics
- `forbidden_ai_actions`
- generic device profile fallback
- Project ZIP self-contained contract
- AI no-invented-measurement rule

- events.jsonl is the only canonical truth.
- known_facts.json is a materialized domain projection.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- renderer/view code is read-only.
- visual evidence (including visual traces) is visual-only and must not promote to measured electrical nets.
- no `component_removed` event in V1.
- component removal is modeled as `repair_action_recorded(action_type="remove_component")`.
- removed components stay in history and do not trigger connected-net invalidation.
