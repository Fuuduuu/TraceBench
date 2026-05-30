# ACTIVE_SCOPE_LOCK.md

## Current pass

`LIVE_LITE_SMOKE_TEST_PLAN_PASS`

## Goal

Docs-only planning pass to create a focused manual live-lite smoke-test runbook for current board-canvas and readiness-panel behavior.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/LIVE_LITE_SMOKE_TEST_PLAN_PASS.md`
- `docs/BOARD_CANVAS_LIVE_LITE_SMOKE_TEST_PLAN.md`

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
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Docs-only updates.
- No schema/tool/materializer/Dart/Flutter implementation or automated test changes.
- No Project ZIP contract changes.
- No evidence-boundary weakening.
- Renderer/view remains no-write.

## Next recommended pass

`LIVE_LITE_SMOKE_TEST_RUN_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
