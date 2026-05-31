# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for V1.1 local sidecar reference image viewer direction (Model B), without implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md` (only if architecture/routing wording needs alignment)
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_SCOPE_LOCK_PASS.md`

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
- schema/materializer semantics changes
- automated test implementation changes
- fixture/sample implementation or edits
- generated data or artifact changes
- git tag creation
- git tag push
- git tag delete/move
- Project ZIP tooling/files
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Docs-only scope lock pass.
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

`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
