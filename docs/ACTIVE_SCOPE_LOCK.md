# ACTIVE_SCOPE_LOCK.md

## Current pass

`STATUS_SEMANTICS_REGRESSION_CLOSEOUT_PASS`

## Goal

Record Pro status-semantics post-implementation audit outcome and close queued regression work in docs/queue state without additional code or audit implementation changes.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/STATUS_SEMANTICS_REGRESSION_CLOSEOUT_PASS.md`
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
- sample refresh

## Scope decisions

1. Pro `STATUS_SEMANTICS_END_TO_END_AUDIT_PASS` verdict is `PASS_WITH_NITS`.
2. Pro audit satisfies the intent of queued `STATUS_SEMANTICS_REGRESSION_PASS`.
3. No additional status-semantics code fix is required in current accepted state.
4. Keep hard boundaries unchanged:
   - accepted events are current domain truth,
   - non-accepted events remain audit/history/review data,
   - known_facts is current projection (not audit history),
   - no `visual_trace` -> measured-net promotion,
   - no AI proposal -> confirmed fact promotion,
   - `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
5. Next routing is queue review (`QUEUE_REVIEW_AFTER_STATUS_SEMANTICS_PASS`), not direct renderer/UI implementation.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
