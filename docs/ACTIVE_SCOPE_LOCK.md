# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_CLOSEOUT_PASS`

## Goal

Record the completed manual Windows smoke run for `REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_PASS` and preserve V1.1 Model-B sidecar boundaries.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN.md`
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS.md`
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_CLOSEOUT_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `lib/**`
- `test/**`
- `tests/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- schema/materializer semantics changes
- fixture/sample implementation or edits
- generated data or artifact changes
- git tag creation/push/delete/move
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- QA-closeout pass; docs-only, no implementation changes.
- Record completed smoke run evidence:
  - Project Overview reachability for the Reference Images viewer.
  - Local picker import support for `png`, `jpg`, `jpeg`, `webp`; unsupported formats blocked.
  - Sidecar writes to `.tracebench_local/reference_images/`.
  - Ledger metadata written to `.tracebench_local/reference_images.json`.
  - Safety copy and evidence boundaries visible in viewer:
    - `reference only`,
    - `not evidence`,
    - `not included in Project ZIP`,
    - `not used by AI`,
    - `renderer writes: none`.
  - Exported ZIP excludes `.tracebench_local` contents.
  - Exported ZIP contains no `board_graph.json` and no `view_state.json`.
  - Reference-image flow does not write `events.jsonl` or `known_facts.json`.
  - No URL import, no Board Canvas overlay, no AI/OCR/CV/proposal behavior.
- Preserve Model-B boundary: local sidecar only, non-canonical, outside ZIP/events/known_facts/Board Canvas evidence rendering/AI-OCR-CV, and no URL import.
- No fixture/sample/asset/generated-artifact changes.
- No evidence-boundary weakening.
- No tag or release-object mutation.
- Non-blocking observation (recorded, not blocking): exported ZIP contained duplicate `device_profiles/default.json`.

## Next recommended pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
