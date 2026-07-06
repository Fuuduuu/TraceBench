# CURRENT_STATE

Last updated: 2026-07-06

## Current route

Current: `BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS`
Next: `BENCHBEEP_STARTUP_INTRO_IMPL_PASS`

## Active pass

`BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS` is a docs-only build-lock / implementation allowlist sync for a narrow BenchBeep startup intro implementation.

This pass performs no runtime or test implementation. It verifies the design handoff ZIP, reads the live launcher code, and arms the exact implementation allowlist for `BENCHBEEP_STARTUP_INTRO_IMPL_PASS`.

## Implementation allowlist armed

Future implementation may write only:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_splash_screen.dart`
- `test/widget/benchbeep_splash_screen_test.dart`

If startup intro implementation needs `lib/app/router.dart`, `pubspec.yaml`, assets, home lockup replacement, writer/schema/materializer/validator/tools/events/known_facts, `_incoming`, or any additional file, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.

## Design input verified

Design/provenance input only:

- `_incoming/ui_redesign/TraceBench_startup_animation.zip`

Expected ZIP entries verified:

- `codex/BENCHBEEP_LOGO_INTEGRATION.md`
- `codex/README.md`
- `codex/benchbeep_lockup.dart`
- `codex/benchbeep_splash_screen.dart`

Only the startup intro / splash material is in scope for the next implementation. The lockup refresh material exists in the ZIP but is explicitly out of scope.

Do not import, stage, or copy the ZIP itself. Do not stage `_incoming`.

## Live-code findings for implementation

- `TraceBenchApp` is a `ConsumerStatefulWidget`.
- `_TraceBenchAppState` already controls launcher/workbench transition through local `_showLauncher` state.
- When launcher is active, `TraceBenchApp.build` returns `MaterialApp(home: _buildLauncherHome(context))`.
- Existing launcher home is `BenchBeepHomeScreen`.
- The splash can be wired before the existing launcher without touching `lib/app/router.dart`.
- `BenchBeepHomeScreen` already uses `assets/brand/benchbeep_mark.png`.
- No new dependency, asset, font, or `pubspec.yaml` edit is expected.
- The new splash widget and its widget test do not exist yet and are intentionally armed as new implementation files.

## Locked implementation intent

Add a presentation-only startup intro that shows once per app process before the existing BenchBeep launcher home.

Preferred implementation:

- Add `BenchBeepSplashScreen` at `lib/features/home/screens/benchbeep_splash_screen.dart` using the design handoff as source material.
- Wire the splash in `lib/app/app.dart` through local `_TraceBenchAppState` state.
- Use an in-memory bool such as `_showStartupIntro` or `_showSplash`.
- If `_showLauncher` is true and the splash flag is true, show `BenchBeepSplashScreen`.
- On splash completion, set the splash flag false and then show the existing launcher home.
- Do not show the splash every time the user returns from workbench to home during the same app process.
- Do not route through `/splash`.
- Do not edit `router.dart`.

## Test intent

Future implementation should add a targeted widget test for `BenchBeepSplashScreen` that:

- pumps the splash with a short total duration
- verifies key startup text / visual identity renders
- verifies `onComplete` fires once after animation completes
- verifies repeat completion does not call the callback multiple times if practical

If practical, add a source-level assertion that `app.dart` imports/wires `BenchBeepSplashScreen` without `router.dart` changes.

Do not add broad brittle golden tests.

## Product and canonical boundaries

This is launcher presentation only.

- It must not affect Board Canvas workflows, right-panel behavior, project data, canonical writes, or old route migration policy.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human is the sensor; AI is the graph engine.
- UI animation must not create or imply canonical facts.
- No events or facts are written by the splash.

## Strict exclusions

- No runtime or test edits in this build-lock pass.
- No router changes.
- No old standalone Add/Edit/Measure page changes.
- No writer/schema/materializer/validator/tool changes.
- No canonical event changes.
- No events.jsonl / known_facts.json semantic changes.
- No `_incoming` use or staging.
- No new assets.
- No `pubspec.yaml` changes.
- No new packages.
- No Space Grotesk/font work.
- No logo lockup refresh in this pass.
- No Board Canvas workflow changes.
- No Visual First rule changes.
- No duplicate old workflow menu/hub/card.
- No table/form UX regression.
- Do not stage, commit, or push.
