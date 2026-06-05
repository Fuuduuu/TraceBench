# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`PROJECT_CREATOR_TEST_FLAKE_FIX_PASS`

## Next recommended pass

`PROJECT_CREATOR_TEST_FLAKE_FIX_POST_AUDIT_PASS`

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
| REFERENCE_IMAGES_UX_STATES_IMPL_PASS | FLUTTER_PASS | completed | Implemented empty/missing/error state copy and behavior for Reference Images, with existing Model-B boundary and no full preview/metadata grouping/accessibility/layout changes. |
| REFERENCE_IMAGES_UX_STATES_CLOSEOUT_PASS | DOCS_SYNC | completed | Closeout for `REFERENCE_IMAGES_UX_STATES_IMPL_PASS` with accepted post-audit result: `PASS`, `ACCEPT_AS_IS`; `Reference Images tests: 8/8`, `Full Flutter suite: 191`; route set to metadata grouping scope lock. |
| REFERENCE_IMAGES_UX_METADATA_GROUPING_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock the next narrow metadata grouping UX scope with strict test seam and no full-screen rewrite; preview decoding constraints must remain in place. |
| REFERENCE_IMAGES_UX_METADATA_GROUPING_IMPL_PASS | FLUTTER_PASS | completed | Implement selected-image metadata grouping (Identity, File details, Provenance), required label/copy improvements, and non-invasive test-seam support. |
| REFERENCE_IMAGES_UX_METADATA_GROUPING_CLOSEOUT_PASS | DOCS_SYNC | completed | Metadata grouping closeout accepted and closeout nits recorded; route to `REFERENCE_IMAGES_UX_ACCESSIBILITY_SCOPE_LOCK_PASS`. |
| REFERENCE_IMAGES_UX_ACCESSIBILITY_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock accessibility/focus-only improvements for Reference Images metadata/readability/interactive affordance semantics without changing runtime behavior. |
| REFERENCE_IMAGES_UX_ACCESSIBILITY_IMPL_PASS | FLUTTER_PASS | completed | Implement accessibility/focus polish for import action, list items, and metadata headings while preserving all Model-B boundaries and safety copy. |
| REFERENCE_IMAGES_UX_ACCESSIBILITY_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out accessibility/focus implementation with accepted post-audit outcome (`PASS_WITH_NITS`, `ACCEPT_AS_IS`), preserved boundaries, and route to `REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_SCOPE_LOCK_PASS`. |
| REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock narrow follow-up semantics/focus scope for `REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS`; no runtime, schema, tool, or ZIP surface expansion. |
| REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_PASS | FLUTTER_PASS | completed | Fixed inert focus wrappers, import action semantics, and selected-item accessibility announcements for Reference Images; preserved required safety strings and Model-B boundaries. |
| REFERENCE_IMAGES_UX_ACCESSIBILITY_FIXUP_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out accepted accessibility fixup with final closeout ledger and routing to post-slice smoke verification. |
| REFERENCE_IMAGES_UX_POST_SLICE_SMOKE_RUN_PASS | DOCS_SYNC / QA_RUN | completed | Recorded PASS_WITH_NITS smoke check for safety-copy/state visibility and routed non-responsive layout NITs to responsive layout follow-up scope lock. |
| REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked the narrow responsive layout implementation scope; implementation target is `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS`. |
| REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS | FLUTTER_PASS | completed | Implement constrained-width responsive behavior for Reference Images: wide/narrow layout handling, overflow-safe long-path metadata display, and layout-focused widget verification (`11/11` tests). |
| REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out accepted responsive-layout implementation, record `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_POST_AUDIT_PASS` outcome (`ACCEPT_AS_IS`), and route next to `V1_1_REFERENCE_IMAGES_UX_POST_RESPONSIVE_ROUTE_REVIEW_PASS`. |
| V1_1_REFERENCE_IMAGES_UX_POST_RESPONSIVE_ROUTE_REVIEW_PASS | AUDIT_ONLY / ROUTE_REVIEW | completed | Route review (no file changes): confirmed Reference Images UX track complete and governance clean; recommended opening the Board Canvas read-only visual polish track via scope lock. Decision recorded in `CURRENT_STATE`. |
| BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS | DOCS_SYNC / SCOPE_LOCK | completed | Docs-only lock of a small read-only Board Canvas visual polish scope (presentation/styling/layout/label clarity on existing projection facts); records Claude Design GO; locks exact allowed files and read-only geometry sources; routes to `BOARD_CANVAS_READONLY_VISUAL_POLISH_IMPL_PASS`. |
| BOARD_CANVAS_READONLY_VISUAL_POLISH_IMPL_PASS | FLUTTER_PASS | completed | Implemented first narrow read-only Board Canvas visual polish slice: canvas hierarchy, static footprint legend/safety caption, existing-template footprint body/pad/orientation rendering, and focused widget assertions; preserved evidence boundaries. |
| BOARD_CANVAS_READONLY_VISUAL_POLISH_POST_AUDIT_PASS | AUDIT_ONLY | accepted (`ACCEPT_AS_IS`) | Claude Code / Opus post-audit accepted the read-only Board Canvas visual polish implementation slice: no scope drift, Board Canvas widget tests PASS (`43/43`), `validate_all.py` PASS, forbidden-surface diff clean; unrelated `project_creator_test.dart` Windows temp-file flake isolated/non-blocking. |
| BOARD_CANVAS_READONLY_VISUAL_POLISH_CLOSEOUT_PASS | DOCS_SYNC | completed | Docs-only closeout recording accepted implementation and post-audit (`ACCEPT_AS_IS`) for `BOARD_CANVAS_READONLY_VISUAL_POLISH_IMPL_PASS`; routed to `V1_1_POST_BOARD_CANVAS_POLISH_ROUTE_REVIEW_PASS`. |
| V1_1_POST_BOARD_CANVAS_POLISH_ROUTE_REVIEW_PASS | AUDIT_ONLY / ROUTE_REVIEW | completed | Route review (no file changes): confirmed both V1.1 tracks complete and governance clean; recommended fixing the `project_creator_test.dart` flake next via a test-only scope lock. Decision recorded in `CURRENT_STATE`. |
| PROJECT_CREATOR_TEST_FLAKE_FIX_SCOPE_LOCK_PASS | DOCS_SYNC / SCOPE_LOCK | completed | Docs-only lock of a test-only fix for the `project_creator_test.dart` Windows full-suite flake (un-awaited fake materializer write -> read-before-write race on `known_facts.json`); locks exact allowed test file + the fix + validation; routes to `PROJECT_CREATOR_TEST_FLAKE_FIX_PASS`. |
| PROJECT_CREATOR_TEST_FLAKE_FIX_PASS | TEST_FIX_PASS | completed | Applied the locked test-only fix in `test/unit/project_creator_test.dart` (synchronous fake materializer write + post-`createProject` `known_facts.json` existence assertion); no production change; targeted test, 3 full Flutter suite runs, and `validate_all.py` passed; route next to post-audit. |
| PROJECT_CREATOR_TEST_FLAKE_FIX_POST_AUDIT_PASS | AUDIT_ONLY | planned | Claude Code / Opus post-audit and repeated reliability validation for the test-only `project_creator_test.dart` flake fix before acceptance. |
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

