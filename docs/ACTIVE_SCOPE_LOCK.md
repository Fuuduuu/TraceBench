# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS`

## Goal

Docs-only UI scope lock for the next safe board-canvas photo-alignment direction after the accepted readiness panel + QA chain.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md` only if needed to clarify UI boundaries
- `docs/PHOTO_FLOW_SPEC.md` only if needed to add a short pointer
- `docs/audit/BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS.md`

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
- Flutter implementation
- board-canvas rendering implementation
- background photo helper
- transform computation
- matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry
- measurement canvas overlay
- event-writing UI
- reference-point editing
- edit/confirm/save/apply controls
- AI proposal UI

## Scope boundary (locked)

- no schema/tool/materializer/Dart model changes.
- no Project ZIP changes.
- no transform computation/matrix math or coordinate conversion.
- no background photo helper.
- no photo-local evidence board rendering.
- no visual_trace/damage/suspect canvas geometry.
- no measurement canvas overlay.
- no event-writing/reference-point-edit/edit/confirm/save/apply UI.
- no `board_graph.json`.
- no `view_state.json`.
- renderer writes nothing.

## Next recommended pass

`LIVE_LITE_SMOKE_TEST_PLAN_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
