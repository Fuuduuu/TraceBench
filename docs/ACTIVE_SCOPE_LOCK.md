# ACTIVE_SCOPE_LOCK.md

## Current pass

`QUEUE_REVIEW_AFTER_STATUS_SEMANTICS_PASS`

## Goal

Review queue/state/lock alignment after status-semantics closeout and route the next safest pass without touching code/tooling/runtime surfaces.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/QUEUE_REVIEW_AFTER_STATUS_SEMANTICS_PASS.md`
- `docs/PROJECT_MEMORY.md` (only if narrowly needed)
- `docs/TRUTH_INDEX.md` (only if narrowly needed)

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `tests/**`
- `lib/**`
- `test/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- schema/validator/materializer implementation
- runtime/Flutter code
- renderer/UI implementation
- AI proposal persistence
- external AI simulation lab files

## Scope decisions

1. Status-semantics series is closed (`PASS_WITH_NITS` Pro closeout accepted, no further code fix required).
2. Current routing to already-completed status-semantics work is removed.
3. Next safest pass is `VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS`.
4. Rationale: footprint/template model boundaries should be scope-locked before any board-canvas renderer/UI implementation to prevent boundary drift between placement/template/identity semantics.
5. Keep renderer/UI implementation deferred in this pass.
6. Keep AI proposal persistence deferred and external simulation lab out-of-repo.
7. Preserve hard boundaries:
   - accepted events are current domain truth,
   - non-accepted events remain audit/history/review data,
   - known_facts is current projection,
   - no `visual_trace` -> measured net promotion,
   - no AI proposal -> confirmed fact promotion,
   - `board_graph.json` / `view_state.json` forbidden in V1.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
