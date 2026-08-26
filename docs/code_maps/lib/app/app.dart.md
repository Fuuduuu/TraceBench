# Code Map: `lib/app/app.dart`

- Source: `lib/app/app.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the single lifetime BenchBeep navigation shell and the app-level adapters
that install newly loaded or created projects into `ProjectSession`. One state
object creates one `GoRouter`, supplies the canonical launcher at `/`, renders
one `MaterialApp.router`, moves launcher actions through that existing router,
and disposes the router once. The same state object retains startup-intro
presentation, existing-project acquisition callbacks, and generation-guarded
bundled/Wizard project opening; provider declarations live under
`shared/session`.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Root injection contract | `TraceBenchApp`, `createProject` | Exposes the optional project-creation seam while retaining the Wizard's default creator path. |
| Session dependency and guarded bundled open | `projectStateProvider`, `projectSession`, `_loadBundledProject`, `ProjectLoader.loadFromAssets`, `generation`, `openProject` | Captures the active generation before the bundled read and installs its result only when that generation is still current. |
| Existing-project acquisition | `_importProjectZip`, `_openProjectDirectory`, `ProjectZipImportAction.importZip`, `ProjectDirectoryOpenAction.openDirectory` | Delegates ZIP/directory picker, load, generation guard, session handoff, feedback, and success behavior to the neutral acquisition owner. |
| Launcher callback wiring | `_buildLauncherHome`, `BenchBeepHomeScreen`, `onCreateProject`, `onOpenProject`, `onOpenWorkbench` | Projects project availability and connects launcher actions to acquisition or routed workbench entry. |
| Startup-intro lifecycle | `_showStartupIntro`, `_completeStartupIntro`, `_buildLauncherShell`, `ValueNotifier`, `ValueListenableBuilder`, `Stack`, `IgnorePointer`, `BenchBeepSplashScreen` | Keeps the 3200 ms splash as pointer-transparent launcher state and latches completion without rebuilding the app root. |
| Lifetime router ownership | `_router`, `initState`, `_buildWorkbenchRouter`, `buildTraceBenchRouter`, `initialLocation`, `homeBuilder` | Creates one router during state initialization at canonical `/` and supplies `_buildLauncherShell` as its root builder. |
| Existing-router navigation | `_openWorkbench`, `_router.go` | Latches the intro complete and navigates the owned router to `/new-project` or `/project` without replacement, push, or interim disposal. |
| Wizard creation adapter | `_createProject`, `ProjectCreationSuccess`, `ProjectCreationFailed`, `newProjectBuilder`, `NewProjectWizardScreen` | Wraps the injected/default creator, generation-guards successful session opening, and converts a stale success into sanitized Wizard-visible failure without changing the Wizard contract. |
| Root rendering and disposal | `build`, `MaterialApp.router`, `routerConfig`, `dispose`, `_router.dispose`, `_showStartupIntro.dispose` | Renders one routed application root for the state lifetime and releases the router and intro notifier once. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every literal token resolves in the
mapped source. Qualified tokens resolve as exact owner/member expressions; the
map uses no line-number anchors.

## State and data flow

1. `_TraceBenchAppState.initState` constructs `_router` exactly once through
   `_buildWorkbenchRouter` with `initialLocation: '/'`.
2. The router's required `homeBuilder` points to `_buildLauncherShell`, so `/`
   renders the canonical launcher inside the same routed app used by every
   workbench destination.
3. `_showStartupIntro` begins true. `ValueListenableBuilder` overlays
   `BenchBeepSplashScreen` in an `IgnorePointer` `Stack`; normal completion
   flips only the notifier and reveals the already-built launcher child.
4. Launcher creation and continuation callbacks call `_openWorkbench`; that
   method latches intro completion and calls `_router.go(initialLocation)`.
5. Returning to `/` reuses the same router, app state, and `ProviderScope`; the
   intro remains completed. Project-session clearing on the Workbench Home
   action belongs to `WorkbenchShell`, while beginner mode remains separate.
6. Bundled acquisition captures `ProjectSession.generation` before loading and
   calls `openProject` only after the await. ZIP and directory callbacks
   delegate the same guarded handoff to neutral acquisition actions.
7. `_createProject` captures the generation, awaits the injected/default
   creator, and opens a successful hydrated state only if mounted and current.
   A stale success becomes `ProjectCreationFailed`; an accepted success remains
   visible on Wizard Step 7 until its explicit `/project` action.
8. State disposal releases `_router` and `_showStartupIntro` once, then calls
   `super.dispose()`.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework/root UI | Supplies application root, lifecycle widgets, overlay layout, notifier listening, and theme presentation. |
| Riverpod | dependency access | Reads the shared ProjectSession provider while its declaration and state ownership stay outside this file. |
| `ProjectSession` / `projectStateProvider` | shared session owner | Supplies generation, guarded open, and current loaded-state reads to app adapters and launcher availability. |
| GoRouter and `buildTraceBenchRouter` | navigation shell | Own one route graph whose root and workbench destinations share a lifetime. |
| `BenchBeepHomeScreen` | outbound launcher | Receives current project availability and launcher callbacks. |
| `BenchBeepSplashScreen` | outbound startup presentation | Reports timed completion while remaining presentation-only. |
| `NewProjectWizardScreen` | outbound creation UI | Receives the generation-guarded creation adapter through its unchanged creation seam. |
| `ProjectCreator` result/request types | injected/default contract | Type and execute the optional/default creation dependency before guarded session installation. |
| `ProjectLoader` | outbound reader | Loads the bundled sample directly in this file. |
| `ProjectZipImportAction`, `ProjectDirectoryOpenAction` | outbound acquisition owner | Own picker, ZIP/directory loading, state assignment, feedback, and callback/default navigation behavior. |
| `windowManager` | outbound lifecycle | Closes the desktop application from the launcher callback. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Bundled-project guarded open | `PROJECTION_STATE` | Calls `ProjectSession.openProject` with a captured generation after asset loading; stale completion mutates nothing. |
| ZIP/directory action delegation | observed `PROJECTION_STATE` | Neutral actions own their guarded session installation before callback/default navigation. |
| `_createProject` | `NONCANONICAL_FILE` boundary invoked + `PROJECTION_STATE` | Invokes the existing creator, then installs only a generation-valid success; persistent creation remains `ProjectCreator`-owned. |
| Intro notifier and router ownership | `UI_LOCAL` | Mutate transient startup and navigation state without canonical data mutation. |
| Route transitions | `UI_LOCAL` | `go` selects `/new-project` or `/project` on the existing router. |
| Root rendering and disposal | `ZERO_WRITE` | Build widgets and release UI/navigation resources only. |

The app shell contains no event append, fact creation, materializer, Project
ZIP writer, canonical component/placement/measurement write, or electrical-
semantic conversion. Persistent creation remains owned downstream by the
Wizard and `ProjectCreator`.

## Zero-write zones

- Provider reads and generation checks do not persist project data.
- Router construction, root selection, splash rendering, theme selection,
  navigation, and disposal persist no project data.
- The app callback does not inspect Wizard drafts or creation-result raw
  diagnostics.
- App-owned route changes do not themselves clear session state; the explicit
  Workbench Home control separately owns `closeProject`.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Session adapters | [D] Bundled and Wizard flows capture generation and use shared session operations. | `ProjectSession`, acquisition actions, Wizard result contract | `PROJECTION_STATE` / invoked `NONCANONICAL_FILE` | stale bundled/Wizard and successful handoff tests |
| Launcher callbacks | [D] Constructor arguments are explicit. | Home action availability and route entry | `ZERO_WRITE` / `UI_LOCAL` | action, route, acquisition, and exit tests |
| Startup intro | [D] One notifier drives one overlay builder. | splash timer/presentation and early pointer-through entry | `UI_LOCAL` | normal completion, early transition, and no-replay tests |
| Router lifetime | [D] One `late final` field is assigned in `initState` and disposed in `dispose`. | router factory, app root, and State lifetime | `UI_LOCAL` | identity plus construction/disposal source guards |
| Navigation | [D] `_openWorkbench` calls `_router.go`. | Wizard cancel, Home recovery, aliases, and back semantics | `UI_LOCAL` | Wizard/Home/project round trips and ProjectGate suite |
| Wizard handoff | [D] Builder passes `_createProject`; the adapter opens only generation-valid successes. | Wizard success latch, creator, and Canvas readers | `NONCANONICAL_FILE` boundary invoked + `PROJECTION_STATE` | successful and stale Wizard tests |
| Existing acquisition | [D] Neutral actions retain load, guarded open, and callback/default routing ownership. | Project ZIP/directory loaders and session generation | observed `PROJECTION_STATE` | bundled, stale folder, and stale/success ZIP regressions |
| Root rendering | [D] Every build returns `MaterialApp.router` with `_router`. | theme and all route destinations | `ZERO_WRITE` | launcher, splash, and routed-screen tests |

## Relevant tests and helpers

- `test/widget/benchbeep_home_screen_test.dart` provides 25 launcher,
  creation, router-identity, guarded Wizard/bundled/directory/ZIP acquisition,
  explicit Home close, beginner-mode survival, responsive, hover,
  legacy-absence, and exit tests.
- `test/widget/benchbeep_splash_screen_test.dart` provides six focused tests
  for splash identity/timing, normal app completion, early pointer-through
  transition, no replay, one-router source shape, and presentation-only scope.
- `test/widget/new_project_wizard_screen_test.dart` owns the complementary
  cancellation, exactly-once handoff, persistent Step 7, and explicit route.
- `test/widget/project_gate_test.dart` owns canonical Home recovery, all 15
  gated destinations, both aliases, original-URI retention, and zero-write
  reveal.

## Dangerous combinations

- Changing router initialization and disposal together can introduce a second
  construction, premature disposal, or a leaked router.
- Changing `_openWorkbench`, root construction, and Wizard navigation together
  can obscure `go` versus `push` and provider-before-route ordering.
- Resetting `_showStartupIntro` while changing Home return can replay the
  startup overlay or detach it from the canonical launcher.
- Reintroducing provider declarations or compatibility exports here would
  reverse the shared-session dependency direction and split ownership.
- Omitting a captured generation from either awaited open path can let stale
  bundled or Wizard results overwrite a newer session.
- Combining acquisition callbacks with creation handoff can blur read/import
  and generated-project ownership.

## Safe SNIPER slices

- Router lifetime only: `_router`, `initState`, `_buildWorkbenchRouter`,
  `build`, `dispose`, and focused identity/source guards.
- Startup overlay only: `_showStartupIntro`, `_completeStartupIntro`,
  `_buildLauncherShell`, and the splash suite.
- Existing-router entry only: `_openWorkbench`, one launcher action, and its
  route/identity assertions.
- Wizard adapter only: `_createProject`, `newProjectBuilder`, and successful/
  stale provider-before-route evidence.
- Existing-project acquisition only: one action callback plus its handoff
  tests.

## Future extraction seams

- [D] Existing-project acquisition behavior remains behind the neutral
  `project_acquisition_actions.dart` owner.
- [D] The Wizard success adapter is already the named `_createProject` method;
  persistent creation and the Wizard latch remain separate owners.
- [S] Router construction could receive a focused factory seam only if the
  one-instance State ownership remains explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when session, generation, router, injection, or
handoff anchors change; `FLOW_DRIFT` when startup, guarded session opening,
navigation, or disposal ordering changes; `BOUNDARY_DRIFT` when persistent
creation or canonical writes enter; `TEST_DRIFT` when lifecycle/round-trip
assertions move; and `STRUCTURE_DRIFT` when launcher and workbench stop sharing
one routed root.

## Known uncertainty

- [D] The Wizard owns the exactly-once latch; this file owns only the guarded
  creation adapter and its sanitized stale-success result.
- [D] Construction/disposal cardinality is source-guarded; runtime tests prove
  stable identity and clean unmount rather than instrumenting GoRouter itself.
- [P] Consumers of `beginnerModeProvider` outside this file are not enumerated
  by the focused launcher suite.
