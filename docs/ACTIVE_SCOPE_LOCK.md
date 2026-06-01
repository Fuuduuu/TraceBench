# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS`

## Goal

Record the final Claude Design deepening package before `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS.md`

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

For this scope-lock pass:

- Docs-only addendum pass to lock final UX package before implementation.
- Final locked package before `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`:
  - six fixed zones:
    - header band,
    - image list/contact sheet,
    - preview,
    - details/metadata,
    - safety strip,
    - footer/provenance.
  - required strings are locked verbatim and must remain visible across states:
    - `reference only`
    - `not evidence`
    - `not included in Project ZIP`
    - `not used by AI`
    - `renderer writes: none`
  - required state coverage is locked:
    - empty,
    - selected image,
    - missing local file,
    - unsupported format,
    - import failure,
    - large file rejected,
    - max count reached.
  - required microcopy and labels are locked as listed in the addendum pass spec (including `No reference images yet`, `Import from this computer`, `Reference images`, `Reference image · not evidence`, etc.).
  - required accessibility constraints:
    - keyboard navigation,
    - visible focus ring,
    - screen-reader labels,
    - AA contrast,
    - no color-only meaning,
    - hit targets at least 44px,
    - safety strip and footer visible in every state.
  - forbidden wording remains in-scope blocked for both UI chrome and metadata content:
    - `confirmed`, `detected`, `measured`, `fault`, `suspect`, `probability`, `net`, `trace proof`, `AI found`, `verified`, `identified`, `proven`, `match found`, `candidate`.
  - preserve Model B boundaries: local sidecar, non-canonical, outside ZIP/events/known_facts/materializer, no Board Canvas evidence coupling.
- Board Canvas polishing remains a separate track: `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS`.
- Prescribe no code changes in this pass.

## Next recommended pass

`REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`

## Validate

- `git status --short --branch`
- `py -3 tools\validate_all.py`
- `git diff --name-only`
