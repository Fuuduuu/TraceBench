# BENCHBEEP_FULLSCREEN_REQUIRES_PLATFORM_SCOPE_PASS

## Mode

Docs-only blocked-closeout plus platform build-lock.

## Purpose

Record that `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS` did not satisfy real Windows desktop fullscreen with SDK-only `SystemChrome`, then arm a platform-scoped fullscreen implementation using a desktop window management package.

## Baseline verification

Verified before editing:
- `git status --short --branch`: `main...origin/main`; tracked diff clean; cached diff clean; unrelated untracked scratch present.
- `git log --oneline --decorate -10`: latest commit `5a85b73 docs: lock benchbeep fullscreen launch`.
- `git diff --name-status`: no tracked diff before this pass.
- `git diff --cached --name-status`: no cached diff before this pass.
- `git diff --check`: clean before this pass.

## Precondition

The uncommitted SDK-only implementation diff was absent before this docs pass.

No `lib/main.dart` or `test/widget/fullscreen_launch_test.dart` implementation diff remained.

## Route and active-lock gate

Verified before editing:
- `docs/CURRENT_STATE.md`: Current `BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS`, Next `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`.
- `docs/PASS_QUEUE.md`: Current `BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS`, Next `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md`: `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS` armed only for `lib/main.dart` and `test/widget/fullscreen_launch_test.dart`.

## Blocker recorded

`BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS` attempted SDK-only immersive startup using:
- `SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)`

Manual smoke result:
- the app does not open as true fullscreen on Windows desktop.

Verdict:
- `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE`

Reason:
- true desktop-window fullscreen requires platform/window-manager scope outside the previous SDK-only allowlist.

## Platform-scoped implementation path armed

Implementation pass:
- `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`

Preferred dependency candidate:
- `window_manager`

Rationale:
- supports desktop platforms including Windows
- provides `windowManager.ensureInitialized()`
- provides `windowManager.setFullScreen(true)`

## Exact implementation allowlist

- `pubspec.yaml`
- `pubspec.lock`
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

`pubspec.lock` exists and is tracked, so it is included in the future implementation allowlist if dependency resolution changes it.

## Stop conditions for the next implementation

Report `BLOCKED_NEEDS_NATIVE_RUNNER_SCOPE` if true Windows fullscreen requires:
- `windows/`
- native runner edits
- native platform-specific code outside the allowlist

Report `BLOCKED_ALLOWLIST_MISMATCH` if implementation requires any file outside the exact allowlist.

## Strict exclusions

Do not change:
- router files
- route definitions
- splash implementation
- home/workbench screens
- Board Canvas
- Add/Edit/Measure pages
- writer/schema/materializer/validator/tool behavior
- canonical events/facts
- `events.jsonl`
- `known_facts.json`
- `_incoming`
- docs compaction

## Product/canonical boundary

This is app-shell/window presentation only. It creates no facts, writes no events, and does not change projection/cache semantics.

## Route result

Current: `BENCHBEEP_FULLSCREEN_REQUIRES_PLATFORM_SCOPE_PASS`
Next: `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`

## Review state

RETRO_CLAUDE_READY
DO_NOT_CLAIM_CLAUDE_REVIEW
