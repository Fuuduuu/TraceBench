# V2_BENCHBEEP_HOME_LAUNCHER_IMPORT_ACTION_ACTIVE_LOCK_SYNC_PASS

## Status

- Lane: `B`
- Type: `CODEX / DOCS_SYNC / PROTECTED_ACTIVE_LOCK_ALLOWLIST_EXPANSION`
- Result: current docs-only import-action active-lock sync candidate
- Date: 2026-06-23

## Purpose

Record the Home launcher Import project blocker and expand the live implementation allowlist narrowly so the current `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS` can repair Import project wiring without routing through the legacy start screen.

## Baseline

- Current implementation pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- Latest accepted/pushed Home launcher scope-lock: `1249b6d` (`docs: lock BenchBeep home launcher`).
- Latest accepted/pushed Home launcher active-lock sync: `e0055eb` (`docs: arm BenchBeep home launcher implementation`).
- Manual smoke: Home visual direction is acceptable enough for now; logo polish is deferred; `Open existing` works; Import project is blocked.

## Blocker recorded

- Existing import behavior exists inside `lib/features/project/screens/home_screen.dart`.
- The existing import flow is embedded in the legacy `HomeScreen` private `_importZip` flow.
- The previous active allowlist did not include that file.
- Routing Import project to the legacy start screen is forbidden.
- Silently disabling Import project is not acceptable as a final implementation.

## Changed files in this docs-only sync

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_LAUNCHER_IMPORT_ACTION_ACTIVE_LOCK_SYNC_PASS.md`

## Carryover implementation diff

The working tree may already include in-progress runtime/test files from `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.

These are carryover implementation files, not changes made by this docs-only sync pass:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

## Route state

- Active implementation route remains: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- Next route after implementation acceptance remains: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS`.
- Next action after this sync is accepted/pushed: rerun the Home launcher implementation repair for Import project wiring.

## Expanded implementation allowlist

The current Home launcher implementation pass may use only:

- existing Home launcher implementation files already in the active lock;
- `lib/features/project/screens/home_screen.dart` only to expose/reuse the existing import flow without changing its semantics;
- `lib/app/router.dart` only if required to route directly to an existing import surface;
- a new narrowly named reusable import action/widget/service file only if needed to extract the existing private `_importZip` behavior;
- focused widget tests for Home import action wiring.

## Future repair boundaries

- Import project must invoke/reuse existing import/open-project behavior directly.
- Import project must not route to the legacy start screen.
- No fake import behavior.
- No new Project ZIP/import/write semantics.
- No schema/writer/materializer/validator/projection/Project ZIP/event/fact changes.
- `Open existing` must keep opening the existing Workbench context.
- `Start new` remains deferred unless separately scoped.
- Home remains launcher/board-selection, not a marketing page.
- Logo polish remains deferred.

## Boundary confirmation

- This pass is docs-only.
- No runtime files are edited by this pass.
- No test files are edited by this pass.
- No import action is implemented by this pass.
- No Home visual changes are implemented by this pass.
- No false accepted/pushed hash is recorded for `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_PASS`.
- Protected data/write surfaces remain untouched.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
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
