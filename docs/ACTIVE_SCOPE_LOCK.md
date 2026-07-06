# Active Scope Lock

## Current pass

`BENCHBEEP_FULLSCREEN_REQUIRES_PLATFORM_SCOPE_PASS`

## Next recommended pass

`BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`

## Lock type

Docs-only blocked-closeout plus platform build-lock.

## Current pass write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_FULLSCREEN_REQUIRES_PLATFORM_SCOPE_PASS.md`

## Blocked prior implementation path

`BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS` is blocked for the real Windows desktop fullscreen requirement.

Recorded blocker:
- `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE`

Reason:
- SDK-only `SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky)` did not make the app open as true fullscreen on Windows desktop.
- true desktop-window fullscreen requires platform/window-manager scope outside the previous two-file allowlist.

## Armed implementation pass

`BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS`

## Exact implementation write allowlist

- `pubspec.yaml`
- `pubspec.lock`
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

No other runtime, test, docs, schema, tool, event, fact, platform runner, native runner, `windows/`, or `_incoming` file is armed.

`pubspec.lock` exists and is tracked, so it is included if dependency resolution changes it.

## Implementation goal

Use a desktop window manager approach for true Windows fullscreen launch.

Preferred dependency candidate:
- `window_manager`

Allowed implementation shape:
- add `window_manager` through `pubspec.yaml`
- update `pubspec.lock` through normal dependency resolution
- call `windowManager.ensureInitialized()` before window manipulation
- call `windowManager.setFullScreen(true)` or the package's current equivalent API before rendering `TraceBenchApp`
- preserve `ProviderScope(child: TraceBenchApp())`
- keep this app-shell/window presentation only
- add or update focused tests in `test/widget/fullscreen_launch_test.dart`

## Required stop conditions

Report `BLOCKED_NEEDS_NATIVE_RUNNER_SCOPE` if true Windows fullscreen requires:
- `windows/`
- native runner edits
- native platform-specific code outside the allowlist

Report `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any file outside:
- `pubspec.yaml`
- `pubspec.lock`
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

## Forbidden surfaces

Do not change:
- router files
- route definitions
- splash implementation
- home/workbench screens
- Board Canvas
- Add/Edit/Measure pages
- writer services
- schemas
- validators/materializers/tools
- events/facts semantics
- `events.jsonl`
- `known_facts.json`
- `_incoming`
- docs compaction

## Product/canonical boundary

This pass and the armed implementation are app-shell/window presentation only. They do not authorize canonical data changes, workflow changes, fact/event creation, project semantics changes, or product-route changes.
