# Active Scope Lock

## Current pass

`V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_PROTECTED_PRODUCT_SURFACE_SCOPE_LOCK

## Goal

Create a docs-only scope-lock for future BenchBeep menu-system work after the accepted Home launcher implementation.

## Baseline

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

- `ROUTE_EFFECT: PROTECTED_PRODUCT_SURFACE_SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS`
- `LANE_B`

## Locked future scope

Future menu-system work is limited to product-surface/navigation direction only:

- Define a restrained BenchBeep menu system direction.
- Define app-level menu affordances needed after Home launcher.
- Use technical/instrument-style menu surfaces, not generic SaaS navigation.
- Preserve Home launcher and Workbench navigation.
- Preserve BenchBeep as the user-facing app/product name.
- Preserve TraceBench as the repo/platform/project name.
- Preserve BoardFact as a data-fact/subsystem name unless a specific UI surface earns it.
- Scope app bar / breadcrumb refinement only if already present or needed for launcher/workbench flow.
- Scope context / overflow menu patterns only where already appropriate.
- Treat command menu / Ctrl-K palette as a future pro workflow surface.
- Allow clear disabled/future affordances for menu items not yet implemented.

## Explicitly deferred

- Actual menu implementation.
- Command menu / Ctrl-K implementation.
- Context menu implementation.
- Audio/save beep.
- Canvas token consumer migration.
- Full app redesign.
- Logo polish.
- High-pin selector UX.
- Dual-primary restyling.
- New project creation.
- Any canonical board/write behavior.
- Placement write / Confirm-write / Edit Layout.
- Schema/writer/materializer/validator/projection/Project ZIP/event/fact changes.

## Boundary

- This pass is docs-only.
- No runtime files are edited in this pass.
- No test files are edited in this pass.
- Home launcher remains accepted and must not be reworked by this pass.
- Menu system remains a product-surface/navigation concern only.
- Menu work must not create or alter canonical project, board, component, or placement data.
- Menu work must not introduce Project ZIP import/export semantics.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- Future implementation must be narrow and may require an active-lock sync / runtime allowlist before code changes.
- No false accepted/pushed hash is recorded for `V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS`.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS`
- Next route: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
