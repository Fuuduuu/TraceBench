# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS`

## Next recommended pass

`REFERENCE_IMAGES_UX_POLISH_IMPL_PASS`

## Docs drift countdown (canonical)

`5`

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_PLAN_PASS | DOCS_SYNC / QA_PLAN | completed | Created manual Windows smoke plan for sidecar viewer, ZIP/sidecar behavior, and navigation/route checkpoints. |
| REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_PASS | DOCS_SYNC / QA_RUN | completed | Ran manual smoke and confirmed project overview entry, local sidecar import/persistence, and route/ZIP boundary invariants. |
| REFERENCE_IMAGE_LOCAL_SIDECAR_SMOKE_TEST_RUN_CLOSEOUT_PASS | DOCS_SYNC / QA_CLOSEOUT | completed | Recorded PASS smoke run outcomes and the non-blocking duplicate `device_profiles/default.json` ZIP observation as note. |
| PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked dedup scope for Project ZIP export duplicate arc names, specifically `device_profiles/default.json`; implementation target is `TOOLS_PASS`. |
| PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS | TOOLS_PASS | completed | Remove duplicate archive entry behavior by ensuring unique ZIP arc names while preserving required export behavior and exclusions. |
| PROJECT_ZIP_DEVICE_PROFILES_DEDUP_CLOSEOUT_PASS | DOCS_SYNC | completed | Recorded accepted `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS` implementation and closeout outcome (`PASS`, `ACCEPT_AS_IS`); contract boundaries preserved. |
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | completed | Ran docs drift cleanup after dedup closeout and kept docs compact while fixing route context. |
| REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS | DOCS_SYNC | in_progress | Lock safe UX polish scope for local sidecar reference image viewer; no implementation yet. |
