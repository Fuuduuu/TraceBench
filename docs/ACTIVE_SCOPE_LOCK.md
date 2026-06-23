# Active Scope Lock

## Current pass

`V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`

## Type

CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC_CLOSEOUT

## Goal

Record the docs-only post-audit closeout for the accepted/pushed BenchBeep Home launcher implementation (`6758cfd`).

## Baseline

- Latest accepted/pushed Home launcher scope-lock: `V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS` at `1249b6d` (`docs: lock BenchBeep home launcher`).
- Active-lock sync pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS` accepted/pushed as `e0055eb` (`docs: arm BenchBeep home launcher implementation`).
- Import-action active-lock sync pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPORT_ACTION_ACTIVE_LOCK_SYNC_PASS` accepted/pushed as `21975c1` (`docs: allow Home launcher import action repair`).
- Accepted/pushed Home launcher implementation: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS` at `6758cfd` (`feat: add BenchBeep home launcher`).
- Current closeout route: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`.
- BenchBeep token foundation exists as inert `ThemeExtension<BenchBeepVisualTokens>`.
- Existing Workbench, Add Component, Measure Sheet, and Board Canvas behavior remains accepted.
- Manual interaction smoke found the Home launcher visual direction acceptable enough for now, with logo polish deferred, `Open existing` working, `Import project` working through the existing allowed import/open-project flow, and back/home navigation returning to the new BenchBeep Home launcher rather than the legacy start screen.

## Status labels to record

- `ROUTE_EFFECT: IMPLEMENTATION_POST_AUDIT_CLOSEOUT`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_B`

## Accepted implementation files

The accepted Home launcher implementation changed only these runtime/test files:

- `lib/app/app.dart`
- `lib/app/router.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

This closeout pass is docs-only and does not authorize runtime/test edits.

## Accepted implementation behavior

- App opens to the new BenchBeep Home launcher.
- Home is a launcher, not a marketing landing page.
- BenchBeep is the user-facing app/product name.
- `Open existing` opens the existing Workbench context.
- `Import project` invokes/reuses existing import/open-project behavior directly.
- `Import project` does not route to the legacy start screen.
- No fake import behavior or new Project ZIP/import/write semantics were introduced.
- Back/home navigation returns to the new BenchBeep Home launcher, not the legacy start screen.
- `Start new` remains deferred unless separately scoped.
- Existing Workbench, Add Component, Measure Sheet, and Board Canvas behavior remains preserved.

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

- `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS` is docs-only implementation closeout.
- No runtime files are edited in this closeout pass.
- No test files are edited in this closeout pass.
- No product behavior is changed in this closeout pass.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- Future Home implementation must not alter canonical board data, events, facts, writer, schema, materializer, validator, projection, Project ZIP, placement records, Confirm/write, or Edit Layout.
- Future Home implementation must not create new canonical board/project data unless separately scoped.
- Existing Workbench route and safety/read-only framing must remain intact.
- Import-action repair must not create new Project ZIP/import/write semantics.
- Import-action repair must not route to the legacy start screen.
- Import-action repair may only expose/reuse the existing import behavior.
- No menus, command menu, context menus, audio/save beep, canvas token consumer migration, high-pin selector UX, full app redesign, or broad font bundling are authorized.
- No false accepted/pushed hash is recorded for `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
