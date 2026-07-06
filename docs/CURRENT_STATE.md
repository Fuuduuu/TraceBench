# Current State

Current pass: BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS
Next recommended pass: BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS

## Status

Docs-only build-lock / implementation allowlist sync is active for BenchBeep fullscreen launch.

This pass records live startup-shell findings and arms the narrow implementation pass only. It does not implement fullscreen behavior.

## Build-lock decision

BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS may request fullscreen / immersive startup before rendering `TraceBenchApp` using Flutter SDK APIs only.

Live-code findings recorded for the implementation pass:
- `lib/main.dart` currently ensures Flutter widgets binding and runs `ProviderScope(child: TraceBenchApp())`.
- `TraceBenchApp` owns launcher/workbench UI in `lib/app/app.dart`.
- `pubspec.yaml` currently has no desktop window/fullscreen package.
- `windows/` is untracked scratch on this host and is not an implementation surface for this pass.

Implementation decision:
- SDK-only fullscreen/immersive request is allowed as a best-effort startup-shell change.
- True Windows desktop-window fullscreen requiring a package, `pubspec.yaml`, platform runner, or `windows/` changes is not allowed in this pass and must stop as `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE`.

## Armed implementation pass

Implementation pass: `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`

Exact implementation allowlist:
- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

Expected implementation shape:
- keep `WidgetsFlutterBinding.ensureInitialized()` before `runApp`
- request fullscreen / immersive mode before `runApp`
- preserve `ProviderScope(child: TraceBenchApp())`
- avoid route, splash, home, workbench, Board Canvas, writer, schema, tool, event, known_facts, `_incoming`, package, and platform-runner changes

## Route

Current: `BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS`
Next: `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`
