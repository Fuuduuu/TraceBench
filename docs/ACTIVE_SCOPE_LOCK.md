# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS`

## Goal

Narrow Project ZIP tooling hardening to exclude `.tracebench_local` sidecar paths from export and reject them during ZIP validation.

## Allowed surfaces

- `tools/export_project_zip.py`
- `tests/test_project_zip.py`
- `docs/PROJECT_ZIP_SPEC.md`
- `tools/validate_project_zip.py` (narrow symmetry-only)
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**` (except `tools/export_project_zip.py` and `tools/validate_project_zip.py`)
- `lib/**`
- `test/**`
- `tests/**` (except `tests/test_project_zip.py`)
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
- fixture/sample implementation or edits
- generated data or artifact changes
- git tag creation/push/delete/move
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Narrow tooling hardening pass only.
- No Flutter/runtime/reference-viewer implementation.
- No schema/materializer/events/known_facts changes.
- No fixture/sample/asset/generated-artifact changes.
- No Project ZIP contract expansion.
- No evidence-boundary weakening.
- No tag or release-object mutation.

## Next recommended pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_POST_AUDIT_PASS`

## Validate

- `py -3 -m unittest tests.test_project_zip`
- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
