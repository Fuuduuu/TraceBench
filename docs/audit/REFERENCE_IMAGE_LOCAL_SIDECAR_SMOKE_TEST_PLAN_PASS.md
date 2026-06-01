# REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS`

## Lane
`DOCS_SYNC / QA_PLAN`

## Mode
Docs-only QA plan.

## Verdict
Completed.

## Scope
- Docs-only plan creation for manual Windows smoke validation of the accepted local reference-image sidecar viewer and path-clamp behavior.
- No code or runtime changes.
- No schema/tool/materializer/sample or release-object edits.

## Implemented plan artifacts
- `docs/REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN.md` created.

## Required prerequisite confirmations
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS` accepted/pushed.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_CLOSEOUT_PASS` accepted/pushed.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS` accepted/pushed.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_CLOSEOUT_PASS` accepted/pushed.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_POST_AUDIT_PASS` accepted (`PASS`, `ACCEPT_AS_IS`).
- `V1_1_HARDENING_BACKLOG_REVIEW_PASS` accepted (`PASS`) from audit context.
- `v1.0.0-rc1` exists and remains present on origin.

## Acceptance summary
- Manual runbook covers:
  - clean-tree/startup preflight,
  - Project Overview reachability of Reference Images,
  - local picker import of `png/jpg/jpeg/webp`,
  - sidecar persistence under `.tracebench_local/reference_images/`,
  - reference-images metadata ledger update and safety-copy text assertions,
  - Project ZIP exclusion check (`.tracebench_local` absent),
  - optional path-clamp tamper smoke check.
- Forbidden behavior section explicitly includes:
  - no events/known_facts writes,
  - no Board Canvas overlay,
  - no URL import,
  - no AI/OCR/CV path,
  - no `board_graph.json`,
  - no `view_state.json`,
  - `renderer writes: none`.
- PASS template for run pass included (pass/fail capture matrix + stop criteria).

## Boundaries preserved
- Evidence boundaries from `ACTIVE_SCOPE_LOCK.md` remain intact:
  - local sidecar/reference-only,
  - non-canonical,
  - outside ZIP/events/known_facts/materializer/Board Canvas evidence/AI-OCR-CV,
  - no URL import.

## Next recommended pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_PASS`
