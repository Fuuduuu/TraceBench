# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_ALIGNMENT_READINESS_QA_CLOSEOUT_PASS`

## Goal

Docs-only audit closeout for `BOARD_CANVAS_ALIGNMENT_READINESS_QA_PASS` after Claude Code review.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_ALIGNMENT_READINESS_QA_CLOSEOUT_PASS.md`

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
- event-writing UI
- AI proposal UI

## Closeout boundary (locked)

- no schema/tool/materializer/Dart model changes.
- no Project ZIP changes.
- no transform computation or coordinate conversion.
- no background photo helper.
- no photo-local evidence board rendering.
- no visual_trace/damage/suspect canvas geometry.
- no event-writing/edit/confirm/save/apply UI.
- no `board_graph.json`.
- no `view_state.json`.
- renderer writes nothing.

## Next recommended pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
