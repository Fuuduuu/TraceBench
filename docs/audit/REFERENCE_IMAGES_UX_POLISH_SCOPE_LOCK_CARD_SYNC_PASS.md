# REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS

PASS_ID: `REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS`
Lane: `DOCS_SYNC`
Mode: `Docs-only sync/addendum`

## Status

- ACCEPTED by docs sync as final Claude Design scope-lock card input for implementation.
- `REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS` and `REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS` remain retained.
- Keeps Reference Images UX polish and Board Canvas polish as separate tracks.
- `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS` must consume this card as implementation input.

## Accepted card summary

Final required design card for Reference Images UX polish:

- **Scopes separated**:
  - Reference Images = local sidecar reference shelf, personal and non-canonical.
  - Board Canvas = read-only projection/instrument surface, kept separate in `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS`.
- **Model B boundaries unchanged**:
  - local sidecar only,
  - non-canonical,
  - outside Project ZIP,
  - outside `events.jsonl`,
  - outside `known_facts.json`,
  - outside materializer,
  - outside Board Canvas evidence rendering,
  - outside AI/OCR/CV,
  - no URL import.
- **Six fixed UI zones**:
  - header band,
  - image list / contact sheet,
  - preview,
  - details / metadata,
  - safety strip,
  - footer / provenance.
- **Required copy (must render where relevant/visible)**:
  - `reference only`
  - `not evidence`
  - `not included in Project ZIP`
  - `not used by AI`
  - `renderer writes: none`
- **Required state coverage**:
  - empty,
  - selected,
  - missing local file,
  - unsupported,
  - import failure,
  - large file,
  - max count,
  - narrow window.
- **Required metadata grouping**:
  - Identity (`Reference ID`, `As imported`, `Your notes`)
  - File details (`Type`, `Size`, `SHA-256`, `Stored path`)
  - Provenance (`Imported`, `added via local file picker`, `Project`)
- **SHA-256 framing**:
  - `file integrity / duplicate check — not an evidence seal`
  - must be treated as non-proof integrity context in all states.
- **Accessibility requirements**:
  - keyboard navigation,
  - visible focus ring,
  - screen-reader labels,
  - AA contrast,
  - no color-only meaning,
  - hit targets >= 44px.

## Acceptance and tests to require in implementation pass

- required-string assertions,
- forbidden-word scan,
- eight-state coverage,
- no forbidden affordance checks,
- metadata-grouping assertions,
- separation check against Board Canvas/AI imports,
- boundary checks (`events.jsonl`/`known_facts` write-path absence, no ZIP inclusion, path-clamp preservation).

## Boundary confirmation

- No Board Canvas overlay/align/transform/matrix work.
- No AI/OCR/CV/proposal workflow.
- No URL import.
- No `board_graph.json` / `view_state.json`.
- Renderer/write policy remains: no event/known-facts writes from Reference Images UX.

## Next pass

- `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`
