# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_READONLY_INSPECTOR_CLOSEOUT_PASS`

## Goal

Docs-only audit closeout after `BOARD_CANVAS_READONLY_INSPECTOR_AUDIT_PASS` verdict `PASS_WITH_NITS`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md` (only if stale)
- `docs/TRUTH_INDEX.md` (only if stale)
- `docs/audit/BOARD_CANVAS_READONLY_INSPECTOR_CLOSEOUT_PASS.md`

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
- CustomPainter changes
- Canvas rendering changes
- scene graph
- spatial index
- hit testing
- component editing UI
- event-writing UI
- AI proposal persistence
- background photo helper
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Locked decisions

1. `BOARD_CANVAS_READONLY_INSPECTOR_AUDIT_PASS` verdict is recorded as `PASS_WITH_NITS`.
2. `BOARD_CANVAS_READONLY_INSPECTOR_PASS` is accepted as scope-compliant:
   - read-only inspector,
   - non-canvas non-mutating selection,
   - local/volatile selection state only.
3. Read-only and evidence boundaries remain locked:
   - no event writing,
   - no known-facts mutation,
   - no raw `known_facts.json` parsing,
   - no `board_graph.json` / `view_state.json`,
   - no AI proposal canonicalization,
   - no `visual_trace` to electrical-net promotion,
   - no `template_id` to component-identity promotion.
4. Required identity warning remains part of accepted inspector state:
   - `Template does not prove electrical identity.`
5. Non-blocking validation nit is recorded:
   - intermittent Windows temp-file lock flake in full Flutter suite (`project_creator_test.dart`), isolated rerun PASS.
6. Next recommended pass is locked to:
   - `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS`
   - no direct visual-trace/evidence rendering implementation before this scope audit.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
