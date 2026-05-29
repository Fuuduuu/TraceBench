# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_ALIGNMENT_EVENT_SCHEMA_CLOSEOUT_PASS`

## Goal

Docs-only closeout for `PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS` after Claude Code audit (`PASS_WITH_NITS`).

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PHOTO_ALIGNMENT_EVENT_SCHEMA_CLOSEOUT_PASS.md`
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
- schema/validator/materializer implementation
- Dart `KnownFacts` implementation
- photo alignment implementation/UI
- background photo helper
- visual_trace/damage/suspect rendering
- coordinate transform implementation
- AI proposal persistence
- raw `known_facts` JSON parsing in board-canvas code

## Locked decisions

1. `PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS` is accepted; closeout verdict is `PASS_WITH_NITS`.
2. Accepted in current state:
   - `photo_to_board_alignment_confirmed` event schema support,
   - validator enforcement,
   - validator tests,
   - valid schema sample.
3. Still deferred:
   - materializer projection,
   - `known_facts` schema/model projection,
   - Dart `KnownFacts` projection,
   - board-canvas rendering/alignment UI,
   - Project ZIP contract changes.
4. Placeholder policy remains unchanged:
   - `photo_reference_points_set` and `photo_layer_aligned` remain reserved/deferred and not writer-ready.
5. Next recommended pass:
   - `PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
