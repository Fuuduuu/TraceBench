# V2_BENCHBEEP_MENU_SYSTEM_IMPL_ACTIVE_LOCK_SYNC_PASS

## Pass metadata

- Pass ID: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Lane: `B`
- Type: docs-only protected active-lock / route sync
- Status: current uncommitted docs-sync candidate

## Baseline

- Latest accepted/pushed scope-lock: `V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS`.
- Scope-lock commit: `c731513` (`docs: lock BenchBeep menu system`).
- Accepted Home launcher closeout: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`.

## Drift risk addressed

GPT Pro documentation-governance audit identified `DRIFT_RISK`: the Menu System scope-lock was accepted/pushed, but `docs/ACTIVE_SCOPE_LOCK.md` still needed an exact runtime/test implementation allowlist before code could begin.

This pass resolves that by arming the protected implementation route without performing runtime or test implementation.

## Route update

- Active implementation route: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS`.
- Next route after implementation: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_POST_AUDIT_PASS`.
- This docs-sync pass does not claim that `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS` is accepted, committed, or pushed.

## Implementation allowlist armed

Future implementation may edit only:

- `lib/app/app.dart`
- `lib/app/router.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`

If the implementation needs any other runtime, test, route, theme, canvas, schema, writer, materializer, validator, projection, Project ZIP, event, fact, or generated file, Codex must stop for a new scope/allowlist decision.

## Locked implementation boundaries

Future implementation is limited to the first restrained BenchBeep menu-system affordance needed after Home launcher:

- app-level menu, app-bar, or breadcrumb affordance for Home launcher / Workbench navigation flow;
- technical bench-instrument style, not generic SaaS navigation;
- clear disabled/future affordances for menu items not yet implemented;
- preservation of Home launcher behavior;
- preservation of Workbench navigation and existing safety/read-only framing;
- preservation of BenchBeep / TraceBench / BoardFact naming boundaries.

## Explicitly forbidden / deferred

- command menu / Ctrl-K implementation;
- context menu implementation;
- audio/save beep;
- canvas token consumer migration;
- full app redesign;
- logo polish;
- high-pin selector UX;
- dual-primary visual restyling;
- new project creation;
- Project ZIP import/export semantics;
- canonical board/write behavior;
- placement write;
- Confirm/write;
- Edit Layout;
- schema/writer/materializer/validator/projection/Project ZIP/event/fact changes;
- `_incoming`, screenshots, docs/sources, or mockups as runtime source.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_MENU_SYSTEM_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Validation

Required for this docs-sync candidate:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Staging state

- Staged: no
- Committed: no
- Pushed: no
