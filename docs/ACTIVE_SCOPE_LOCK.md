# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_CLOSEOUT_PASS`

## Goal

Docs-only audit closeout for `PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_PASS` after Claude Code review.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_CLOSEOUT_PASS.md`

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
- no AI proposal canonicalization
- no raw known_facts JSON parsing in renderer
- no `board_graph.json`
- no `view_state.json`

## Next recommended pass

`PHOTO_FLOW_SPEC_AUDIT_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
