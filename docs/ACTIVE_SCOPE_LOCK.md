# Active Scope Lock

## Current pass

`V2_BENCHBEEP_MENU_SYSTEM_IMPL_POST_AUDIT_PASS`

## Type

CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC_CLOSEOUT

## Goal

Record the accepted/pushed BenchBeep Menu System implementation closeout for `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS` at `85bf54d` (`feat: add BenchBeep menu system`) and route onward to `NEEDS_USER_DECISION` without runtime/test changes.

## Baseline

- Latest accepted/pushed Menu System scope-lock: `V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS` at `c731513` (`docs: lock BenchBeep menu system`).
- Latest accepted/pushed Menu System active-lock sync: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_ACTIVE_LOCK_SYNC_PASS` at `c5e10b2` (`docs: arm BenchBeep menu system implementation`).
- Latest accepted/pushed Menu System implementation: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS` at `85bf54d` (`feat: add BenchBeep menu system`).
- Claude audit: `AUDIT_VERDICT: ACCEPT_WITH_NITS`; `SAFE_FOR_STAGING: YES`.
- This closeout performs no runtime/test implementation.

## Status labels to record

- `ROUTE_EFFECT: IMPLEMENTATION_POST_AUDIT_CLOSEOUT`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_B`

## Accepted implementation files

The accepted implementation changed only:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`

## Accepted behavior

- Narrow Menu System slice implemented.
- Home launcher has an instrument-style menu/app-bar affordance.
- Workbench/Overview has Home button plus breadcrumb affordance.
- BenchBeep / TraceBench / BoardFact naming remains correct.
- Home launcher accepted behavior remains preserved.
- `Open existing` still opens Workbench.
- `Import project` still opens the existing allowed import/open-project flow.
- `Import project` does not route to the legacy start screen.
- Back/home navigation still returns to BenchBeep Home.
- Workbench behavior remains preserved.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain preserved.

## Validation evidence recorded

- `flutter test`: all tests passed, `332` tests.
- `flutter analyze`: `18` pre-existing issues, zero findings in changed files.
- `py -3 tools/validate_all.py`: passed, `273` tests.

## Non-blocking nits

- Incidental const-correctness cleanup occurred within allowlisted files.
- Some `find.text('BenchBeep')` assertions were loosened because the accepted menu/breadcrumb UI intentionally creates additional `BenchBeep` occurrences.

## Explicitly not changed in this closeout

- Runtime files.
- Tests.
- Command menu / Ctrl-K palette.
- Context menus.
- Audio/save beep.
- Canvas token consumer migration.
- Full redesign, logo polish, high-pin selector UX, or new project creation.
- Canonical board/write behavior.
- Placement write / Confirm-write / Edit Layout.
- Schema/writer/materializer/validator/projection/Project ZIP/event/fact files.
- `_incoming`, screenshots, docs/sources, design artifacts, or untracked scratch files.

## Boundary

- This closeout records accepted implementation state only.
- This closeout does not implement more menu behavior.
- This closeout does not claim an accepted/pushed hash for itself.
- Home launcher remains accepted and is not reworked by this pass.
- Menu system remains a product-surface/navigation concern only.
- Menu work must not create or alter canonical project, board, component, or placement data.
- Menu work must not introduce Project ZIP import/export semantics.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_POST_AUDIT_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```