# Code Map: `test/widget/board_canvas_screen_test.dart`

- Source: `test/widget/board_canvas_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3000 lines + 3+ test families`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This 178-declaration Board Canvas widget-test owner supplies explicit-fresh
fixtures, seeded-ProjectSession direct/production-router harnesses, writer doubles, interaction and
painter assertions, read-only Wizard overlay coverage, local panel/focus
evidence, direct deterministic measurement read-model characterization through
an explicit `measurement_projection.dart` import, nine direct pure placement-
geometry tests through an explicit `placement_geometry.dart` import, and a
routed six-width responsive contract. Its static boundary test reads the Board
Canvas host, Wizard overlay part, and geometry library separately; geometry
ownership assertions target only `geometrySource`, while the candidate-rotation
painter slice remains isolated in the Wizard source. Project-wide
destination inventory and navigation belong to the shared-shell suite; this
file proves the Canvas remains rich across that shell cutover and has no
competing local Project hub or rail control.

## Qualification

`[D]` Committed source contains 178 declarations (`155` `testWidgets` plus `23`
`test`) across more than three behavior families and exceeds 3,000 lines. Its
flat structure has no single meaningful `group()` ownership, so families are
derived from stable helpers, doubles, and exact test names.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Fixtures and harness lifecycle | `_inlineProjectState`, `_wizardIntake`, `_componentNavigatorState`, `SeededProjectSession`, `_harness`, `_routerHarness`, `_readProjectState`, `_replaceProjectState` | Builds state, seeds sessions, mounts direct/routed screens, observes current state, and performs explicit generation-valid test replacements. |
| 2. Theme, shell, and route baselines | `buildTheme exposes BenchBeep semantic visual tokens`, `/project is the named canonical board canvas route`, `/project/board-canvas redirects once to canonical /project` | Verifies theme, empty/loaded shell, canonical entry, and compatibility alias. |
| 3. Navigator, selection, hover, and filter | `_selectPlacement`, `_hoverWidgetByKey`, `_painterPreviewKeys`, `_painterDimmedKeys`, `_canvasSemanticsLabels` | Exercises typed selection, category drill-down, hover, ordering, counts, and hide-unmeasured behavior. |
| 4. Measurement entry, association, and pure read-model characterization | `_FakeSaveMeasurementWriter`, `_measurementRecordedEventJson`, `_expectStableComponentPreviewGeometry`, `measurementValueBadgesByComponents`, `measurementHasScalarValueAndUnit`, `measurementValueBadgeText`, `measurementValidityNeedsCaution` | Covers target/draft/save, Measure Sheet navigation, endpoint/count association, characterized badge ordering/fallback, scalar/unit eligibility, exact badge text, and stale/invalid/suspect caution classification. |
| 5. Component create and edit | `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_componentCreatedEventJson`, `_componentUpdatedEventJson` | Verifies guarded identity creation/edit requests, errors, returned events, and idempotency. |
| 6. Placement builder, draft, ghost, and save | `_FakePlacementWriter`, `_placementWriterEventJson`, `_tapCanvasAtNormalized`, `_tapWidgetByKey`, `Add Component idempotent Salvesta leaves duplicate state unchanged` | Exercises template selection, local drafts, ghost movement, normalized bounds, explicit save, accepted-event stale promotion, and duplicate-result no-op behavior. |
| 7. Canvas interaction, Wizard fit, and placement geometry | `_wizardIntakePainter`, `_wizardPhotoLayer`, `initial fit runs once for each active project and intake`, `placement geometry read model`, `_geometryPlacement`, `_geometryTemplate`, `_geometryTemplateWithPinCount` | Verifies pan/zoom, hit selection, aspect mapping, fallback, padding, one initial fit, alignment, badges, and nine pure center/body/envelope/classifier/maximum/upright-hit contracts. |
| 8. Painter, overlay, footprint, and semantics | `_boardCanvasPainter`, `_compositedPixelColor`, `_canvasSemanticsLabels`, `geometrySource` | Inspects composite order/pixels, read-only Wizard geometry, Board/Wizard rotation separation, footprint/pin rendering, cues, semantics, fallbacks, and separate host/Wizard/geometry source ownership. |
| 9. Inspector, readiness, and evidence | `_openSafetyEvidence`, `_openWideContextMode`, `readiness panel` | Verifies projected inspector content, readiness/safety wording, measurements, and visual-trace metadata. |
| 10. Local panels, focus, and routed responsive layout | `routed Board Canvas stays rich across the shell cutover`, `Workbench panel modes preserve focus restoration`, `wide Workbench starts with hidden right context panel`, `board_canvas_project_navigation_hub` | Proves exact six-width shell modes, continuous rich Canvas, hidden default, retained panels/focus, and absence of local Project navigation. |
| 11. Volatility and protected-boundary guards | `selection state is volatile in memory only`, `events.jsonl`, `event_writer_service.py` | Asserts volatile-only state, unchanged provider/files, empty unintended writer requests, and static source boundaries. |
| 12. Projection freshness | `unknown freshness warning keeps Board Canvas usable`, `ProjectionStaleBanner.unknownPrimaryText` | Proves distinct unknown warning, usable workspace, explicit fresh fixtures, accepted-event stale promotion, and duplicate-result state preservation. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed test source. The map uses no line-number anchors.

## Routed responsive and local-panel contract

The production-router case resizes one loaded Board Canvas through:

1. `959` — compact shared navigation, rich local Workbench
2. `960` — compact shared navigation, rich local Workbench
3. `1227` — compact shared navigation, rich local Workbench
4. `1228` — persistent shared navigation, rich local Workbench
5. `1229` — persistent shared navigation, rich local Workbench
6. `1500` — persistent shared navigation, rich local Workbench

At every width it asserts one `WorkbenchShell`, the expected shared navigation
key, `board_canvas_workbench_shell` present, compact `board_canvas_control_band`
absent, identical `projectStateProvider`, and no exception.

Direct wide cases prove the local context panel starts hidden; no
`board_canvas_rail_project_tool` or Project hub exists; Measure, Add, Inspector,
Placements, and Safety tools remain; and a retained selected panel survives
focus hide/restore without events or freshness changes.

## State and data flow

- `[D]` `_inlineProjectState` defaults explicitly to fresh unless a case selects
  stale/unknown behavior.
- `[D]` `_harness` and `_routerHarness` seed `SeededProjectSession`; four
  replaceable writers remain controlled while routed cases exercise the outer
  shared shell.
- `[D]` `_replaceProjectState` uses generation-current
  `replaceWithReloaded` for tests that intentionally swap fixtures after mount;
  no external notifier-state assignment remains.
- `[D]` The six-width case pairs shell-mode assertions with local Canvas rich
  geometry, so navigation cutover alone cannot mask a destination inversion.
- `[D]` Local panel tests open retained modes through `_openWideContextMode`,
  verify hidden initial state, and preserve the active retained mode across
  focus hide/restore.
- `[D]` Wizard/painter helpers inspect accepted presentation input and composite
  output without creating canonical data.
- `[D]` `board canvas source keeps read-only data-path boundaries` separately
  reads the host, `wizard_intake_overlay.part.dart`, and
  `placement_geometry.dart`. Geometry declaration/literal assertions target
  `geometrySource`, host call-site assertions use public geometry names, and
  the unchanged Wizard painter slice remains separate from the Board painter
  rotation-negative slice.
- `[D]` Direct `test` declarations import the normal measurement library and
  characterize pure endpoint/count helpers,
  lexical distinct-nonblank-ID ordering with equal/empty-ID index fallback,
  scalar/unit eligibility, exact value-unit text, and validity caution without
  mounting widgets or invoking a writer.
- `[D]` Nine direct `test` declarations import the normal placement-geometry
  library and characterize center clamp/conversion, body-size precedence,
  every visual-kind envelope, exact template mappings, classifier branches,
  visual maxima, upright hit boundaries, and ignored nonzero rotation without
  mounting widgets or invoking a writer.
- `[D]` Successful simulated writer calls are observed through
  `_readProjectState` as ProjectSession-applied events and stale projection;
  the duplicate placement result is rejected without changing freshness.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `BoardCanvasScreen` and production map | system under test / map input | Supplies destination behavior and local responsibilities. |
| `measurement_projection.dart` and production map | direct pure-helper system under test / map input | Supplies endpoint/count, badge ordering, scalar/text, and presentation-caution behavior without mounting the screen. |
| `placement_geometry.dart` and production map | direct pure-helper system under test plus source-read / map input | Supplies center/body/visual sizing, minimum envelopes, visual-kind/template classification, and upright hit behavior without mounting the screen; its source is read separately for physical-ownership guards. |
| `wizard_intake_overlay.part.dart` and production map | direct source-read / map input | Supplies the physically moved Wizard fit/photo/painter declarations and the painter-to-EOF structural slice. |
| `WorkbenchShell` | routed outer composition | Supplies compact/persistent project navigation without entering Board source. |
| `projectStateProvider`, `SeededProjectSession`, `ProviderScope`, `ProjectState` | fixture / observation | Seeds state and proves responsive/session invariance, guarded replacement, or post-write application. |
| `buildTraceBenchRouter`, `GoRouter`, `MaterialApp.router` | routed harness | Verifies canonical entry, alias, Measure Sheet, and shared-shell composition. |
| Four V2 writer interfaces/providers | test doubles | Capture add, edit, placement, and measurement requests/results. |
| BoardFact models and `TraceBenchEvent` | fixture/assertion input | Build projected facts and returned events. |
| `WizardIntake` family | fixture/assertion input | Builds optional aspect/photo/contour/problem/candidate presentation. |
| Flutter widget, gesture, semantics, painter APIs | driver/observation | Controls viewports/input/rendering/semantics/private painter state. |
| `dart:io` temporary directories and source reads | harness-only file boundary | Supports zero-write fixtures plus separate host, Wizard-part, and placement-geometry static source reads; the measurement library is not source-read. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Screen action -> four fake request lists | exercised `CANONICAL_EVENT` | `[D]` Fakes observe existing interfaces; they do not prove persistence internals. |
| Returned fake event -> `_readProjectState` | observed `PROJECTION_STATE` | `[D]` Separates ProjectSession application/dedup/stale promotion from input fixtures. |
| `_replaceProjectState` | observed `PROJECTION_STATE` | `[D]` Uses generation-valid session replacement only for test fixture transitions. |
| Selection, hover, filter, draft, ghost, local panel, focus, badges | `UI_LOCAL` | `[D]` In-memory effects; no request before explicit save. |
| Shared-shell responsive navigation observation | `ZERO_WRITE` | `[D]` Route/layout changes retain provider identity and rich Canvas state. |
| Wizard gate/photo/fit/composite/candidate taps | `ZERO_WRITE` | `[D]` Intake/facts/events and four fake lists remain unchanged. |
| Temp directory setup/teardown | `NONCANONICAL_FILE` | `[D]` Harness-only and outside product persistence. |
| Production source string reads | `ZERO_WRITE` | `[D]` Read the host, Wizard part, and geometry library separately without modifying them; ownership and Board/Wizard rotation assertions remain source-specific. |

Canonical event meaning, writer implementation, schemas, Project ZIP,
materialization, coordinates, electrical meaning, and evidence promotion stay
owned by their production/canonical owners.

## Zero-write zones

- Routed responsive, shell-presence, hidden-default, panel/focus, theme, route,
  painter, Wizard, inspector, and freshness assertions invoke no writer action.
- Negative local Project-hub/rail assertions guard against duplicate navigation
  without owning the shared destination model.
- Static source and provider observations are read-only.
- Direct placement-geometry tests and source reads are `ZERO_WRITE`; they mount
  no widget and invoke no writer.

## Impact matrix

| Family | Direct evidence | Coupling | Write class | Escalation |
| --- | --- | --- | --- | --- |
| Fixtures/harness | `[D]` state/providers/router/fakes | whole file | setup | full target |
| Route/shared-shell responsive | `[D]` six routed widths | shell threshold, Board 900/framing | `ZERO_WRITE` | routed case + shell suite |
| Local panels/focus | `[D]` hidden default and retained modes | local rail/selection | `UI_LOCAL` | panel/focus cases |
| Navigator/filter | `[D]` helpers/painter observations | targets, geometry, responsive | `UI_LOCAL` | exact family + full target |
| Measurement read model | `[D]` direct normal-library import, endpoint/count tests, and four helper characterizations | normal-library implementation and unchanged host consumers | `ZERO_WRITE` | exact helper declarations + full target |
| Writers/session | `[D]` four fakes/results and seeded session observations | selection/generation/dedup/freshness | exercised `CANONICAL_EVENT` + observed `PROJECTION_STATE` | exact writer family + session unit suite + full target |
| Canvas/geometry/Wizard | `[D]` transforms/pixels/painter state, nine pure geometry tests, and retargeted three-source guard | z-order/hits/semantics, normal geometry API, upright Board painter, and Wizard final-declaration coupling | `UI_LOCAL` / `ZERO_WRITE` | exact pure geometry/render cases + structural boundary declaration |
| Inspector/evidence | `[D]` projected summaries | selection/measurement | `ZERO_WRITE` | exact family + full target |
| Freshness/boundaries | `[D]` explicit states/source guards | cross-cutting | `ZERO_WRITE` / observed projection | full target + integration |

## Relevant tests and helpers

| Family | Stable anchors | Representative coverage |
| --- | --- | --- |
| Shared shell / local responsive | `_routerHarness`, routed six-width case | Compact/persistent cutover, rich Canvas continuity, provider identity. |
| Local panels/focus | `_openWideContextMode`, `_tapWidgetByKey` | Hidden default, five retained tools, panel mode and focus restoration, no local Project hub. |
| State/mounting | `_inlineProjectState`, `_componentNavigatorState`, `SeededProjectSession`, `_harness`, `_readProjectState`, `_replaceProjectState` | No-project/project shell, session replacement, provider, and projection assertions. |
| Rendering/Wizard | `_wizardIntake`, `_wizardIntakePainter`, `_wizardPhotoLayer`, `_boardCanvasPainter`, `_compositedPixelColor`, `board canvas source keeps read-only data-path boundaries` | Gate, fit, z-order, photo, rotation, footprints/pins, and exact source-owner retarget. |
| Interaction | `_selectPlacement`, `_tapCanvasAtNormalized`, `_hoverWidgetByKey`, `_canvasSemanticsLabels` | Selection, hover, filter, hit alignment, semantics. |
| Placement geometry | `placement geometry read model`, `_geometryPlacement`, `_geometryTemplate`, `_geometryTemplateWithPinCount` | Nine direct tests for clamp/conversion, sizing precedence, all envelopes, exact mappings, classifier precedence, visual maxima, upright edges, and ignored rotation. |
| Measurement read model | `measurementValueBadgesByComponents`, `measurementHasScalarValueAndUnit`, `measurementValueBadgeText`, `measurementValidityNeedsCaution` | Directly imported normal-library endpoint/count association plus characterized ordering/fallback, eligibility, exact formatting, and caution contracts. |
| Writer/session boundaries | Four fake writers, event builders, and session observations | Explicit saves, guards, errors, identity dedup, accepted stale promotion, and duplicate no-op state. |

## Dangerous combinations

- Checking only shared navigation keys would miss a Board rich/compact
  inversion; local layout keys must remain paired at all six widths.
- Reintroducing local Project-hub helpers/tests would duplicate shared-shell
  inventory and zero-write ownership.
- Surface-size tests must restore global binding state.
- Shared harness/session changes can alter many unrelated painter/writer
  families.
- Placement ghost conversion plus requests can cross from UI-local drafts into
  canonical normalized-coordinate behavior.
- Placement-geometry behavior affects hit selection, badges, labels, painter
  and semantics bounds. Do not combine pure API changes with painter movement,
  rotated hit testing, State/provider/writer work, or static-guard broadening.
- Pure measurement helper expectations must not be combined with writer/event
  semantic changes; the direct declarations prove `ZERO_WRITE` read-model
  behavior only.
- The Wizard source guard currently slices from `_WizardIntakePainter` to EOF.
  Adding any later declaration can broaden that structural assertion surface;
  moving or reordering the painter requires review of the same test.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Shell cutover vs Board layout | routed six-width case | shell source/test and Board 900 cutover | exact routed case + both focused suites |
| One local panel/focus behavior | `_openWideContextMode`, matching test | shared navigation absence | hidden/focus/panel cases |
| One Wizard render assertion | painter/photo/pixel helpers or exact source guard | fixtures/z-order/hit path and part declaration order | exact overlay cases or structural declaration + full target |
| One writer assertion | corresponding fake writer | selection/result/freshness | exact writer family |
| One measurement read-model assertion | exact helper/test title | host consumers and writer family | direct helper declarations |
| One placement-geometry assertion | exact public API/test title | host interaction, badge, label, painter, and semantics consumers | exact pure geometry declaration plus source guard |
| One freshness assertion | explicit freshness fixture | scaffold/provider/integration | exact warning case + full target |
| One writer-result application | matching fake/event title | ProjectSession generation/dedup contract | matching writer family + session unit suite |

## Future extraction seams

- `[S]` Shared six-width expectation values could be a pure test fixture only
  if Board and Overview retain separate destination geometry assertions.
- `[S]` Local panel/focus helpers are cohesive but cannot regain project-wide
  navigation ownership.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for helper/title, harness/session/route,
writer/filesystem, linked-family, source-read ownership, or family-ownership
drift. Recheck exact test count (`178 = 155 testWidgets + 23 test`), both direct
normal-library imports, the nine placement-geometry and four measurement
helper contracts, the separate `hostSource` / `wizardOverlaySource` /
`geometrySource` ownership guard, all six widths, shell/Board keys, hidden
default, five retained local tools, focus restoration, and negative Project
hub/rail evidence after related changes. Recheck the painter-to-EOF slice if
the Wizard part's painter ceases to be its final declaration. Formatting,
comments, imports, and line movement alone do not stale the map.

## Known uncertainty

- `[D]` Families are analytical; source has no owning `group()` hierarchy.
- `[P]` Dynamic private-painter inspection is more structure-sensitive than
  public behavior.
- `[D]` `_WizardIntakePainter` is currently the final Wizard-part declaration;
  the EOF slice is deliberate structural coupling, not product behavior
  authority or a product bug.
- `[S]` Routed shell coverage does not transfer shell metadata ownership into
  this destination test owner.
