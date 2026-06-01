# REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS

PASS_ID: `REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC`
Mode: `Docs-only scope lock`

## Scope lock decision

This pass records the accepted Claude Design direction for Reference Images UX polish as a V1.1 UX-only next-pass boundary.

- Design verdict: `GO` for safe UX polish direction.
- Goal is to make the reference screen read as a personal reference shelf, not evidence.
- Current accepted implementation baseline remains unchanged:
  - local sidecar storage in `.tracebench_local/reference_images/`
  - ledger in `.tracebench_local/reference_images.json`
  - read-only viewer behavior
  - ZIP exclusion in place
  - path clamp hardening in place
  - no changes to runtime, evidence, or materialization surfaces.

## Locked scope for implementation pass

Allowed implementation pass: `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`

Allowed implementation surfaces:

- `lib/features/reference_images/screens/reference_images_screen.dart`
- focused widget tests (likely `test/widget/reference_images_screen_test.dart`)

Locked polish scope:

- Layout, hierarchy, spacing, typography.
- Safety strip/header and explicit required copy.
- Three-zone layout direction:
  - list/contact sheet
  - preview
  - details + safety
- Improved empty/missing/error/failure states.
- Grouped metadata:
  - identity/user-supplied display info
  - file details
  - provenance
- SHA-256 framing only as file integrity/duplication context.
- Accessibility improvements.
- Clear text for import/remove actions if exposed.

Locked forbidden surfaces:

- No Board Canvas overlay, reference-image layer, alignment, transform, matrix, AI/OCR/CV, evidence labels, or event/known_facts writes.
- No Project ZIP inclusion, no URL import/download.
- No wording implying confirmation/detection/measurement/fault/probability/trace proof/evidence certainty.
- No board_graph/view_state artifacts.
- No runtime/model/materializer/tool/schema/sample/runtime changes in this pass.

## Required acceptance criteria

1. Safety copy remains visible across empty/selected/missing-file states:
   - `reference only`
   - `not evidence`
   - `not included in Project ZIP`
   - `not used by AI`
   - `renderer writes: none`
2. Forbidden wording is absent from UI chrome, controls, metadata titles, and error/empty states.
3. `SHA-256` is communicated only as integrity/duplication context.
4. File names and notes remain clearly user-supplied metadata.
5. No Board Canvas geometry/overlay coupling; viewer remains visually distinct.
6. Path-clamp and sidecar boundary remain unchanged.
7. Tests cover required strings, forbidden wording, and key states (empty/selected/missing-file).

## Notes

- `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS` remains deferred and separate.
- This pass is docs-only and does not modify non-governance files.
