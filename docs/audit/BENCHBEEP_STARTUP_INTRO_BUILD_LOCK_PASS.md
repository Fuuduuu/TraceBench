# BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS

## Mode

Docs-only build-lock / implementation allowlist sync.

## Baseline verification

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main...origin/main`
- Baseline HEAD: `572c44a` (`docs: close out typed canvas selection phase 1`)
- Starting tracked diff: clean
- Starting cached diff: clean
- `git diff --check` before edit: PASS
- Route gate before edit:
  - Current: `NEEDS_USER_DECISION`
  - Next: `NEEDS_USER_DECISION`
- Active lock before edit: no implementation pass armed
- Known untracked scratch and design input remained unrelated and unstaged

## Purpose

Arm a narrow runtime implementation pass to add the BenchBeep startup intro from the design handoff ZIP.

This is a short build-lock, not a broad docs or architecture pass.

## Design input findings

Design/provenance input only:

- `_incoming/ui_redesign/TraceBench_startup_animation.zip`

ZIP exists and contains the expected entries:

- `codex/BENCHBEEP_LOGO_INTEGRATION.md`
- `codex/README.md`
- `codex/benchbeep_lockup.dart`
- `codex/benchbeep_splash_screen.dart`

Relevant design findings:

- `codex/benchbeep_splash_screen.dart` is a self-contained animated startup intro widget that calls `onComplete` when finished.
- The splash reuses `assets/brand/benchbeep_mark.png`.
- The handoff states no new assets or packages are needed for the splash.
- The ZIP also contains lockup refresh material, but that is explicitly out of scope for this pass and the next implementation pass.
- `_incoming` and the ZIP must not be staged, imported wholesale, or treated as runtime truth.

## Live-code findings

- `TraceBenchApp` is a `ConsumerStatefulWidget`.
- `_TraceBenchAppState` controls launcher/workbench transition through local `_showLauncher` state.
- When launcher is active, `TraceBenchApp.build` returns `MaterialApp(home: _buildLauncherHome(context))`.
- Existing launcher home is `BenchBeepHomeScreen`.
- `BenchBeepHomeScreen` already receives the project-open callbacks and is built by `_buildLauncherHome`.
- The splash can be wired before the existing launcher without touching `lib/app/router.dart`.
- Existing asset `assets/brand/benchbeep_mark.png` is already used by `BenchBeepHomeScreen`.
- No new dependency, asset, font, or `pubspec.yaml` edit is expected.
- `lib/features/home/screens/benchbeep_splash_screen.dart` does not exist yet.
- `test/widget/benchbeep_splash_screen_test.dart` does not exist yet.

## Implementation pass armed

`BENCHBEEP_STARTUP_INTRO_IMPL_PASS`

## Exact implementation allowlist

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_splash_screen.dart`
- `test/widget/benchbeep_splash_screen_test.dart`

If implementation needs any other file, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation intent

Add a presentation-only startup intro that shows once per app process before the existing BenchBeep launcher home.

Preferred implementation:

- Add new `BenchBeepSplashScreen` widget from the design handoff as `lib/features/home/screens/benchbeep_splash_screen.dart`.
- Wire it in `lib/app/app.dart` through local `_TraceBenchAppState` state.
- Use an in-memory bool such as `_showStartupIntro` or `_showSplash`.
- If `_showLauncher` is true and `_showStartupIntro` is true, show `BenchBeepSplashScreen`.
- On splash complete, set `_showStartupIntro = false` and then show the existing launcher home.
- Do not show splash every time user returns from workbench to home during the same app process.
- Do not route through `/splash`.
- Do not edit `router.dart`.

## Test intent

Future implementation should add a targeted widget test for `BenchBeepSplashScreen`:

- pumps the splash with a short total duration
- verifies key startup text / visual identity renders
- verifies `onComplete` fires once after animation completes
- verifies repeat completion does not call the callback multiple times if practical

If practical, add a source-level assertion that `app.dart` imports/wires `BenchBeepSplashScreen` without `router.dart` changes.

Do not add broad brittle golden tests.

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

## Product and canonical boundary

This is launcher presentation only.

- It must not affect Board Canvas workflows, right-panel behavior, project data, canonical writes, or old route migration policy.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human is the sensor; AI is the graph engine.
- UI animation must not create or imply canonical facts.
- No events or facts are written by the splash.

## Route after build-lock

- Current: `BENCHBEEP_STARTUP_INTRO_BUILD_LOCK_PASS`
- Next: `BENCHBEEP_STARTUP_INTRO_IMPL_PASS`

## Boundary confirmation

- Docs-only build-lock.
- No runtime edits.
- No test edits.
- No router edits.
- No writer/schema/materializer/validator/tool edits.
- No events.jsonl / known_facts.json semantic changes.
- No samples/assets/_incoming edits or staging.
- No staging, commit, or push.

## Validation commands

- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Claude audit status

- `RETRO_CLAUDE_READY`
- `DO_NOT_CLAIM_CLAUDE_REVIEW`
