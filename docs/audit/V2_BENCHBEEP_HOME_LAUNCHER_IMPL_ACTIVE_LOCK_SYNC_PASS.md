# V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS

## Status

- Lane: `B`
- Type: `CODEX / DOCS_SYNC / PROTECTED_ACTIVE_LOCK_ROUTE_SYNC`
- Result: current docs-only active-lock / route sync candidate
- Date: 2026-06-23

## Purpose

Record that the BenchBeep Home launcher scope-lock was accepted/pushed and arm the live active lock for the next implementation attempt.

## Accepted baseline recorded

- `V2_BENCHBEEP_HOME_LAUNCHER_SCOPE_LOCK_PASS` accepted/pushed as `1249b6d` (`docs: lock BenchBeep home launcher`).
- Home launcher scope remains launcher / board-selection only.
- Home is not a marketing landing page.
- BenchBeep remains the user-facing app/product name.
- TraceBench remains the repo/platform/project name.
- BoardFact remains a data-fact/subsystem name.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_LAUNCHER_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Route update

- Active implementation route: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`
- Next route after implementation: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`
- Next action after this sync is accepted/pushed: rerun `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.

## Implementation allowlist armed

The future implementation may use only:

- `lib/features/home/screens/benchbeep_home_screen.dart` only for the new narrow Home launcher screen/widget.
- `lib/app/app.dart` only for showing Home first and routing/opening the existing Workbench.
- `test/widget/benchbeep_home_screen_test.dart` only for focused Home launcher widget tests.
- `lib/shared/theme/app_theme.dart` only if strictly needed to consume the existing token foundation without changing token architecture.

If implementation requires any other runtime/test file, Codex must stop and request re-scope before editing.

## Locked future implementation behavior

- Introduce a BenchBeep Home launcher / board-selection entry surface.
- Home lets a technician choose/open an existing board/workbench context.
- Home may show restrained board cards, a recent list, and read-only safety framing only inside the implementation allowlist.
- Home may use the existing BenchBeep visual token foundation.
- Home must route into the existing Workbench without changing canonical data behavior.
- Existing Workbench, Add Component, Measure Sheet, and Board Canvas behavior must remain preserved.

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

## Boundary confirmation

- This pass is docs-only.
- No runtime/test implementation is performed.
- No Home implementation is accepted/pushed by this pass.
- No false pushed hash is recorded for `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- Protected data/write surfaces remain untouched.
- Untracked scratch files remain untouched and unstaged.

## Required validation

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Staging state

- STAGED: NO
- COMMITTED: NO
- PUSHED: NO

## Safe for audit

YES.
