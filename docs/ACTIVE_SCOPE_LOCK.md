# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_SCOPE_LOCK_PASS`

## Goal

Lock the implementation scope for the next board-canvas pass: read-only component placement rendering.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- `docs/audit/BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_SCOPE_LOCK_PASS.md`
- Optional only if stale:
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
- Flutter renderer implementation
- CustomPainter implementation
- Canvas rendering
- scene graph implementation
- spatial index implementation
- hit testing implementation
- component editing UI
- event-writing UI
- AI proposal persistence
- background photo helper
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Locked decisions

1. Shell audit verdict is recorded: `PASS_WITH_NITS`.
2. Next implementation pass is locked to `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS`.
3. Future implementation allowlist is locked to:
   - `lib/features/board_canvas/**`
   - `test/widget/board_canvas_screen_test.dart` (or focused board-canvas widget tests)
   - docs ledger files
4. Future implementation data path is locked to:
   - `ProjectState.knownFacts.componentVisualPlacements`
   - `ProjectState.knownFacts.components`
   - `VectorFootprintLibrary` metadata
5. Future implementation must not parse raw `known_facts.json`.
6. Coordinate rule for future implementation is locked:
   - render only `coordinate_space = board_normalized`
   - `photo_local` is deferred until accepted coordinate-mapping scope
   - `photo_local` entries must not be converted to board coordinates
   - encountering `photo_local` must remain safe (no crash)
7. Template boundary for future implementation is locked:
   - `template_id` is package/geometry metadata only
   - missing or unknown `template_id` must use neutral fallback
   - no template-driven identity inference
8. Future implementation may render:
   - confirmed/projected component visual placements in `board_normalized`
   - designator/label only when present in known facts
   - unknown template families (`unknown_rect`, `unknown_2pin`, `unknown_3pin`, `unknown_multi_pin`) safely
9. Future implementation must preserve shell behavior:
   - existing empty states remain valid
   - exact status chrome text remains visible: `renderer writes: none`
10. Future implementation read-only boundary remains strict:
    - no event writing
    - no known-facts mutation
    - no file writes
    - no `board_graph.json` / `view_state.json`
    - no Project ZIP contract changes
11. Future implementation must not introduce:
    - `photo_local` board rendering
    - visual trace/damage/suspect/measurement rendering
    - inspector
    - AI proposal UI / Top-3 UI
    - background photo helper
    - edit handles, drag/rotate/resize
    - confirm/save/export/apply actions
12. If future implementation requires shared helper expansion outside `lib/features/board_canvas/**`, it must stop and report for allowlist update.
13. Locked next-sequence remains:
    1. `BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS` (completed)
    2. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_SCOPE_LOCK_PASS` (this pass)
    3. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS`
    4. `BOARD_CANVAS_READONLY_INSPECTOR_PASS`
    5. `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS`
    6. `BOARD_CANVAS_READONLY_RENDERER_QA_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
