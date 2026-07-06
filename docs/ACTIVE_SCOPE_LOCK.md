# Active Scope Lock

## Current pass

`BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS`

## Next recommended pass

`BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`

## Lock type

Docs-only build-lock / implementation allowlist sync.

## Current pass write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS.md`

## Armed implementation pass

`BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`

## Exact implementation write allowlist

- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

No other runtime, test, docs, schema, tool, event, fact, platform, package, or `_incoming` file is armed.

## Implementation goal

Request fullscreen / immersive startup before rendering `TraceBenchApp`.

Allowed implementation shape:
- keep `WidgetsFlutterBinding.ensureInitialized()`
- use Flutter SDK APIs only
- request fullscreen / immersive mode before `runApp`
- preserve `ProviderScope(child: TraceBenchApp())`
- add a focused test for the startup-shell configuration if useful

## Live-code findings recorded

- `lib/main.dart` currently only ensures widget binding and runs `ProviderScope(child: TraceBenchApp())`.
- `TraceBenchApp` owns launcher/workbench UI in `lib/app/app.dart`.
- `pubspec.yaml` currently has no desktop window/fullscreen package.
- `windows/` is not a tracked implementation surface for this pass.

## Required stop conditions

Report `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE` if real desktop fullscreen requires:
- `pubspec.yaml`
- a new dependency
- `windows/`
- native platform runner edits
- platform-specific window-management code outside the allowlist

Report `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any file outside:
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

## Forbidden surfaces

Do not change:
- `pubspec.yaml`
- packages/dependencies
- platform runner files
- `windows/`
- router files
- app route flow
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

## Product/canonical boundary

This pass and its armed implementation are app-shell presentation only. They do not authorize canonical data changes, workflow changes, fact/event creation, or product-route changes.
