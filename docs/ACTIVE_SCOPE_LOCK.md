# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_ALIGNMENT_MATERIALIZER_CLOSEOUT_PASS`

## Goal

Docs-only closeout for `PHOTO_ALIGNMENT_MATERIALIZER_PASS` after audit verdict `PASS_WITH_NITS`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_CLOSEOUT_PASS.md`

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

## Closeout boundary (locked)

- no event/schema/validator changes
- no materializer changes
- no Dart/Flutter changes
- no Project ZIP changes
- no `board_graph.json`
- no `view_state.json`

## Next recommended pass

`PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
