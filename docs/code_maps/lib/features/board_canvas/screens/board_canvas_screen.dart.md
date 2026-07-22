# Code Map: `lib/features/board_canvas/screens/board_canvas_screen.dart`

- Source: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — >5000 lines + 3+ responsibilities`
- Audit evidence: `docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_PASS.md`

## File purpose

This file owns the Visual First Board Canvas screen: responsive Workbench shell,
component navigation and selection, canvas interaction and rendering, contextual
inspection, UI-local drafts, zero-write navigation to existing project views,
and explicit calls into four existing canonical writer services. It reads
projected facts for display; source, tests, canonical owners, and active locks
outrank this descriptive map.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen orchestration | `BoardCanvasScreen`, `_BoardCanvasScreenState`, `_WorkbenchContextPanelMode`, `_buildScaffold` | Watches project state, derives screen inputs, switches contextual modes, and composes the Workbench. |
| 2. Typed selection and preview | `CanvasSelection`, `EmptyCanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection`, `_setCanvasSelection`, `_setPreviewPlacementKeys` | Owns volatile component/placement selection and temporary hover-preview keys. |
| 3. Component navigator | `_ComponentCategory`, `_componentCategoryFor`, `_naturalComponentIdCompare`, `_ComponentNavigatorPanel` | Derives fixed categories, sorts components, groups placed/unplaced entries, and drives drill-down/hover. |
| 4. Visibility filtering | `_toggleHideUnmeasuredComponents`, `measurementCountsByComponents`, `measurementValueBadgesByComponents`, `_CanvasPanel` | Applies hide-unmeasured state across navigator, visible canvas entries, targeting, hit eligibility, preview, and badges. |
| 5. Measurement entry | `_IntegratedMeasurePanelState`, `_saveMeasurement`, `_MeasureTargetRow`, `_appendMeasurementEventAndMarkStale` | Builds technician targets and drafts, invokes explicit measurement save, and mirrors the returned event into stale local projection state. |
| 6. Component create/edit | `_RightPanelComponentCreationSection`, `_confirmRightPanelComponentCreation`, `_RightPanelMetadataEditSection`, `_confirmRightPanelMetadataEdit` | Validates explicit identity creation and selected-component metadata edits before calling their writers. |
| 7. Placement draft/save | `_AddComponentTemplateBuilderPanel`, `_PlacementEditorDraftState`, `_PlacementSaveTarget`, `_confirmAddComponentTemplatePlacement` | Owns template/ghost/editor drafts, normalized placement guards, and explicit visual-placement save. |
| 8. Canvas interaction | `_CanvasPanelState`, `_selectPlacementAt`, `_fitCanvasView`, `_renderedPlacementContains`, `_renderedPlacementCenter` | Handles tap selection, ghost dragging, pan/zoom reset, coordinate conversion, and hit testing. |
| 9. Visual rendering | `_BoardPlacementPainter`, `_FootprintPreviewPainter`, `_RectangularPerimeterTemplatePreviewPainter`, `_footprintVisualKind`, `_footprintPinRenderPlan` | Paints projected footprints, previews, selection/hover cues, measurement cues, and semantics without writes. |
| 10. Inspector and evidence | `_InspectorPanel`, `_PhotoAlignmentReadinessPanel`, `_BoardCanvasSafetyEvidenceDisclosure`, `_MeasurementSummaryCard`, `_VisualTraceMetadataCard` | Presents placement, measurement, alignment, safety, and visual-trace context without promoting evidence. |
| 11. Rail, focus, responsive chrome | `_WorkbenchToolRail`, `_WorkbenchPanelModeButton`, `_CanvasFocusButton`, `_CanvasFocusRestoreBar`, `_BoardCanvasControlBand` | Adapts medium/wide layout, panel topology, rail actions, and canvas-focus chrome. |
| 12. Project navigation hub | `_WorkbenchContextPanelMode.projectNavigation`, `_ProjectNavigationHub`, `_ProjectNavigationHub._action` | Exposes seven existing project-view destinations through `context.go`; it owns no route definition or persistence. |

## State and data flow

- `[D]` `projectStateProvider` supplies `ProjectState`; projected components,
  placements, pins, measurements, traces, and alignments are derived into
  `_PlacementEntry` collections and presentation models.
- `[D]` `_BoardCanvasScreenState` owns selection, preview, filtering, panel,
  focus, template, metadata, and badge-visibility state; these feed navigator,
  inspector, `_CanvasPanel`, and painter inputs.
- `[D]` `_ComponentNavigatorPanel` and `_CanvasPanelState` send selection,
  preview, filter, tap, and ghost-anchor callbacks back to screen-local state.
- `[D]` The `Projekt` rail action selects the project-navigation context mode;
  `_ProjectNavigationHub` sends one of seven fixed existing locations to
  `context.go` without calling a writer or mutating project state.
- `[D]` Explicit create, edit, placement, and measurement actions construct
  requests and call their dedicated writer providers; button copy alone is not
  treated as write evidence.
- `[D]` Successful writer results flow through `_markPlacementProjectionStale`
  or `_appendMeasurementEventAndMarkStale`, which mirror returned events into
  `projectStateProvider` and set `isProjectionStale`.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider`, `ProjectState` | input and local projection update | Supplies accepted project state and receives post-write stale-state mirroring. |
| `ComponentFact`, `ComponentVisualPlacementFact`, `MeasurementFact`, `VisualTraceFact`, `KnownFacts` pin projection | input | Projected facts used for targeting, inspection, badges, and rendering. |
| `v2AddComponentWriterProvider` | outbound | Existing `component_created` writer boundary. |
| `v2EditComponentWriterProvider` | outbound | Existing `component_updated` writer boundary. |
| `v2PlacementWriterProvider` | outbound | Existing `component_visual_placement_confirmed` writer boundary. |
| `v2SaveMeasurementWriterProvider` | outbound | Existing `measurement_recorded` writer boundary. |
| `TraceBenchEvent` | inbound from writer result | Parses returned events before local stale-state mirroring. |
| `VectorFootprintLibrary`, `FootprintTemplate` | input | Supplies visual/package geometry; it does not prove identity or electrical function. |
| Flutter gestures, semantics, and `CustomPainter` | UI/rendering | Owns interaction, accessibility regions, and zero-write drawing. |
| `GoRouter` | outbound navigation | Opens the existing Measure Sheet route and seven fixed Project Navigation Hub destinations without a project write. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_confirmRightPanelComponentCreation` → `v2AddComponentWriterProvider` | `CANONICAL_EVENT` | `[D]` Explicit action builds `V2AddComponentRequest` and calls `addComponent`. |
| `_confirmRightPanelMetadataEdit` → `v2EditComponentWriterProvider` | `CANONICAL_EVENT` | `[D]` Selected existing component and non-empty changes guard `editComponent`. |
| `_confirmAddComponentTemplatePlacement` → `v2PlacementWriterProvider` | `CANONICAL_EVENT` | `[D]` Bounds, target, directory, and explicit save guard `confirmPlacement`. |
| `_IntegratedMeasurePanelState._saveMeasurement` → `v2SaveMeasurementWriterProvider` | `CANONICAL_EVENT` | `[D]` Explicit `Salvesta` builds a human-entered measurement request. |
| `_markPlacementProjectionStale` | `PROJECTION_STATE` | `[D]` Mirrors a returned event into local `ProjectState.events` and sets `isProjectionStale`; it does not call a writer. |
| `_appendMeasurementEventAndMarkStale` | `PROJECTION_STATE` | `[D]` Deduplicates the returned event in local provider state and marks projection stale. |
| Selection, preview, filtering, drafts, ghost drag, focus, rail, badge visibility | `UI_LOCAL` | `[D]` Mutated only through widget state/controllers and callbacks. |
| Project rail mode → `_ProjectNavigationHub` → `context.go` | `UI_LOCAL` + `ZERO_WRITE` | `[D]` Selects a context panel and changes location only; it calls no project writer and creates no project file. |
| Painters, inspectors, summaries, category/measurement helpers | `ZERO_WRITE` | `[D]` Consume inputs and return widgets, paint output, labels, or derived collections. |
| Noncanonical project-file output | `NONCANONICAL_FILE` | `[D]` No such write call path exists in this source. |

Canonical event meaning stays writer-owned. The screen does not directly mutate
`known_facts.json`; visual placement remains separate from identity, contacts,
pins, pads, measurements, traces, nets, electrical function, and fault truth.

## Zero-write zones

- `[D]` `_BoardPlacementPainter`, `_FootprintPreviewPainter`, and
  `_RectangularPerimeterTemplatePreviewPainter` only paint and build semantics.
- `[D]` Navigator drill-down, hover preview, hide-unmeasured filtering,
  selection, focus, pan/zoom, and route navigation are UI-local or read-only.
- `[D]` `_ProjectNavigationHub` exposes only existing destinations and invokes
  `context.go`; it does not own routes, writer calls, or project persistence.
- `[D]` `_InspectorPanel`, `_PhotoAlignmentReadinessPanel`, measurement cards,
  and `_VisualTraceMetadataCard` display projected context without confirmation.
- `[D]` `knownFacts` is read as projection input; this file has no direct
  `known_facts.json`, `board_graph.json`, or `view_state.json` write path.
- `[D]` Visual traces and template/contact-marker presentation do not establish
  electrical connectivity, identity, or confirmed contacts.

## Impact matrix

| Change zone | Direct evidence | Inspect-only coupling / risk | Write class | Stop / exclude | Relevant tests |
| --- | --- | --- | --- | --- | --- |
| Screen orchestration | `[D]` mode/focus/layout composition | `[P]` rail and panel reachability | `UI_LOCAL` | Stop if route or writer behavior changes; exclude painters | `wide Workbench exposes contextual panel-mode rail and keeps focus on canvas` |
| Typed selection | `[D]` typed selection variants | `[H]` preview, inspector, filter, painter rings | `UI_LOCAL` | Exclude writer requests | `component click selects component without selecting a placement`; `category hover previews matches and preserves canvas selection` |
| Navigator | `[D]` category mapping/grouping/sort | `[H]` first-placement and filter coupling | `UI_LOCAL` | Stop on identity semantics; exclude create writer | `component navigator maps types into the fixed category order`; `navigator hover navigation and filter call no writer` |
| Visibility filter | `[D]` shared measured visibility state | `[H]` hit, badge, target, preview eligibility | `UI_LOCAL` | Stop if measurement meaning changes | `hide unmeasured removes menu rendering and hit eligibility`; `hide unmeasured Measure targets the first visible placement` |
| Measurement entry | `[D]` target/draft/save flow | `[P]` selected placement and stale-state mirroring | `CANONICAL_EVENT` | Protected writer/measurement semantics; exclude badges | `integrated Measure panel saves measurement only from explicit Salvesta` |
| Component create/edit | `[D]` guarded writer calls | `[P]` selection and stale projection | `CANONICAL_EVENT` | Protected identity/event semantics; split create from edit | `Add Component right panel creates component identity only from explicit action`; `Board Canvas metadata edit saves selected component update explicitly` |
| Placement draft/save | `[D]` local draft plus guarded save | `[P]` coordinates, template ID, first placement | `UI_LOCAL` + `CANONICAL_EVENT` | Protected placement geometry/event semantics | `Paiguta canvasele starts only the existing local placement flow`; `Add Component Salvesta writes placement only on explicit user action` |
| Canvas interaction | `[D]` tap/drag/transform/hit path | `[P]` painter geometry and selection anchor | `UI_LOCAL` | Stop if canonical coordinates change; exclude writers | `board canvas supports pan/zoom affordances with fit reset and stays read-only`; `tap-to-select leaves project state canonical data unchanged` |
| Visual rendering | `[D]` painter and semantics inputs | `[P]` hit regions, filters, badges | `ZERO_WRITE` | Stop if renderer writes or semantic promotion appears | `renders visual footprint forms for board placements`; `footprint pin visuals stay faithful to projected pin sources` |
| Inspector/evidence | `[D]` projected summaries and safety copy | `[P]` selection and evidence-floor wording | `ZERO_WRITE` | Exclude confirmation and electrical proof | `readiness panel remains project-level metadata with selection, inspector, measurement, and visual trace state`; `visual trace summary shows safe copy and metadata fields` |
| Rail/focus/responsive | `[D]` rail controls and responsive composition | `[P]` panel topology and canvas space | `UI_LOCAL` | Stop on route/topology expansion; exclude writers | `focus canvas hides rail canvas chrome and restores read-only panel`; `wide Workbench rail opens placement and safety/evidence right panel modes` |
| Project navigation | `[D]` project mode, seven fixed locations, `context.go` | `[P]` router definitions, rail/context-panel reachability, focus restoration | `UI_LOCAL` + `ZERO_WRITE` | Stop on route creation/rename or persistence; exclude writers | `Projekt hub actions navigate to exact existing routes without writes`; `Projekt hub preserves existing panel modes and focus restoration` |

## Relevant tests and helpers

`test/widget/board_canvas_screen_test.dart` is inspect-only evidence; this map
does not require or authorize a test-file map.

| Family | Stable helpers / fixtures | Representative coverage |
| --- | --- | --- |
| State and harness | `_inlineProjectState`, `_componentNavigatorState`, `_harness`, `_routerHarness` | Empty/project state, responsive shell, direct route compatibility. |
| Navigation and interaction | `_selectPlacement`, `_openSafetyEvidence`, `_openWideContextMode`, `_tapCanvasAtNormalized`, `_tapWidgetByKey`, `_pumpUntilRouterPath`, `_hoverWidgetByKey` | Drill-down, rail/focus/safety, Project Hub exact-route/no-write behavior, hover, filter, tap and placement selection. |
| Painter and semantics | `_boardCanvasPainter`, `_painterPreviewKeys`, `_painterDimmedKeys`, `_canvasSemanticsLabels`, `_expectStableComponentPreviewGeometry` | Footprint rendering, selection/hover distinction, badges, hit alignment, accessibility. |
| Writer boundaries | `_FakeAddComponentWriter`, `_FakeEditComponentWriter`, `_FakePlacementWriter`, `_FakeSaveMeasurementWriter` | Explicit writer calls, guard failures, idempotent returned events, stale projection status. |
| Boundary regression | `board canvas source keeps read-only data-path boundaries` | Source-level guard against direct projection/file writes and forbidden promotion. |

## Dangerous combinations

- `[H]` Typed selection plus global filtering affects navigator, canvas entries,
  hit testing, hover, badges, inspector, and measurement targeting together.
- `[H]` Navigator changes plus first-placement actions can cross from UI-local
  drill-down into the guarded placement workflow.
- `[P]` Painter geometry plus `_renderedPlacementContains` can desynchronize
  visible footprints, semantic regions, and tap targets.
- `[P]` Ghost coordinate conversion plus placement-request construction can
  alter canonical board-normalized placement data.
- `[P]` Measurement targeting plus hide-unmeasured filtering can select a
  target no longer eligible or visible.
- `[P]` Metadata form state plus component selection guards can update the wrong
  component if ownership is changed independently.
- `[P]` Responsive shell changes plus contextual-panel topology can make a
  writer action unreachable while leaving its state active.
- `[P]` Project Hub destination changes plus router-owner drift can make a
  zero-write action point at a missing or newly stateful route while the local
  panel still appears valid.

## Safe SNIPER slices

| One outcome | Primary symbols | Inspect only | Stop / exclude | Direct tests |
| --- | --- | --- | --- | --- |
| Category label/mapping presentation | `_ComponentCategory`, `_componentCategoryFor` | Navigator grouping and filter | Stop on identity semantics; exclude writers | `component navigator maps types into the fixed category order` |
| Navigator count copy | `measurementCountsByComponents`, `_ComponentNavigatorPanel` | Filter and measurement association | Stop on targeting/count semantics; exclude save | `category rows show explicit normal placement counts` |
| Navigator control styling | `_benchBeepNavigatorControlStyle`, `_ComponentNavigatorPanel` | Medium/wide reachability | Stop on action behavior; exclude state/write paths | `navigator actions use visible back paths and gold controls` |
| Hover cue only | `_setPreviewPlacementKeys`, `_BoardPlacementPainter` | Typed selection and filter | Stop on hit testing; exclude writers | `component hover previews only its visible placements` |
| One placement guard | `_addComponentTemplateCanonicalBoundsBlockReason`, `_confirmAddComponentTemplatePlacement` | Draft coordinates and target | Stop before request/writer semantics; exclude other writers | `Add Component blocks invalid board-normalized draft size before writer call` |
| One measurement-target guard | `_saveBlockReason`, `_MeasureTargetRow` | Selection and visible targets | Stop before writer/request changes; exclude badges | `integrated Measure panel target selection and draft capture stay local` |
| One responsive correction | `_BoardCanvasControlBand`, `_WorkbenchToolRail`, `_CanvasFocusButton` | Panel topology and canvas constraints | Stop on route/action expansion; exclude writers | `medium navigator keeps all levels and filter action reachable` |
| Painter surface detail | `_footprintVisualKind`, `_BoardPlacementPainter` | Hit geometry and semantics | Stop on semantic promotion; exclude interaction/writers | `renders visual footprint forms for board placements` |
| One Project Hub label or existing destination | `_ProjectNavigationHub`, `_ProjectNavigationHub._action` | Router owner, rail mode, focus restoration | Stop on route creation/rename or persistence; exclude all writers | `Projekt hub actions navigate to exact existing routes without writes` |

Safe slices are decomposition guidance only. They do not authorize work or
expand an allowlist. More than one independent changed zone, any writer/event
semantic change, or canonical coordinate/electrical change is
`DECOMPOSE_REQUIRED` and needs explicit scope.

## Future extraction seams

| Observed cohesion seam | Evidence | Authorization |
| --- | --- | --- |
| Selection and navigator state | `[S]` Typed variants, category state, preview, and filter have clustered consumers. | `NONE` |
| Canvas interaction and painter geometry | `[S]` Hit testing, rendered centers, transforms, and painter inputs share geometry. | `NONE` |
| Placement draft and save orchestration | `[S]` Template/editor state and guarded request construction are tightly coupled. | `NONE` |
| Integrated measurement panel | `[S]` Target rows, draft values, request building, and post-write state form a cohesive region. | `NONE` |
| Inspector/evidence presentation | `[S]` Placement, measurement, trace, alignment, and safety views are read-only peers. | `NONE` |

These observations neither recommend nor authorize extraction.

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for `SYMBOL_DRIFT`, `FLOW_DRIFT`, `BOUNDARY_DRIFT`,
  `TEST_DRIFT`, or `STRUCTURE_DRIFT` affecting mapped claims.
- Recheck the map when responsibility ownership, writer providers/requests,
  post-write stale handling, selection/filter flow, geometry, or zero-write
  painter behavior changes.
- Recheck linked helpers and behavior-family tests when the Board Canvas test
  harness or test titles change materially.
- Recheck the map when Project Hub destinations, `context.go` behavior, project
  rail reachability, or their no-write tests change materially.
- Formatting, imports, comments, and physical line movement alone do not require
  an update. Accepted committed source remains authoritative.

## Known uncertainty

- `[P]` Local mirroring of returned events is classified `PROJECTION_STATE`
  because the source updates rebuildable provider state and marks it stale; the
  canonical append remains inside imported writer ownership.
- `[S]` This map does not assert backend implementation details beyond the
  verified provider/service call boundaries; deeper writer internals require
  their exact owners.
- `[S]` Extraction seams are unmeasured hypotheses and cannot authorize files,
  refactors, scope, protected changes, or mandatory tests.
