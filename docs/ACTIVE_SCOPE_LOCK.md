# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`

## Goal

Docs-only lock for future materializer/known-facts projection direction of `photo_to_board_alignment_confirmed`, before any projection/schema/model/runtime implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS.md`
- `docs/PHOTO_FLOW_SPEC.md` only if needed
- `docs/PROJECT_MEMORY.md` only if stale
- `docs/TRUTH_INDEX.md` only if stale

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `lib/**`
- `test/**`
- `tests/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter/runtime implementation
- materializer implementation
- known_facts schema implementation
- Dart `KnownFacts` implementation
- photo alignment UI
- background photo helper
- visual_trace rendering
- damage/suspect rendering
- coordinate transform implementation
- AI proposal persistence
- raw `known_facts` JSON parsing in board-canvas code

## Locked decisions

1. Accepted baseline remains:
   - `PHOTO_ALIGNMENT_EVENT_SCHEMA_CLOSEOUT_PASS`.
2. Projection ownership is locked for future implementation:
   - canonical alignment projection belongs to Python materializer + `known_facts` schema.
   - Flutter/UI local transform state cannot become canonical truth.
3. Future projection direction is locked (not implemented in this pass):
   - optional top-level `photo_to_board_alignments` in `known_facts`,
   - canonical event data only plus `source_event_id` and normalized projection `status`.
4. Materializer boundaries are locked:
   - no transform matrix computation in first projection pass,
   - no conversion of photo-local evidence into board-canvas geometry,
   - no side effects into components/pins/nets/measurements/visual-traces/fault flows,
   - no `board_graph.json` / `view_state.json`,
   - no Project ZIP contract changes.
5. Placeholder policy remains locked:
   - `photo_reference_points_set` and `photo_layer_aligned` remain reserved/deferred, not writer-ready, not materialized.
6. Next recommended pass:
   - `PHOTO_ALIGNMENT_MATERIALIZER_PRECHECK_AUDIT_PASS`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
