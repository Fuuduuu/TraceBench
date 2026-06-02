# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`REFERENCE_IMAGES_UX_STATES_IMPL_PASS`

## Next recommended pass

`REFERENCE_IMAGES_UX_STATES_POST_AUDIT_PASS`

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
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | completed | Replaced stale `docs/SOURCES_INDEX_CURRENT.md` “Current release/governance state” content with canonical pointers, aligned routing docs, and preserved compact docs-only drift cleanup. |
| V1_1_POST_GOVERNANCE_CLEANUP_NEXT_ROUTE_REVIEW_PASS | DOCS_SYNC | completed | Confirmed that route review is complete and that the next safe pass is `REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS`. |
| REFERENCE_IMAGES_UX_STATES_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock the next narrow Reference Images recovery slice for empty/missing/error states only. |
| REFERENCE_IMAGES_UX_STATES_IMPL_PASS | FLUTTER_PASS | in_progress | Implement empty/missing/error state copy and behavior for Reference Images, with existing Model-B boundary and no full preview/metadata grouping/accessibility/layout changes. |
| REFERENCE_IMAGES_UX_STATES_POST_AUDIT_PASS | DOCS_SYNC | planned | Claude Code post-implementation audit and closeout for `REFERENCE_IMAGES_UX_STATES_IMPL_PASS`. |
| REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock safe UX polish scope for local sidecar reference image viewer; no implementation yet. |
| REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS | DOCS_SYNC | completed | Add final Design-deepening acceptance package for UX polish (six fixed zones, required copy/state set, accessibility + forbidden wording constraints). |
| REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS | DOCS_SYNC | completed | Sync final Claude Design scope-lock card as accepted implementation input for `REFERENCE_IMAGES_UX_POLISH_IMPL_PASS` (six zones, required strings, metadata/state coverage, accessibility, track separation, test intent). |
| REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock constrained copy/safety implementation slice for `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS` after `REFERENCE_IMAGES_UX_POLISH_RECOVERY_AUDIT_PASS`; required copy and non-fs-heavy tests only. |
| REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS | FLUTTER_PASS | completed | Implement required copy/safety microcopy, required safety strings, and import wording in `ReferenceImagesScreen` with focused widget coverage; no rewrite, no filesystem-heavy new behaviors. |
| REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_CLOSEOUT_PASS | DOCS_SYNC | accepted (`PASS`) | Close out copy/safety implementation with accepted implementation/post-audit state, closeout exception handling, boundary lock persistence, and routing to `PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS`. |
| PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked a focused test-only fix scope for `test/unit/project_exporter_test.dart` order-dependent isolation and routed to `PROJECT_EXPORTER_TEST_FIX_PASS` (`TEST_FIX_PASS`). |
| PROJECT_EXPORTER_TEST_FIX_PASS | TEST_FIX_PASS | completed | Applied test-only normalization in fallback assertions (`_commandExecutable`) to make `ProjectExporter falls back to python3/python when earlier candidates fail` order-independent; no production behavior change; accepted post-audit (`PASS`, `ACCEPT_AS_IS`). |
| PROJECT_EXPORTER_TEST_FIX_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out `PROJECT_EXPORTER_TEST_FIX_PASS` with post-audit summary, accepted status propagation, and routing to `PROMPT_PROTOCOL_GUARD_CLAUSES_PASS`. |
| PROMPT_PROTOCOL_GUARD_CLAUSES_PASS | DOCS_SYNC | completed | Added reusable prompt guard clauses for test hangs, FS-image test guardrails, bounded waits, and model/tool routing reminders; docs-only implementation. |
| TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock the low-staleness Mermaid diagram set for governance orientation before implementation: pass lifecycle, evidence boundaries, and tool/model routing. |
| TRACEBENCH_GOVERNANCE_DIAGRAMS_PASS | DOCS_SYNC | completed | Implemented locked governance diagram docs: `docs/PASS_LIFECYCLE.md`, `docs/ARCHITECTURE_BOUNDARIES.md`, and routing section in `docs/MODEL_ROUTING.md`. |
| TRACEBENCH_GOVERNANCE_DIAGRAMS_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out the pass by recording accepted closeout outcomes, NITs, and routing to docs drift cleanup. |

