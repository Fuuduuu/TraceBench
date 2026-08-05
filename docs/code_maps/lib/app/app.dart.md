# Code Map: `lib/app/app.dart`

- Source: `lib/app/app.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS.md`

## File purpose

Owns application-level providers and the BenchBeep launcher/workbench shell.
It loads existing projects, constructs and disposes the active router, injects
project creation into the New Project Wizard, and accepts the successful
hydrated `ProjectState` into the app-owned provider before the Wizard exposes
its explicit Board Canvas transition.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Application providers | `projectStateProvider`, `beginnerModeProvider`, `routerProvider` | Owns app-wide in-memory project state, beginner mode, and the default router provider. |
| Root injection contract | `TraceBenchApp`, `createProject` | Exposes an optional project-creation seam while retaining the default creator path in the Wizard. |
| Existing-project acquisition | `_loadBundledProject`, `_importProjectZip`, `_openProjectDirectory`, `ProjectLoader.loadFromAssets` | Coordinates bundled, ZIP, and directory reads and their projection-state handoffs. |
| Launcher callback wiring | `_buildLauncherHome`, `BenchBeepHomeScreen`, `onCreateProject`, `onOpenProject` | Projects project availability and supplies launcher transitions without creating project data itself. |
| Startup intro lifecycle | `_completeStartupIntro`, `_buildLauncherShell`, `BenchBeepSplashScreen` | Owns the guarded startup overlay and its local completion state. |
| Workbench-router transition | `_openWorkbench`, `_buildWorkbenchRouter`, `buildTraceBenchRouter`, `initialLocation` | Replaces the prior router, selects its initial route, and switches out of launcher mode. |
| Wizard injection and handoff | `newProjectBuilder`, `NewProjectWizardScreen`, `onProjectCreated`, `projectStateProvider.notifier` | Injects creation and assigns the successful hydrated state through the app-owned provider callback. |
| Root rendering and disposal | `build`, `dispose`, `_workbenchRouter`, `MaterialApp.router` | Selects launcher or routed workbench presentation and disposes the owned router. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. The resulting inventory has 28 unique
anchors.

- Literal source symbols/strings: 25. Each must resolve as an exact substring
  in the mapped source.
- Qualified source expressions: 3 —
  `ProjectLoader.loadFromAssets`, `projectStateProvider.notifier`, and
  `MaterialApp.router`. Each must resolve as the exact owner/member expression.
- Exact test-name references: 0.

## State and data flow

1. `TraceBenchApp` begins in launcher mode and optionally receives a creation
   function for dependency-controlled execution.
2. Bundled, ZIP, and directory paths load a `ProjectState` and assign it to
   `projectStateProvider` before opening or enabling project presentation.
3. The launcher create action calls
   `_openWorkbench(initialLocation: '/new-project')`.
4. `_buildWorkbenchRouter` passes the optional creation function into
   `NewProjectWizardScreen` and supplies `onProjectCreated`.
5. The Wizard's own success latch invokes that callback once; the callback
   synchronously assigns the returned hydrated state to
   `projectStateProvider`.
6. The Wizard remains on its terminal success step until its explicit
   navigation action changes the route to `/project`.
7. Re-entering workbench construction disposes the previously owned router
   before replacing it.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework/root UI | Supplies application roots, widget lifecycle, overlay layout, and theme presentation. |
| Riverpod | state owner | Hosts the app-owned project and beginner-mode providers. |
| GoRouter and `buildTraceBenchRouter` | navigation shell | Construct the workbench route graph and selected initial destination. |
| `BenchBeepHomeScreen` | outbound launcher | Receives current project availability and launcher callbacks. |
| `NewProjectWizardScreen` | outbound creation UI | Receives creation and successful-state handoff seams. |
| `ProjectCreator` result/request types | injected contract | Types the optional application-level creation dependency. |
| `ProjectLoader` and existing acquisition actions | outbound readers | Load bundled, ZIP, or directory-backed project state. |
| `windowManager` | outbound lifecycle | Closes the desktop application from the launcher callback. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Existing-project provider assignment | `PROJECTION_STATE` | Assigns loader-returned state in memory; this file writes no project file. |
| Wizard `onProjectCreated` callback | `PROJECTION_STATE` | Assigns only the already-created, hydrated state; persistent writes belong to `ProjectCreator`. |
| `createProject` injection | `ZERO_WRITE` | Passes a callable to the Wizard; this shell does not invoke it directly. |
| Launcher and router fields | `UI_LOCAL` | Mutate transient launcher, splash, and router ownership state. |
| Route transitions | `UI_LOCAL` | Select `/new-project` or `/project` without canonical mutation. |
| Rendering and disposal | `ZERO_WRITE` | Build widgets and release router resources only. |

The app shell contains no event append, fact creation, materializer,
Project ZIP writer, canonical component/placement/measurement write, or
electrical-semantic conversion. The one persistent creation call is owned
downstream by the Wizard and `ProjectCreator`.

## Zero-write zones

- Provider declarations allocate in-memory containers.
- Launcher construction projects `hasProject` and wires callbacks.
- Router creation, route selection, splash rendering, theme selection, and
  router disposal do not persist project data.
- The app callback does not inspect Wizard drafts or creation-result raw
  diagnostics.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Providers | [D] Declarations and assignments are local. | loader results and provider consumers | `PROJECTION_STATE` | bundled/folder/ZIP handoff tests |
| Launcher callbacks | [D] Constructor arguments are explicit. | Home action availability and router entry | `ZERO_WRITE` / `UI_LOCAL` | Home action and route tests |
| Router transition | [D] Router is replaced before launcher state flips. | router factory and disposal | `UI_LOCAL` | launcher-to-Wizard and project routes |
| Wizard injection | [D] Builder passes both dependencies. | Wizard creation state machine and `ProjectCreator` | `ZERO_WRITE` | injected creation test |
| Success handoff | [D] Callback assigns provider state. | terminal Wizard step and Board Canvas readers | `PROJECTION_STATE` | provider-before-open test |
| Existing acquisition | [D] Action owners return loaded state. | Project ZIP/directory loaders | `PROJECTION_STATE` | bundled, folder, and ZIP regressions |
| Root lifecycle | [D] `build` selects one root mode. | splash, theme, workbench router | `ZERO_WRITE` / `UI_LOCAL` | responsive launcher and exit tests |

## Relevant tests and helpers

Primary focused evidence is
`test/widget/benchbeep_home_screen_test.dart`. It covers launcher activation,
injected creation, provider handoff before explicit Canvas open, inert
pre-activation behavior, existing-project acquisition, responsive layout, and
router destinations. `test/widget/new_project_wizard_screen_test.dart` owns
the complementary exactly-once Wizard latch and terminal-step behavior.

## Dangerous combinations

- Changing `onProjectCreated` assignment and success navigation together can
  expose `/project` before provider state is ready.
- Changing router replacement and disposal together can leak or reuse stale
  router state.
- Moving creation into the launcher shell would duplicate Wizard ownership and
  blur persistent-write attribution.
- Combining existing-project action changes with creation handoff changes can
  conflate read/import and generated-project flows.

## Safe SNIPER slices

- Startup overlay only: `_completeStartupIntro` and
  `_buildLauncherShell`.
- Existing-project acquisition only: one action callback plus its focused
  handoff tests.
- Wizard dependency injection only: `_buildWorkbenchRouter` and focused
  injection tests, preserving provider-before-route ordering.
- Root router lifecycle only: `_openWorkbench`, `dispose`, and route tests.

## Future extraction seams

- [S] Existing-project acquisition callbacks could move behind one coordinator.
- [S] Router lifecycle could be isolated if launcher rebuilding and disposal
  remain explicit.
- [S] The Wizard success callback could become a named method if the handoff
  contract grows.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when provider, router, injection, or handoff anchors
change; `FLOW_DRIFT` when provider assignment or navigation ordering changes;
`BOUNDARY_DRIFT` when this file begins persistent creation or canonical
writes; `TEST_DRIFT` when handoff/route assertions move; and
`STRUCTURE_DRIFT` when launcher and workbench ownership separate.

## Known uncertainty

- [D] The Wizard, not this file, owns the exactly-once latch; this map records
  the app callback boundary but does not claim independent app-side counting.
- [D] Startup-intro timing and router disposal have less focused coverage than
  creation handoff.
- [P] Consumers of `beginnerModeProvider` outside this file are not enumerated
  by the creation-focused test suite.
