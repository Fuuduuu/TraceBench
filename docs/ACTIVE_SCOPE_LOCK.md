# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS`

## Goal

Docs-only PHOTO_FLOW_SPEC nit-polish followup with no implementation-surface changes.

## Allowed surfaces

- `docs/PHOTO_FLOW_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS.md`

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

## Followup boundary (locked)

- no event/schema/validator changes
- no materializer changes
- no Dart/Flutter changes
- no Project ZIP changes
- no photo-local evidence rendering
- no transform matrix computation
- no AI proposal canonicalization
- no raw known_facts JSON parsing in renderer
- no `board_graph.json`
- no `view_state.json`

## Next recommended pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
