# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS`

## Goal

Record the final Claude Design scope-lock card as accepted implementation input for `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS.md`

## Forbidden surfaces

- `tools/**`
- `test/**`
- `lib/**`
- `assets/**`
- `board_graph.json`
- `view_state.json`
- `events.jsonl`
- `known_facts.json`
- `materializer/**`
- `schemas/**`
- `Project ZIP tooling/contracts`
- runtime/schema/materializer/sample/asset/tooling/model changes
- path, storage, or metadata-model expansion
- Board Canvas overlay/alignment/transform/photo-layer paths
- AI/OCR/CV/proposal UI
- event-writing/edit/confirm/save/apply controls
- reference-image URL import/download

## Scope boundary (locked)

For this scope-lock card-sync pass:

- Docs-only sync of final accepted design card before implementation.
- Accepted final card for `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS` before implementation:
  - six fixed zones:
    - header band,
    - image list / contact sheet,
    - preview,
    - details/metadata,
    - safety strip,
    - footer/provenance.
  - required strings (must render verbatim in empty/selected states):
    - `reference only`
    - `not evidence`
    - `not included in Project ZIP`
    - `not used by AI`
    - `renderer writes: none`
  - required state coverage:
    - empty,
    - selected,
    - missing local file,
    - unsupported,
    - import failure,
    - large file,
    - max count,
    - narrow window.
  - required metadata grouping:
    - Identity:
      - `reference_image_id` as `Reference ID`
      - `original_filename_display` as `As imported`
      - `notes` as `Your notes`
    - File details:
      - `mime_type` as `Type`
      - `file_size_bytes` as `Size`
      - `sha256` as `SHA-256`
      - `stored_relative_path` as `Stored path`
    - Provenance:
      - `imported_at` as `Imported`
      - `source` as `added via local file picker`
      - project binding as `Project`
  - required microcopy includes:
    - `Reference images`
    - `No reference images yet`
    - `Import from this computer`
    - `Reference image · not evidence`
    - `File integrity / duplicate check — not an evidence seal`
    - `Personal annotation only — not a recorded finding`
    - `non-canonical · local sidecar · not evidence — personal reference only.`
  - required accessibility constraints:
    - keyboard navigation,
    - visible focus ring,
    - screen-reader labels,
    - AA contrast,
    - no color-only meaning,
    - hit targets at least 44px,
    - safety strip and footer visible in every state.
  - required forbidden wording:
    - `confirmed`, `detected`, `measured`, `fault`, `suspect`, `probability`, `net`, `trace proof`, `AI found`, `verified`, `identified`, `proven`, `match found`, `candidate`.
  - preserve Model B boundaries:
    - local sidecar only,
    - non-canonical,
    - outside ZIP/events/known_facts/materializer,
    - outside Board Canvas evidence rendering,
    - outside AI/OCR/CV.
  - preserve strict track separation:
    - Reference Images polish does not overlap Board Canvas polish scope.
    - Board Canvas polish remains separate track: `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS`.
  - no code changes in this pass.
- `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS` must take this card as implementation input.

## Next recommended pass

`REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`

## Validate

- `git status --short --branch`
- `py -3 tools\validate_all.py`
- `git diff --name-only`
