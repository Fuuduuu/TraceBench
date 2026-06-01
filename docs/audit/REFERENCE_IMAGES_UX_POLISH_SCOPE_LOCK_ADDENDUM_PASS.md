# REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS

PASS_ID: `REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS`
Lane: `DOCS_SYNC`
Mode: `Docs-only scope-lock addendum`

## Status

- ACCEPTED as final design package input for `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`.
- Keeps implementation narrowed to UX polish only for the local sidecar reference image viewer.

## Design update recorded

Final deepening accepted from Claude Design (`REFERENCE_IMAGES_UX_DESIGN_DEEPENING_PASS`, GO):

- Six fixed zones:
  - header band
  - image list / contact sheet
  - preview
  - details / metadata
  - safety strip
  - footer / provenance
- Always-visible frame elements:
  - header band
  - safety strip
  - footer
  - non-evidence tag on every image
- Required strings (must be rendered verbatim):
  - `reference only`
  - `not evidence`
  - `not included in Project ZIP`
  - `not used by AI`
  - `renderer writes: none`
- Required state coverage:
  - empty
  - selected image
  - missing local file
  - unsupported format
  - import failure
  - large file rejected
  - max count reached
- Required microcopy:
  - Header: `Reference images`
  - Boundary line: `Non-canonical · local sidecar · not evidence — personal reference only.`
  - Empty headline: `No reference images yet`
  - Import button: `Import from this computer`
  - Preview label: `As imported: <original filename>`
  - Preview sub-label: `Reference image · not evidence`
  - Safety heading: `What this is`
  - SHA-256 caption: `File integrity / duplicate check — not an evidence seal.`
  - Notes helper: `Personal annotation only — not a recorded finding.`
  - Missing file: `File not found at its stored path.`
  - Missing file helper: `Reference images live only on this computer; this one may have been moved or deleted.`
  - Unsupported format: `Unsupported format. Supported: PNG, JPEG, WebP.`
  - Large file: `File exceeds the local reference size limit (N MB).`
  - Max count: `Reference limit reached (N). Remove one to add another.`
- Required metadata grouping in UI:
  - Identity / user-supplied display
  - File details
  - Provenance
  - Optional notes
- Accessibility requirements:
  - keyboard navigation
  - visible focus ring
  - screen-reader labels
  - AA contrast
  - no color-only meaning
  - hit targets >= 44px
  - safety strip and footer visible in every state
- Tests are deferred to implementation pass, but required assertions include:
  - required strings in empty and selected states,
  - forbidden wording scan,
  - safety strip visible in every state,
  - required state coverage,
  - metadata grouping visible,
  - no Board Canvas / AI / URL / evidence affordances,
  - path-clamp preservation.

## Locked boundaries retained

- Reference Images remains Model B:
  - local sidecar only
  - non-canonical
  - outside Project ZIP
  - outside `events.jsonl`
  - outside `known_facts.json`
  - outside materializer
  - outside Board Canvas evidence rendering
  - outside AI/OCR/CV workflows
  - no URL import
- Board Canvas polish remains separate and deferred:
  - `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS`
- Path clamp hardening remains unchanged:
  - `resolveStoredImageFile` and sidecar traversal safety remain preserved by existing pass.

## Forbidden implementation surfaces (hard)

- Board Canvas overlay and board-canvas image/reference layer work.
- Reference-image layer on Board Canvas.
- Photo alignment transforms/matrices.
- AI/OCR/CV and detection/proposal UI.
- Top-3 candidate UI.
- Event/known-facts write paths.
- Project ZIP inclusion.
- Runtime schema/tool/materializer/sample changes.
- Any wording implying confirmation/detection/measurement/fault/probability/provenance-as-proof semantics.

## Next pass

- `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`
