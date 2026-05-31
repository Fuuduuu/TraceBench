# ACTIVE_SCOPE_LOCK.md

## Current pass

`VALIDATE_ALL_FIXTURE_COVERAGE_CLOSEOUT_PASS`

## Goal

Docs-only closeout recording for accepted fixture coverage implementation and post-audit verdict.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md` (only if stale wording requires correction)
- `docs/audit/VALIDATE_ALL_FIXTURE_COVERAGE_CLOSEOUT_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `lib/**`
- `test/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter/runtime implementation
- schema/materializer semantics changes
- automated test implementation changes
- fixture/sample implementation or edits
- generated data or artifact changes
- git tag creation
- git tag push
- git tag delete/move
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Docs-only closeout pass.
- No schema/tool/materializer/Dart/Flutter implementation changes.
- No fixture/sample/data changes in this pass.
- No Project ZIP contract changes.
- No evidence-boundary weakening.
- No tag mutation in this pass.
- Renderer/view remains no-write.
- No visual evidence geometry expansion.
- No transform/photo-layer behavior expansion.
- No generated artifacts.

## Next recommended pass

`REFERENCE_IMAGE_IMPORT_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
