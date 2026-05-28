# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_AUDIT_CLOSEOUT_PASS`

## Goal

Docs-only audit closeout for Pro + Claude photo-evidence alignment findings and board-canvas visual-evidence boundary decisioning.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if stale
- `docs/TRUTH_INDEX.md` only if stale
- `docs/audit/BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_AUDIT_CLOSEOUT_PASS.md`

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

1. Final decision locked by this closeout: `DEFER_PHOTO_ALIGNMENT_IMPLEMENTATION`.
2. `photo_local` evidence remains non-renderable on board canvas without separately accepted transform model/scope.
3. No visual evidence overlay implementation is opened by this closeout:
   - no visual_trace canvas geometry
   - no damage/suspect canvas geometry
   - no background photo helper layer
4. Placeholder alignment event names are not implementation authorization:
   - `photo_reference_points_set`
   - `photo_layer_aligned`
5. Read-only no-write boundaries remain locked:
   - no events writes
   - no known-facts mutation
   - no `board_graph.json` / `view_state.json`
   - no Project ZIP contract change
6. Next recommended pass:
   - `BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
