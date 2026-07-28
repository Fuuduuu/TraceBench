# Code Map: `lib/app/app.dart`

- Source: `lib/app/app.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`

## File purpose

Owns the application-level providers and the BenchBeep launcher-to-workbench
shell. It loads or opens project data into in-memory projection state, wires
the accepted Home callbacks, controls the startup intro, constructs the active
router, and switches the root application between launcher and router modes.
The accepted source exposes no create-project callback to Home.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Application providers | `projectStateProvider`, `beginnerModeProvider`, `routerProvider` | Owns app-wide in-memory project, beginner-mode, and default-router providers. |
| Root shell state | `_showLauncher`, `_showStartupIntro`, `_workbenchRouter` | Tracks whether the launcher or workbench is visible and owns the disposable workbench router. |
| Bundled sample loading | `_loadBundledProject`, `ProjectLoader.loadFromAssets` | Loads bundled project data and assigns the result to `projectStateProvider` after a mounted check. |
| Existing project acquisition | `_importProjectZip`, `_openProjectDirectory` | Delegates ZIP and directory flows to the existing action owners and opens `/project` only through their success callbacks. |
| Launcher callback wiring | `_buildLauncherHome`, `BenchBeepHomeScreen` | Projects current project availability and supplies the accepted load, open, workbench, and exit callbacks. |
| Startup intro lifecycle | `_completeStartupIntro`, `_buildLauncherShell`, `BenchBeepSplashScreen` | Overlays the non-interactive splash and removes it through guarded local state. |
| Workbench-router transition | `_openWorkbench`, `buildTraceBenchRouter` | Replaces the prior workbench router, forwards an optional initial location, and leaves launcher mode. |
| Root rendering and disposal | `build`, `dispose`, `MaterialApp`, `MaterialApp.router` | Selects launcher or router presentation, applies theme/identity, and disposes the owned router. |

## State and data flow

1. `[D]` `TraceBenchApp` starts with launcher and startup-intro state enabled.
2. `[D]` `build` renders `_buildLauncherShell` until `_showLauncher` becomes
   false; afterward it renders `MaterialApp.router`.
3. `[D]` `_buildLauncherHome` watches `projectStateProvider` and converts
   non-null state to `hasProject` for `BenchBeepHomeScreen`.
4. `[D]` Bundled loading awaits `ProjectLoader.loadFromAssets` and then assigns
   the returned state to `projectStateProvider`.
5. `[D]` ZIP and directory entry points delegate to
   `ProjectZipImportAction` and `ProjectDirectoryOpenAction`; each accepted
   success callback invokes `_openWorkbench(initialLocation: '/project')`.
6. `[D]` Existing-project callbacks either open `/project` through
   `_openWorkbench` or forward the default `_openWorkbench` tear-off.
7. `[D]` `_openWorkbench` disposes the previous router, creates one with the
   supplied initial location and Home builder, then changes only shell-local
   launcher visibility.
8. `[D]` `_completeStartupIntro` performs mounted and one-shot guards before
   changing intro visibility.
9. `[D]` Current `_buildLauncherHome` wiring has no create-project callback.
   Although `_openWorkbench` accepts arbitrary router locations, no accepted
   Home call path supplies `/new-project`.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework and root UI | Supplies application roots, widget lifecycle, layout, and theme integration. |
| Riverpod | inbound/outbound state | Hosts providers, watches project state, and receives loaded project state. |
| GoRouter and `buildTraceBenchRouter` | outbound navigation shell | Construct and own the workbench route graph at a selected initial location. |
| `BenchBeepHomeScreen` | outbound launcher UI | Receives current project availability and all accepted launcher callbacks. |
| `BenchBeepSplashScreen` | outbound intro UI | Reports startup-intro completion through a local callback. |
| `ProjectZipImportAction` | outbound acquisition action | Reads/imports selected ZIP data and reports successful in-memory loading. |
| `ProjectDirectoryOpenAction` | outbound acquisition action | Reads an existing project directory and reports successful in-memory loading. |
| `ProjectLoader` | outbound reader | Loads the bundled project state. |
| `ProjectState` | provider value | Represents current in-memory project state. |
| `windowManager` | outbound application lifecycle | Closes the desktop window from the Home exit callback. |
| `buildTheme` | outbound presentation | Supplies the accepted root theme. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `projectStateProvider` assignment | `PROJECTION_STATE` | Replaces in-memory application state with loader-returned data; this file persists no fact, event, or project file. |
| `beginnerModeProvider` and shell booleans | `UI_LOCAL` | Hold only transient application/UI mode. |
| `_loadBundledProject` | `PROJECTION_STATE` | Reads bundled data through `ProjectLoader` and assigns the returned state. |
| ZIP/directory action delegation | `PROJECTION_STATE` | Inspected action call paths read selected data and assign in-memory state; this file owns no filesystem write. |
| `_completeStartupIntro` | `UI_LOCAL` | Changes only startup overlay visibility. |
| `_openWorkbench` | `UI_LOCAL` + `ZERO_WRITE` | Replaces transient router/shell state and navigates; it does not create or mutate project content. |
| `windowManager.close` callback | `ZERO_WRITE` | Closes the application window without a project, fact, event, schema, or file write in this call path. |
| `build`, `_buildLauncherHome`, `_buildLauncherShell` | `ZERO_WRITE` | Read state and render/wire callbacks only. |

The file contains no canonical event append, fact creation, Project ZIP write,
schema mutation, materializer implementation, project-directory creation, or
direct call to `ProjectCreator.createProject`.

## Zero-write zones

- `[D]` Provider declarations allocate state containers but perform no project
  acquisition or persistence.
- `[D]` Home construction projects `hasProject` and supplies callbacks only.
- `[D]` Router construction and navigation do not persist project content.
- `[D]` Splash rendering and completion are local presentation behavior.
- `[D]` Theme and title selection are presentation-only.
- `[D]` The current absence of a create-project callback means the launcher
  cannot enter `/new-project` through this file's accepted Home wiring.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Providers | `[D]` App-wide state is declared and consumed here. | Loader results, downstream project screens | `PROJECTION_STATE` / `UI_LOCAL` | Home sample, folder, ZIP, and continuation tests |
| Bundled load | `[D]` Loader result is assigned after a mounted check. | `ProjectLoader`, launcher detail state | `PROJECTION_STATE` | Bundled sample handoff |
| ZIP/directory delegation | `[D]` Existing action owners invoke success callbacks. | Picker/loader actions, `/project` route | `PROJECTION_STATE` | Folder cancel/success/error; ZIP cancel/success |
| Home wiring | `[D]` Constructor arguments are the complete launcher contract. | `BenchBeepHomeScreen`, launcher rail, exit dialog | `ZERO_WRITE` | Launcher identity, disabled actions, load parent, exit |
| Intro lifecycle | `[D]` Splash completion changes one guarded boolean. | `BenchBeepSplashScreen`, launcher pointer blocking | `UI_LOCAL` | Full app launcher tests |
| Router transition | `[D]` Initial location and Home builder feed a newly owned router. | Router definitions, project and Home builders | `UI_LOCAL` / `ZERO_WRITE` | Sample/folder/ZIP project routing |
| Root rendering | `[D]` Shell state selects `MaterialApp` or `MaterialApp.router`. | Theme, router disposal, window lifecycle | `ZERO_WRITE` | Launcher and canonical Board Canvas assertions |

## Relevant tests and helpers

Primary focused evidence is
`test/widget/benchbeep_home_screen_test.dart`, especially its
`TraceBenchApp` harnesses for bundled sample loading, directory and ZIP
acquisition, loaded-project continuation, canonical `/project` routing, and
exit behavior. Downstream widget and integration suites also consume
`projectStateProvider`, but they do not all exercise this launcher's wiring.

Inspect-only call-path owners are `lib/app/router.dart` and
`lib/features/project/screens/home_screen.dart`.

## Dangerous combinations

- `[D]` Changing provider assignment and success routing together can expose a
  destination before project state is available.
- `[D]` Changing router replacement, disposal, and root rendering together can
  leak routers or strand launcher state.
- `[D]` Changing Home constructor callbacks and Home action availability
  together can silently disconnect or enable a route.
- `[D]` Changing ZIP/directory action ownership together with this coordinator
  can duplicate state assignment or navigation.
- `[D]` Treating `_openWorkbench(initialLocation: ...)` as proof that a Home
  action exists would misdescribe current accepted behavior.
- `[D]` Adding creator or persistence behavior here would cross the explicit
  zero-write boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Startup intro only: `_completeStartupIntro` and `_buildLauncherShell`; exclude
  project state and router creation.
- Bundled sample handoff only: `_loadBundledProject` and its Home callback;
  exclude ZIP/directory actions.
- Existing-project router transition only: `_openWorkbench`, disposal, and
  `/project` focused tests; exclude acquisition behavior.
- One Home callback contract change: `_buildLauncherHome` plus the matching
  Home constructor and focused test seam; inspect router coupling and exclude
  project creation/persistence.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Project acquisition callbacks may be separable from root shell state.
- `[S]` Workbench router ownership may be separable if disposal and Home
  rebuilding remain explicit.
- `[S]` Startup intro state may be isolated from launcher/workbench selection.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when providers, shell fields, callbacks, or router
anchors change; `FLOW_DRIFT` when project acquisition, provider assignment,
initial-location forwarding, or root selection changes; `BOUNDARY_DRIFT` when
project creation or persistent writes enter this file; `TEST_DRIFT` when Home
handoff or route assertions change; and `STRUCTURE_DRIFT` when launcher,
router, or acquisition ownership moves.

## Known uncertainty

- `[D]` Focused Home tests do not directly exercise startup-intro completion
  timing or router disposal.
- `[D]` The default `routerProvider` is declared here but the launcher creates
  its workbench router directly.
- `[D]` `beginnerModeProvider` consumers outside this file are not enumerated
  by the focused Home suite.
- `[D]` A separately authorized future slice proposes a Home create callback
  that calls `_openWorkbench(initialLocation: '/new-project')`; it is absent
  from accepted source and would require map review after accepted code changes.
