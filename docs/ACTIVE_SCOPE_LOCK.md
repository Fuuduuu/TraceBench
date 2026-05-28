# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_MEASUREMENT_SUMMARY_CLOSEOUT_PASS`

## Goal

Docs-only audit closeout for board-canvas read-only measurement summary after dual audits (`PASS_WITH_NITS`).

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if stale
- `docs/TRUTH_INDEX.md` only if stale
- `docs/audit/BOARD_CANVAS_MEASUREMENT_SUMMARY_CLOSEOUT_PASS.md`

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

1. `BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS` is accepted as read-only metadata scope only.
2. Strict association rule remains required:
   - `measurement.from == componentId`
   - `measurement.to == componentId`
   - `measurement.from` starts with `componentId + "."`
   - `measurement.to` starts with `componentId + "."`
3. Loose prefix matching remains forbidden (`Q2` must not match `Q20`, `Q20.1`, `AQ2`, `Q2A`).
4. Measurement summaries remain non-geometric:
   - no canvas overlays
   - no coordinate/anchor inference
   - no measurement->net inference
5. Read-only no-write boundaries remain locked:
   - no events writes
   - no known-facts mutation
   - no `board_graph.json` / `view_state.json`
   - no Project ZIP contract change
6. Next recommended pass:
   - `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
