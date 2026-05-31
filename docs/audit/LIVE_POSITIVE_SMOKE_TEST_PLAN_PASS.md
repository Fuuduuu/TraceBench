# LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS

## PASS_ID
`LIVE_POSITIVE_SMOKE_TEST_PLAN_PASS`

## Lane
`DOCS_SYNC / QA_PLAN`

## Mode
Docs-only positive smoke planning.

## Result
Completed.

## What was added
- New runbook:
  - `docs/BOARD_CANVAS_LIVE_POSITIVE_SMOKE_TEST_PLAN.md`
- Ledger/routing updates:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`

## Fixture target
- `samples/board_canvas_positive_smoke`
- `project_id: prj_board_canvas_smoke_001`

## Fixture opening strategy
Documented two valid paths:
1. Direct open of fixture directory (if app open-project flow supports folder projects).
2. ZIP workflow with exact tool command syntax:
   - `py -3 tools\export_project_zip.py <project_dir> <output_zip>`
   - `py -3 tools\validate_project_zip.py <project_zip_or_dir>`
   - `py -3 tools\import_project_zip.py <project_zip> <output_dir>`

Runbook uses recommended temporary ZIP path:
- `C:\Users\Kasutaja\Desktop\TraceBench\.codex\board_canvas_positive_smoke.zip`

## Commands covered in plan
- Gate/status/log checks.
- Fixture-specific event validation.
- Fixture materializer regeneration check.
- Full repo validation (`validate_all.py`).
- Flutter device discovery.
- Flutter run commands for `windows` and `edge`.

## Positive checks covered
- Board Canvas route reachability.
- Positive placement visibility (`SMP001`).
- Read-only inspector behavior.
- Measurement summary (`M1001`) visibility.
- visual_trace summary (`VT001`) visibility.
- readiness panel visibility and expected values (`ALN1001`, source photo, reference pair count, declared transform type).
- Mandatory safety copy confirmation.

## Forbidden/evidence-boundary coverage
- Explicit forbidden-action/forbidden-rendering checklist included.
- Raw reference coordinate display prohibition included with measurement-value nuance.
- Evidence-boundary checklist included (no identity/net/fault promotion, no transform computation, no write behavior, no board_graph/view_state behavior).

## Validation
- `py -3 tools\validate_all.py` passed.
- `git diff --name-only` limited to docs allowlist.
- `git status --short --branch` shows docs changes plus unrelated local untracked paths.

## Next recommended pass
`LIVE_POSITIVE_SMOKE_TEST_RUN_PASS`
