# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_HARDENING_VALIDATION_SMOKE_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for first V1.1 validation/smoke hardening route after accepted V1 RC + roadmap + source-guide sync.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_HARDENING_VALIDATION_SMOKE_SCOPE_LOCK_PASS.md`

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

- Docs-only hardening validation/smoke scope-lock pass.
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

`V1_1_HARDENING_VALIDATION_SMOKE_AUDIT_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
