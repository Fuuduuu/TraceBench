# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for future `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md` (only if boundary wording needs alignment)
- `docs/audit/BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS.md`

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

## Scope-lock boundary (locked)

- readiness panel is read-only metadata/status only.
- no canvas geometry, overlays, or photo rendering.
- no raw reference-point x/y display.
- no transformed coordinates or transform matrix/math output.
- no mapped visual_trace/damage/suspect rendering.
- no edit/confirm/save/apply controls.
- no event-writing actions or reference-point editing.
- panel is project/photo-level, not component-identity proof.
- renderer writes nothing.
- no `board_graph.json`.
- no `view_state.json`.

## Next recommended pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
