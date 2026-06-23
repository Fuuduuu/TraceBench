# Active Scope Lock

## Current pass

`V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS`

## Type

CODEX / PROTECTED_PRODUCT_SURFACE_IMPLEMENTATION

## Goal

Implement the first narrow BenchBeep menu-system slice authorized by the accepted Menu System scope-lock. This route was armed by `V2_BENCHBEEP_MENU_SYSTEM_IMPL_ACTIVE_LOCK_SYNC_PASS`; that sync pass performed docs-only route/allowlist work and no runtime implementation.

## Baseline

- Latest accepted/pushed Menu System scope-lock: `V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS` at `c731513` (`docs: lock BenchBeep menu system`).
- Latest accepted/pushed Home launcher implementation closeout: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS` at `e5407d2` (`docs: record BenchBeep home launcher`).
- Accepted Home launcher implementation: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS` at `6758cfd` (`feat: add BenchBeep home launcher`).
- App opens to the new BenchBeep Home launcher.
- Home is a board/workbench launcher, not a marketing landing page.
- `Open existing` opens the existing Workbench context.
- `Import project` works through the existing allowed import/open-project flow.
- Back/home navigation returns to the new BenchBeep Home launcher.
- `Start new` remains deferred.
- Logo polish remains deferred.

## Status labels to record

- `ROUTE_EFFECT: PROTECTED_PRODUCT_SURFACE_IMPLEMENTATION_ACTIVE`
- `ROUTE_EFFECT_NEXT: V2_BENCHBEEP_MENU_SYSTEM_IMPL_POST_AUDIT_PASS`
- `LANE_B`

## Implementation allowlist

Future menu-system implementation may edit only:

- `lib/app/app.dart`
- `lib/app/router.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`

If implementation requires any other runtime, test, routing, theme, canvas, schema, writer, materializer, validator, projection, Project ZIP, event, fact, generated, or tooling file, Codex must stop and request a new scope/allowlist decision.

## Locked implementation scope

The implementation may only add the first restrained BenchBeep menu-system affordance needed after Home launcher:

- app-level menu, app-bar, or breadcrumb affordance for the Home launcher / Workbench navigation flow;
- technical bench-instrument menu direction, not generic SaaS navigation;
- preservation of existing Home launcher and Workbench navigation;
- preservation of `BenchBeep` as the user-facing app/product name;
- preservation of `TraceBench` as the repo/platform/project name;
- preservation of `BoardFact` as the data-fact/subsystem name unless an existing surface already justifies it;
- clear disabled/future affordances for menu items that are not implemented.

## Must preserve

- App still opens to BenchBeep Home launcher.
- Home remains a launcher / board-selection surface, not a marketing landing page.
- Open existing continues to open the existing Workbench context.
- Import project continues to use the existing allowed import/open-project behavior.
- Import project must not route to the legacy start screen.
- Start new remains disabled/deferred unless separately scoped.
- Existing Workbench, Add Component, Measure Sheet, Board Canvas, click-to-place, and drag-to-place behavior remain unchanged.
- Existing read-only/safety framing remains intact.

## Explicitly deferred

- Command menu / Ctrl-K palette implementation.
- Context menu implementation.
- Menu implementation outside the narrow allowed first slice.
- Audio/save beep.
- Canvas token consumer migration.
- Full app redesign.
- Logo polish.
- High-pin selector UX.
- Dual-primary visual restyling.
- New project creation.
- Project ZIP import/export semantics.
- Any canonical board/write behavior.
- Placement write / Confirm-write / Edit Layout.
- Schema/writer/materializer/validator/projection/Project ZIP/event/fact changes.

## Boundary

- This active implementation lock is the result of docs-only sync; no runtime files were edited by the sync pass.
- No test files were edited by the sync pass.
- Home launcher remains accepted and must not be reworked outside the menu affordance scope.
- Menu system remains a product-surface/navigation concern only.
- Menu work must not create or alter canonical project, board, component, or placement data.
- Menu work must not introduce Project ZIP import/export semantics.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- No false accepted/pushed hash is recorded for `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS`.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS`
- Next route: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_POST_AUDIT_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
