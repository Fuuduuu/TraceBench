# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_SCOPE_AND_NOISE_CLEANUP_PASS`

## Goal

Docs-only cleanup of scope/routing noise after `DOCS_SCOPE_AND_NOISE_AUDIT_PASS`, with no product behavior changes.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- `docs/PHOTO_FLOW_SPEC.md`
- `docs/MODEL_ROUTING.md` (concise no-self-approval rule only)
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/DOCS_SCOPE_AND_NOISE_CLEANUP_PASS.md`

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
- No schema/tool/materializer/Dart/Flutter implementation changes.
- No Project ZIP contract changes.
- No evidence-boundary weakening.
- Renderer/view remains no-write.

## Next recommended pass

`LIVE_LITE_SMOKE_TEST_PLAN_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
