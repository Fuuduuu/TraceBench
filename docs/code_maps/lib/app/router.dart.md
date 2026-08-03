# Code Map: `lib/app/router.dart`

- Source: `lib/app/router.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `HUMAN OVERRIDE — creation handoff crosses router, screen and provider boundaries and requires durable impact analysis.`
- Audit evidence: `none`

## File purpose

Builds the application route graph used by the launcher/workbench shell. It
selects the initial location, optionally substitutes the root Home builder,
constructs the current zero-write New Project Wizard route, exposes Board
Canvas at canonical `/project`, nests the accepted project tools, preserves two
compatibility redirects, and renders a generic routing error surface. It does
not currently own project state, project creation, persistence, or a provider
handoff.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Route factory contract | `buildTraceBenchRouter`, `initialLocation`, `homeBuilder` | Exposes the router-construction seam, caller-selected initial URI, and optional root-Home override. |
| Root Home route | `path: '/'`, `name: 'home'`, `HomeScreen` | Builds the default Home destination or delegates it to the supplied builder. |
| New Project Wizard route | `path: 'new-project'`, `name: 'new-project'`, `NewProjectWizardScreen` | Builds the current const Wizard below Home with no creator, project-state, or completion callback. |
| Canonical Board Canvas route | `path: 'project'`, `name: 'board-canvas'`, `BoardCanvasScreen` | Makes `/project` the canonical Board Canvas destination and parent of project tools. |
| Project overview and component routes | `project-overview`, `component-list`, `add-component`, `edit-component` | Exposes the accepted overview, component-list, add, and edit destinations below `/project`. |
| Measurement and evidence routes | `measurement-list`, `measure-sheet`, `not-populated`, `pin-list`, `events`, `known-facts` | Exposes measurement, pin, event, known-fact, and not-populated read/write screens without implementing their behavior. |
| Visual and report routes | `board-graph`, `photos`, `reference-images`, `customer-report` | Exposes graph, photo, reference-image, and report destinations below `/project`. |
| Compatibility redirects and error surface | `measurements/new`, `board-canvas`, `redirect`, `errorBuilder` | Redirects retained legacy child paths and renders an error string when route resolution fails. |

## State and data flow

1. `[D]` A caller invokes `buildTraceBenchRouter`, optionally choosing
   `initialLocation` and `homeBuilder`.
2. `[D]` `GoRouter` consumes that initial location and the static route tree;
   the factory retains no mutable router or project state.
3. `[D]` `/` builds the injected Home widget when supplied, otherwise the
   default `HomeScreen`.
4. `[D]` `/new-project` builds a const `NewProjectWizardScreen`. No request,
   provider, project state, or write-capable collaborator crosses that route
   today.
5. `[D]` `/project` builds `BoardCanvasScreen` and owns the nested URI
   namespace for the accepted project screens.
6. `[D]` `/project/measurements/new` redirects to
   `/project/measure-sheet`; `/project/board-canvas` redirects to `/project`.
7. `[D]` Every other leaf builder instantiates one screen and delegates all
   domain reads, UI state, or writes to that screen and its dependencies.
8. `[D]` Failed resolution produces a `Scaffold` containing the router error
   text or `Unknown route`; it does not change application or project state.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework UI | Supplies `WidgetBuilder`, `Scaffold`, `Center`, and `Text` for route construction and errors. |
| GoRouter | routing framework | Owns path matching, names, nested routes, redirects, navigation state, and error delivery. |
| `HomeScreen` | outbound destination | Default root screen when no caller-provided Home builder exists. |
| `NewProjectWizardScreen` | outbound destination | Current zero-write project-draft workflow at `/new-project`. |
| `BoardCanvasScreen` | outbound destination | Canonical `/project` workbench and nested-project parent. |
| Project overview/component/measurement/evidence screens | outbound destinations | Implement the domain behavior behind their registered URIs. |
| Graph/photo/reference/report screens | outbound destinations | Implement visual, reference, and report behavior behind their registered URIs. |
| `lib/app/app.dart` | inbound caller | Constructs the default router and launcher-owned workbench routers with selected initial locations and a Home override. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `buildTraceBenchRouter` and route declarations | `ZERO_WRITE` | Construct navigation objects and widget builders only. |
| `initialLocation` | `UI_LOCAL` | Selects transient router presentation; it does not load or persist project data. |
| `homeBuilder` | `ZERO_WRITE` | Delegates widget construction; side effects, if any, belong to the supplied builder. |
| New Project Wizard builder | `ZERO_WRITE` | Instantiates the current const screen without project creation or provider assignment. |
| `/project` and nested builders | `ZERO_WRITE` | Instantiate destinations; downstream screens own their own state/read/write paths. |
| Compatibility redirects | `UI_LOCAL` | Replace only the current URI. |
| `errorBuilder` | `ZERO_WRITE` | Presents route failure text only. |

This file contains no event/fact append, writer invocation, materializer,
projection mutation, Project ZIP operation, directory or file write, project
creation request, provider assignment, AI/OCR/CV path, or canonical coordinate
conversion.

## Zero-write zones

- `[D]` Imports and route-name/path constants describe destinations only.
- `[D]` Root and leaf builders instantiate widgets without domain mutation.
- `[D]` The current Wizard route passes no state or write callback.
- `[D]` The Board Canvas route performs no loading or placement operation in
  the router.
- `[D]` Redirect callbacks return URI strings only.
- `[D]` Error presentation reads the router error and renders text.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Factory parameters | `[D]` Both parameters feed `GoRouter` or the root builder. | `lib/app/app.dart`, test harnesses constructing routers | `ZERO_WRITE`; `UI_LOCAL` initial URI | Home launcher route tests; Board Canvas route tests |
| Root Home route | `[D]` Optional builder controls the root destination. | launcher shell and `HomeScreen` callbacks | `ZERO_WRITE` | Home launcher and continuation tests |
| New Project Wizard route | `[D]` Current builder is const and callback-free. | app launcher handoff and Wizard cancellation/navigation | `ZERO_WRITE` | `benchbeep_home_screen_test.dart`; `new_project_wizard_screen_test.dart` |
| Canonical Board Canvas route | `[D]` `/project` owns the named destination and child tree. | app project-state handoff, Canvas provider consumers | `ZERO_WRITE` | canonical `/project` and redirect tests in `board_canvas_screen_test.dart` |
| Project child tree | `[D]` Stable paths/names bind screen destinations. | each destination screen and any deep links | `ZERO_WRITE` | project overview, Board Canvas, and integration route suites |
| Measurement redirects | `[D]` Exact redirect strings retain compatibility. | measure-sheet and overview navigation | `UI_LOCAL` | project overview compatibility-route tests |
| Board Canvas redirect | `[D]` Legacy child URI resolves once to `/project`. | canonical Board Canvas route | `UI_LOCAL` | Board Canvas redirect test |
| Error surface | `[D]` `errorBuilder` renders `state.error`. | GoRouter error semantics | `ZERO_WRITE` | no focused route-error test identified |

## Relevant tests and helpers

Primary direct and integration evidence:

- `test/widget/benchbeep_home_screen_test.dart` exercises the real
  `TraceBenchApp` launcher transition to `/new-project`, the existing project
  transition to `/project`, and the current null project-state Wizard entry.
- `test/widget/new_project_wizard_screen_test.dart` supplies an isolated router
  for `/new-project` and `/`, then proves cancellation and the current final
  zero-write boundary.
- `test/widget/board_canvas_screen_test.dart` uses
  `buildTraceBenchRouter`, proves named `/project`, the legacy
  `/project/board-canvas` redirect, and several nested route targets.
- `test/widget/project_overview_screen_test.dart` proves the retained overview,
  measure-sheet, and legacy measurement redirect paths.
- Integration suites enter selected nested project routes through the same
  factory.

No dedicated `router_test.dart` exists; route behavior is distributed across
the destination-focused suites above.

## Dangerous combinations

- `[D]` Changing `initialLocation`, app router replacement, and provider
  readiness together can reveal a project destination before state exists.
- `[D]` Changing the Wizard builder together with launcher wiring can duplicate
  or lose a state handoff across app, router, and screen ownership.
- `[D]` Changing `/project`, its route name, and compatibility redirects
  together can split canonical and legacy Canvas destinations.
- `[D]` Changing nested path strings together with screen navigation calls can
  produce deep-link-only regressions outside the immediately edited screen.
- `[D]` Adding a write-capable callback to a route builder without tracing its
  caller and lifecycle can turn navigation into a repeated or premature write
  path.
- `[P]` Capturing provider-owned state inside long-lived route closures can
  create stale ownership if router disposal/replacement is not inspected.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- One leaf path/name/builder only, with the destination's focused route test;
  exclude parent paths and redirects.
- One compatibility redirect only, with canonical target and deep-link tests;
  exclude destination behavior.
- Root `homeBuilder` selection only, coupled to app router construction and
  Home continuation tests.
- Error presentation only, excluding every route declaration and downstream
  screen.

A New Project Wizard state handoff is not a router-only slice: app provider
ownership, Wizard callback lifecycle, duplicate-call prevention, and both
launcher/Wizard integration suites must be inspected together.

## Future extraction seams

Descriptive, non-authorizing possibilities:

- `[S]` Route path/name constants could be centralized if every direct string
  caller and compatibility redirect were proven together.
- `[S]` Project-child route construction could become a private helper if
  parent URI semantics and route names remain unchanged.
- `[S]` Error presentation could be isolated without affecting route state.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when the factory, parameter, path, route-name,
screen, redirect, or builder anchors change; `FLOW_DRIFT` when state or
callbacks cross a route boundary; `BOUNDARY_DRIFT` when project creation,
provider assignment, persistence, or canonical behavior enters this file;
`TEST_DRIFT` when distributed route coverage changes; and `STRUCTURE_DRIFT`
when destinations move between root and project subtrees.

Any change to the New Project Wizard builder, app/router state handoff,
canonical `/project` ownership, or compatibility redirects requires renewed
source/test comparison before this map can be considered current.

## Known uncertainty

- `[D]` No focused route-error test was identified.
- `[D]` Route tests are distributed across large destination suites rather
  than one cohesive router suite.
- `[D]` The current factory does not receive `WidgetRef`, `ProjectState`, or a
  creation callback, so future ownership cannot be inferred from this map.
- `[P]` Some nested destination tests may rely on route names or direct paths
  without importing this file through the same harness.
- `[D]` Downstream screen write behavior is outside this map; a registered
  destination does not make the router the owner of that behavior.
