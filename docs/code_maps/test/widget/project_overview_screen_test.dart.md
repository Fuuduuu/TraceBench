# Code Map: `test/widget/project_overview_screen_test.dart`

- Source: `test/widget/project_overview_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — 19 tests across freshness, shared-shell, responsive, preview, workflow-route, and zero-write families`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Verifies Project Overview as destination content under the production shared
Workbench shell and, where useful, as a direct mount. The 19-test suite covers
warning ownership, retained summary/preview/placeholder content, shared-shell
copy and colors, six-width routed responsive monotonicity, retained
Measure/Add/Edit workflows, inert future controls, and event preservation. It
no longer owns top-level Canvas/Graph/Reference Images navigation coverage.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Project fixture | `_inlineProjectState`, `_normalizedPlacementFacts`, `projectionFreshness` | Builds fresh/stale/unknown states, placements, raw IDs, counters, and seeded events. |
| Direct/routed harness | `_pumpProjectOverview`, `buildTraceBenchRouter`, `ProviderContainer`, `useRouter` | Mounts the destination directly or through the production router with controlled providers. |
| Route and warning identity | `/project/overview opens the retained named overview route`, `shows stale projection banner when projection is stale`, `shows one distinct unknown freshness warning` | Verifies canonical route plus exactly one shared stale/unknown warning and no legacy tag. |
| Shared shell and copy | `renders workbench-first shell with dominant primary action`, `workbench-shell`, `workbench-breadcrumb`, `workbench-home-button` | Verifies shared dark Scaffold/AppBar, breadcrumb/Home ownership, localized destination copy, and action hierarchy. |
| Six-width monotonic geometry | `routed overview stays monotonic across the shell cutover`, `959`, `960`, `1227`, `1228`, `1229`, `1500` | Proves compact/persistent navigation and stacked/wide Overview geometry without inversion. |
| Comfortably wide density | `routed 1500 layout gives board preview room and compacts rail`, `overview-workbench-board-preview` | Verifies dominant Workbench zone, bounded action rail, and preview height at the satisfiable wide checkpoint. |
| Summary, preview, and empty state | `renders compact status strip for board statistics`, `renders sparse-placement workbench placeholder state`, `renders read-only board canvas` | Covers counters, placeholder, and board-normalized read-only preview. |
| Visibility and future controls | `hides raw fixture identifiers from the visible shell`, `future tools are collapsed by default and remain inert` | Guards visible copy and all four null future callbacks. |
| Retained workflow routes | `legacy measurement action routes to measure sheet`, `Add Component action navigates to add component screen`, `Edit Component action navigates to edit component screen` | Verifies exact Measure/Add/Edit destination behavior. |
| Zero-write navigation | `overview shell does not mutate project events on render or measurement navigation` | Compares provider events before/after render and workflow navigation. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed test source. The map uses no line-number anchors.

## State and data flow

- `[D]` `_inlineProjectState` creates typed projection state with explicit
  `fresh` default and optional stale/unknown state, placements, raw identifiers,
  or seeded events.
- `[D]` `_pumpProjectOverview` seeds providers and mounts either the production
  router at `/project/overview` or the destination directly.
- `[D]` Shared-shell assertions target shell keys while Overview assertions
  continue to target `overview-*` content keys.
- `[D]` The monotonic case resizes one routed composition through exactly 959,
  960, 1227, 1228, 1229, and 1500 pixels, pairing shell-mode assertions with
  measured Overview row/stack geometry and provider identity.
- `[D]` The 1500 case separately proves preview width produces height at least
  430 and the action rail remains at most 260 wide.
- `[D]` Workflow tests stop after destination presentation; the zero-write case
  snapshots and compares event IDs.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectOverviewScreen` | system under test | Supplies retained destination content and private keyed zones. |
| `WorkbenchShell`, `WorkbenchShellColors` | shared-shell observation | Supplies shared chrome, navigation mode, and dark vocabulary. |
| `buildTraceBenchRouter`, `GoRouter` | routed harness | Resolves canonical and retained workflow routes. |
| `projectStateProvider`, `beginnerModeProvider` | fixture | Injects loaded state/mode; provider identity is observed during resize. |
| `ProjectState`, manifest/fact/event models | fixture | Build typed projected inputs. |
| `ProjectionStaleBanner` | warning assertion | Supplies current warning constants. |
| Flutter tester geometry APIs | harness | Drive taps, expansion, routing, viewport changes, and rectangle measurements. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Provider fixture construction | `UI_LOCAL` | Creates in-memory typed test state only. |
| Overview/shell rendering | `ZERO_WRITE` | Inspects widgets, colors, geometry, copy, and warnings. |
| Workflow route taps | `UI_LOCAL` | Change location without invoking a writer in this suite. |
| Seeded-event comparison | `ZERO_WRITE` | Proves no canonical event append during render/navigation. |
| Surface-size changes | `UI_LOCAL` | Test binding state is restored through teardown. |

Destination screens may own writers, but this suite stops before any explicit
write action. Placement facts remain read-only preview inputs.

## Zero-write zones

- Shell/copy, responsive, warning, summary, placeholder, preview, and inert-tool
  cases perform no writer action.
- Workflow tests only establish destination reachability.
- Event-preservation assertions read provider state only.

## Impact matrix

| Family | Evidence | Coupling | Write class | Escalation |
| --- | --- | --- | --- | --- |
| Fixture/harness | `[D]` shared by all 19 tests | provider, router, screen | setup | full target |
| Warning | `[D]` explicit tri-state fixtures and one-banner assertions | shared banner and status strip | `ZERO_WRITE` | stale/unknown cases |
| Shared shell/copy | `[D]` shell keys, colors, localized text | Workbench shell map | `ZERO_WRITE` | shell/copy case plus shell suite |
| Responsive | `[D]` six routed widths and measured rectangles | shell 1228, Overview 960/framing | `ZERO_WRITE` | monotonic + 1500 cases |
| Preview/placeholder | `[D]` optional normalized placement fixture | known-facts model/painter | `ZERO_WRITE` | both preview states |
| Inert controls | `[D]` expansion and null callbacks | future product authority | `ZERO_WRITE` | future-tools case |
| Workflow routes | `[D]` three destination action keys | router/destination screens | `UI_LOCAL` | Measure/Add/Edit cases |
| No-write guard | `[D]` before/after event IDs | provider and canonical writers | `ZERO_WRITE` | final event case |

## Relevant tests and helpers

- The target contains exactly 19 `testWidgets` declarations.
- `_inlineProjectState`, `_normalizedPlacementFacts`, and
  `_pumpProjectOverview` are shared across freshness, geometry, preview, route,
  and no-write families.
- `test/widget/workbench_shell_test.dart` owns top-level destination inventory,
  Home/mode survival, representative route navigation, aliases, and shell-only
  responsive evidence.
- `test/widget/project_gate_test.dart` owns all-15 route composition and nested
  stack identity.
- Production-map counterpart:
  `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`.

## Dangerous combinations

- Harness changes can alter every shared-shell, route, warning, and geometry
  expectation.
- Surface-size tests must restore global binding state.
- Shell cutover and local Overview geometry assertions must remain paired;
  checking only navigation mode would miss a destination inversion.
- The 430-pixel preview assertion is satisfiable at 1500, not 1440, under the
  retained 244/24/252/12/24 geometry.
- Re-adding removed top-level route tests here would duplicate shell ownership.
- Enabling future controls requires product authority, not an expectation edit.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning assertion | warning tests and fixture freshness | shared banner/status strip | both warning cases |
| Shared-shell copy | shell/copy case | shell source and Overview content | shell case + shell suite |
| Responsive geometry | monotonic and 1500 cases | surface teardown, shell/Overview thresholds | both responsive cases |
| One preview state | placement fixture and keyed preview | model/painter | placeholder + preview cases |
| One workflow route | matching action key/test | router/destination | exact route plus event guard |

## Future extraction seams

- `[S]` Repeated workflow tap/settle assertions could become a small helper if
  route evidence remains explicit.
- `[S]` Six-width expectations could become a shared immutable fixture only if
  Board and Overview continue asserting their own geometry independently.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for helper/title `SYMBOL_DRIFT`, router/provider or
resize `FLOW_DRIFT`, no-write `BOUNDARY_DRIFT`, family coverage `TEST_DRIFT`,
or shell/content `STRUCTURE_DRIFT`. Recheck test count, exact six widths, shell
keys, Overview keys, and event guard whenever imported contracts change.

## Known uncertainty

- `[P]` Destination assertions prove reachability, not destination internals.
- `[P]` Color and geometry assertions intentionally couple to accepted visual
  structure and require review after a committed redesign.
- `[S]` Extraction observations are non-authorizing.
