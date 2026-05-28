# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for a future read-only visual-trace metadata summary in board-canvas inspector/list area.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- `docs/audit/BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS.md`
- optional only if stale:
  - `docs/PHOTO_FLOW_SPEC.md`
  - `docs/BOARD_GRAPH_SPEC.md`
  - `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
  - `docs/FLUTTER_UI_SPEC.md`

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tests/**`
- `schemas/**`
- `tools/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter implementation
- visual trace rendering
- visual trace canvas polyline
- photo-to-board transform
- background photo helper
- damage/suspect rendering
- measurement canvas overlay
- AI proposal persistence
- edit/confirm/save/export/event-writing UI
- raw known_facts JSON parsing

## Locked decisions

1. Photo evidence alignment decision remains: `DEFER_PHOTO_ALIGNMENT_IMPLEMENTATION`.
2. Future board-canvas visual-trace support is locked to read-only inspector/list metadata only.
3. Future visual-trace-to-component association is locked to strict rules:
   - `trace.fromComponent == componentId`
   - `trace.toComponent == componentId`
   - `trace.fromPin` starts with `componentId + "."`
   - `trace.toPin` starts with `componentId + "."`
4. Explicitly forbidden:
   - loose prefix matching (`Q2` must not match `Q20`)
   - matching by nets/proximity/measurement/template/overlap
   - visual-trace geometry rendering on board canvas
   - `from_point` / `to_point` board-canvas rendering path
   - photo-local to board transform/alignment implementation
   - visual-trace-to-net promotion/inference
5. Read-only no-write boundaries remain locked:
   - no events writes
   - no known-facts mutation
   - no `board_graph.json` / `view_state.json`
   - no Project ZIP contract change
6. Next recommended pass:
   - `BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
