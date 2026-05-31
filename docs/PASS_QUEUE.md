# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS`

## Next recommended pass

`V1_TO_V2_ROADMAP_DECISION_PASS`

## Docs drift countdown (canonical)

`0`

## Planned / Recommended

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS | DOCS_SYNC | current | Records Claude Code audit `PASS`, accepts tag verification as complete/scope-compliant, confirms annotated/pushed `v1.0.0-rc1` at accepted V1 RC baseline, and routes to roadmap decision. |
| V1_TO_V2_ROADMAP_DECISION_PASS | DOCS_SYNC | recommended | Use accepted roadmap audits/decision context to lock forward plan from fixed V1 RC baseline. |
| V1_RELEASE_TAG_VERIFICATION_PASS | AUDIT_ONLY | completed (`PASS`) | Verified local+remote `v1.0.0-rc1` existence, annotated type/message, HEAD target compatibility, clean repo hygiene, forbidden artifact absence, and full validation suite PASS. |
| REFERENCE_IMAGE_CONTEXT_FUTURE_WORK_PASS | DOCS_SYNC | completed | Recorded reference-image-as-AI-context future-work direction while preserving V1 RC boundaries and release-tag flow. |
| V1_RELEASE_CANDIDATE_TAG_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked the V1 RC annotated-tag workflow (`v1.0.0-rc1`) as user-only action with exact commands and verification expectations. |
| V1_FINAL_SMOKE_CHECK_PASS | DOCS_SYNC / QA_RUN | completed (`PASS`) | Final manual V1 RC smoke verification recorded as `PASS`; Board Canvas, read-only metadata panels, safety copy, readiness metadata, and forbidden-behavior absence confirmed on positive fixture. |
| REFERENCE_IMAGE_IMPORT_SCOPE_LOCK_PASS | DOCS_SYNC | deferred V1.1 candidate | Future scope lock for reference-only image import/viewer metadata contract; no canonical-fact creation. |
| REFERENCE_IMAGE_AI_CONTEXT_SCOPE_AUDIT_PASS | AUDIT_ONLY | deferred V2 candidate | Future audit for AI proposal workflow that can consume reference images as context while keeping outputs non-canonical until human confirmation. |
| BOARD_CANVAS_REFERENCE_IMAGE_LAYER_SCOPE_AUDIT_PASS | AUDIT_ONLY | deferred high-risk V2 | Future high-risk scope audit for optional board-canvas reference-image layer; requires GPT Pro + Claude Code gate before implementation. |
| AI_LAYOUT_PROPOSAL_BENCHMARK_SCOPE_PASS | DOCS_SYNC / RESEARCH_SCOPE | deferred V2+ research | Future benchmark design for reference-image-driven AI layout proposals (top-1/top-3 accuracy) with unconfirmed proposal outputs only. |
| V1_RELEASE_READINESS_REPO_AUDIT_PASS | AUDIT_ONLY | completed (`READY_WITH_NITS`) | Repo-local release-readiness audit accepted with no true blockers and non-blocking cleanup/tagging/tooling nits. |
| V1_RELEASE_READINESS_CLOSEOUT_PASS | DOCS_SYNC | completed | Recorded GPT Pro + Claude readiness verdicts (`READY_WITH_NITS`), readiness estimate (94%), no true blockers, and V1 release-checkpointable status. |
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | completed | Reset docs drift countdown to standard value `5`, aligned renderer-spec status/addendum wording, and preserved docs-only/no-surface-expansion boundaries. |
| V1_RELEASE_CANDIDATE_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked V1 release-candidate included/excluded scope, acceptance checklist, and evidence boundaries without implementation changes. |
| V1_RELEASE_CANDIDATE_SCOPE_LOCK_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Claude Code repo-local audit confirmed V1 RC scope lock accuracy/completeness and boundary preservation. |
| BOARD_CANVAS_READONLY_POLISH_V1_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked safe V1 read-only Board Canvas visual polish scope to styling/layout/copy/accessibility only; no geometry/write/transform/photo-overlay expansion allowed. |
| BOARD_CANVAS_READONLY_POLISH_V1_IMPL_PASS | FLUTTER_PASS | completed | Implemented scoped read-only board-canvas visual polish (three-zone responsive hierarchy, metadata-card polish, evidence tags) without behavior or evidence-surface expansion. |
| BOARD_CANVAS_READONLY_POLISH_V1_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Claude Code audit accepted V1 read-only polish implementation and recorded non-blocking QA nits. |
| BOARD_CANVAS_READONLY_POLISH_V1_QA_PASS | QA_PASS / FLUTTER_TEST_PASS | completed | Added focused QA hardening for non-identity copy assertions and targeted no-evidence-geometry source guards without changing product behavior. |
| BOARD_CANVAS_READONLY_POLISH_V1_QA_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Claude Code audit accepted QA hardening and confirmed boundary-safe test-only scope. |
| BOARD_CANVAS_READONLY_POLISH_V1_CLOSEOUT_PASS | DOCS_SYNC | completed | Recorded dual audit verdicts, accepted implementation + QA state, and routed to release-readiness audit checkpoint. |
| V1_RELEASE_READINESS_AUDIT_PASS | AUDIT_ONLY | completed (`READY_WITH_NITS`) | Release-readiness checkpoint audit accepted with no blockers and Board Canvas V1 marked release-checkpointable. |
| LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS | DOCS_SYNC / QA_PLAN | completed | Added practical manual positive smoke runbook for `board_canvas_positive_smoke`, including direct-open and ZIP export/import strategies with explicit boundary checks. |
| LIVE_POSITIVE_SMOKE_TEST_RUN_PASS | DOCS_SYNC / QA_RUN | completed (`PASS`) | Manual positive smoke run completed and recorded with confirmed placement/inspector/measurement/visual-trace/readiness-panel behavior and preserved boundaries. |
| BOARD_CANVAS_POSITIVE_SMOKE_PROJECT_ZIP_FIXTURE_PASS | DOCS_SYNC / TOOLING_SCOPE | deferred alternative | Optional alternative strategy if fixture import path is preferred later; requires separate scope lock for ZIP-fixture surfaces. |
| BOARD_CANVAS_NAVIGATION_SMOKE_FIXUP_AUDIT_PASS | AUDIT_ONLY | deferred | Independent audit for navigation discoverability fix scope and boundary preservation. |
| BOARD_CANVAS_UI_POLISH_SCOPE_LOCK_PASS | DOCS_SYNC | superseded | Replaced by accepted narrower `BOARD_CANVAS_READONLY_POLISH_V1_SCOPE_LOCK_PASS` route. |
| PHOTO_ALIGNMENT_TRANSFORM_COMPUTATION_SCOPE_AUDIT_PASS | AUDIT_ONLY | deferred high-risk | Must stay audit-only until GPT Pro + Claude Code gate is completed. |
| BOARD_CANVAS_BACKGROUND_PHOTO_HELPER_SCOPE_AUDIT_PASS | AUDIT_ONLY | deferred high-risk | Must stay audit-only until GPT Pro + Claude Code gate is completed. |

## Completed sequence (compact recent ledger)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Closed fixture audit, accepted deterministic sample/mirror state, recorded non-blocking nits, and routed to live positive smoke planning. |
| BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Accepted fixture correctness and boundary compliance; recorded non-blocking lock-pointer + validate-all coverage nits for closeout tracking. |
| BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_PASS | SAMPLE_PASS / QA_PASS | completed | Added deterministic positive-smoke sample and mirrored asset fixture, generated materialized known-facts projection, and extended sample parity checks with no runtime/schema/tool changes. |
| BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_PRECHECK_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Confirmed deterministic fixture strategy is ready for implementation with strict sample/asset-only write surfaces and validator-compatible ID/range constraints. |
| LIVE_LITE_SMOKE_TEST_PLAN_PASS | DOCS_SYNC / QA_PLAN | completed | Added practical manual Windows runbook for board-canvas/readiness-panel visual verification with explicit forbidden-behavior and evidence-boundary checks. |
| LIVE_LITE_SMOKE_TEST_RUN_PASS | DOCS_SYNC / QA_RUN | completed (`PASS_WITH_FINDINGS`) | Manual run proved launch/navigation/board-canvas shell and empty-state behavior; positive placement/readiness-panel behavior could not be validated because opened project lacked confirmed visual placements and visible `photo_to_board_alignments`. |
| BOARD_CANVAS_POSITIVE_SMOKE_FIXTURE_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked conservative fixture strategy for positive board-canvas smoke validation and routed next to precheck audit before any sample/fixture implementation. |
| DOCS_SCOPE_AND_NOISE_CLEANUP_PASS | DOCS_SYNC | completed | Closed Claude-audit docs cleanup: compacted state/queue noise, fixed stale invariants/spec wording, and reconciled canonical countdown ownership. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked V1 photo-alignment UI meaning to metadata-only readiness/status and routed next to live-lite smoke planning. |
| BOARD_CANVAS_ALIGNMENT_READINESS_QA_CLOSEOUT_PASS | DOCS_SYNC | completed | Closed out readiness QA audit (`PASS`) and aligned scope-lock pointers. |
| BOARD_CANVAS_ALIGNMENT_READINESS_QA_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Confirmed readiness QA stayed test-only and boundary-safe. |
| BOARD_CANVAS_ALIGNMENT_READINESS_QA_PASS | QA_PASS | completed | Added combined-state board-canvas readiness coverage without product behavior changes. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_CLOSEOUT_PASS | DOCS_SYNC | completed | Closed out nits follow-up audit (`PASS`). |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Confirmed label casing + multi-alignment test hardening with no scope expansion. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_PASS | QA_PASS / FLUTTER_TEST_PASS | completed | Fixed label casing and added multi-alignment readiness panel widget test. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_CLOSEOUT_PASS | DOCS_SYNC | completed | Closed out readiness panel audit (`PASS_WITH_NITS`) and preserved boundaries. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Accepted metadata-only panel behavior and overflow fix. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS | FLUTTER_PASS | completed | Implemented read-only readiness metadata panel with no transform/overlay/event-writing behavior. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked metadata-only readiness panel scope and field/copy boundaries. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS | DOCS_SYNC | completed | GPT Pro + Claude direction accepted: `READINESS_PANEL_ONLY`. |

For full historical ledger, use `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
