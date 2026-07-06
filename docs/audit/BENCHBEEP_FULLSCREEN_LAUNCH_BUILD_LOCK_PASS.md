# BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS

## Mode

Docs-only build-lock / implementation allowlist sync.

## Purpose

Arm the narrow runtime implementation pass for `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`.

## Baseline verification

- `git status --short --branch`: clean tracked/cached diff; branch aligned as `main...origin/main`; untracked scratch remains outside scope.
- `git log --oneline --decorate -10`: latest commit verified as `1f26b1f docs: close out benchbeep startup intro`.
- `git diff --name-status`: no tracked diff before this pass.
- `git diff --cached --name-status`: no cached diff before this pass.
- `git diff --check`: clean before this pass.

## Route and active-lock gate

Verified before editing:
- `docs/CURRENT_STATE.md`: Current `NEEDS_USER_DECISION`, Next `NEEDS_USER_DECISION`.
- `docs/PASS_QUEUE.md`: Current `NEEDS_USER_DECISION`, Next `NEEDS_USER_DECISION`.
- `docs/ACTIVE_SCOPE_LOCK.md`: Current `NEEDS_USER_DECISION`, Next `NEEDS_USER_DECISION`; no implementation pass armed.

## Live-code findings

- `lib/main.dart` currently imports Flutter material and Riverpod, ensures widget binding, and runs `ProviderScope(child: TraceBenchApp())`.
- `TraceBenchApp` owns launcher/workbench UI in `lib/app/app.dart`.
- `pubspec.yaml` has no desktop window/fullscreen package.
- Existing widget tests include source-level shell tests, so a focused source/widget test for `lib/main.dart` is acceptable if useful.
- `windows/` is not a tracked implementation surface for this pass.

## Decision

SDK-only fullscreen / immersive startup is allowed as a best-effort app-shell request.

True Windows desktop-window fullscreen that requires a package, dependency, `pubspec.yaml`, platform runner, native code, or `windows/` edits is outside this pass and must stop as `BLOCKED_FULLSCREEN_REQUIRES_PLATFORM_SCOPE`.

## Armed implementation pass

`BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`

## Exact implementation allowlist

- `lib/main.dart`
- `test/widget/fullscreen_launch_test.dart`

## Implementation target

The future implementation may:
- import `package:flutter/services.dart`
- keep `WidgetsFlutterBinding.ensureInitialized()`
- request fullscreen / immersive mode before `runApp`
- preserve `ProviderScope(child: TraceBenchApp())`
- add a focused startup-shell test

The future implementation must not:
- edit `pubspec.yaml`
- add packages
- edit platform runners or `windows/`
- edit router/app/splash/home/workbench/Board Canvas feature flows
- edit writer/schema/materializer/validator/tool/event/fact semantics
- edit `events.jsonl`, `known_facts.json`, or `_incoming`

## Product/canonical boundary

This is app-shell/window presentation only. It does not change canonical data, project loading, routing, writer behavior, placement behavior, measurement behavior, events, facts, projections, or schemas.

## Route result

Current: `BENCHBEEP_FULLSCREEN_LAUNCH_BUILD_LOCK_PASS`
Next: `BENCHBEEP_FULLSCREEN_LAUNCH_IMPL_PASS`

## Review state

RETRO_CLAUDE_READY
DO_NOT_CLAIM_CLAUDE_REVIEW
