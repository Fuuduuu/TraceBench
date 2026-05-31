# ACTIVE_SCOPE_LOCK.md

## Current pass

`LIVE_POSITIVE_SMOKE_TEST_RUN_PASS`

## Goal

Docs-only recording pass for the completed manual positive smoke run using the accepted `board_canvas_positive_smoke` fixture.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/LIVE_POSITIVE_SMOKE_TEST_RUN_PASS.md`

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

- Docs-only smoke-run evidence recording and routing reconciliation.
- No schema/tool/materializer/Dart/Flutter implementation or automated test changes.
- No fixture/sample/data changes in this pass.
- No Project ZIP contract changes.
- No evidence-boundary weakening.
- Renderer/view remains no-write.

## Next recommended pass

`BOARD_CANVAS_UI_POLISH_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
