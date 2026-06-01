# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Goal

Compact governance handoff docs after `REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_CLOSEOUT_PASS` and re-align current/next routing boundaries.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/DOCS_DRIFT_MINI_CLEANUP_PASS.md`

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
- schema/materializer/runtime/tooling surface changes
- fixture/sample/asset or generated-artifact edits
- Git tag actions
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry inference
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- This is a docs-only cleanup pass.
- Keep `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md` compact and bounded to current handoff state.
- Keep `AUDIT_INDEX.md` and the pass audit doc aligned to the same cleanup outcome.
- Do not expand implementation scope while compacting docs.

## Next recommended pass

`NONE` (no immediate implementation pass queued)

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git diff --cached --name-only`
- `git status --short --branch`
