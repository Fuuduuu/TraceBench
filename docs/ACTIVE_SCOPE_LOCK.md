# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for future read-only board-canvas measurement summaries.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- `docs/audit/BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS.md`
- optional only if stale:
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
- measurement UI implementation
- measurement canvas overlay
- visual_trace rendering
- damage/suspect rendering
- background photo helper
- coordinate transform implementation
- AI proposal persistence
- edit/confirm/save/export/event-writing UI
- raw known_facts JSON parsing

## Locked decisions

1. Visual/evidence closeout decision remains `DEFER_VISUAL_EVIDENCE`.
2. Board-canvas measurements are locked as future read-only inspector/list metadata only.
3. Measurement canvas overlays remain forbidden.
4. Strict future association rule is locked:
   - include only when:
     - `measurement.from == componentId`, or
     - `measurement.to == componentId`, or
     - `measurement.from` starts with `componentId + "."`, or
     - `measurement.to` starts with `componentId + "."`.
5. Loose prefix matching is forbidden (`Q2` must not match `Q20`).
6. Net/proximity/coordinate inference from measurement summaries is forbidden.
7. Future implementation must remain read-only:
   - no event writing
   - no known-facts mutation
   - no file writes
   - no `board_graph.json` / `view_state.json`
8. Next recommended pass is locked:
   - `BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
