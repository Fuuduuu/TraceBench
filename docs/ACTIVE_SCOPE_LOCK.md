# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_CLOSEOUT_PASS`

## Goal

Docs-only closeout pass to finalize audit acceptance for `BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_PASS` and align forward routing.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_PASS.md`
- `docs/audit/BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_CLOSEOUT_PASS.md`

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
- automated test implementation
- fixture/sample implementation
- generated data changes
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Docs-only closeout and routing reconciliation.
- No schema/tool/materializer/Dart/Flutter implementation or automated test changes.
- No fixture/sample/data changes in this pass.
- No Project ZIP contract changes.
- No evidence-boundary weakening.
- Renderer/view remains no-write.

## Next recommended pass

`LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
