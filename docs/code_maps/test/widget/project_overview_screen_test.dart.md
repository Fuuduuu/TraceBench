# Code Map: `test/widget/project_overview_screen_test.dart`

- Source: `test/widget/project_overview_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — 23 tests across freshness, shell, layout, route, and zero-write families`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`

## File purpose

This widget target verifies the project overview as a routed and directly
mounted read-only Workbench shell. It covers warning presentation, responsive
geometry, board-placement preview and placeholder states, localized copy,
inert future tools, exact destination routes, and preservation of project
events during navigation.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Project fixture | `_inlineProjectState(projectionFreshness:)`, `_normalizedPlacementFacts` | Builds explicit-fresh-by-default counters, stale/unknown variants, optional placements, raw IDs, and seeded events. |
| 2. Mounting and router harness | `_pumpProjectOverview`, `buildTraceBenchRouter`, `ProviderContainer` | Supports direct and routed mounts with controlled providers and location. |
| 3. Route identity | `/project/overview opens the retained named overview route` | Verifies canonical path and named route. |
| 4. Warning state | `shows stale projection banner when projection is stale`, `shows one distinct unknown freshness warning` | Verifies exactly one shared stale banner, distinct unknown copy, and absence of the removed local `PROJECTION STALE` evidence tag. |
| 5. Shell and copy | `renders workbench-first shell with dominant primary action`, `uses polished Estonian copy` | Covers dark shell, breadcrumb, action hierarchy, localization, and forbidden legacy copy. |
| 6. Responsive geometry | `wide layout makes the workbench zone visually dominant`, `wide density layout gives board preview room and compacts rail` | Verifies Workbench/rail ratios and preview height. |
| 7. Preview and empty state | `renders sparse-placement workbench placeholder state`, `renders read-only board canvas` | Distinguishes placeholder from board-normalized read-only preview. |
| 8. Visibility and inert controls | `hides raw fixture identifiers`, `future tools are collapsed by default and remain inert` | Guards user-facing copy and null future callbacks. |
| 9. Existing route actions | measurement/add/edit/canvas/graph/reference-image tests | Verifies exact navigation and compatibility redirect behavior. |
| 10. Zero-write navigation | `Board Canvas action does not mutate project events`, `overview shell does not mutate project events` | Compares provider events before and after route actions. |

## State and data flow

- `[D]` `_inlineProjectState` creates typed projection state with explicit
  `ProjectionFreshness.fresh` default and optionally supplies stale/unknown
  state, placements, raw identifiers, or seeded events.
- `[D]` The stale case scopes its tag assertion beneath the single banner and
  proves the literal old `PROJECTION STALE` tag is absent; the unknown case
  proves distinct unknown text and the same legacy-tag absence.
- `[D]` `_pumpProjectOverview` seeds providers, mounts either router or direct
  screen, and returns the container for post-action assertions.
- `[D]` Layout tests alter and restore surface size before measuring keyed
  regions.
- `[D]` Route tests tap visible actions, settle navigation, and assert exact
  destination content/path.
- `[D]` Zero-write tests snapshot event IDs from the provider and compare them
  after navigation.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectOverviewScreen` | system under test | Supplies the overview shell and private keyed zones. |
| `buildTraceBenchRouter`, `GoRouter` | routed harness | Resolves canonical, compatibility, and destination routes. |
| `projectStateProvider`, `beginnerModeProvider` | fixture/observation | Inject state/mode and inspect event preservation. |
| `ProjectState`, known-facts/manifest/event models | fixture | Build typed projected inputs. |
| `ProjectionStaleBanner` | presentation assertion | Supplies current warning constants. |
| Flutter tester surface/geometry APIs | harness | Drive taps, expansion, routing, and responsive measurements. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Provider fixture construction | `UI_LOCAL` test state | `[D]` Creates in-memory typed state only. |
| Overview rendering and placement preview | `ZERO_WRITE` exercised | `[D]` Tests inspect widgets, colors, geometry, and copy. |
| Route taps | `ZERO_WRITE` exercised | `[D]` Change location without direct writer calls. |
| Seeded-event comparisons | absent `CANONICAL_EVENT` | `[D]` Assert event IDs remain identical across navigation. |
| Surface-size changes | `UI_LOCAL` test binding | `[D]` Restored through teardown. |

Destination screens may own writers, but reaching them from the overview does
not exercise or transfer their canonical authority. Placement facts remain
read-only preview input.

## Zero-write zones

- `[D]` Shell, layout, warning, copy, placeholder, preview, and inert-tool
  tests perform no writer action.
- `[D]` Route tests stop after destination presentation appears.
- `[D]` Event-preservation tests read provider state only.
- `[D]` Future-tool callbacks are asserted null.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Fixture/harness | `[D]` shared by all tests | providers, router, source map | test setup | full target |
| Warning | `[D]` explicit tri-state fixture, banner count/constants, negative legacy-tag assertions | banner widget and overview status strip | `ZERO_WRITE` | stale and unknown warning tests |
| Shell/copy | `[D]` keys, colors, localized text | production visual tokens | `ZERO_WRITE` | shell/copy/raw-ID tests |
| Responsive layout | `[D]` measured rectangles | Workbench/rail/preview zones | `ZERO_WRITE` | two wide-layout tests |
| Preview/placeholder | `[D]` optional placement fixture | known-facts placement model | `ZERO_WRITE` | two preview-state tests |
| Inert tools | `[D]` expansion and null callbacks | future product authority | `ZERO_WRITE` | future-tools test |
| Routes | `[D]` router harness and action keys | router and destination screens | `ZERO_WRITE` | exact destination tests |
| No-write guards | `[D]` before/after event IDs | provider and canonical writers | absent write | two event-preservation tests |

## Relevant tests and helpers

- The target contains 23 widget tests spanning freshness plus the retained
  shell/layout/route/zero-write families.
- `test/integration/projection_stale_banner_end_to_end_test.dart` provides
  cross-surface warning navigation coverage.
- `test/widget/measure_sheet_screen_test.dart`,
  `test/widget/edit_component_screen_test.dart`,
  `test/widget/board_graph_screen_test.dart`, and the maintained Board Canvas
  test map own destination details.
- Production-map counterpart:
  `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`.

## Dangerous combinations

- `[P]` Shared fixture or harness changes can alter every shell, route, and
  event-preservation expectation.
- `[P]` Surface-size tests must restore global binding state.
- `[P]` Router settling can briefly retain outgoing widgets; exact path plus
  destination assertions should stay paired.
- `[P]` Finder-only preview checks cannot prove geometry; measured zones and
  read-only copy protect different aspects.
- `[P]` A global tag-text assertion without scoping the shared banner could
  miss a duplicate local evidence tag; the literal legacy-tag exclusion is a
  separate required assertion.
- `[H]` Enabling future controls would require product authority, not merely a
  test expectation update.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning assertion | stale/unknown tests and `_inlineProjectState(projectionFreshness:)` | shared banner, count, status strip, duplicate-tag exclusion | both warning tests |
| One responsive assertion | two wide tests | surface teardown and preview | both layout tests |
| One preview state | placement fixture and preview tests | known-facts model | placeholder + preview tests |
| One route action | matching keyed action test | router/destination | exact route plus no-write guard when applicable |
| One shell-copy rule | shell/copy/raw-ID tests | production visual tokens | matching tests |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Route-action table | `[S]` Several tests repeat ensure-visible/tap/settle. | `NONE` |
| Shared shell expectations | `[S]` Copy and visual keys recur across tests. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for helper/title `SYMBOL_DRIFT`, router/provider
  `FLOW_DRIFT`, zero-write `BOUNDARY_DRIFT`, family coverage `TEST_DRIFT`, or
  organization `STRUCTURE_DRIFT`.
- Recheck the production map when keyed zones, route actions, placement
  preview, warning ownership, or provider use changes.
- Recheck explicit fresh setup, one-banner count, distinct unknown copy, and
  the `PROJECTION STALE` exclusion together when warning ownership changes.
- Formatting and line movement alone do not stale this map.

## Known uncertainty

- `[P]` Destination assertions prove navigation reachability, not complete
  destination behavior.
- `[P]` Color and geometry assertions intentionally couple to accepted visual
  structure and may need review after a committed redesign.
- `[S]` Extraction observations are non-authorizing.
