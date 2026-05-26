# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_PLACEMENT_EVENT_SCHEMA_SPLIT_ROUTING_PASS`

## Goal

Refine roadmap routing by splitting the previously broad placement schema implementation into smaller safe implementation passes, without changing runtime/schema/tool behavior in this pass.

## Allowed surfaces

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/BOARD_PLACEMENT_EVENT_SCHEMA_SPLIT_ROUTING_PASS.md`

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tests/**`
- `schemas/**`
- `tools/**`
- `samples/**`
- `assets/**`
- `pubspec.yaml`
- `pubspec.lock`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter implementation
- schema implementation
- validator implementation
- materializer implementation
- renderer implementation
- event-writing UI
- component editing UI
- AI proposal persistence
- camera/OCR/CV

## Scope decisions to lock

1. Pro verdict recorded: `READY_WITH_IMPLEMENTATION_SPLIT`.
2. Broad next-pass routing to `BOARD_PLACEMENT_EVENT_SCHEMA_PASS` is replaced by:
   - next: `BOARD_PLACEMENT_EVENT_SCHEMA_VALIDATOR_PASS`
   - follow-up: `BOARD_PLACEMENT_EVENT_PROJECTION_PASS`
3. `BOARD_PLACEMENT_EVENT_SCHEMA_VALIDATOR_PASS` scope intent:
   - `schemas/events.schema.json`
   - `tools/validate_events_jsonl.py`
   - `tests/test_validate_events_jsonl.py`
   - `tests/test_schema_samples.py` only if required
4. `BOARD_PLACEMENT_EVENT_PROJECTION_PASS` scope intent:
   - `schemas/known_facts.schema.json`
   - `tools/materialize_known_facts.py`
   - `tests/test_materialize_known_facts.py`
   - `tests/test_project_zip.py`
5. First implementation split keeps event name: `component_visual_placement_confirmed`.
6. First implementation split lock expectations:
   - require `actor.type == user`
   - reject `actor.type` in `{ai, system, import}`
   - require prior `component_created` for `component_id`
   - reject forward component references
   - reject `graph_layout`
   - `board_normalized` uses 0..1 bounds
   - `photo_local` requires prior valid `photo_added` `source_photo_id`
   - reject `source_photo_id` when `coordinate_space == board_normalized`
   - enforce exactly one sizing mode: `scale` xor (`width` + `height`)
   - defer `template_assignment_event_id` from first implementation split
   - allow optional `template_id` as opaque string only
7. Deferred to projection split:
   - known-facts shape updates
   - materializer projection behavior
   - placement ZIP regression coverage tied to projection outputs
8. Safety boundaries remain unchanged:
   - no identity confirmation
   - no electrical/net confirmation
   - no AI proposal canonicalization
   - no `graph_layout` canonical coordinate
   - no `visual_trace` promotion.

## Validate

- `py -3 tools\validate_all.py`
