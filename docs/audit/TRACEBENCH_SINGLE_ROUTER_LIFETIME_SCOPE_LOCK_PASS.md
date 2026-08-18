# Audit Artifact — Single Router Lifetime Scope Lock

- PASS_ID: `TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS`
- Lane: `B`
- Mode: `SCOPE_LOCK / DOCS_ONLY / PHASE_1`
- Baseline: `6a81dbad9f38c3514c1db169db5a359bd0c2fc19`
- Status: `REVIEW_REQUIRED`
- Manual smoke for this docs-only scope: `NOT_APPLICABLE`
- Manual smoke for the reserved implementation: `REQUIRED_BEFORE_IMPLEMENTATION_AUDIT`

## Purpose

This artifact records one human-selected product/architecture scope. The only
future outcome is that `TraceBenchApp` owns one `MaterialApp.router` and one
`GoRouter` for its state lifetime instead of switching from a launcher
`MaterialApp` to a rebuilt workbench router. This pass changes documentation
authority only.

## Live baseline

Verified before authoring:

- repository: `C:\dev\TraceBench`;
- branch: `main`;
- `HEAD`: `6a81dbad9f38c3514c1db169db5a359bd0c2fc19`;
- `origin/main`: `6a81dbad9f38c3514c1db169db5a359bd0c2fc19`;
- subject: `docs: refresh legacy viewer removal code maps`;
- divergence: `0 0`;
- staged set: empty;
- unmerged set: empty;
- untracked set: empty;
- substantive tracked content diff: empty; and
- preserved porcelain-only Windows EOL/stat residue:
  `windows/flutter/generated_plugin_registrant.cc`,
  `windows/flutter/generated_plugin_registrant.h`, and
  `windows/flutter/generated_plugins.cmake`.

The baseline commit completes the accepted Legacy Viewer removal Code Map
maintenance and releases its route to non-executable `NEEDS_USER_DECISION`.
This explicit human request supplies the next decision.

## Exact Phase-1 material set -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS.md`

No sixth path is authorized. The pass may update only the three route-owner
tops, add one neutral `REVIEW_REQUIRED` ledger row, and create this artifact
with exactly one named empty verdict block. It may not edit implementation,
tests, maps/index, packages, platforms, tools, schemas, assets, samples,
generated files, or Windows residue.

## Route reconciliation

The three route owners must agree:

```text
Current: TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS
Next: TRACEBENCH_SINGLE_ROUTER_LIFETIME_IMPL_PASS
```

The complete transition is:

```text
TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 6a81dba]
-> TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS
-> TRACEBENCH_SINGLE_ROUTER_LIFETIME_IMPL_PASS
   [activates only after independent scope acceptance, bounded verdict
    recording, and human exact scope commit/push]
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped committed-source Code Map maintenance as required]
-> NEEDS_USER_DECISION
```

No additional implementation, closeout, or map PASS_ID is reserved here.

## Lifecycle symbol and caller closure

Live exact-symbol inspection established:

| Symbol/surface | Exact live ownership and callers | Child disposition |
| --- | --- | --- |
| `TraceBenchApp` | Defined in `lib/app/app.dart`; production construction only in `lib/main.dart`; real-app test construction in the mapped Home suite and three compact end-to-end suites; `fullscreen_launch_test.dart` reads the unchanged `main.dart` call as source text. | Change only private state lifecycle in `app.dart`; constructor and `main.dart` stay unchanged. |
| `_showLauncher` | One private field and the launcher/workbench branch in `app.dart`. | Remove; it may no longer choose between two Material apps. |
| `_showStartupIntro` | One private field, completion guard, launcher shell, and one splash source assertion. | Retain as launcher-state, including early-navigation completion latch. |
| `_workbenchRouter` | One nullable private field; disposed/rebuilt in `_openWorkbench`, disposed in `dispose`, and read/fallback-created in `build`. | Replace with one non-null lifetime router initialized once and disposed once. |
| `_openWorkbench` | Called after successful ZIP/directory acquisition and by all launcher create/open/workbench callbacks. | Keep the callback seam; route with the existing router's `go(initialLocation)`. |
| `_buildWorkbenchRouter` | Sole production `buildTraceBenchRouter` caller. | Build once at `/`, with `_buildLauncherShell` and the unchanged Wizard injection/handoff. |
| `_buildLauncherHome` | Builds the canonical launcher, watches `projectStateProvider`, and wires acquisition/create/open/exit callbacks. | Preserve behavior and callback identities. |
| `_buildLauncherShell` | Composes launcher plus pointer-transparent startup splash while `_showStartupIntro` is true. | Become the canonical `/` builder; preserve exact presentation/timing semantics. |
| `buildTraceBenchRouter` | Defined once in `lib/app/router.dart`; one production caller in `app.dart`; direct test callers are exactly `board_canvas_screen_test.dart`, `edit_component_screen_test.dart`, `project_gate_test.dart`, `project_overview_screen_test.dart`, and `projection_stale_banner_end_to_end_test.dart` (seven call sites). | Factory signature/body and every direct test caller are frozen. |
| production `MaterialApp` / `MaterialApp.router` | `app.dart` currently has one launcher `MaterialApp` and one conditional `MaterialApp.router`. | Leave exactly one lifetime `MaterialApp.router`; no plain production `MaterialApp`. |
| focused harness roots | Wizard and ProjectGate tests own independent `MaterialApp.router` harnesses; Home and splash suites also contain isolated plain `MaterialApp` component harnesses. | Harnesses outside the two authorized lifecycle suites are frozen; isolated component harnesses remain valid. |

The Wizard's `_openCreatedProject` uses `context.go('/project')`; untouched and
confirmed cancellation paths use `context.go('/')`. ProjectGate Home recovery
uses `context.go('/')`. Project Overview's Home action also uses
`context.go('/')`. No implementation change to those callers is required.

Any additional required lifecycle caller or writable test stops the child with
`BLOCKED_ALLOWLIST_MISMATCH`.

## Exact future implementation allowlist -- 3

```text
PASS_ID: TRACEBENCH_SINGLE_ROUTER_LIFETIME_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / ROUTER_LIFETIME / UI_LOCAL
Write class: ZERO_WRITE + UI_LOCAL; tests observe PROJECTION_STATE
```

1. `lib/app/app.dart`
2. `test/widget/benchbeep_home_screen_test.dart`
3. `test/widget/benchbeep_splash_screen_test.dart`

No fourth path is reserved. No new file, deletion, rename, move, package,
asset, generated output, map, or index edit is authorized. The reservation is
conditional until this exact scope is independently accepted, its verdict is
recorded under explicit authorization, and the human stages, commits, and
pushes exactly the accepted five-file scope.

### Allowed source slice

Only the private root/router lifecycle in `lib/app/app.dart` may change:

- remove `_showLauncher` and the two-root build branch;
- replace nullable/rebuilt `_workbenchRouter` ownership with one initialized
  lifetime `GoRouter`;
- initialize it once at `/` through the existing `buildTraceBenchRouter`;
- pass `_buildLauncherShell` as `homeBuilder`;
- retain the existing Wizard builder, optional creator injection, and
  provider assignment callback;
- change `_openWorkbench` to latch any active startup intro complete and call
  `go(initialLocation)` on the same router;
- dispose that router exactly once from state disposal; and
- return one `MaterialApp.router` with the existing title, theme,
  debug-banner setting, and stable workbench-router key.

Imports and mechanical formatting may change only as required by this slice.

### Allowed test slices

`test/widget/benchbeep_home_screen_test.dart` may add or tighten only app-
lifecycle, route, and provider-survival assertions around its existing real-
app fixtures. `test/widget/benchbeep_splash_screen_test.dart` may add only
app-level startup/root/no-replay coverage and a narrow lifecycle source-shape
guard. Existing visual, acquisition, Wizard, responsive, and exit assertions
must remain at least as strong.

## Exact behavioral invariants

1. `TraceBenchApp` renders one `MaterialApp.router` from first build until
   disposal. Widget rebuilds may reconstruct configuration objects in the
   normal Flutter sense, but may not switch root application types.
2. Exactly one app-owned `GoRouter` instance is constructed during state
   initialization, is reused for every route transition, and is disposed
   exactly once from `dispose`. Build and navigation callbacks may not create
   or dispose routers.
3. The router starts at canonical `/`; that route renders the existing
   BenchBeep launcher through `_buildLauncherShell`.
4. The splash remains launcher-local state, not a route. It keeps the default
   3200 ms duration, existing visual source, stack order, and `IgnorePointer`
   behavior. It completes at most once per app state lifetime.
5. A launcher action remains reachable through the pointer-transparent splash.
   If it navigates before animation completion, `_showStartupIntro` becomes
   false before leaving `/`; later Home returns do not replay the splash.
6. `_openWorkbench` performs `go(initialLocation)` on the existing router.
   It must not use `push`, create a second route history, rebuild a router, or
   dispose a router. Existing GoRouter matching/nested-page/back behavior is
   preserved by freezing the graph and continuing to use `go`.
7. `/new-project`, `/project`, all route names and nesting, all 15 real
   project destinations, `/project/measurements/new`,
   `/project/board-canvas`, and the generic error surface remain byte-frozen
   in `router.dart`.
8. Wizard untouched cancellation and confirmed cancellation still go to `/`.
   Successful creation still calls `onProjectCreated` exactly once, remains
   on Step 7, and navigates to `/project` only through `Ava projekt`.
9. ProjectGate still retains the requested project URI while no project is
   loaded; its Home recovery still goes to `/`; successful loading reveals the
   originally requested child without a forced canonical redirect.
10. Returning from any workbench route to `/` retains the identical loaded
    `ProjectState`. Launcher continuation remains enabled, re-entry uses the
    same router, and no provider is recreated or cleared.
11. `projectStateProvider` and `beginnerModeProvider` declarations, defaults,
    assignment sites, watch/read behavior, and enclosing `ProviderScope`
    ownership remain unchanged.
12. Bundled sample, ZIP and directory acquisition—including picker, cancel,
    load, typed/generic failure, provider assignment, callback/default-route
    behavior—remain unchanged.
13. Launcher visuals/responsiveness, startup visuals, window close behavior,
    theme, destinations, Project ZIP, writers, events, facts, evidence,
    freshness, and every protected semantic remain unchanged.

## Focused regression tests required

The child must preserve every existing assertion and add evidence for:

1. cold startup mounts the canonical `/` launcher inside the one production
   router and captures that router's object identity before navigation;
2. launcher -> `/new-project` uses the identical router; Wizard cancellation
   -> `/` uses the identical router and does not accumulate an independent
   launcher/workbench router history;
3. a loaded project enters `/project`, returns to `/`, remains identical in
   `projectStateProvider`, keeps launcher continuation enabled, and re-enters
   `/project` through the same router;
4. the existing real Wizard success regression captures router identity and
   still proves one provider assignment before explicit `Ava projekt`, with
   no automatic transition and no router replacement;
5. lifecycle source shape has one production `MaterialApp.router`, no plain
   production `MaterialApp`, one `buildTraceBenchRouter` construction site in
   `app.dart`, one lifetime disposal site, and `go`-based `_openWorkbench`
   without interim disposal;
6. app-level splash startup remains on URI `/`, co-mounts launcher underneath,
   keeps the overlay pointer-transparent, retains the default 3200 ms timing,
   and removes the overlay once while preserving the same router;
7. an early pointer-through New Project transition before splash completion
   reaches `/new-project`; returning `/` does not replay the splash; and
8. teardown completes without a duplicate-disposal or post-dispose router
   error.

Required unchanged regression owners are:

- the existing Home-suite acquisition, responsive, route, provider-handoff,
  and exit cases;
- `new_project_wizard_screen_test.dart` exact untouched-cancel, confirmed-
  cancel, success/handoff/wait/open, and pre-activation inert cases; and
- the complete compact `project_gate_test.dart` suite covering Home recovery,
  all 15 real targets, both aliases, URI retention, and zero-write reveal.

Tests may not change production behavior, route strings, provider semantics,
timing, or expected copy to make the conversion pass.

## Code Map preflight and dispositions

`docs/code_maps/CODE_MAP_INDEX.md` was checked first. The live registry has 31
actual maps and 31 rows, with all actual maps `MAINTAINED`.

| Target | Index/map result | Changed or inspect-only zone | Direct dependencies and focused evidence | Write class | Disposition |
| --- | --- | --- | --- | --- | --- |
| `lib/app/app.dart` | `docs/code_maps/lib/app/app.dart.md`, `MAINTAINED`, automatic qualification | change root rendering, router construction/navigation/disposal, and splash-root wiring; inspect providers, acquisition, Wizard handoff, theme, exit | router factory, launcher, splash, acquisition actions, Wizard; Home and splash suites | `ZERO_WRITE + UI_LOCAL`, existing observed `PROJECTION_STATE` | `UPDATE_REQUIRED` after accepted committed implementation |
| `test/widget/benchbeep_home_screen_test.dart` | maintained `SCORE 11/12` map | add lifetime identity, Home-return, provider-survival, early-splash/no-replay assertions; all visual/acquisition/exit fixtures otherwise inspect-only | real `TraceBenchApp`, Riverpod container, GoRouter, Wizard, Canvas | test-local `UI_LOCAL`, observes `PROJECTION_STATE` | `UPDATE_REQUIRED` after accepted committed implementation |
| `test/widget/benchbeep_splash_screen_test.dart` | no index/map; live 102 lines, four compact tests, below score threshold and no automatic trigger | add app startup/lifecycle assertions only; splash source remains inspect-only | app/router source guards and `BenchBeepSplashScreen` | test-local `ZERO_WRITE + UI_LOCAL` | `NOT_APPLICABLE` from live source; requalify after committed implementation |
| `lib/app/router.dart` | maintained human-override map | inspect only required `homeBuilder`, initial location, root/Wizard/project graph, aliases, errors | app caller plus five direct caller-test files | `ZERO_WRITE + UI_LOCAL` | `REVIEWED_NO_CHANGE` |
| `test/widget/new_project_wizard_screen_test.dart` | maintained automatic map | inspect only cancellation and handoff/success/route families | Wizard local router harness | test-local `UI_LOCAL`, observes handoff | `REVIEWED_NO_CHANGE` |
| `test/widget/project_gate_test.dart` | maintained `SCORE 7/12` map | inspect only canonical Home recovery, route matrix, aliases, URI retention | production router and ProjectGate | test-local `ZERO_WRITE + UI_LOCAL`, observes projection | `REVIEWED_NO_CHANGE` |

Explicitly excluded zones are every route declaration, destination, error
surface, acquisition body, provider declaration/semantics, Wizard state
machine, ProjectGate behavior, launcher/splash source, Workbench shell, and
canonical/protected writer surface.

The app map will incur `FLOW_DRIFT` and `STRUCTURE_DRIFT`; the Home-test map
will incur `TEST_DRIFT`. The router, Wizard-test, and ProjectGate-test maps
remain materially accurate because their source and mapped responsibilities
do not change. Neither this scope nor the child may edit any map or index row.
After accepted implementation is committed and pushed, separately scoped
committed-source maintenance must refresh required maps and requalify the
splash test. No maintenance PASS_ID is pre-reserved.

## Manual smoke contract

Manual smoke is mandatory after fresh implementation validation and before
independent implementation audit. Run on the normal Windows desktop build:

1. Cold launch with no project. Confirm the unchanged black/gold startup
   identity, meter/copy, 3200 ms duration, launcher behind it, and normal
   launcher after completion. Confirm the splash appears only once.
2. Cold launch again and, before completion, activate `Loo projekt nullist`
   through the pointer-transparent overlay. Confirm `/new-project`, cancel to
   `/`, and confirm the splash does not replay.
3. From the normal launcher, enter the Wizard, cancel untouched, then repeat
   with a dirty draft and confirmed cancellation. Both return to the canonical
   launcher without a second application root or stale overlay.
4. Complete a project creation. Confirm Step 7 remains visible, project name,
   ID, and location are present, no auto-navigation occurs, and only
   `Ava projekt` opens canonical `/project`.
5. From the loaded project, use an existing Home return to `/`. Confirm the
   loaded-project launcher state and continue back to `/project`; project data
   and beginner mode remain unchanged.
6. Exercise bundled sample, ZIP, and directory success. Exercise ZIP/directory
   cancel and one failure. Confirm existing feedback, provider, and route
   behavior.
7. Open a project deep link with null state, use ProjectGate
   `Tagasi avalehele`, and confirm canonical launcher recovery. Then load a
   project and confirm the originally requested destination reveals.
8. Visit representative project children plus both compatibility aliases;
   verify expected back/Home behavior and no duplicate navigator, lost state,
   or route-error surface.
9. Check wide and medium launcher layout and hover/reachability remain
   unchanged.
10. Exercise window-close cancel and confirm exactly one close request.

Record each step `PASS` or stop. The subsequent implementation audit packet
must say `USE ONLY AFTER MANUAL SMOKE PASS` and include the human result.

## Frozen boundaries

The child must not change:

- `lib/app/router.dart`, any route path/name/nesting, either alias, the generic
  error surface, or any direct route-factory caller;
- `projectStateProvider` or `beginnerModeProvider` declarations, defaults,
  assignment/read/watch semantics, or the `ProviderScope` lifetime;
- bundled sample, ZIP, directory, `ProjectLoader`, ProjectGate recovery, New
  Project Wizard creation, exactly-once handoff, Step 7, or explicit success;
- splash source/visuals/timing, launcher source/visuals/responsiveness, theme
  tokens, window/fullscreen/close behavior, or WorkbenchShell;
- Project Overview, `/project/measurements/new`, `/project/board-canvas`,
  Add/Edit/Measure consolidation, capability tiers, Diagnostics/Advanced,
  router-error redesign, dead null-defense cleanup, or any product IA;
- writers, event envelopes, facts, evidence status/lifecycle, freshness,
  `valid_from_event_id`, `valid_until_event_id`, repair/staleness, conflict,
  `not_populated`, `forbidden_ai_actions`, generic fallback, Project ZIP, or
  any protected semantic; or
- maps/index, packages, assets, schemas, tools, samples, generated files,
  `_incoming`, scratch, Windows/EOL residue, or any nonallowlisted byte.

No `sequence` field may be added to V2 events. The child remains navigation-
local and performs no canonical or persistent write.

## Future implementation validation

The child must run fresh:

```text
dart format --output=none --set-exit-if-changed lib/app/app.dart test/widget/benchbeep_home_screen_test.dart test/widget/benchbeep_splash_screen_test.dart
flutter analyze lib/app/app.dart test/widget/benchbeep_home_screen_test.dart test/widget/benchbeep_splash_screen_test.dart
flutter test test/widget/benchbeep_home_screen_test.dart
flutter test test/widget/benchbeep_splash_screen_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart --plain-name "untouched cancellation returns Home without a dialog"
flutter test test/widget/new_project_wizard_screen_test.dart --plain-name "confirmed Katkesta returns Home"
flutter test test/widget/new_project_wizard_screen_test.dart --plain-name "success hands off once, shows returned state, waits, then opens project"
flutter test test/widget/new_project_wizard_screen_test.dart --plain-name "creation and project routing stay inert until activation"
flutter test test/widget/project_gate_test.dart
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch
```

Also prove exactly the three allowed implementation paths have substantive
diffs, staged/unmerged sets are empty, `router.dart` and every other frozen
path have empty content diffs, one router identity survives every automated
transition, and the human manual-smoke record is complete before audit.

## Stop conditions

Stop before or during the child on:

- baseline, branch, divergence, route, or accepted-scope mismatch;
- inability to implement with exactly the three reserved paths;
- need to edit `router.dart`, a route caller, provider, Wizard, ProjectGate,
  launcher/splash source, acquisition owner, destination, package, platform,
  map/index, generated file, or other frozen surface;
- any route-topology, route-name/path, product behavior, product-IA, error-
  surface, back-stack, or second-outcome change;
- provider recreation/loss, Wizard handoff/order change, splash replay/timing/
  pointer drift, acquisition drift, or duplicate router lifecycle;
- an excluded cleanup becoming necessary;
- `BLOCKED_CODE_MAP_REQUIRED`, `BLOCKED_CODE_MAP_STALE`,
  `BLOCKED_CODE_MAP_CONFLICT`, `BLOCKED_ALLOWLIST_MISMATCH`, or
  `DECOMPOSE_REQUIRED`;
- test, analyzer, formatter, doctor, validator, diff-check, or manual-smoke
  failure outside the exact authorized fix surface;
- any unexpected staged/unmerged/frozen content or Windows normalization; or
- any stage, commit, push, stash, reset, restore, clean, delete, or Phase-2
  action without new explicit human authority.

## Phase-1 validation contract

Before independent scope audit, run exactly:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch
```

Also prove:

- exact five-path substantive scope and exactly one new artifact;
- empty cached and unmerged sets;
- matching Current/Next tuples across all three route owners;
- one matching neutral `REVIEW_REQUIRED` ledger row;
- exactly one verdict marker pair with whitespace-only interior;
- no Dart, test, map/index, Windows, or other nonallowlisted content diff; and
- no false audit, acceptance, staging, commit, or push claim for this pass.

## TOOL_SKILL_CHECK

- Relevant skill/tool/helper found: loader-qualified
  `tracebench-scope-lock`; repo inventory and conditional map policy;
  `tracebench-prompt-authoring` for handoff/self-reference shape; Git, `rg`,
  `tools/doctor.py`, and `tools/validate_all.py`.
- Capability actually used: `tracebench-scope-lock` to author current/future
  authority, exact allowlists, route, lifecycle, invariants, manual smoke,
  validation, and stops; prompt-authoring guidance only for the genuine
  post-change audit handoff, not to arm a second implementation prompt.
- Why applicable: this is a docs-only reservation of one exact future
  implementation route materially depending on mapped Dart/test surfaces.
- External tool required: `NO`.

No skill, helper, or map expanded either allowlist. Audit reconciliation is
not applicable because no pushed pass artifact is being reconciled.

## SELF_REFERENCE_AUDIT

- The artifact Status and ledger Status are neutral `REVIEW_REQUIRED`.
- The designated verdict-block interior is empty.
- No touched artifact, ledger, or route owner asserts an audit verdict or
  staging-safety result for this current scope.
- Child activation language is conditional and time-invariant.
- The accepted predecessor is identified by committed evidence; this scope is
  not described as accepted, staged, committed, or pushed.
- Historical route sections are explicitly non-authorizing.

## Independent audit focus

Audit the exact five-file docs diff; live baseline and Windows-residue claim;
one-child/three-path allowlist; complete lifecycle/caller closure; the early-
navigation splash edge; exact router/provider/Wizard/ProjectGate/back-stack
invariants; focused tests; Code Map dispositions; manual smoke; frozen
boundaries; route/ledger agreement; validation evidence; and the single empty
verdict block. Apply `scope-lock-post-audit` from `docs/AUDIT_CONTRACT.md`.

<!-- TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_SINGLE_ROUTER_LIFETIME_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
