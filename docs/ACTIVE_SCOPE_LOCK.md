# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_13_PASS`

## Goal

Run docs-only governance cleanup after accepted board-canvas placement rendering and full codebase audit (`PASS_WITH_NITS`), then route safely to inspector scope-lock.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if stale
- `docs/TRUTH_INDEX.md` only if stale
- `docs/audit/DOCS_DRIFT_MINI_CLEANUP_13_PASS.md`

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
- Canvas rendering changes
- scene graph
- spatial index
- hit testing
- component editing UI
- event-writing UI
- AI proposal persistence
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Locked decisions

1. Full codebase audit verdict is recorded as `PASS_WITH_NITS`.
2. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS` is accepted and remains read-only.
3. Governance routing is locked to scope-first inspector progression:
   - next recommended pass: `BOARD_CANVAS_READONLY_INSPECTOR_SCOPE_LOCK_PASS`
   - do not route directly to `BOARD_CANVAS_READONLY_INSPECTOR_PASS` implementation.
4. Renderer evidence boundaries remain unchanged:
   - no `visual_trace` to electrical-net promotion
   - no `template_id` to identity promotion
   - no AI proposal canonicalization
   - no renderer write path
   - no `board_graph.json` / `view_state.json`
   - no Project ZIP contract changes
5. Non-blocking cleanup candidates are recorded for later narrow passes only (no implementation work in this pass).

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
