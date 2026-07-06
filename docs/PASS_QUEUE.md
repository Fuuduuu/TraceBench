# Pass Queue

## Current route

Current: `BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS`
Next: `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`

## Current focus

Docs-only build-lock / implementation allowlist sync for BenchBeep fullscreen launch.

## Armed implementation

Implementation pass: `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`

Exact implementation allowlist:
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

## Implementation intent

Request fullscreen / immersive startup before rendering `TraceBenchApp`, using Flutter SDK APIs only.

The implementation may update `lib/main.dart` to import `package:flutter/services.dart`, keep `WidgetsFlutterBinding.ensureInitialized()`, request `SystemChrome.setEnabledSystemUIMode(...)` before `runApp`, and preserve `ProviderScope(child: TraceBenchApp())`.

The implementation may add a focused source/widget test in `test/widget/fullscreen_launch_test.dart` that proves the startup shell is configured without changing app routing, splash/home/workbench flows, packages, or platform runner files.

## Stop conditions for implementation

Stop and report `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE` if the requested desktop fullscreen behavior requires:
- a new package
- `pubspec.yaml`
- `windows/`
- native platform runner edits
- app/router/splash/home/feature workflow changes

Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if any file outside the armed allowlist is required.

## Boundaries

This route is app-shell/window presentation only.

Do not change:
- runtime routes beyond `lib/main.dart`
- splash implementation
- home/workbench screens
- Board Canvas
- Add/Edit/Measure pages
- writer/schema/materializer/validator/tool behavior
- canonical events/facts
- `events.jsonl`
- `known_facts.json`
- `_incoming`

## Route after build-lock

Proceed directly to `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS` after this build-lock is accepted and staged by the user.
