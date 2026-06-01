# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_CLOSEOUT_PASS`

## Goal

Record docs-only closeout evidence for accepted copy/safety UX work in
`REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS` and route to the next pass.

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
- `docs/audit/REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_CLOSEOUT_PASS.md`

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

## Scope boundary (closeout)

Closeout scope is docs-only:

- copy/safety polish only (empty-state safety copy and import label text),
- no implementation changes.
- required routing/docs updates only.
- no service/model/storage/schema/tooling/runtime changes.
- required boundary recap:
  - local sidecar only,
  - outside `events.jsonl` / `known_facts.json` / materializer / ZIP / Board Canvas evidence / AI/CV.

## Next recommended pass

`PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS`

## Closeout validations

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
