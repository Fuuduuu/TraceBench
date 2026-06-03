# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_METADATA_GROUPING_IMPL_PASS`

## Goal

Implement the next narrow Reference Images metadata-grouping slice in:
- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Scope lock summary

- implementation is selected-image metadata-grouping only
- no full screen rewrite
- no broad layout architecture rewrite
- no accessibility/focus redesign in this slice
- no service/storage/model/schema/Project ZIP/tool/materializer/runtime changes
- no Board Canvas/AI/OCR/CV/URL-import/transform or event-writing scopes
- no `board_graph.json` or `view_state.json`
- no filesystem-heavy selected-image runtime rendering in tests
- optional test seam for image previews only (no production behavior change)

## Required guardrails for implementation

- preserve existing Model-B boundary:
  - local sidecar only
  - not in `events.jsonl`
  - not in `known_facts.json`
  - not in materializer
- selected-image safety strings stay required and visible
- grouped metadata order must stay stable by source `KnownReferenceImage` order
- selected-image grouping tests must avoid real image decoding:
  - use fake service/placeholder path flow
  - test seam only if needed, with production default unchanged
  - no temp-file image writes

## Allowed implementation surfaces

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Allowed docs surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_METADATA_GROUPING_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_METADATA_GROUPING_IMPL_PASS.md`

## Forbidden surfaces

- `lib/shared/models/**`
- `lib/shared/services/**` (except no changes in this pass)
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

`REFERENCE_IMAGES_UX_METADATA_GROUPING_POST_AUDIT_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
