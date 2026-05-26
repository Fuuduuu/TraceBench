# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_PLACEMENT_EVENT_MODEL_SCOPE_LOCK_PASS`

## Goal

Lock the future canonical event-model direction for human-confirmed visual component placement while preserving evidence-floor boundaries and keeping AI proposals non-canonical until explicit human confirmation.

## Allowed surfaces

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/BOARD_PLACEMENT_EVENT_MODEL_SCOPE_LOCK_PASS.md`
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
- event-writing implementation
- component editing UI
- renderer implementation
- schema implementation
- materializer implementation
- camera/OCR/CV
- AI proposal persistence
- AI diagnostics/fault probability
- source search
- KiCad/boardview import/export
- BLE/cloud

## Scope decisions to lock

1. Audit verdict is accepted: `PLACEMENT_SHOULD_BE_CANONICAL_EVENT`.
2. Future direction uses new canonical event type (recommendation): `component_visual_placement_confirmed`; existing event types must not be overloaded.
3. Confirmation concepts remain separate:
   - `component_template_assigned_confirmed`
   - `component_identity_confirmed`
   - `component_pin_mapping_confirmed`
   - `visual_trace_confirmed`
   - measured electrical remains `measurement_recorded` -> `net_connection_confirmed`.
4. Placement confirmation is visual/documentation fact only and does not confirm identity, electrical behavior, measured net, or hidden-layer trace.
5. AI proposals remain `unconfirmed_ai_proposal` and non-canonical until explicit human confirmation through accepted event flow.
6. Canonical placement must include `coordinate_space`.
7. Future canonical placement coordinate spaces:
   - `board_normalized`
   - `photo_local` only with valid `source_photo_id`.
8. `graph_layout` is non-canonical render state and must never be accepted as canonical placement coordinate space.
9. Minimum future placement payload direction:
   - `component_id`
   - `template_id` or reference to separately confirmed template assignment
   - `board_side`
   - `coordinate_space`
   - `center_x`
   - `center_y`
   - `rotation_deg`
   - `width`/`height` or `scale`
   - `source_photo_id` optional/required for `photo_local`.
10. Future validation direction (schema/tool pass):
   - reject `actor.type == "ai"` for placement confirmation
   - whitelist coordinate spaces
   - require valid `source_photo_id` for `photo_local`
   - reject `graph_layout`
   - require existing `component_id`
   - prevent identity/net side effects from placement confirmation.
11. Future projection direction may materialize confirmed placement into `known_facts.json` as component placement facts only; proposal layer remains non-canonical and non-materialized.

## Validate

- `py -3 tools\validate_all.py`
