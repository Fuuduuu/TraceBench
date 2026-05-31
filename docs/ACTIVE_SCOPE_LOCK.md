# ACTIVE_SCOPE_LOCK.md

## Current pass

`VALIDATE_ALL_FIXTURE_COVERAGE_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for a small V1.1 tools-hardening pass that brings `board_canvas_positive_smoke` into the main validation gate.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/VALIDATE_ALL_FIXTURE_COVERAGE_SCOPE_LOCK_PASS.md`

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
- tools implementation changes
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

- Docs-only scope lock pass.
- No schema/tool/materializer/Dart/Flutter implementation or automated test changes.
- No fixture/sample/data changes in this pass.
- No Project ZIP contract changes.
- No evidence-boundary weakening.
- No tag mutation in this pass.
- Renderer/view remains no-write.
- No visual evidence geometry expansion.
- No transform/photo-layer behavior expansion.
- No generated artifacts.

## Next recommended pass

`VALIDATE_ALL_FIXTURE_COVERAGE_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
