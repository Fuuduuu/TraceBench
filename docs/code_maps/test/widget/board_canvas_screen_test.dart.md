# Code Map: `test/widget/board_canvas_screen_test.dart`

- Source: `test/widget/board_canvas_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3000 lines + 3+ test families`
- Audit evidence: `docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS.md`

## File purpose

This file is the widget-test owner for the Board Canvas screen. It supplies
project fixtures, provider and router harnesses, writer doubles, interaction
helpers, painter inspection, and behavior-family assertions spanning the
Workbench shell. It verifies production boundaries but does not own production
behavior, writer semantics, routes, or the maintained production map.

## Qualification

`[D]` The accepted committed source qualifies automatically because it exceeds
3,000 physical lines and contains more than three independently testable
families. Its flat structure has no meaningful `group()` ownership; family
boundaries below are derived from stable helpers, doubles, and exact test names.

## Responsibility zones

The zones are analytical families anchored by symbols and exact test names;
the source has no `group()` hierarchy that owns these families.

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fixtures and harness lifecycle | `_inlineProjectState`, `_componentNavigatorState`, `_harness`, `_routerHarness`, `_readProjectState` | Builds accepted state variants, overrides providers, mounts direct or routed screens, and observes post-action provider state. |
| 2. Theme, shell, and route baselines | `_harness`, `_routerHarness`; `buildTheme exposes BenchBeep semantic visual tokens`; `/project is the named canonical board canvas route` | Verifies theme tokens, empty/loaded shell behavior, canonical entry, and legacy redirect compatibility. |
| 3. Navigator, selection, hover, and filter | `_selectPlacement`, `_hoverWidgetByKey`, `_painterPreviewKeys`, `_painterDimmedKeys`, `_canvasSemanticsLabels` | Exercises typed component/placement selection, category drill-down, hover preview, ordering, counts, and hide-unmeasured eligibility. |
| 4. Measurement entry and association | `_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson`, `_expectStableComponentPreviewGeometry`; `integrated Measure panel target selection and draft capture stay local` | Covers target selection, drafts, explicit save, Measure Sheet navigation, measurement association, badges, and stale/suspect states. |
| 5. Component create and edit | `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_componentCreatedEventJson`, `_componentUpdatedEventJson` | Verifies guarded identity creation, metadata editing, canonical request values, returned-event handling, errors, and idempotency. |
| 6. Placement builder, draft, ghost, and save | `_FakePlacementWriter`, `_placementWriterEventJson`, `_tapCanvasAtNormalized`, `_tapWidgetByKey` | Exercises template selection, local placement drafts, ghost movement, normalized bounds, explicit save, and writer-result handling. |
| 7. Canvas interaction and geometry | `_tapCanvasAtNormalized`, `_painterSelectedComponentId`, `_painterSelectedPlacementKey`; `tap selection stays aligned after canvas transform` | Verifies pan/zoom, fit reset, transformed hit selection, selection state, and measurement-badge anchoring. |
| 8. Painter, footprint, and semantics | `_boardCanvasPainter`, `_canvasSemanticsLabels`, `_expectStableComponentPreviewGeometry`; `renders visual footprint forms for board placements` | Inspects placement paths, footprint/pin rendering, preview and selection cues, semantics, and fallback visibility. |
| 9. Inspector, readiness, and evidence | `_openSafetyEvidence`, `_openWideContextMode`; `readiness panel remains project-level metadata with selection, inspector, measurement, and visual trace state` | Verifies projected inspector content, readiness and safety wording, fallbacks, measurement summaries, and visual-trace metadata. |
| 10. Rail, project hub, focus, and responsive layout | `_openWideContextMode`, `_tapWidgetByKey`, `_pumpUntilRouterPath`; `Projekt hub actions navigate to exact existing routes without writes` | Covers rail/panel modes, exact zero-write navigation, medium/wide reachability, focus entry, and restoration. |
| 11. Volatility and protected-boundary guards | `_readProjectState`; `tap-to-select leaves project state canonical data unchanged`; `board canvas source keeps read-only data-path boundaries` | Asserts volatile-only state, absent unintended writer/file effects, projection separation, and selected static source boundaries. |

## State and data flow

- `[D]` `_inlineProjectState` and `_componentNavigatorState` build projected
  `ProjectState` inputs consumed through `projectStateProvider` overrides.
- `[D]` `_harness` mounts `BoardCanvasScreen` directly and can replace each of
  the four writer providers; `_routerHarness` exercises `buildTraceBenchRouter`.
- `[D]` Interaction helpers drive visible controls, canvas coordinates, hover,
  panel modes, and route transitions; assertions then inspect widgets, painter
  fields, semantics, fake requests, router paths, or provider state.
- `[D]` The four fake writers capture requests in memory and synthesize writer
  results. They demonstrate the production call boundary, not canonical
  persistence internals.
- `[D]` Successful simulated writes are observed through `_readProjectState`
  as returned-event mirroring plus stale projection state, while the original
  fixture remains unchanged.
- `[D]` Project-hub filesystem checks use a synchronous temporary directory,
  navigate one destination at a time, settle the Navigator, and assert that no
  project files or events were produced.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `BoardCanvasScreen` and its maintained production map | system under test / inspect-only map | Supplies the behavior under test; production responsibility ownership remains independent. |
| `projectStateProvider`, `ProviderScope`, `ProjectState` | fixture input and observation | Injects projected state and reads post-result local projection state. |
| `buildTraceBenchRouter`, `GoRouter`, `MaterialApp.router` | routed harness | Verifies canonical entry, redirect, Measure Sheet, and project-hub destinations. |
| Four V2 writer interfaces and providers | outbound test doubles | Capture add, edit, placement, and measurement requests and return controlled results. |
| BoardFact models and `TraceBenchEvent` data | fixture and assertion input | Builds components, placements, measurements, traces, alignments, and returned events. |
| Flutter widget, gesture, semantics, and painter APIs | test driver and observation | Controls viewports, input, rendering frames, semantics, and custom-painter state. |
| `dart:io` temporary directories and source reads | test-only filesystem fixture / inspection | Supports zero-file assertions and a read-only source-boundary regression. |
| BenchBeep theme and app/router owners | imported behavior | Supplies theme tokens and route configuration without test ownership. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Screen action → four fake-writer request lists | `CANONICAL_EVENT` boundary exercised | `[D]` The fake records that production invoked an existing writer interface; the fake itself does not prove persistence. |
| Returned fake event → `_readProjectState` assertions | `PROJECTION_STATE` observed | `[D]` Tests check mirrored events and `isProjectionStale` separately from the unchanged input fixture. |
| Selection, hover, filter, draft, ghost, panel, focus, and badge actions | `UI_LOCAL` | `[D]` Tests assert in-memory UI effects with empty writer requests where no explicit save occurs. |
| Painting, semantics, inspector, readiness, and route navigation | `ZERO_WRITE` | `[D]` These families inspect output or change location without exercising a project writer. |
| `Directory.systemTemp.createTempSync` and teardown deletion | `NONCANONICAL_FILE` test fixture | `[D]` The synchronous directory lifecycle is harness-only and outside product persistence. |
| Empty recursive directory assertions after project-hub navigation | absent `NONCANONICAL_FILE` product output | `[D]` Exact-route tests verify navigation creates no project files. |
| `File(...).readAsStringSync()` in the source-boundary test | `ZERO_WRITE` | `[D]` The guard reads production source text and does not modify it. |

Canonical event meaning, writer implementation, event/fact schemas, Project ZIP,
projection materialization, placement coordinates, net/electrical meaning, and
evidence promotion remain owned by their exact production and semantic owners.

## Zero-write zones

- `[D]` Navigator, hover, filtering, selection, focus, pan/zoom, route, painter,
  semantics, inspector, readiness, and evidence tests include no real writer.
- `[D]` Guard and draft tests prove fake request lists remain empty until the
  exact explicit save action.
- `[D]` Project-hub navigation checks all four fake request lists, fixture and
  provider events, stale status, and directory contents.
- `[D]` Painter and source-string inspection are observational; they do not
  promote visual evidence or mutate runtime owners.
- `[D]` Writer doubles are observers of imported boundaries, not substitute
  canonical implementations.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests | Escalation |
| --- | --- | --- | --- | --- | --- |
| Fixtures/harness | `[D]` shared providers and state builders | All families; production zones 1–11 | `ZERO_WRITE` setup | `shows no-project state when project is not loaded` | Full target; broader Flutter for imported provider, model, or theme drift. |
| Shell/routes | `[D]` direct and routed mounts | Harness, rail/focus; production zones 1, 11 | `ZERO_WRITE` | `/project is the named canonical board canvas route`; `/project/board-canvas redirects once to canonical /project` | Full target for shared route harness; broader Flutter for app/router drift. |
| Navigator/filter | `[D]` interaction and painter helpers | Measurement, geometry, responsive; production zones 2–4 | `UI_LOCAL` | `component navigator maps types into the fixed category order`; `hide unmeasured removes menu rendering and hit eligibility` | Focused family; full target for shared selection/filter helpers; broader Flutter for production behavior drift. |
| Measurement | `[D]` target, fake request, provider assertions | Filter, placement, inspector; production zones 4, 5, 10 | `UI_LOCAL` + exercised `CANONICAL_EVENT` | `integrated Measure panel saves measurement only from explicit Salvesta` | Focused family; full target for shared fake/state changes; broader Flutter for writer/model drift. |
| Component create/edit | `[D]` two request-capturing fakes | Selection and stale projection; production zone 6 | exercised `CANONICAL_EVENT` | `Add Component right panel creates component identity only from explicit action`; `Board Canvas metadata edit saves selected component update explicitly` | Focused family; full target for fixture/fake changes; broader Flutter for writer/provider drift. |
| Placement | `[D]` draft coordinates and placement fake | Canvas geometry and painter; production zones 7–9 | `UI_LOCAL` + exercised `CANONICAL_EVENT` | `Add Component Salvesta writes placement only on explicit user action`; `clicking board canvas moves Add Component ghost as local draft only` | Focused family; full target for shared placement helpers; broader Flutter for writer/coordinate drift. |
| Canvas interaction | `[D]` coordinate taps and painter selection | Painter, semantics, badges; production zones 8, 9 | `UI_LOCAL` | `board canvas supports pan/zoom affordances with fit reset and stays read-only`; `tap selection stays aligned after canvas transform` | Focused family; full target for shared tap/painter helpers; broader Flutter for transform or hit-path drift. |
| Painter/semantics | `[D]` dynamic painter and label inspection | Hit geometry, filter, inspector; production zones 4, 8, 9 | `ZERO_WRITE` | `renders visual footprint forms for board placements`; `footprint pin visuals stay faithful to projected pin sources` | Focused family; full target for painter helpers; broader Flutter for production painter/model drift. |
| Inspector/evidence | `[D]` projected summaries and safety controls | Selection, measurement, painter; production zone 10 | `ZERO_WRITE` | `measurement summary shows safe copy and verbatim value`; `visual trace summary shows safe copy and metadata fields` | Focused family; full target for shared fixtures; broader Flutter for production projection/view drift. |
| Rail/project/focus | `[D]` panel helpers, router path, viewports | Every reachable panel; production zones 1, 11 | `UI_LOCAL` + `ZERO_WRITE` | `medium Workbench exposes Projekt rail action and exact hub`; `Projekt hub preserves existing panel modes and focus restoration` | Medium/wide/focus families; full target for panel/router helpers; broader Flutter for router/layout-owner drift. |
| Boundary guards | `[D]` state, fake, filesystem, source assertions | Cross-cutting | observed `PROJECTION_STATE`; absent persistent writes | `Projekt hub actions navigate to exact existing routes without writes`; `board canvas source keeps read-only data-path boundaries` | Full target; broader Flutter whenever the imported production data path changes. |

A shared harness, provider override, fake, event builder, or cross-zone helper
change has whole-file blast radius and requires the full target test file after
focused diagnosis. Imported production, router, writer, model, provider, or
theme contract drift also requires broader `flutter test` validation.

## Relevant tests and helpers

| Family | Stable helpers / fixtures | Representative coverage |
| --- | --- | --- |
| State and mounting | `_inlineProjectState`, `_componentNavigatorState`, `_harness`, `_routerHarness`, `_readProjectState` | Empty/loaded state, shell, route, provider, and projection assertions. |
| Interaction and routing | `_selectPlacement`, `_openSafetyEvidence`, `_openWideContextMode`, `_tapCanvasAtNormalized`, `_tapWidgetByKey`, `_pumpUntilRouterPath`, `_hoverWidgetByKey` | Selection, rail/panel/focus, canvas, hover, filter, and exact-route flows. |
| Rendering | `_boardCanvasPainter`, painter field helpers, `_canvasSemanticsLabels`, `_expectStableComponentPreviewGeometry` | Footprints, pins, preview/dim/selection state, badges, semantics, and hit alignment. |
| Writer boundaries | Four event JSON builders; `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_FakePlacementWriter`, `_FakeSaveMeasurementWriter` | Explicit saves, validation guards, errors, idempotency, returned events, and stale projection. |
| Boundary regression | Synchronous temp directories; `board canvas source keeps read-only data-path boundaries` | Navigation no-write proof and selected static data-path exclusions. |

## Dangerous combinations

- `[H]` Replacing synchronous temp-directory setup with awaited real filesystem
  work can stall the widget-test fake-async environment before construction.
- `[H]` Router URI equality can precede Navigator transition completion; without
  settling, outgoing and incoming `BoardCanvasScreen` instances can coexist.
- `[P]` Shared fixture, harness, provider, fake, or event-builder changes can
  drift unrelated behavior families and projection expectations together.
- `[P]` Navigator/filter changes couple visible entries, hover, hit eligibility,
  measurement targets, painter cues, semantics, and responsive reachability.
- `[P]` Painter geometry plus coordinate taps can desynchronize visible forms,
  semantic regions, measurement badges, and hit selection.
- `[P]` Placement ghost conversion plus request assertions can cross the
  UI-local draft boundary into canonical normalized-coordinate behavior.
- `[P]` Rail, panel, focus, and viewport changes can make actions unreachable
  while their prior state remains active.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One navigator/filter assertion | `_selectPlacement`, `_hoverWidgetByKey` | Painter, measurement targets, responsive reachability | Exact navigator/filter family |
| One painter or hit-alignment assertion | `_boardCanvasPainter`, `_tapCanvasAtNormalized` | Semantics, badges, selection | Exact footprint/geometry family |
| One measurement guard assertion | `_FakeSaveMeasurementWriter` | Targeting, provider stale state | Exact integrated Measure family |
| One component writer assertion | `_FakeAddComponentWriter` or `_FakeEditComponentWriter` | Selection and returned-event state | Exact create or edit family |
| One placement draft/save assertion | `_FakePlacementWriter`, `_tapCanvasAtNormalized` | Bounds, painter, provider state | Exact template/ghost/save family |
| One rail/panel behavior | `_openWideContextMode`, `_tapWidgetByKey` | Medium/wide and focus restoration | Exact panel plus responsive family |
| One route lifecycle assertion | `_pumpUntilRouterPath` | Router harness and destination teardown | Canonical route plus project-hub family |

These slices are decomposition guidance only. They do not authorize edits,
files, scope expansion, refactors, or protected-surface changes.

## Future extraction seams

| Observed test cohesion seam | Evidence | Authorization |
| --- | --- | --- |
| Repeated project fixtures and viewport setup | `[S]` Many families compose the same accepted state and surface sizes. | `NONE` |
| Four writer doubles and event builders | `[S]` Request capture and result synthesis follow parallel test-only shapes. | `NONE` |
| Router destination and temp-directory setup | `[S]` Exact-route checks share lifecycle and no-write assertions. | `NONE` |
| Analytical behavior-family organization | `[S]` The flat test body contains recurring families without `group()` ownership. | `NONE` |

These observations neither recommend nor authorize extraction.

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for helper or title `SYMBOL_DRIFT`, harness/provider or
  route `FLOW_DRIFT`, writer/filesystem `BOUNDARY_DRIFT`, linked-family
  `TEST_DRIFT`, or family-ownership `STRUCTURE_DRIFT`.
- Recheck lifecycle claims when temp-directory creation, router settling,
  viewport teardown, provider overrides, or fake-writer result flow changes.
- Recheck production-map coupling when linked Board Canvas zones or imported
  router, writer, model, provider, or theme contracts change materially.
- Formatting, comments, imports, and physical line movement alone do not
  require a map update. Accepted committed source remains authoritative.

## Known uncertainty

- `[D]` Responsibility families are analytical; the source does not assign
  them through `group()` declarations.
- `[P]` `_boardCanvasPainter` uses dynamic test-only inspection of private
  painter state and is more sensitive to source structure than public behavior.
- `[P]` Static source-string assertions prove selected source shape, not the
  runtime absence of every possible side effect.
- `[S]` Local router harnesses and fake writer results do not verify destination
  internals, router disposal ownership, canonical persistence, or writer
  implementation details.
- `[S]` Extraction observations are unmeasured and cannot authorize scope,
  files, mandatory tests, protected changes, or refactors.
