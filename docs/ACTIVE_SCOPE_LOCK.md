# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`

## Goal

Narrow Model-B implementation of local sidecar reference-image import and read-only viewer.

## Allowed surfaces

- `lib/features/reference_images/**`
- `lib/app/router.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/reference_images_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `lib/**` (except `lib/features/reference_images/**`, `lib/app/router.dart`, and `lib/features/project/screens/project_overview_screen.dart`)
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

- Narrow viewer implementation pass.
- No Project ZIP tooling or contract changes.
- No events/known_facts/schema/materializer changes.
- No AI/OCR/CV/detection/proposal behavior.
- No Board Canvas overlay or transform behavior.
- No fixture/sample/asset/generated-artifact changes.
- No evidence-boundary weakening.
- No tag or release-object mutation.

## Next recommended pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_POST_AUDIT_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `py -3 -m unittest tests.test_project_zip`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `git diff --name-only`
- `git status --short --branch`
