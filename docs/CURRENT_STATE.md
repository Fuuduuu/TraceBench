# Current State

Current pass: BENCHBEEP_FULLSCREEN_REQUIRES_PLATFORM_SCOPE_PASS
Next recommended pass: BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS

## Status

Docs-only blocked-closeout plus platform build-lock is active for BenchBeep fullscreen launch.

This pass records that the SDK-only fullscreen launch implementation path did not satisfy real Windows desktop fullscreen in manual smoke, and arms a platform-scoped window-manager implementation pass.

## Blocker recorded

`BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS` attempted SDK-only immersive startup using `SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)`, but manual smoke showed the app does not open as true fullscreen on Windows desktop.

Verdict: `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE`

Reason: true desktop-window fullscreen requires platform/window-manager scope outside the SDK-only allowlist.

## Platform-scoped implementation pass armed

Implementation pass: `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`

Preferred dependency candidate: `window_manager`

Rationale:
- supports desktop platforms including Windows
- provides `windowManager.ensureInitialized()`
- provides `windowManager.setFullScreen(true)`

Exact implementation allowlist:
- `pubspec.yaml`
- `pubspec.lock`
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

`pubspec.lock` exists and is tracked, so it is armed for the future implementation if changed by dependency resolution.

Do not arm or touch `windows/` or native runner files unless a later pass proves they are required. If they are required, stop and report `BLOCKED_NEEDS_NATIVE_RUNNER_SCOPE`.

## Boundaries

This remains app-shell/window presentation only.

Do not change:
- router or app routes
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

## Route

Current: `BENCHBEEP_FULLSCREEN_REQUIRES_PLATFORM_SCOPE_PASS`
Next: `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`
