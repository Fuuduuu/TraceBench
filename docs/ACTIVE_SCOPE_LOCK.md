# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS`

## Goal

Create and record the manual Windows smoke test plan for the accepted V1.1 local sidecar reference image viewer.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN.md`
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS.md`

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

- QA-plan-only pass; no implementation changes.
- Create manual Windows smoke plan for:
  - Reference Images panel reachability from Project Overview,
  - local picker import for `png/jpg/jpeg/webp`,
  - `.tracebench_local/reference_images/` write verification,
  - `.tracebench_local/reference_images.json` safety metadata verification,
  - preview safety copy verification,
  - ZIP export sidecar-exclusion verification,
  - optional ledger path-clamp defensive check.
- Record that `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS` + path-clamp closure + post-audit are accepted and preserved as accepted implementation context.
- Preserve Model-B boundary: local sidecar only, non-canonical, outside ZIP/events/known_facts/Board Canvas evidence rendering/AI-OCR-CV, and no URL import.
- No fixture/sample/asset/generated-artifact changes.
- No evidence-boundary weakening.
- No tag or release-object mutation.

## Next recommended pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
