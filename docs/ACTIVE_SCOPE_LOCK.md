# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_READONLY_INSPECTOR_SCOPE_LOCK_PASS`

## Goal

Lock the implementation scope for the next board-canvas pass: read-only inspector/details panel.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- `docs/audit/BOARD_CANVAS_READONLY_INSPECTOR_SCOPE_LOCK_PASS.md`
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
- Flutter inspector implementation
- renderer implementation changes
- CustomPainter changes
- hit testing implementation
- drag/resize/rotate logic
- component editing UI
- event-writing UI
- AI proposal persistence
- background photo helper
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Locked decisions

1. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS` is accepted and read-only boundaries are preserved.
2. Next implementation pass is locked to `BOARD_CANVAS_READONLY_INSPECTOR_PASS`.
3. First inspector selection model is locked to non-canvas controls only:
   - no canvas hit-testing in first inspector pass unless a later scope pass explicitly allows it.
4. Future inspector implementation data path is locked to:
   - `ProjectState.knownFacts`
   - `KnownFacts.componentVisualPlacements`
   - `KnownFacts.components`
   - `VectorFootprintLibrary` metadata
5. Future inspector implementation may only add read-only details UI:
   - selected placement/component details only
   - local volatile selection state only
   - no persisted selection (`view_state.json` forbidden)
6. Future inspector implementation must preserve read-only boundaries:
   - no event writer imports/usages
   - no raw `known_facts.json` parsing
   - no reads from `events.jsonl` or Project ZIP directly
   - no canonical fact mutation
   - no file writes
   - no `board_graph.json` / `view_state.json`
   - no schema/tool/materializer/registry changes
7. Future inspector implementation must not introduce:
   - edit/confirm/change-template/promote/delete actions
   - AI identify/detect/suggest/proposal actions
   - measure/apply-to-schematic/fault-probability actions
   - save/export/upload/start-placement actions
   - drag/resize/rotate handles
8. Identity/evidence boundaries remain locked:
   - no identity inference from `template_id`
   - no `visual_trace` to electrical-net promotion
   - no AI proposal canonicalization
9. Required renderer chrome text remains visible:
   - `renderer writes: none`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
