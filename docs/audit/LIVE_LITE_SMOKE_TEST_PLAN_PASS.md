# LIVE_LITE_SMOKE_TEST_PLAN_PASS

## PASS_ID
`LIVE_LITE_SMOKE_TEST_PLAN_PASS`

## Lane
`DOCS_SYNC / QA_PLAN`

## Mode
Docs-only live-lite smoke test planning.

## Goal
Create a practical manual runbook for visually verifying current accepted board-canvas and photo-alignment readiness-panel behavior before any UI/evidence expansion.

## Plan created
- Added `docs/BOARD_CANVAS_LIVE_LITE_SMOKE_TEST_PLAN.md`.
- Includes:
  - purpose/prerequisites
  - exact command sequence (git status/log, validate_all, flutter devices, run targets)
  - route/opening instruction (`/project/board-canvas`)
  - positive verification checklist
  - forbidden UI/behavior checklist
  - evidence-boundary checklist
  - screenshot/notes collection guidance
  - observations template with verdict field
  - pass/fail criteria
  - known expected warning (`photos/top_backlight_001.jpg`)
  - stop conditions

## Routing updates
- Current pass set to `LIVE_LITE_SMOKE_TEST_PLAN_PASS`.
- Next recommended pass set to `LIVE_LITE_SMOKE_TEST_RUN_PASS`.
- ACTIVE_SCOPE_LOCK updated to this planning pass with docs-only allowlist.

## Drift/countdown coherence
- `PASS_QUEUE.md` remains canonical countdown owner.
- Countdown set to `2` and aligned in `CURRENT_STATE.md`.

## Boundaries preserved
- No schema/tool/lib/test/assets/runtime changes.
- No automated test implementation.
- No product behavior changes.
- No transform/background/overlay/event-writing scope expansion.

## Validation
- `py -3 tools\validate_all.py`: PASS
- `git diff --name-only`: docs-only changes
- `git status --short --branch`: docs changes + expected unrelated untracked paths
