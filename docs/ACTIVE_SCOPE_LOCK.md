# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS`

## Goal

Lock the next narrow Reference Images UX recovery slice:

- lock empty/missing/error-state UX recovery implementation next step (`REFERENCE_IMAGES_UX_STATES_IMPL_PASS`)
- keep implementation scope limited to calm state messaging and required safety copy
- preserve all existing Model-B and evidence boundaries
- defer larger UX slices:
  - metadata grouping,
  - accessibility/focus,
  - responsive/layout expansion,
  - background photo/Board Canvas/AI overlays.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `tools/**`
- `schemas/**`
- `lib/shared/models/**`
- `lib/shared/services/**`
- `schemas/known_facts.schema.json`
- `lib/features/reference_images/services/reference_image_sidecar_service.dart`
- `sample*/**`
- `assets/**`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- reference-image URL import
- Board Canvas overlay
- photo overlay transform/matrix workflows
- AI/OCR/CV/AI proposal rendering
- event-writing/proposal confirmation UIs
- metadata grouping implementation
- accessibility/focus broad refactor

## Scope boundary (lock)

- Current scope lock (docs-only) applies to:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS.md`
- The locked future implementation target for this slice (`REFERENCE_IMAGES_UX_STATES_IMPL_PASS`) may touch only:
  - `lib/features/reference_images/screens/reference_images_screen.dart`
  - `test/widget/reference_images_screen_test.dart`

## Next recommended pass

`REFERENCE_IMAGES_UX_STATES_IMPL_PASS`

## Closeout validations

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Validation commands for next pass

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
