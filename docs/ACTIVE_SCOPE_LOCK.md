# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_CLOSEOUT_PASS`

## Goal

Docs-only closeout for dual visual-trace inspector audits after accepted implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if stale
- `docs/TRUTH_INDEX.md` only if stale
- `docs/audit/BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_CLOSEOUT_PASS.md`

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
- visual_trace canvas rendering
- `from_point` / `to_point` model changes
- photo-to-board transform
- background photo helper
- damage/suspect rendering
- measurement canvas overlay
- AI proposal persistence
- edit/confirm/save/export/event-writing UI
- raw known_facts JSON parsing

## Locked decisions

1. `BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS` is accepted as read-only metadata-only implementation.
2. Dual audits are accepted with `PASS_WITH_NITS` / `PASS_WITH_NITS`.
3. Preserved boundaries:
   - no visual-trace geometry rendering,
   - no visual-trace -> electrical/net promotion,
   - no event writing,
   - no known-facts mutation,
   - no `board_graph.json` / `view_state.json`,
   - no Project ZIP contract change.
4. Next recommended pass:
   - `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
