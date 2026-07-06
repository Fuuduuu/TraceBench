# ACTIVE_SCOPE_LOCK

Last updated: 2026-07-06

## Current pass

`BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS`

## Next recommended pass

`BENCHBEEP_STARTUP_INTRO_IMPL_PASS`

## Active lock state

Docs-only build-lock / implementation allowlist sync is active.

The runtime implementation lock is now armed for `BENCHBEEP_STARTUP_INTRO_IMPL_PASS`.

## Write allowlist for this build-lock pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS.md`

## Armed implementation pass

`BENCHBEEP_STARTUP_INTRO_IMPL_PASS`

## Exact implementation write allowlist

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_splash_screen.dart`
- `test/widget/benchbeep_splash_screen_test.dart`

If implementation needs any additional file, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.

## Verified design input

Design/provenance input only:

- `_incoming/ui_redesign/TraceBench_startup_animation.zip`

Verified ZIP entries:

- `codex/BENCHBEEP_LOGO_INTEGRATION.md`
- `codex/README.md`
- `codex/benchbeep_lockup.dart`
- `codex/benchbeep_splash_screen.dart`

The implementation pass may use only the startup intro / splash material. It must not import, copy, or stage the ZIP or `_incoming` directory. It must not implement the lockup refresh.

## Live-code findings

- `TraceBenchApp` is a `ConsumerStatefulWidget`.
- `_TraceBenchAppState` owns local launcher/workbench transition state through `_showLauncher`.
- When launcher is active, `TraceBenchApp.build` returns `MaterialApp(home: _buildLauncherHome(context))`.
- Existing launcher home is `BenchBeepHomeScreen`.
- The splash can be wired before the existing launcher without touching `lib/app/router.dart`.
- `BenchBeepHomeScreen` already uses `assets/brand/benchbeep_mark.png`.
- No new dependency, asset, font, or `pubspec.yaml` edit is expected.

## Locked implementation intent

Add a presentation-only startup intro that shows once per app process before the existing BenchBeep launcher home.

Preferred implementation:

- Add `BenchBeepSplashScreen` at `lib/features/home/screens/benchbeep_splash_screen.dart`.
- Wire it in `lib/app/app.dart` using local `_TraceBenchAppState` state.
- Use an in-memory bool such as `_showStartupIntro` or `_showSplash`.
- If `_showLauncher` is true and the splash flag is true, show `BenchBeepSplashScreen`.
- On splash completion, set the splash flag false and then show the existing launcher home.
- Do not show the splash every time the user returns from workbench to home during the same app process.
- Do not route through `/splash`.
- Do not edit `router.dart`.

## Test intent

- Add `test/widget/benchbeep_splash_screen_test.dart`.
- Pump the splash with a short total duration.
- Verify key startup text / visual identity renders.
- Verify `onComplete` fires once after animation completes.
- Verify repeat completion does not call the callback multiple times if practical.
- If practical, add a source-level assertion that `app.dart` imports/wires `BenchBeepSplashScreen` without router changes.
- Do not add broad brittle golden tests.

## Strict exclusions

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

## Product and canonical boundary retained

This is launcher presentation only.

- It must not affect Board Canvas workflows, right-panel behavior, project data, canonical writes, or old route migration policy.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human is the sensor; AI is the graph engine.
- UI animation must not create or imply canonical facts.
- No events or facts are written by the splash.
