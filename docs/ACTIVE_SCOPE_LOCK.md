# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_12_PASS`

## Goal

Run required docs-drift cleanup after vector footprint registry audit closeout, align queue/state/lock/spec routing, and prepare next safe scope-lock pass.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md` (only if stale)
- `docs/TRUTH_INDEX.md` (only if stale)
- `docs/BOARD_GRAPH_SPEC.md` (only if stale)
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` (only if stale)
- `docs/VECTOR_FOOTPRINT_LIBRARY_SPEC.md` (only if stale)
- `docs/audit/DOCS_DRIFT_MINI_CLEANUP_12_PASS.md`

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
- `CustomPainter` implementation
- canvas rendering implementation
- scene graph implementation
- spatial index implementation
- hit testing implementation
- component editing UI
- event-writing UI
- AI proposal persistence
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Locked decisions

1. Registry skeleton remains accepted as metadata/model/const registry only.
2. Footprint templates remain non-canonical metadata and `template_id` is not identity/electrical proof.
3. Renderer/UI and AI proposal persistence remain deferred.
4. `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
5. Next recommended pass is `BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
