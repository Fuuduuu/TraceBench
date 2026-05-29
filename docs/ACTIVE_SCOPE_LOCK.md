# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS`

## Goal

Lock the future Dart KnownFacts model direction for `known_facts.photo_to_board_alignments` before implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PHOTO_FLOW_SPEC.md` (only if needed for model-direction wording alignment)
- `docs/audit/PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS.md`

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

## Scope-lock boundary (locked)

- no event/schema/validator changes
- no materializer changes
- no Dart/Flutter changes in this pass
- no Project ZIP changes
- no raw known_facts JSON parsing in renderer
- no `board_graph.json`
- no `view_state.json`

## Next recommended pass

`PHOTO_ALIGNMENT_DART_MODEL_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
