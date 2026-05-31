# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_FINAL_SMOKE_CHECK_PASS`

## Goal

Docs-only final smoke check recording for V1 release candidate boundary confirmation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_FINAL_SMOKE_CHECK_PASS.md`

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
- Flutter/runtime implementation
- automated test implementation
- fixture/sample implementation
- generated data changes
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Docs-only recording of final manual smoke PASS observations.
- No schema/tool/materializer/Dart/Flutter implementation or automated test changes.
- No fixture/sample/data changes in this pass.
- No Project ZIP contract changes.
- No evidence-boundary weakening.
- Renderer/view remains no-write.
- No visual evidence geometry expansion.
- No transform/photo-layer behavior expansion.

## Next recommended pass

`V1_RELEASE_CANDIDATE_TAG_SCOPE_LOCK_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
