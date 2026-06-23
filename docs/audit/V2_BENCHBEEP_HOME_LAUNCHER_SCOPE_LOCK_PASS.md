# V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS

Date: 2026-06-23
Lane: B
Type: CODEX / DOCS_PROTECTED_PRODUCT_SURFACE_SCOPE_LOCK
Status: current docs-only protected product-surface scope-lock

## PASS_ID

`V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS`

## BASELINE

- Latest accepted/pushed: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_POST_AUDIT_PASS`.
- Commit: `a4356fa` (`docs: record BenchBeep token foundation`).
- Current route before this pass: `NEEDS_USER_DECISION`.

## CHANGED_FILES

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS.md`

## WORK_SUMMARY

This pass locks future work only for a BenchBeep Home launcher / board-selection entry surface.

No Home screen, runtime code, tests, menu system, command menu, context menu, audio/save beep, token consumer migration, full app redesign, or product behavior changes are implemented in this scope-lock pass.

## LOCKED_FUTURE_WORK

- Introduce a BenchBeep Home launcher / board-selection entry surface.
- Home is a launcher, not a marketing landing page.
- Home lets a technician choose or open an existing board/workbench context.
- Home may show restrained board cards, a recent list, and read-only safety framing if scoped in implementation.
- Home may use the existing BenchBeep visual token foundation.
- Home must route into the existing Workbench without changing canonical data behavior.
- Existing Workbench, Add Component, Measure Sheet, and Board Canvas behavior must be preserved.

## BRANDING_AND_NAMING

- BenchBeep is the user-facing app/product name.
- TraceBench remains the repo/platform/project name.
- BoardFact is a data-fact/subsystem name, not the primary app wordmark unless a specific surface earns it.
- Home should lean into bench-instrument identity, not generic SaaS landing-page style.

## EXPLICITLY_DEFERRED

- Menu system.
- Command menu / Ctrl-K palette.
- Context menus.
- Left rail redesign.
- Audio/save beep.
- Token consumer migration for existing canvas colors.
- Broad typography/font asset bundling.
- High-pin selector UX.
- Dual-primary restyling.
- Full app redesign.
- Data model changes.
- Canonical board/write behavior.
- Placement write / Confirm-write / Edit Layout.

## BOUNDARY_CONFIRMATION

- This pass only locks future Home launcher scope.
- No runtime files changed.
- No test files changed.
- No product behavior changed.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- Future Home implementation must not alter canonical board data, events, facts, writer, schema, materializer, validator, projection, Project ZIP, placement records, Confirm/write, or Edit Layout.
- Future Home implementation must not create new canonical board/project data unless separately scoped.
- Existing Workbench route and safety/read-only framing must remain intact.
- No accepted/pushed hash is claimed for this uncommitted scope-lock pass.
- Untracked scratch files are untouched and unstaged.

## ROUTE_STATE

- Current pass: `V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS`.
- Next route if accepted: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.

## VALIDATION_RESULTS

Required commands for this pass:

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```

## STAGED

NO

## COMMITTED

NO

## PUSHED

NO

## SAFE_FOR_REAUDIT

YES
