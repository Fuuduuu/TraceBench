# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS`

## Next recommended pass

`LIVE_POSITIVE_SMOKE_TEST_RUN_PASS`

## Docs drift countdown (canonical)

`0`

## Planned / Recommended

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS | DOCS_SYNC / QA_PLAN | current | Added practical manual positive smoke runbook for `board_canvas_positive_smoke`, including direct-open and ZIP export/import strategies with explicit boundary checks. |
| LIVE_POSITIVE_SMOKE_TEST_RUN_PASS | DOCS_SYNC / QA_RUN | recommended | Execute manual positive smoke run using new fixture and record objective PASS/PASS_WITH_NITS/FAIL evidence with screenshots/notes template. |
| BOARD_CANVAS_POSITIVE_SMOKE_PROJECT_ZIP_FIXTURE_PASS | DOCS_SYNC / TOOLING_SCOPE | deferred alternative | Optional alternative strategy if fixture import path is preferred later; requires separate scope lock for ZIP-fixture surfaces. |
| BOARD_CANVAS_NAVIGATION_SMOKE_FIXUP_AUDIT_PASS | AUDIT_ONLY | deferred | Independent audit for navigation discoverability fix scope and boundary preservation. |
| BOARD_CANVAS_UI_POLISH_SCOPE_LOCK_PASS | DOCS_SYNC | deferred candidate | Allowed only if kept metadata-only and does not open new evidence surfaces. |
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
