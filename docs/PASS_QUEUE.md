# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`DOCS_SCOPE_AND_NOISE_CLEANUP_PASS`

## Next recommended pass

`LIVE_LITE_SMOKE_TEST_PLAN_PASS`

## Docs drift countdown (canonical)

`3`

## Planned / Recommended

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| DOCS_SCOPE_AND_NOISE_CLEANUP_PASS | DOCS_SYNC | current | Resolve audit-noted docs noise/staleness, compact handoff docs, and keep routing/boundaries coherent. |
| LIVE_LITE_SMOKE_TEST_PLAN_PASS | DOCS_SYNC / QA_PLAN | recommended | Conservative next step: define manual smoke checklist for current board-canvas/readiness metadata behavior before broader UI expansion. |
| BOARD_CANVAS_UI_POLISH_SCOPE_LOCK_PASS | DOCS_SYNC | deferred candidate | Allowed only if kept metadata-only and does not open new evidence surfaces. |
| PHOTO_ALIGNMENT_TRANSFORM_COMPUTATION_SCOPE_AUDIT_PASS | AUDIT_ONLY | deferred high-risk | Must stay audit-only until GPT Pro + Claude Code gate is completed. |
| BOARD_CANVAS_BACKGROUND_PHOTO_HELPER_SCOPE_AUDIT_PASS | AUDIT_ONLY | deferred high-risk | Must stay audit-only until GPT Pro + Claude Code gate is completed. |

## Completed sequence (compact recent ledger)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
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
