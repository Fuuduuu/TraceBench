# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Next recommended pass

`NONE` (no immediate implementation pass queued)

## Docs drift countdown (canonical)

`5`

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS | DOCS_SYNC / QA_PLAN | completed | Created manual Windows smoke plan for sidecar viewer, ZIP/sidecar behavior, and navigation/route checkpoints. |
| REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_PASS | DOCS_SYNC / QA_RUN | completed | Ran manual smoke and confirmed project overview entry, local sidecar import/persistence, and route/ZIP boundary invariants. |
| REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_CLOSEOUT_PASS | DOCS_SYNC / QA_CLOSEOUT | completed | Recorded PASS smoke run outcomes and the non-blocking duplicate `device_profiles/default.json` ZIP observation as note. |
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | current | Compacting governance handoff/state docs and aligning current/next routing pointers after smoke closeout. |
