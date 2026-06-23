# Active Scope Lock

## Current pass

`V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`

## Type

CODEX / FLUTTER_PASS / PROTECTED_PRODUCT_SURFACE_IMPLEMENTATION

## Goal

Implement the narrow BenchBeep Home launcher / board-selection entry surface authorized by accepted scope-lock `1249b6d`, after `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS` arms the live implementation route and allowlist.

## Baseline

- Latest accepted/pushed Home launcher scope-lock: `V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS` at `1249b6d` (`docs: lock BenchBeep home launcher`).
- Active-lock sync pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- This sync pass performs no runtime/test implementation and creates no Home implementation accepted/pushed hash claim.
- Current implementation route after this sync: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- BenchBeep token foundation exists as inert `ThemeExtension<BenchBeepVisualTokens>`.
- Existing Workbench, Add Component, Measure Sheet, and Board Canvas behavior remains accepted.

## Status labels to record

- `ROUTE_EFFECT: PROTECTED_PRODUCT_SURFACE_IMPLEMENTATION_ACTIVE`
- `ROUTE_EFFECT_NEXT: V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`
- `LANE_B`

## Implementation allowlist

The future Home launcher implementation may use only these narrow targets:

- `lib/features/home/screens/benchbeep_home_screen.dart` only for the new narrow Home launcher screen/widget.
- `lib/app/app.dart` only for showing Home first and routing/opening the existing Workbench.
- `test/widget/benchbeep_home_screen_test.dart` only for focused Home launcher widget tests.
- `lib/shared/theme/app_theme.dart` only if strictly needed to consume the existing token foundation without changing token architecture.

If implementation requires any other runtime/test file, Codex must stop and request re-scope before editing.

## Locked implementation work

- Introduce a BenchBeep Home launcher / board-selection entry surface.
- Home is a launcher, not a marketing landing page.
- Home lets a technician choose or open an existing board/workbench context.
- Home may show restrained board cards, a recent list, and read-only safety framing if kept inside the implementation allowlist.
- Home may use the existing BenchBeep visual token foundation.
- Home must route into the existing Workbench without changing canonical data behavior.
- Existing Workbench, Add Component, Measure Sheet, and Board Canvas behavior must be preserved.

## Branding and naming

- BenchBeep is the user-facing app/product name.
- TraceBench remains the repo/platform/project name.
- BoardFact is a data-fact/subsystem name, not the primary app wordmark unless a specific surface earns it.
- Home should lean into bench-instrument identity, not generic SaaS landing-page style.

## Explicitly deferred

- Menu system.
- Command menu / Ctrl-K palette.
- Context menus.
- Left rail redesign.
- Audio/save beep.
- Canvas token consumer migration.
- High-pin selector UX.
- Dual-primary visual restyling.
- Broad typography/font asset bundling.
- Full app redesign.
- Data model changes.
- Canonical board/write behavior.
- Placement write / Confirm-write / Edit Layout.

## Boundary

- `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS` is docs-only route/allowlist sync.
- No runtime files are edited in this sync pass.
- No test files are edited in this sync pass.
- No product behavior is changed in this sync pass.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- Future Home implementation must not alter canonical board data, events, facts, writer, schema, materializer, validator, projection, Project ZIP, placement records, Confirm/write, or Edit Layout.
- Future Home implementation must not create new canonical board/project data unless separately scoped.
- Existing Workbench route and safety/read-only framing must remain intact.
- No menus, command menu, context menus, audio/save beep, canvas token consumer migration, high-pin selector UX, full app redesign, or broad font bundling are authorized.
- No false accepted/pushed hash is recorded for `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`
- Next route: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
