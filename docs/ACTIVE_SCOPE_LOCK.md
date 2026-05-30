# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS`

## Goal

Docs-only audit closeout for `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_PASS` after GPT Pro + Claude Code review.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `lib/**`
- `test/**`
- `tests/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter UI/runtime changes
- Dart KnownFacts model changes
- materializer implementation changes
- validator implementation changes
- schema implementation changes
- photo alignment UI
- background photo helper
- transform computation

## Closeout boundary (locked)

- no event/schema/validator changes
- no materializer changes
- no Dart/Flutter changes
- no Project ZIP changes
- no photo-local evidence rendering
- no transform matrix computation
- no transform computation in renderer as canonical truth
- no volatile preview state promoted to saved/exported/materialized/reported truth
- no background photo helper hidden truth
- no visual_trace/damage/suspect canvas geometry rendering
- no event-writing UI
- no reference-point editing/confirm/save/apply controls
- no AI proposal canonicalization
- no raw known_facts JSON parsing in renderer
- no `board_graph.json`
- no `view_state.json`

## Next recommended pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
