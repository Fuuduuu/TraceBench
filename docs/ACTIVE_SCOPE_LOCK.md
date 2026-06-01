# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS`

## Goal

Lock the next recovery copy/safety UX slice for `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS` and keep this pass docs-only.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS.md`
- (Next pass target) `lib/features/reference_images/screens/reference_images_screen.dart`
- (Next pass target) `test/widget/reference_images_screen_test.dart`

## Forbidden surfaces

- `tools/**` in this scope
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
- `lib/features/reference_images/services` / path-clamp changes (already completed in prior implementation passes)
- metadata grouping expansion, empty/missing/unsupported test rewrite, accessibility overhaul, responsive layout rewrite.

## Scope boundary (locked)

For this docs-only scope-lock pass:

- `REFERENCE_IMAGES_UX_POLISH_RECOVERY_AUDIT_PASS` is recorded as the recovered input (`PASS`, no production change).
- No code changes in this pass.

For the next implementation pass (`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`), lock:

- copy/safety polish only (empty-state safety copy and import label text),
- no full screen rewrite,
- no metadata grouping expansion,
- no accessibility/layout overhauls,
- no filesystem-heavy test fixtures,
- no `Image.file` decode in selected-image/widget tests,
- deferred slices: metadata grouping, missing/error/unsupported states, narrow-window polish, accessibility refinements.

Required implementation assertions to keep:

- empty-state required safety strings are visible:
  - `reference only`
  - `not evidence`
  - `not included in Project ZIP`
  - `not used by AI`
  - `renderer writes: none`
- import button text is exactly `Import from this computer`.
- safe forbidden-word guard remains intact.
- service behavior remains unchanged.
- keep model-B boundaries:
  - local sidecar only,
  - outside `events.jsonl` / `known_facts.json` / materializer / ZIP / Board Canvas evidence / AI/CV.

## Next recommended pass

`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`

## Validate

- `git status --short --branch`
- `py -3 tools\validate_all.py`
- `git diff --name-only`
