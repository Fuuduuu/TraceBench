# Code Map: `test/widget/board_canvas_screen_test.dart`

- Source: `test/widget/board_canvas_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3000 lines + 3+ test families`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This 168-test Board Canvas widget-test owner supplies explicit-fresh fixtures,
provider/router harnesses, writer doubles, navigation inventories,
interaction/painter assertions, and read-only Wizard overlay coverage. It
verifies committed UI behavior and zero-write boundaries without owning
production semantics.

## Qualification

`[D]` Committed source contains 168 test declarations
(`158` `testWidgets` plus `10` `test`) across more than three behavior
families and exceeds 3,000 lines. Its flat structure has no meaningful
`group()` ownership, so families are derived from stable helpers, doubles, and
exact test names.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fixtures and harness lifecycle | `_inlineProjectState(projectionFreshness:)`, `_wizardIntake`, `_componentNavigatorState`, `_harness`, `_routerHarness`, `_readProjectState` | Builds explicit-fresh-by-default state, overrides providers, mounts direct/routed screens, and observes provider state. |
| 2. Theme, shell, and route baselines | `_harness`, `_routerHarness`; `buildTheme exposes BenchBeep semantic visual tokens`; `/project is the named canonical board canvas route` | Verifies theme, empty/loaded shell, canonical entry, and legacy redirect compatibility. |
| 3. Navigator, selection, hover, and filter | `_selectPlacement`, `_hoverWidgetByKey`, `_painterPreviewKeys`, `_painterDimmedKeys`, `_canvasSemanticsLabels` | Exercises typed selection, category drill-down, hover, ordering, counts, and hide-unmeasured eligibility. |
| 4. Measurement entry and association | `_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson`, `_expectStableComponentPreviewGeometry` | Covers target/draft/save, Measure Sheet navigation, association, badges, and stale/suspect display. |
| 5. Component create and edit | `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_componentCreatedEventJson`, `_componentUpdatedEventJson` | Verifies guarded identity creation/edit requests, errors, returned events, and idempotency. |
| 6. Placement builder, draft, ghost, and save | `_FakePlacementWriter`, `_placementWriterEventJson`, `_tapCanvasAtNormalized`, `_tapWidgetByKey` | Exercises template selection, local drafts, ghost movement, normalized bounds, explicit save, and results. |
| 7. Canvas interaction, Wizard fit, and geometry | `_tapCanvasAtNormalized`, `_wizardIntakePainter`, `_wizardPhotoLayer`; `initial fit runs once for each active project and intake`; landscape/legacy tests | Verifies pan/zoom, hit selection, aspect-aware mapping, square fallback, padding, one initial fit, alignment, and badges. |
| 8. Painter, Wizard overlay, footprint, and semantics | `_wizardIntakePainter`, `_wizardPhotoLayer`, `_boardCanvasPainter`, `_compositedPixelColor`, `_canvasSemanticsLabels` | Inspects composite order/pixels, photo states, read-only geometry, rotation, footprint/pin rendering, cues, semantics, and fallbacks. |
| 9. Inspector, readiness, and evidence | `_openSafetyEvidence`, `_openWideContextMode`; readiness/trace test names | Verifies projected inspector content, readiness/safety wording, measurements, and visual-trace metadata. |
| 10. Rail, Project hub, focus, and responsive layout | `_projectHubDestinations`, `_projectHubActionKeys`, `_revealProjectHubAction`, `_openWideContextMode`, `_tapWidgetByKey`, `_pumpUntilRouterPath`; default medium/wide, 12-route, round-trip, and restore test names | Proves initial hub visibility, exact ordered inventory, exclusions, all destinations, `Projekt`/focus restoration, canonical round trip, and zero writes. |
| 11. Volatility and protected-boundary guards | `_readProjectState`; zero-component, tap-selection, and source-boundary test names | Asserts volatile-only state, unchanged provider/files, empty unintended writer requests, and static production boundaries. |
| 12. Projection freshness presentation | `unknown freshness warning keeps Board Canvas usable`, `ProjectionStaleBanner.unknownPrimaryText` | Proves distinct unknown warning, usable workspace, explicit fresh fixtures, and existing post-write stale behavior. |

## Project navigation fixture and coverage

`_projectHubDestinations` is the shared ordered source of expected key, label,
and path tuples:

1. Home — `board_canvas_project_home_action` — `/`
2. Overview — `board_canvas_project_overview_action` — `/project/overview`
3. Components — `board_canvas_project_components_action` — `/project/components`
4. Measurements — `board_canvas_project_measurements_action` — `/project/measurements`
5. Pins — `board_canvas_project_pins_action` — `/project/pins`
6. Not Populated — `board_canvas_project_not_populated_action` — `/project/not-populated`
7. Photos — `board_canvas_project_photos_action` — `/project/photos`
8. Reference Images — `board_canvas_project_reference_images_action` — `/project/reference-images`
9. Graph — `board_canvas_project_graph_action` — `/project/graph`
10. Events — `board_canvas_project_events_action` — `/project/events`
11. Known Facts — `board_canvas_project_known_facts_action` — `/project/known-facts`
12. Report — `board_canvas_project_report_action` — `/project/report`

`_projectHubActionKeys` reads the actual `ListView` child keys in order.
`_revealProjectHubAction` scrolls the hub before tapping off-screen actions.
The medium `1000x800` and wide `1400x800` tests require the hub immediately;
the inventory assertion requires 12 unique ordered keys and excludes Add
Component, Edit Component, and Measure Sheet.

## State and data flow

- `[D]` `_inlineProjectState` explicitly defaults to
  `ProjectionFreshness.fresh`, preventing unrelated cases from inheriting the
  compatibility `unknown` default.
- `[D]` `_harness` mounts `BoardCanvasScreen` directly with four replaceable
  writer providers; `_routerHarness` and `buildTraceBenchRouter` exercise
  canonical route behavior.
- `[D]` The default medium/wide tests inspect the hub without first tapping
  `Projekt`; the restore test switches panel, restores Project, hides focus
  chrome, and restores the same selected hub.
- `[D]` The 12-route loop checks production named locations, scrolls to every
  action, settles each destination, and asserts empty fake writers, unchanged
  provider identity/events/freshness, and an empty temporary project tree.
- `[D]` The Canvas -> Overview -> Canvas test uses the production router,
  starts at `/project`, follows the new Overview action, uses the existing
  Overview Canvas action, and requires final canonical `/project` with
  unchanged unknown freshness, events, provider identity, and writers.
- `[D]` Wizard/painter helpers inspect model-valid presentation input and
  composite output without creating canonical data.
- `[D]` Successful simulated writer calls are observed separately through
  `_readProjectState` as returned-event mirroring and stale projection state.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `BoardCanvasScreen` and its production map | system under test / inspect-only map | Supplies behavior; production responsibility remains independent. |
| `projectStateProvider`, `ProviderScope`, `ProjectState` | fixture / observation | Injects state and proves navigation/provider invariance or post-write mirroring. |
| `buildTraceBenchRouter`, `GoRouter`, `MaterialApp.router` | routed harness | Verifies canonical entry, redirect, Overview round trip, Measure Sheet, and 12 Project destinations. |
| Four V2 writer interfaces/providers | test doubles | Capture add, edit, placement, and measurement requests and return controlled results. |
| BoardFact models and `TraceBenchEvent` | fixture / assertion input | Builds projected facts and returned events. |
| `WizardIntake` family | fixture / assertion input | Builds optional aspect/photo/contour/problem/candidate presentation. |
| Flutter widget, gesture, semantics, and painter APIs | driver / observation | Controls viewports/input/rendering/semantics/private painter state. |
| `dart:io` temporary directories and source reads | harness-only filesystem / inspection | Proves navigation creates no project file and statically checks selected source boundaries. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Screen action -> four fake request lists | exercised `CANONICAL_EVENT` boundary | `[D]` Fakes observe existing interfaces; they do not prove persistence internals. |
| Returned fake event -> `_readProjectState` | observed `PROJECTION_STATE` | `[D]` Tests separate local mirroring/stale promotion from unchanged input fixtures. |
| Selection, hover, filter, draft, ghost, panel, focus, badges | `UI_LOCAL` | `[D]` In-memory effects; no request before an explicit save. |
| Project hub and round trip | `UI_LOCAL` + `ZERO_WRITE` | `[D]` Route-only actions retain provider identity, state values, all fake lists, and project files. |
| Wizard gate/photo/fit/composite/candidate taps | `UI_LOCAL` + `ZERO_WRITE` | `[D]` Intake/provider/debug JSON/facts/events and four fake lists remain unchanged. |
| Temp directory setup/teardown | `NONCANONICAL_FILE` test fixture | `[D]` Harness-only and outside product persistence. |
| Production source string read | `ZERO_WRITE` | `[D]` `File.readAsStringSync` observes and does not modify source. |

Canonical event meaning, writer implementation, schemas, Project ZIP,
materialization, coordinates, electrical meaning, and evidence promotion stay
owned by their production/canonical owners.

## Impact matrix

| Family | Direct evidence | Coupling | Write class | Escalation |
| --- | --- | --- | --- | --- |
| Fixtures/harness | `[D]` state/providers/router/fakes | Whole file | `ZERO_WRITE` setup | Full target; broader Flutter for imported contract drift. |
| Shell/routes | `[D]` direct/routed mounts | Rail/focus/harness | `ZERO_WRITE` | Full target for router harness; broader tests for router drift. |
| Navigator/filter | `[D]` helper/painter observations | Targets, geometry, responsive | `UI_LOCAL` | Focused family plus full target for shared helpers. |
| Writers | `[D]` four request fakes/results | Selection/provider/freshness | exercised `CANONICAL_EVENT` | Exact writer family plus full target. |
| Canvas/Wizard | `[D]` transforms, pixels, painter state | Z-order/hits/semantics | `UI_LOCAL` + `ZERO_WRITE` | Exact geometry/render cases plus full target. |
| Inspector/evidence | `[D]` projected summaries | Selection/measurement | `ZERO_WRITE` | Exact family plus full target for fixture drift. |
| Rail/Project/focus | `[D]` shared 12-tuple inventory and route lifecycle | Router, Overview, provider/files, scrollability | `UI_LOCAL` + `ZERO_WRITE` | All navigation cases plus full target; broader tests for router/Overview drift. |
| Freshness/boundaries | `[D]` explicit states, fake/files/source guards | Cross-cutting | `ZERO_WRITE` / observed projection | Full target and routed freshness integration when imported flow changes. |

## Relevant tests and helpers

| Family | Stable anchors | Representative coverage |
| --- | --- | --- |
| Project navigation | `_projectHubDestinations`, `_projectHubActionKeys`, `_revealProjectHubAction`, `_pumpUntilRouterPath` | `medium Workbench starts with visible exact Project hub`; wide equivalent; `12 Projekt hub actions navigate to exact routes without writes`; canonical round trip; `Projekt hub preserves existing panel modes and focus restoration`; wide default context-panel case. |
| State/mounting | `_inlineProjectState`, `_componentNavigatorState`, `_harness`, `_routerHarness`, `_readProjectState` | No-project/project shell, route, provider, and projection assertions. |
| Rendering/Wizard | `_wizardIntake`, `_wizardIntakePainter`, `_wizardPhotoLayer`, `_boardCanvasPainter`, `_compositedPixelColor` | Gate, aspect/fallback, z-order, photo, rotation, non-actionability, footprints/pins. |
| Interaction | `_selectPlacement`, `_tapCanvasAtNormalized`, `_hoverWidgetByKey`, `_canvasSemanticsLabels` | Selection, canvas, hover, filter, hit alignment, semantics. |
| Writer boundaries | Four fake writers and event builders | Explicit saves, guards, errors, idempotency, returned events, stale state. |
| Freshness | explicit freshness fixture and shared banner constants | Fresh default, unknown usable workspace, stale promotion. |

## Dangerous combinations

- `[H]` Router URI equality can precede Navigator completion; route helpers
  must settle transitions before inspecting destination widgets.
- `[H]` Long-hub actions require `_revealProjectHubAction`; an off-screen key
  can exist without being tappable.
- `[P]` Shared destination tuples or router harness changes can drift exact
  inventory, all-route, round-trip, and zero-write assertions together.
- `[P]` Removing explicit fresh fixture defaults obscures intentional unknown
  banner coverage.
- `[P]` Wizard transform/pixel changes can desynchronize layers while
  placements still pass; shared fit and final composite evidence move together.
- `[P]` Viewport changes require teardown so later tests do not inherit size.
- `[P]` Placement ghost conversion plus requests can cross from UI-local
  drafts into canonical normalized-coordinate behavior.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One Project destination | `_projectHubDestinations`, `_revealProjectHubAction` | Production hub/router/Overview | inventory + route loop + full target |
| One default/restore behavior | `_projectHubActionKeys`, `_openWideContextMode` | Focus and viewport teardown | medium/wide + restore cases |
| One Wizard render assertion | painter/photo/pixel helpers | Fixtures, z-order, placement hit path | exact overlay cases + full target |
| One writer assertion | corresponding fake writer | Selection/result/freshness | exact writer family |
| One freshness assertion | explicit freshness fixture | scaffold/provider/integration route | exact warning case + full target |

Slices guide decomposition only and do not authorize edits or files.

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for helper/title, harness/provider/route,
  writer/filesystem, linked-family, or family-ownership drift.
- Recheck on destination order/keys/paths, default hub visibility,
  `Projekt`/focus restoration, router settling, Overview return behavior,
  zero-write assertions, or committed test-count change.
- Recheck Wizard, painter, geometry, selection/filter, writer, and freshness
  families when their imported production contracts change.
- Formatting, comments, imports, and line movement alone do not require an
  update. Accepted committed source remains authoritative.

## Known uncertainty

- `[D]` Families are analytical; source has no owning `group()` hierarchy.
- `[P]` Dynamic private-painter inspection is more structure-sensitive than
  public behavior.
- `[P]` Static source-string assertions prove selected shape, not every
  possible runtime absence.
- `[S]` Local router harnesses and fake writers do not verify destination
  internals, persistence implementations, or router disposal ownership.
