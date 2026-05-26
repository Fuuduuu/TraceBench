# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_PLACEMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS`

## Goal

Lock the future schema/validator/materializer direction for human-confirmed visual placement events before any implementation.

## Allowed surfaces

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/BOARD_PLACEMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` (optional, only if strictly needed)

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
- event-writing implementation
- component editing UI
- renderer implementation
- camera/OCR/CV
- AI proposal persistence
- AI diagnostics/fault probability
- source search
- KiCad/boardview import/export
- BLE/cloud

## Scope decisions to lock

1. Audit verdict is accepted: `SCHEMA_DIRECTION_APPROVED_WITH_CHANGES`.
2. Future schema direction uses dedicated event type: `component_visual_placement_confirmed`; existing event types must not be overloaded.
3. Future concept separation remains explicit:
   - `component_template_assigned_confirmed`
   - `component_identity_confirmed`
   - `component_pin_mapping_confirmed`
   - `visual_trace_confirmed`
   - measured electrical remains `measurement_recorded` -> `net_connection_confirmed`.
4. Required future placement payload direction:
   - `component_id`
   - `coordinate_space`
   - `board_side`
   - `center_x`
   - `center_y`
   - `rotation_deg`
   - one sizing mode: `scale` or (`width` + `height`)
   - optional: `template_id`, `template_assignment_event_id`, `source_photo_id` (when `photo_local`), `notes`.
5. Placement confirmation is visual/documentation fact only and must not confirm identity/electrical/net/measurement/fault/repair conclusions.
6. AI proposals remain `unconfirmed_ai_proposal` and non-canonical until explicit human confirmation.
7. Canonical placement must include `coordinate_space`; allowed future canonical coordinate spaces:
   - `board_normalized`
   - `photo_local` only with valid `source_photo_id`.
8. `graph_layout` is non-canonical render state and must be rejected as canonical placement coordinate space.
9. Future schema direction for `schemas/events.schema.json`:
   - add `component_visual_placement_confirmed` to `event_type` enum
   - add strict payload `$defs`
   - `additionalProperties: false`
   - enforce `coordinate_space` enum and `board_side` enum
   - enforce numeric coordinate/size/rotation constraints where practical
   - encode dependency: `photo_local` requires valid `source_photo_id`.
10. Future validator direction for `tools/validate_events_jsonl.py`:
   - reject `actor.type == "ai"` for placement confirmation
   - reject `actor.type == "system"` unless a future dedicated migration scope explicitly allows it
   - whitelist coordinate spaces
   - reject `graph_layout`
   - enforce `board_normalized` ranges
   - require valid prior `photo_added` reference for `photo_local`
   - require existing `component_id`
   - enforce no forward references unless explicitly accepted
   - prevent identity/net/measurement side effects from placement confirmation.
11. Future materializer direction for `tools/materialize_known_facts.py`:
   - materialize placement as visual/documentation fact only
   - no effects on nets/measurements/fault candidates/electrical graph
   - default to latest accepted placement per component
   - retain history in `events.jsonl`
   - keep historical placement visible even if component is removed (non-electrical).
12. Future projection recommendation in `known_facts.json` is top-level `component_visual_placements` to keep visual placement separate from identity/electrical facts.
13. Future test requirements are locked:
   - schema accept/reject cases for placement payload
   - validator reject AI actor and `graph_layout`
   - validator coordinate and `source_photo_id` checks
   - validator unknown `component_id` checks
   - materializer no identity/net side effects
   - ZIP validation remains passing with placement projection
   - placement has no measured-net/fault-candidate effects
   - removal/history behavior is explicit and tested.
14. Next pass recommendation after accepting this lock:
   - `BOARD_PLACEMENT_EVENT_SCHEMA_PASS`
   - optional Pro pre-implementation audit only if governance requires extra schema/tool precheck.

## Validate

- `py -3 tools\validate_all.py`
