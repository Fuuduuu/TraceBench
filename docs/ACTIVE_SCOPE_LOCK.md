# Active Scope Lock

## Current pass

`V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`

## Type

CODEX / FLUTTER_NAV_POLISH

## Goal

Narrow Workbench measurement navigation consolidation that preserves the existing accepted Measure Sheet flow and direct/fallback route compatibility.

## Baseline

- Latest accepted/pushed pass: `TRACEBENCH_POST_MISSING_POINTER_ROUTE_SYNC_PASS` at `955a9b0` (`docs: sync route after missing audit pointer`).
- Previous attempted `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` correctly blocked before edits because live route docs still named `TRACEBENCH_POST_MISSING_POINTER_ROUTE_SYNC_PASS` as current and this active lock allowed only route-cleanup docs.
- `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` was present only as a future route option before this sync.
- This lock arms the future implementation pass only; it does not mark the future implementation accepted/pushed.

## Allowed future implementation files

- `lib/app/router.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/board_canvas_screen_test.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/measure_sheet_screen_test.dart`

If another runtime or test file appears necessary, stop and report the exact rationale before editing it.

## Required preservation

- Existing standalone Measure Sheet route remains alive.
- `/project/measure-sheet` direct/fallback route behavior remains compatible.
- Existing accepted Measure Sheet save behavior remains inside the existing Measure Sheet flow.
- BenchBeep Home launcher remains preserved.
- `Open existing` remains preserved.
- `Import project` remains preserved.
- Back/Home returns to BenchBeep Home, not the legacy start screen.
- Menu System behavior remains preserved.
- Board Canvas read-only behavior remains preserved.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain preserved.

## Explicitly forbidden

- Inline/integrated measurement panel implementation.
- New measurement event type.
- New write semantics.
- Schema, writer, validator, materializer, projection, Project ZIP, events, or facts changes.
- Canonical placement, coordinate, net, or electrical semantics.
- Add Component Confirm/write behavior.
- Command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- Dependency on `_incoming`, screenshots, docs/sources, mockups, or source indexes as runtime truth.

## Boundary

- This lock authorizes only narrow route/navigation/screen polish and focused widget tests for the future implementation pass.
- Runtime/test implementation happens only in `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`, not in `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_ACTIVE_LOCK_SYNC_PASS`.
- It records no accepted/pushed hash for the future implementation pass.
- It does not authorize schema, writer, materializer, validator, projection, Project ZIP, event, fact, or canonical write changes.
- It does not authorize product scope expansion, new measurement write flows, Add Component write behavior, or protected data/write surfaces.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.
- No untracked scratch files are touched or staged.

## Route

- Current/armed pass: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`
- Route after accepted/pushed: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git diff --name-status
git diff --cached --name-status
git diff --check
dart format lib/app/router.dart lib/features/project/screens/project_overview_screen.dart lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/project_overview_screen_test.dart test/widget/board_canvas_screen_test.dart test/widget/benchbeep_home_screen_test.dart test/widget/measure_sheet_screen_test.dart
flutter test test/widget/project_overview_screen_test.dart test/widget/board_canvas_screen_test.dart test/widget/benchbeep_home_screen_test.dart test/widget/measure_sheet_screen_test.dart
flutter test
```
