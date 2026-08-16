# Code Map: `lib/features/board_canvas/screens/board_canvas_screen.dart`

- Source: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — >5000 lines + 3+ responsibilities`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

This file owns the Visual First Board Canvas screen: responsive Workbench,
selection/navigation, rendering, inspection, UI-local drafts, zero-write route
actions, read-only Wizard intake, tri-state freshness presentation, and four
existing writer calls. It keeps the Project hub initially discoverable while
source, tests, canonical owners, and active locks remain authoritative.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen orchestration | `BoardCanvasScreen`, `_BoardCanvasScreenState`, `_WorkbenchContextPanelMode`, `_buildScaffold` | Watches project state, defaults `_contextPanelMode` to `projectNavigation`, derives inputs, and composes the Workbench. |
| 2. Typed selection and preview | `CanvasSelection`, `EmptyCanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection`, `_setCanvasSelection`, `_setPreviewPlacementKeys` | Owns volatile component/placement selection and temporary hover-preview keys. |
| 3. Component navigator | `_ComponentCategory`, `_componentCategoryFor`, `_naturalComponentIdCompare`, `_ComponentNavigatorPanel` | Categorizes, sorts, groups, drills into, and previews placed/unplaced components. |
| 4. Visibility filtering | `_toggleHideUnmeasuredComponents`, `measurementCountsByComponents`, `measurementValueBadgesByComponents`, `_CanvasPanel` | Applies hide-unmeasured state to navigator, canvas visibility, targets, hits, previews, and badges. |
| 5. Measurement entry | `_IntegratedMeasurePanelState`, `_saveMeasurement`, `_MeasureTargetRow`, `_appendMeasurementEventAndMarkStale` | Builds drafts/targets, calls the explicit measurement writer, and mirrors returned events into stale local projection state. |
| 6. Component create/edit | `_RightPanelComponentCreationSection`, `_confirmRightPanelComponentCreation`, `_RightPanelMetadataEditSection`, `_confirmRightPanelMetadataEdit` | Validates explicit identity creation and metadata edits before calling existing writers. |
| 7. Placement draft/save | `_AddComponentTemplateBuilderPanel`, `_PlacementEditorDraftState`, `_PlacementSaveTarget`, `_confirmAddComponentTemplatePlacement` | Owns template/ghost/editor drafts, normalized guards, and explicit visual-placement save. |
| 8. Canvas interaction, gate, and Wizard state | `hasWizardIntakePresentation`, `_CanvasPanelState`, `_selectPlacementAt`, `_fitCanvasView`, `_scheduleWizardInitialFit`, `_wizardPhotoFile`, `_renderedPlacementContains` | Keeps intake/warnings available with zero components; owns tap/ghost/pan/zoom behavior, existing hit conversion, photo visibility, safe photo resolution, and one initial fit. |
| 9. Visual and Wizard rendering | `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter`, `_BoardBackgroundPainter`, `_BoardPlacementPainter`, `_FootprintPreviewPainter`, `_RectangularPerimeterTemplatePreviewPainter` | Fits the optional rectangular reference and paints background/grid, photo, Wizard geometry, then canonical placements, without writes. |
| 10. Inspector and evidence | `_InspectorPanel`, `_PhotoAlignmentReadinessPanel`, `_BoardCanvasSafetyEvidenceDisclosure`, `_MeasurementSummaryCard`, `_VisualTraceMetadataCard` | Presents placement, measurement, alignment, safety, and visual-trace context without promotion. |
| 11. Rail, Project hub, focus, and responsive chrome | `_WorkbenchToolRail`, `_WorkbenchPanelModeButton`, `_ProjectNavigationHub`, `_action`, `_CanvasFocusButton`, `_CanvasFocusRestoreBar`, `_BoardCanvasControlBand` | Makes the 12-action Project hub the initial medium/wide context panel, lets `Projekt` restore it, preserves it through focus hide/restore, and routes without persistence. |
| 12. Projection freshness presentation | `_buildScaffold`, `ProjectionFreshness? projectionFreshness`, `ProjectionStaleBanner` | Inserts one authoritative compact nonblocking banner above either project-backed Canvas branch. |

## Project hub contract

`_ProjectNavigationHub` emits this exact order; the seven pre-existing actions
retain their relative order around the five inserted list/index destinations.

| Order | Class | Key | Label | Location |
| --- | --- | --- | --- | --- |
| 1 | existing | `board_canvas_project_home_action` | BenchBeep Home | `/` |
| 2 | added | `board_canvas_project_overview_action` | Project Overview | `/project/overview` |
| 3 | added | `board_canvas_project_components_action` | Komponendid | `/project/components` |
| 4 | added | `board_canvas_project_measurements_action` | Mõõtmised | `/project/measurements` |
| 5 | added | `board_canvas_project_pins_action` | Pinnid | `/project/pins` |
| 6 | added | `board_canvas_project_not_populated_action` | Täitamata | `/project/not-populated` |
| 7 | existing | `board_canvas_project_photos_action` | Foto tõendid | `/project/photos` |
| 8 | existing | `board_canvas_project_reference_images_action` | Viitepildid | `/project/reference-images` |
| 9 | existing | `board_canvas_project_graph_action` | Advanced graph | `/project/graph` |
| 10 | existing | `board_canvas_project_events_action` | Sündmused | `/project/events` |
| 11 | existing | `board_canvas_project_known_facts_action` | Teadaolevad faktid | `/project/known-facts` |
| 12 | existing | `board_canvas_project_report_action` | Raport | `/project/report` |

Add Component, Edit Component, and Measure Sheet are not Project-hub actions.
Their existing integrated/destination-specific workflows remain separate.

## State and data flow

- `[D]` `projectStateProvider` supplies `ProjectState`; projected components,
  placements, pins, measurements, traces, alignments, intake, and warnings are
  derived into presentation inputs.
- `[D]` `_contextPanelMode` starts as `projectNavigation`, so
  `_ProjectNavigationHub` is visible on the initial supported `1000x800` and
  `1400x800` Workbench render without a preliminary rail action.
- `[D]` Choosing another panel changes widget-local mode; the `Projekt` rail
  action restores `projectNavigation`. Canvas focus hides the chrome and
  restore reveals the selected Project hub again.
- `[D]` Each hub action calls `context.go` with one fixed location. The
  Overview action starts the tested Canvas -> Overview -> Canvas flow; the
  unchanged Overview action and router compatibility redirect return it to
  canonical `/project`.
- `[D]` Navigation calls no writer and changes no provider state, event,
  freshness value, or project file.
- `[D]` Both project-backed `_buildScaffold` call sites pass
  `projectState.projectionFreshness`; `_buildScaffold` owns the single banner
  insertion, and unknown/stale warnings do not gate the workspace.
- `[D]` The no-components empty state is used only when intake and warning are
  absent; Wizard presentation creates no component.
- `[D]` `_WizardIntakeFitTransform` maps `(x * aspect, y)`, uniformly fits true
  contour bounds, uses explicit legacy `1.0`, and shares one photo/contour/
  candidate frame under `IgnorePointer`.
- `[D]` Explicit create, edit, placement, and measurement actions alone build
  requests and call their dedicated providers; returned events are mirrored
  locally and promote freshness to stale through existing state methods.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider`, `ProjectState`, `ProjectionFreshness` | input / local projection update | Supplies accepted state/freshness and receives existing post-write result mirroring. |
| `ProjectionStaleBanner` | child presentation | Displays stale/unknown provenance nonblockingly; fresh renders no banner. |
| BoardFact component, placement, measurement, trace, alignment, and pin models | input | Supplies projected facts for targeting, inspection, badges, and rendering. |
| `WizardIntake` family | noncanonical input | Supplies optional aspect/photo/contour/candidate presentation without proving canonical facts. |
| `dart:io` `Directory`, `File` | local read input | Resolves only a validated project-relative optional background photo. |
| Four V2 writer providers | outbound | Existing component-create, component-edit, placement, and measurement canonical-event boundaries. |
| `TraceBenchEvent` | writer-result input | Parses returned events before local projection-state mirroring. |
| `VectorFootprintLibrary`, `FootprintTemplate` | input | Supplies visual/package geometry without proving identity or electrical function. |
| Flutter gestures, semantics, and `CustomPainter` | UI/rendering | Owns interaction, accessibility, and zero-write drawing. |
| `GoRouter` | outbound navigation | Opens Measure Sheet and the 12 fixed Project-hub locations without project writes; route ownership remains in `lib/app/router.dart`. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_confirmRightPanelComponentCreation` -> `v2AddComponentWriterProvider` | `CANONICAL_EVENT` | `[D]` Explicit guarded action calls the existing writer. |
| `_confirmRightPanelMetadataEdit` -> `v2EditComponentWriterProvider` | `CANONICAL_EVENT` | `[D]` Existing selection/change guards precede the writer. |
| `_confirmAddComponentTemplatePlacement` -> `v2PlacementWriterProvider` | `CANONICAL_EVENT` | `[D]` Bounds, target, directory, and explicit save guard the call. |
| `_IntegratedMeasurePanelState._saveMeasurement` -> `v2SaveMeasurementWriterProvider` | `CANONICAL_EVENT` | `[D]` Explicit `Salvesta` builds a human-entered request. |
| `_markPlacementProjectionStale`, `_appendMeasurementEventAndMarkStale` | `PROJECTION_STATE` | `[D]` Mirror returned events and promote freshness; neither is a writer. |
| Selection, drafts, ghost, filter, panel, focus, badges, photo visibility | `UI_LOCAL` | `[D]` Widget/controller state only. |
| Project hub -> `context.go` | `UI_LOCAL` + `ZERO_WRITE` | `[D]` Default/restore state and location change call no writer/provider/file mutation. |
| Wizard gate/photo/fit/painters, inspectors, summaries | `ZERO_WRITE` | `[D]` Read, derive, paint, and label only. |

Canonical event meaning stays writer-owned. This screen does not directly
mutate `known_facts.json`; visual placement remains separate from identity,
contacts, pins, measurements, nets, electrical function, and fault truth.

## Impact matrix

| Change zone | Direct evidence | Coupling / risk | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Screen orchestration | `[D]` default mode and Workbench composition | Panel/focus reachability | `UI_LOCAL` | default medium/wide hub cases |
| Navigator/filter | `[D]` category/group/filter flow | Hits, previews, targets, badges | `UI_LOCAL` | navigator, hover, hide-unmeasured families |
| Measurement | `[D]` draft/save/result flow | Target/filter/freshness | `CANONICAL_EVENT` | integrated Measure family |
| Component create/edit | `[D]` two guarded writers | Selection and local stale mirroring | `CANONICAL_EVENT` | Add Component and metadata-edit families |
| Placement | `[D]` draft/ghost/save flow | Coordinates, hit/painter geometry | `UI_LOCAL` + `CANONICAL_EVENT` | placement draft/save families |
| Canvas/Wizard | `[D]` gate, transform, photo, painters | Z-order, selection, fit identity | `UI_LOCAL` + `ZERO_WRITE` | zero-component, landscape/legacy, composite, pan/zoom families |
| Inspector/evidence | `[D]` projected summaries | Selection and wording | `ZERO_WRITE` | readiness/safety/trace families |
| Rail/Project/focus | `[D]` default mode, exact 12 actions, restore paths | Router/Overview are inspect-only; long hub scroll | `UI_LOCAL` + `ZERO_WRITE` | default hubs, inventory, 12 routes, round trip, restore |
| Freshness | `[D]` shared scaffold seam | Branch reachability and banner count | `ZERO_WRITE` | unknown/stale Canvas and routed integration |

## Relevant tests and helpers

The mapped companion `test/widget/board_canvas_screen_test.dart` owns the
focused evidence.

| Family | Stable helpers / fixtures | Representative coverage |
| --- | --- | --- |
| State/harness | `_inlineProjectState`, `_wizardIntake`, `_componentNavigatorState`, `_harness`, `_routerHarness` | Empty/project state, intake/warning, responsive shell, canonical routes. |
| Project navigation | `_projectHubDestinations`, `_projectHubActionKeys`, `_revealProjectHubAction`, `_pumpUntilRouterPath` | Initial hub at both widths, exact ordered 12-key inventory, exclusions, all routes, `Projekt`/focus restore, canonical round trip, zero writes. |
| Canvas/Wizard rendering | `_wizardIntakePainter`, `_wizardPhotoLayer`, `_boardCanvasPainter`, `_compositedPixelColor` | Gate, photo, z-order, rectangular/legacy fit, rotation, non-actionability. |
| Interaction/painter | `_selectPlacement`, `_tapCanvasAtNormalized`, `_hoverWidgetByKey`, `_canvasSemanticsLabels` | Selection, hover, filter, hit geometry, footprints, pins, semantics. |
| Writer boundaries | Four fake writers and event builders | Explicit requests, guard failures, idempotent returned events, stale projection. |
| Freshness | `_inlineProjectState(projectionFreshness:)` and shared banner constants | Explicit fresh default, unknown/stale rendering, usable workspace. |

## Dangerous combinations

- `[P]` Project-hub destination changes plus router-owner drift can point a
  zero-write action at a missing/stateful route; router and Overview remain
  inspect-only dependencies.
- `[P]` Default context mode plus focus/panel topology can make actions
  unreachable or restore the wrong mode; medium and wide tests move together.
- `[P]` Long-hub inventory changes require scroll-aware route tests; finder
  presence alone does not prove a destination is reachable.
- `[H]` Filtering couples navigator entries, canvas hits, previews, badges,
  and measurement targets.
- `[P]` Wizard fit/photo/painter changes can desynchronize layers or overlap
  placement interaction; one transform and `IgnorePointer` must remain.
- `[P]` Restoring per-branch freshness insertions can duplicate the banner;
  `_buildScaffold` remains the single seam.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One Project-hub label/location | `_ProjectNavigationHub`, `_action` | Router owner, rail/focus | exact inventory/route case plus full target |
| One panel/focus correction | `_WorkbenchToolRail`, `_CanvasFocusButton`, `_CanvasFocusRestoreBar` | Hub inventory and writers | restore plus medium/wide cases |
| One navigator/filter change | `_ComponentCategory`, `_ComponentNavigatorPanel` | Hits, targets, badges | exact navigator/filter family |
| One Wizard render correction | `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter` | placement painter/hit path | exact overlay test(s) plus full target |
| One freshness presentation change | `_buildScaffold` | provider state and both branches | warning case plus routed integration |

Slices guide decomposition only; they grant no authority. Multi-zone,
writer/event, canonical-coordinate, or electrical changes require explicit
scope and may require decomposition.

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Selection/navigator state | `[S]` Typed variants, categories, preview, and filter share consumers. | `NONE` |
| Canvas interaction/painter geometry | `[S]` Hits, transforms, centers, and painters share geometry. | `NONE` |
| Read-only Wizard overlay | `[S]` Fit, photo, candidate painting, and controls form a cluster. | `NONE` |
| Project navigation chrome | `[S]` Rail, hub, focus, and responsive panel composition share state. | `NONE` |
| Writer-oriented panels | `[S]` Placement, measurement, and metadata each have cohesive guarded flows. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for symbol, flow, boundary, test, or structure drift
  affecting mapped claims.
- Recheck when Project-hub order/keys/locations, default context mode,
  `Projekt`/focus restoration, router coupling, or zero-write tests change.
- Recheck writer/provider/result mirroring, selection/filter, geometry,
  Wizard gate/aspect/photo/z-order, or freshness scaffold behavior when those
  owners change.
- Formatting, imports, comments, and physical line movement alone do not
  require an update. Accepted committed source remains authoritative.

## Known uncertainty

- `[P]` Local returned-event mirroring is `PROJECTION_STATE`; canonical append
  remains inside imported writer ownership.
- `[S]` Router and Overview behavior is recorded only as inspect-only coupling
  needed for the tested round trip; those source owners require their maps.
- `[P]` Optional photo existence is not preflighted before toggle display;
  decode/read failure stays a neutral render state.
- `[S]` Extraction seams are unmeasured and cannot authorize work.
