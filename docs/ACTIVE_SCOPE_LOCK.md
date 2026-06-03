# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_ACCESSIBILITY_IMPL_PASS`

## Goal

Implement narrow Reference Images accessibility/focus recovery slice while preserving all scope boundaries.

Implementation files:

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Scope lock summary

- this pass is implementation and includes only accessibility/focus polish for existing UI strings and labels
- no full screen rewrite
- no broad layout architecture rewrite
- no metadata-grouping behavior changes in this slice
- no empty/missing/error-state rewrite
- no selected-image preview rewrite
- no service/storage/model/schema/Project ZIP/tool/materializer/runtime changes
- no Board Canvas/AI/OCR/CV/URL-import/transform or event-writing scopes
- no `board_graph.json` or `view_state.json`
- required strings and behavior remain unchanged

## Required guardrails for implementation

- preserve existing Model-B boundary:
  - local sidecar only
  - not in `events.jsonl`
  - not in `known_facts.json`
  - not in materializer
- required safety strings stay required and visible:
  - `reference only`
  - `not evidence`
  - `not included in Project ZIP`
  - `not used by AI`
  - `renderer writes: none`
- no real `Image.file` decode in tests
- no filesystem-heavy widget tests in this pass
- bounded pump/test helpers only (no indefinite settling)
- no temporary image file writes in this pass
 - selected-image metadata ordering remains by source `KnownReferenceImage` order
- selected-image grouping accessibility checks avoid real image decoding:
  - use fake service/placeholder path flow
  - test seam only if needed, with production default unchanged
  - no temp-file image writes

## Required tests for next implementation pass

- accessibility tests now include:
  - import button/tooltip/affordance labels
  - reference image list item readable labels and hints
  - metadata-group heading labels and semantic headers
  - required safety copy remains present
  - forbidden affordances remain absent

## Allowed implementation surfaces

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Allowed docs surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_ACCESSIBILITY_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `lib/shared/models/**`
- `lib/shared/services/**` (no changes in this pass)
- `lib/features/board_canvas/**`
- `tools/**`
- `schemas/**`
- `samples/**`
- `assets/**`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- tags/release objects
- `lib/features/reference_images/services/reference_image_sidecar_service.dart`
- any reference-image transform/overlay/URL import path

## Next recommended pass

`REFERENCE_IMAGES_UX_ACCESSIBILITY_IMPL_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
