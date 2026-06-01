# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`

## Goal

Implement the constrained copy/safety UX slice for `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS` only.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS.md`
- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Forbidden surfaces

- `tools/**`
- `assets/**`
- `board_graph.json`
- `view_state.json`
- `events.jsonl`
- `known_facts.json`
- `materializer/**`
- `schemas/**`
- `Project ZIP tooling/contracts`
- runtime/schema/materializer/sample/model changes
- path/storage/model expansion
- Board Canvas overlay/alignment/transform/photo-layer work
- AI/OCR/CV/proposal UI
- event-writing/edit/confirm/save/apply controls
- reference-image URL import/download
- `lib/features/reference_images/services` / path-clamp changes
- metadata grouping expansion
- missing/error/unsupported state rewrite
- accessibility overhaul
- responsive layout rewrite.

## Scope boundary (locked)

For `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`, lock:

- copy/safety polish only (empty-state safety copy and import label text),
- no full screen rewrite,
- no metadata grouping expansion,
- no accessibility/layout overhauls,
- no filesystem-heavy test fixtures in updated tests,
- no `Image.file` decode in updated selected-image/widget tests,
- service behavior remains unchanged.

Required implementation assertions to keep:

- empty-state required safety strings are visible:
  - `reference only`
  - `not evidence`
  - `not included in Project ZIP`
  - `not used by AI`
  - `renderer writes: none`
- import button text is exactly `Import from this computer`.
- import safety copy remains present:
  - `Reference images (local sidecar)`
  - `personal reference only`
  - `local sidecar, non-canonical`
  - `outside project-wide canonical evidence`
- safe forbidden-word guard remains intact.
- service behavior remains unchanged.
- keep model-B boundaries:
  - local sidecar only,
  - outside `events.jsonl` / `known_facts.json` / materializer / ZIP / Board Canvas evidence / AI/CV.

## Next recommended pass

`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_POST_AUDIT_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/widget/reference_images_screen_test.dart --reporter expanded`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `git status --short --branch`