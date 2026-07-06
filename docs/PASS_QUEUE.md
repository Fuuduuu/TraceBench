# PASS_QUEUE

Last updated: 2026-07-06

## Route

Current: `BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS`
Next: `BENCHBEEP_STARTUP_INTRO_IMPL_PASS`

## Current pass summary

`BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS` is a docs-only build-lock / implementation allowlist sync for a narrow BenchBeep startup intro.

It verifies the startup animation handoff ZIP, reads live launcher code, and arms the exact implementation allowlist for `BENCHBEEP_STARTUP_INTRO_IMPL_PASS`.

The sync performs no runtime or test implementation.

## Implementation pass armed

`BENCHBEEP_STARTUP_INTRO_IMPL_PASS`

Exact implementation allowlist:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_splash_screen.dart`
- `test/widget/benchbeep_splash_screen_test.dart`

If implementation needs `lib/app/router.dart`, `pubspec.yaml`, assets, home lockup replacement, writer/schema/materializer/validator/tools/events/known_facts, `_incoming`, or any additional file, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.

## Design input findings

Design/provenance input only:

- `_incoming/ui_redesign/TraceBench_startup_animation.zip`

Verified ZIP entries:

- `codex/BENCHBEEP_LOGO_INTEGRATION.md`
- `codex/README.md`
- `codex/benchbeep_lockup.dart`
- `codex/benchbeep_splash_screen.dart`

Only `codex/benchbeep_splash_screen.dart` and startup intro guidance are in scope for the implementation. The lockup refresh material remains out of scope.

## Live-code findings

- `TraceBenchApp` is a `ConsumerStatefulWidget`.
- `_TraceBenchAppState` already controls launcher/workbench transition through local `_showLauncher` state.
- When launcher is active, `TraceBenchApp.build` returns `MaterialApp(home: _buildLauncherHome(context))`.
- Existing launcher home is `BenchBeepHomeScreen`.
- The splash can be wired before the existing launcher without touching `lib/app/router.dart`.
- `BenchBeepHomeScreen` already uses `assets/brand/benchbeep_mark.png`.
- No new dependency, asset, font, or `pubspec.yaml` edit is expected.
- `lib/features/home/screens/benchbeep_splash_screen.dart` and `test/widget/benchbeep_splash_screen_test.dart` do not exist yet and are intentionally armed as new implementation files.

## Locked implementation shape

- Add a presentation-only `BenchBeepSplashScreen` widget.
- Wire it in `lib/app/app.dart` before the existing launcher home.
- Show it once per app process through local in-memory `_TraceBenchAppState` state.
- On completion, show the existing `BenchBeepHomeScreen` launcher.
- Do not show the splash every time the user returns from workbench to home.
- Do not route through `/splash`.
- Do not edit `router.dart`.
- Do not replace the home lockup in this pass.

## Test requirements for implementation

- Targeted widget test pumps the splash with a short total duration.
- Test verifies key startup text / visual identity renders.
- Test verifies `onComplete` fires once after animation completes.
- Test verifies repeat completion does not call the callback multiple times if practical.
- If practical, source-level assertion confirms `app.dart` wires `BenchBeepSplashScreen` without `router.dart` changes.
- No broad brittle golden tests.

## Product and canonical boundaries

This is launcher presentation only.

- No Board Canvas workflow changes.
- No right-panel behavior changes.
- No project data changes.
- No canonical writes.
- No route migration policy changes.
- No events or facts written by the splash.

Canonical boundary reminders:

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human is the sensor; AI is the graph engine.
- UI animation must not create or imply canonical facts.

## Scope gate rules

- One narrow pass at a time.
- Active implementation allowlists live in `docs/ACTIVE_SCOPE_LOCK.md`.
- Runtime/test implementation may begin only after the active build-lock arms exact files.
- Do not stage, commit, or push from Codex unless explicitly requested.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
