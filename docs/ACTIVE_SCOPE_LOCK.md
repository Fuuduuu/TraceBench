# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_AUDIT_CLOSEOUT_PASS`

## Goal

Docs-only closeout for visual/evidence scope audits with final decision routing.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md` (only if stale)
- `docs/TRUTH_INDEX.md` (only if stale)
- `docs/audit/BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_AUDIT_CLOSEOUT_PASS.md`

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
- visual_trace rendering
- measurement rendering
- damage/suspect rendering
- background photo helper
- coordinate transform implementation
- AI proposal persistence

## Locked decisions

1. Codex and Claude independent audits for `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS` are both recorded.
2. Final closeout verdict is locked: `DEFER_VISUAL_EVIDENCE`.
3. No board-canvas evidence overlay implementation is currently safe.
4. Measurements are locked as future read-only metadata-only candidate (inspector/list), not canvas geometry.
5. Photo-local evidence rendering remains deferred until dedicated coordinate/alignment audit.
6. Evidence boundaries remain strict:
   - visual_trace remains visual-only
   - no visual_trace -> net promotion
   - no photo_local -> board rendering without accepted transform
   - no damage/suspect -> fault proof
   - no measurement coordinate inference
   - no renderer writes
   - no `board_graph.json` / `view_state.json`
7. Next recommended pass is locked:
   - `BOARD_CANVAS_READONLY_RENDERER_QA_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
