# Code Map: `lib/app/router.dart`

- Source: `lib/app/router.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `HUMAN OVERRIDE — creation handoff crosses router, screen and provider boundaries and requires durable impact analysis.`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Builds the application route graph. It accepts optional root-Home and New
Project Wizard builders, preserves their default construction, exposes
`/new-project` and canonical `/project`, nests the established project tools,
wraps all 15 real project targets in one shared `ProjectGate`, retains two
compatibility redirects outside that gate, and renders a generic route-error
surface. It owns widget construction and navigation only: project-state reads,
project-open execution, provider assignment, and destination behavior remain
outside.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Route factory contract | `buildTraceBenchRouter`, `initialLocation`, `homeBuilder`, `newProjectBuilder` | Exposes initial-route and optional widget-construction seams. |
| Root Home route | `path: '/'`, `name: 'home'`, `HomeScreen` | Builds the injected Home when supplied or the unchanged default Home. |
| New Project Wizard route | `path: 'new-project'`, `name: 'new-project'`, `NewProjectWizardScreen` | Builds the injected Wizard when supplied or the unchanged const default Wizard. |
| Canonical Board Canvas route | `path: 'project'`, `name: 'board-canvas'`, `ProjectGate`, `BoardCanvasScreen` | Makes `/project` the canonical Canvas destination and wraps its child in the shared gate. |
| Overview and component routes | `project-overview`, `component-list`, `add-component`, `edit-component` | Registers four gated overview/component destinations. |
| Measurement and pin routes | `measurement-list`, `measure-sheet`, `not-populated`, `pin-list` | Registers four gated measurement/population/pin destinations. |
| Evidence, media, graph, and report routes | `events`, `known-facts`, `photos`, `reference-images`, `board-graph`, `customer-report` | Registers six gated evidence/media/graph/report destinations. |
| Redirects and error surface | `measurements/new`, `board-canvas`, `redirect`, `errorBuilder`, `Unknown route` | Retains compatibility URI redirects and renders unresolved-route errors. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed source. The map uses no line-number anchors.

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
6. Each of the 15 real `/project` targets constructs `ProjectGate(child: ...)`;
   the gate, not this router, watches project state and owns recovery behavior.
7. A loaded project lets the gate render the requested destination; a null
   project keeps that same route matched while the gate renders recovery.
8. `/project/measurements/new` and `/project/board-canvas` remain redirect-only
   aliases outside the gate and return their unchanged canonical URI strings.
9. Unresolved routes render error text.

## Guarded project target inventory

`ProjectGate` wraps exactly these real targets:

1. `/project`
2. `/project/overview`
3. `/project/components`
4. `/project/components/add`
5. `/project/components/edit`
6. `/project/measurements`
7. `/project/measure-sheet`
8. `/project/not-populated`
9. `/project/pins`
10. `/project/events`
11. `/project/graph`
12. `/project/known-facts`
13. `/project/photos`
14. `/project/reference-images`
15. `/project/report`

The two aliases are not additional guarded targets.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework UI | Supplies widget-builder types and the error surface. |
| GoRouter | routing framework | Owns matching, nesting, redirects, route state, and errors. |
| `HomeScreen` | default outbound destination | Preserves default root construction. |
| `NewProjectWizardScreen` | default outbound destination | Preserves default Wizard construction at `/new-project`. |
| `ProjectGate` | outbound wrapper dependency | Applies the shared loaded-project gate while retaining each matched URI. |
| `BoardCanvasScreen` | gated outbound destination | Owns canonical `/project` presentation. |
| Project tool screens | outbound destinations | Implement behavior behind nested URIs. |
| `lib/app/app.dart` | inbound caller | Supplies launcher Home and injected Wizard builders. |
| `test/widget/project_gate_test.dart` | direct route/gate evidence | Proves all 15 wrappers, both aliases, URI retention, Home, loader outcomes, and zero-write reveal. |
| Other widget-test router harnesses | inbound callers | Build real route graphs for Home, Wizard, Canvas, Overview, and edit-screen tests. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `buildTraceBenchRouter` and route declarations | `ZERO_WRITE` | Construct navigation objects and widget builders only. |
| `initialLocation` and redirects | `UI_LOCAL` | Select transient URI presentation. |
| `homeBuilder` and `newProjectBuilder` | `ZERO_WRITE` | Invoke widget factories; downstream widgets own any effects. |
| Gated destination builders | `ZERO_WRITE` | Instantiate `ProjectGate` and child widgets without reading state or performing downstream operations in this file. |
| `errorBuilder` | `ZERO_WRITE` | Reads routing failure and renders text. |

The file imports neither Riverpod nor `ProjectState` and performs no provider
read or mutation. Importing `ProjectGate` does not transfer its downstream
state/open-action ownership into the router. The router contains no event/fact
append, filesystem write, Project ZIP operation, creator call, materializer
call, canonical coordinate conversion, or electrical-semantic mutation.

## Zero-write zones

- Factory parameters and route metadata describe navigation.
- Default and injected builders instantiate widgets only.
- Real project route builders compose `ProjectGate` with one destination and
  delegate state, recovery, and domain behavior downstream.
- Redirect callbacks return URI strings only.
- Error presentation reads route state and renders text.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Factory parameters | [D] Parameters feed `GoRouter` or builders. | `app.dart` and router harnesses | `ZERO_WRITE` / `UI_LOCAL` | Home injection and route tests |
| Root Home | [D] Optional builder has unchanged fallback. | launcher callbacks | `ZERO_WRITE` | Home launcher tests |
| Wizard route | [D] Optional builder has unchanged default. | app dependency injection and Wizard cancellation/success | `ZERO_WRITE` | Home and Wizard route tests |
| Canonical Canvas | [D] `/project` owns gated Canvas and children. | `ProjectGate`, provider consumer, deep links | `ZERO_WRITE` | gate, Home, Canvas, and edit-screen tests |
| Project child tree | [D] All 15 builders explicitly compose `ProjectGate` with one destination. | gate behavior and each destination screen | `ZERO_WRITE` | gate route matrix plus destination suites |
| Redirects | [D] Two exact URI strings are returned outside the gate. | canonical destination names and gate recovery | `UI_LOCAL` | gate, Canvas, and Overview compatibility tests |
| Error surface | [D] Error text only. | GoRouter failure semantics | `ZERO_WRITE` | no focused error test identified |

## Relevant tests and helpers

- `test/widget/benchbeep_home_screen_test.dart` constructs the real app/router
  transition for `/new-project` and `/project`.
- `test/widget/new_project_wizard_screen_test.dart` uses a router harness to
  prove explicit success navigation and pre-activation inertness.
- `test/widget/board_canvas_screen_test.dart` covers canonical Canvas and
  compatibility routing with loaded-state route fixtures.
- `test/widget/edit_component_screen_test.dart` is a direct
  `buildTraceBenchRouter` caller and exercises the edit destination through the
  real graph.
- `test/widget/project_gate_test.dart` is the focused owner for null/loaded
  gate presentation, project-open outcomes, original-URI retention, all 15
  real project targets, both aliases, Home, and representative zero-write
  child reveal.

## Dangerous combinations

- Changing `newProjectBuilder` fallback and app injection together can remove
  the default Wizard or bypass app-owned handoff.
- Adding Riverpod or `ProjectState` here would move ownership across the
  navigation-only boundary.
- Wrapping only some real project builders would recreate inconsistent direct
  deep-link behavior; changing gate ownership and route topology together
  obscures whether navigation or recovery caused a regression.
- Renaming `/project` while changing compatibility redirects can strand deep
  links and explicit Wizard success navigation.
- Changing nested component routes without the direct edit-screen caller can
  hide route regressions.

## Safe SNIPER slices

- Optional Wizard-builder seam only: factory parameter, Wizard builder, app
  caller, and focused Home/Wizard route tests.
- One gated leaf route only: its path/name/builder, the shared route inventory,
  and the focused gate route-matrix test.
- One compatibility redirect only: returned URI and canonical-destination
  test.
- Error presentation only: `errorBuilder` and a focused failure test.

## Future extraction seams

- [S] The large project-child route list could move to a pure route-fragment
  builder if names and redirect ownership stay explicit.
- [S] Compatibility redirects could be grouped after direct deep-link
  coverage exists.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when factory parameters, paths, names, `ProjectGate`,
or screen constructors change; `FLOW_DRIFT` when builder fallback, gate
composition, or nesting changes; `BOUNDARY_DRIFT` if state/provider/write
ownership enters; `TEST_DRIFT` when the gate matrix or other direct callers
move; and `STRUCTURE_DRIFT` when the route tree or guarded inventory splits.

## Known uncertainty

- [D] Route builders prove construction, not the downstream screen's read or
  write behavior.
- [D] The router proves that the shared gate is mounted, while gate tests and
  `ProjectGate` source own recovery/open behavior.
- [D] No focused route-error assertion is identified.
- [P] Additional direct callers may exist outside the named mapped widget
  suites; any route change still requires repository-wide caller search.
