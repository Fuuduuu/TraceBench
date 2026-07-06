# Pass Queue

## Current route

Current: `BENCHBEEP_FULLSCREEN_REQUIRES_PLATFORM_SCOPE_PASS`
Next: `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`

## Current focus

Docs-only blocked-closeout plus platform build-lock for BenchBeep fullscreen launch.

## Blocked SDK-only attempt

`BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS` is recorded as blocked for the real Windows desktop fullscreen requirement.

Observed result:
- SDK-only `SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)` does not make the Windows desktop app open as true fullscreen.

Verdict:
- `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE`

Reason:
- true desktop-window fullscreen requires platform/window-manager scope outside the previous SDK-only allowlist.

## Armed implementation

Implementation pass: `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`

Exact implementation allowlist:
- `pubspec.yaml`
- `pubspec.lock`
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

Preferred dependency candidate:
- `window_manager`

Expected implementation direction:
- add the desktop window manager dependency through `pubspec.yaml`
- update `pubspec.lock` through normal dependency resolution
- initialize the window manager before rendering `TraceBenchApp`
- request real fullscreen with `windowManager.setFullScreen(true)` or the package's current equivalent API
- preserve `ProviderScope(child: TraceBenchApp())`
- keep startup behavior app-shell only

## Stop conditions for implementation

Stop and report `BLOCKED_NEEDS_NATIVE_RUNNER_SCOPE` if true Windows fullscreen requires:
- `windows/`
- native runner edits
- platform-specific native code outside the allowlist

Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any file outside:
- `pubspec.yaml`
- `pubspec.lock`
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

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

## Route after this pass

Proceed to `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS` after this blocked-closeout/platform build-lock is accepted and staged by the user.
