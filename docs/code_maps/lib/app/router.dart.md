# Code Map: `lib/app/router.dart`

- Source: `lib/app/router.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `HUMAN OVERRIDE — creation handoff crosses router, screen and provider boundaries and requires durable impact analysis.`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS.md`

## File purpose

Builds the application route graph. It accepts optional root-Home and New
Project Wizard builders, preserves the default Wizard construction when no
builder is supplied, exposes `/new-project` and canonical `/project`, nests
the established project tools, retains compatibility redirects, and renders a
generic route-error surface. It owns navigation only: Riverpod,
`ProjectState`, creation execution, and provider assignment remain outside.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Route factory contract | `buildTraceBenchRouter`, `initialLocation`, `homeBuilder`, `newProjectBuilder` | Exposes initial-route and optional widget-construction seams. |
| Root Home route | `path: '/'`, `name: 'home'`, `HomeScreen` | Builds the injected Home when supplied or the unchanged default Home. |
| New Project Wizard route | `path: 'new-project'`, `name: 'new-project'`, `NewProjectWizardScreen` | Builds the injected Wizard when supplied or the unchanged const default Wizard. |
| Canonical Board Canvas route | `path: 'project'`, `name: 'board-canvas'`, `BoardCanvasScreen` | Makes `/project` the canonical Canvas destination and parent namespace. |
| Overview and component routes | `project-overview`, `component-list`, `add-component`, `edit-component` | Registers overview, component-list, add, and edit destinations. |
| Measurement and pin routes | `measurement-list`, `measure-sheet`, `not-populated`, `pin-list` | Registers accepted measurement, population, and pin destinations. |
| Evidence, graph, and report routes | `events`, `known-facts`, `board-graph`, `customer-report` | Registers evidence-reading, graph, and report destinations. |
| Redirects and error surface | `measurements/new`, `board-canvas`, `redirect`, `errorBuilder`, `Unknown route` | Retains compatibility URI redirects and renders unresolved-route errors. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. The table yields 30 unique anchors.

- Literal source symbols/strings: 30; each must resolve as an exact substring
  in the mapped source.
- Qualified member references: 0.
- Exact test-name references: 0.

## State and data flow

1. A caller invokes `buildTraceBenchRouter` with an initial URI and optional
   Home/Wizard builders.
2. `GoRouter` consumes the static tree; this factory retains no mutable
   project or provider state.
3. `/` delegates to `homeBuilder` when supplied, otherwise to
   `const HomeScreen()`.
4. `/new-project` delegates to `newProjectBuilder` when supplied, otherwise
   to `const NewProjectWizardScreen()`.
5. The injected builder may close over app-owned dependencies, but none enter
   the router's type surface as Riverpod or `ProjectState`.
6. `/project` constructs `BoardCanvasScreen` and owns the nested project URI
   namespace.
7. Compatibility paths return replacement URI strings; unresolved routes
   render error text.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework UI | Supplies widget-builder types and the error surface. |
| GoRouter | routing framework | Owns matching, nesting, redirects, route state, and errors. |
| `HomeScreen` | default outbound destination | Preserves default root construction. |
| `NewProjectWizardScreen` | default outbound destination | Preserves default Wizard construction at `/new-project`. |
| `BoardCanvasScreen` | outbound destination | Owns canonical `/project` presentation. |
| Project tool screens | outbound destinations | Implement behavior behind nested URIs. |
| `lib/app/app.dart` | inbound caller | Supplies launcher Home and injected Wizard builders. |
| Widget-test router harnesses | inbound callers | Build real route graphs for Home, Wizard, Canvas, and edit-screen tests. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `buildTraceBenchRouter` and route declarations | `ZERO_WRITE` | Construct navigation objects and widget builders only. |
| `initialLocation` and redirects | `UI_LOCAL` | Select transient URI presentation. |
| `homeBuilder` and `newProjectBuilder` | `ZERO_WRITE` | Invoke widget factories; downstream widgets own any effects. |
| Destination builders | `ZERO_WRITE` | Instantiate screens without performing their domain operations. |
| `errorBuilder` | `ZERO_WRITE` | Reads routing failure and renders text. |

The file imports neither Riverpod nor `ProjectState` and performs no provider
mutation. It contains no event/fact append, filesystem write, Project ZIP
operation, creator call, materializer call, canonical coordinate conversion,
or electrical-semantic mutation.

## Zero-write zones

- Factory parameters and route metadata describe navigation.
- Default and injected builders instantiate widgets only.
- Nested route builders delegate domain behavior to their screens.
- Redirect callbacks return URI strings only.
- Error presentation reads route state and renders text.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Factory parameters | [D] Parameters feed `GoRouter` or builders. | `app.dart` and router harnesses | `ZERO_WRITE` / `UI_LOCAL` | Home injection and route tests |
| Root Home | [D] Optional builder has unchanged fallback. | launcher callbacks | `ZERO_WRITE` | Home launcher tests |
| Wizard route | [D] Optional builder has unchanged default. | app dependency injection and Wizard cancellation/success | `ZERO_WRITE` | Home and Wizard route tests |
| Canonical Canvas | [D] `/project` owns Canvas and children. | provider consumers and deep links | `ZERO_WRITE` | Home, Canvas, and edit-screen tests |
| Project child tree | [D] Paths and screen constructors are explicit. | each destination screen | `ZERO_WRITE` | overview/component/measurement suites |
| Redirects | [D] Exact URI strings are returned. | canonical destination names | `UI_LOCAL` | Canvas and overview compatibility tests |
| Error surface | [D] Error text only. | GoRouter failure semantics | `ZERO_WRITE` | no focused error test identified |

## Relevant tests and helpers

- `test/widget/benchbeep_home_screen_test.dart` constructs the real app/router
  transition for `/new-project` and `/project`.
- `test/widget/new_project_wizard_screen_test.dart` uses a router harness to
  prove explicit success navigation and pre-activation inertness.
- `test/widget/board_canvas_screen_test.dart` covers canonical Canvas and
  compatibility routing.
- `test/widget/edit_component_screen_test.dart` is a direct
  `buildTraceBenchRouter` caller and exercises the edit destination through the
  real graph.

## Dangerous combinations

- Changing `newProjectBuilder` fallback and app injection together can remove
  the default Wizard or bypass app-owned handoff.
- Adding Riverpod or `ProjectState` here would move ownership across the
  navigation-only boundary.
- Renaming `/project` while changing compatibility redirects can strand deep
  links and explicit Wizard success navigation.
- Changing nested component routes without the direct edit-screen caller can
  hide route regressions.

## Safe SNIPER slices

- Optional Wizard-builder seam only: factory parameter, Wizard builder, app
  caller, and focused Home/Wizard route tests.
- One leaf route only: its path/name/builder and direct route test.
- One compatibility redirect only: returned URI and canonical-destination
  test.
- Error presentation only: `errorBuilder` and a focused failure test.

## Future extraction seams

- [S] The large project-child route list could move to a pure route-fragment
  builder if names and redirect ownership stay explicit.
- [S] Compatibility redirects could be grouped after direct deep-link
  coverage exists.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when factory parameters, paths, names, or screen
constructors change; `FLOW_DRIFT` when builder fallback or nesting changes;
`BOUNDARY_DRIFT` if state/provider/write ownership enters; `TEST_DRIFT` when
direct router callers move; and `STRUCTURE_DRIFT` when the route tree splits.

## Known uncertainty

- [D] Route builders prove construction, not the downstream screen's read or
  write behavior.
- [D] No focused route-error assertion is identified.
- [P] Additional direct callers may exist outside the four mapped widget
  suites; any route change still requires repository-wide caller search.
