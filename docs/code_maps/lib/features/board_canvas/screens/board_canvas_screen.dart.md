# Code Map: `lib/features/board_canvas/screens/board_canvas_screen.dart`

- Source: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — >5000 lines + 3+ responsibilities`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the Visual First Board Canvas destination: its local responsive rich
Workbench, selection/navigation, rendering, inspection, UI-local drafts,
read-only Wizard intake, tri-state freshness presentation, and four existing
writer call paths. Project-wide navigation now belongs to the outer shared
Workbench shell; this file starts its local context panel hidden and contains
no competing Project hub or Project rail action. Source, tests, canonical
owners, and active locks remain authoritative.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen orchestration | `BoardCanvasScreen`, `_BoardCanvasScreenState`, `_WorkbenchContextPanelMode`, `_buildScaffold` | Watches project state, defaults the local context mode to `hidden`, derives inputs, and composes the destination. |
| 2. Typed selection and preview | `CanvasSelection`, `EmptyCanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection`, `_setCanvasSelection`, `_setPreviewPlacementKeys` | Owns volatile component/placement selection and temporary hover-preview keys. |
| 3. Component navigator | `_ComponentCategory`, `_componentCategoryFor`, `_naturalComponentIdCompare`, `_ComponentNavigatorPanel` | Categorizes, sorts, groups, drills into, and previews placed/unplaced components. |
| 4. Visibility filtering | `_toggleHideUnmeasuredComponents`, `measurementCountsByComponents`, `measurementValueBadgesByComponents`, `_CanvasPanel` | Applies hide-unmeasured state to navigator, canvas visibility, targets, hits, previews, and badges. |
| 5. Measurement entry | `_IntegratedMeasurePanelState`, `_saveMeasurement`, `_MeasureTargetRow`, `_appendMeasurementEventAndMarkStale` | Builds drafts/targets, calls the existing measurement writer, and mirrors returned events into stale local projection state. |
| 6. Component create/edit | `_RightPanelComponentCreationSection`, `_confirmRightPanelComponentCreation`, `_RightPanelMetadataEditSection`, `_confirmRightPanelMetadataEdit` | Validates explicit identity creation and metadata edits before existing writers. |
| 7. Placement draft/save | `_AddComponentTemplateBuilderPanel`, `_PlacementEditorDraftState`, `_PlacementSaveTarget`, `_confirmAddComponentTemplatePlacement` | Owns template/ghost/editor drafts, normalized guards, and explicit placement save. |
| 8. Canvas interaction, gate, and Wizard state | `hasWizardIntakePresentation`, `_CanvasPanelState`, `_selectPlacementAt`, `_fitCanvasView`, `_scheduleWizardInitialFit`, `_wizardPhotoFile`, `_renderedPlacementContains` | Keeps intake/warnings available with zero components and owns tap/ghost/pan/zoom/photo/fit behavior. |
| 9. Visual and Wizard rendering | `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter`, `_BoardBackgroundPainter`, `_BoardPlacementPainter`, `_FootprintPreviewPainter`, `_RectangularPerimeterTemplatePreviewPainter` | Fits optional reference content and paints Wizard/canonical layers without writes. |
| 10. Inspector and evidence | `_InspectorPanel`, `_PhotoAlignmentReadinessPanel`, `_BoardCanvasSafetyEvidenceDisclosure`, `_MeasurementSummaryCard`, `_VisualTraceMetadataCard` | Presents placement, measurement, alignment, safety, and visual-trace context without promotion. |
| 11. Local rail, panels, focus, and responsive chrome | `constraints.maxWidth >= 900`, `_WorkbenchToolRail`, `_WorkbenchPanelModeButton`, `_CanvasFocusButton`, `_CanvasFocusRestoreBar`, `_BoardCanvasControlBand` | Keeps the destination-local 900 rich-layout cutover, five retained panel tools, hidden default, and focus hide/restore behavior. |
| 12. Projection freshness presentation | `_buildScaffold`, `ProjectionFreshness? projectionFreshness`, `ProjectionStaleBanner` | Inserts one authoritative nonblocking banner above either project-backed Canvas branch. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed source. The map uses no line-number anchors.

## Local Workbench contract

- `_WorkbenchContextPanelMode` contains only `hidden`, `inspector`,
  `placements`, `measure`, `addComponentTemplates`, and `safetyEvidence`.
- `_contextPanelMode` starts as `hidden`; the initial rich layout has no right
  context panel until an explicit retained tool or selection opens one.
- `_WorkbenchToolRail` renders Measure, Add, Inspector, Placements, and Safety
  panel controls plus unchanged inactive future tools. It has no Project tool.
- Canvas focus hides local rail/context chrome and restores the selected
  retained panel mode.
- `constraints.maxWidth >= 900` remains the destination-local rich-layout
  decision. The outer shell owns its separate 1228 persistent-nav threshold;
  this destination receives no shell-width input.

## State and data flow

- `[D]` `projectStateProvider` supplies `ProjectState`; projected components,
  placements, pins, measurements, traces, alignments, intake, and warnings are
  derived into presentation inputs.
- `[D]` Local context mode begins hidden. Explicit rail/selection actions choose
  one retained panel; focus mode hides and restores local chrome without
  changing project-wide navigation.
- `[D]` The rich Board Workbench is selected from its own available width at
  900. Under the outer shell's compact/persistent cutover, routed evidence shows
  the Board remains rich at all locked widths.
- `[D]` The only route action retained here is Measure Sheet navigation through
  `context.push('/project/measure-sheet')`; top-level project navigation is
  absent and shared-shell-owned.
- `[D]` Both project-backed `_buildScaffold` call sites pass authoritative
  freshness; the scaffold owns the single banner insertion.
- `[D]` Wizard fit maps optional photo/contour/candidates into one read-only
  frame beneath canonical placements.
- `[D]` Explicit create, edit, placement, and measurement actions alone call
  their dedicated providers; returned events are mirrored locally and promote
  freshness through existing state methods.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider`, `ProjectState`, `ProjectionFreshness` | input / local projection update | Supplies accepted state/freshness and receives existing post-write result mirroring. |
| `ProjectionStaleBanner` | child presentation | Displays stale/unknown provenance nonblockingly. |
| BoardFact component, placement, measurement, trace, alignment, and pin models | input | Supplies projected facts for targeting, inspection, badges, and rendering. |
| `WizardIntake` family | noncanonical input | Supplies optional aspect/photo/contour/candidate presentation without proving canonical facts. |
| `dart:io` `Directory`, `File` | local read input | Resolves only a validated project-relative optional background photo. |
| Four V2 writer providers | outbound | Existing component-create, component-edit, placement, and measurement canonical-event boundaries. |
| `TraceBenchEvent` | writer-result input | Parses returned events before local projection-state mirroring. |
| `VectorFootprintLibrary`, `FootprintTemplate` | input | Supplies visual/package geometry without proving identity or electrical function. |
| Flutter gestures, semantics, and `CustomPainter` | UI/rendering | Owns interaction, accessibility, and zero-write drawing. |
| GoRouter | outbound workflow navigation | Opens Measure Sheet only; project-wide route ownership remains in router/shell. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_confirmRightPanelComponentCreation` -> add-component provider | `CANONICAL_EVENT` | `[D]` Explicit guarded action calls the existing writer. |
| `_confirmRightPanelMetadataEdit` -> edit-component provider | `CANONICAL_EVENT` | `[D]` Existing selection/change guards precede the writer. |
| `_confirmAddComponentTemplatePlacement` -> placement provider | `CANONICAL_EVENT` | `[D]` Bounds, target, directory, and explicit save guard the call. |
| `_IntegratedMeasurePanelState._saveMeasurement` -> measurement provider | `CANONICAL_EVENT` | `[D]` Explicit save builds a human-entered request. |
| `_markPlacementProjectionStale`, `_appendMeasurementEventAndMarkStale` | `PROJECTION_STATE` | `[D]` Mirror returned events and promote freshness; neither is a writer. |
| Selection, drafts, ghost, filter, panels, focus, badges, photo visibility | `UI_LOCAL` | `[D]` Widget/controller state only. |
| Measure Sheet `push` | `UI_LOCAL` | `[D]` Changes transient route stack and invokes no writer. |
| Wizard gate/photo/fit/painters, inspectors, summaries | `ZERO_WRITE` | `[D]` Read, derive, paint, and label only. |

Canonical event meaning stays writer-owned. This screen does not directly
mutate `known_facts.json`; visual placement remains separate from identity,
contacts, pins, measurements, nets, electrical function, and fault truth.

## Zero-write zones

- Local rail, mode selection, focus, filters, selection, and drafts remain
  transient until an explicit existing save path is used.
- Painters, Wizard intake, inspectors, readiness, safety, and trace summaries
  render accepted inputs only.
- No top-level project destination metadata or navigation hub remains here.

## Impact matrix

| Change zone | Direct evidence | Coupling / risk | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Screen orchestration | `[D]` hidden default and retained local composition | panel/focus reachability | `UI_LOCAL` | hidden-default and focus cases |
| Navigator/filter | `[D]` category/group/filter flow | hits, previews, targets, badges | `UI_LOCAL` | navigator/filter families |
| Measurement | `[D]` draft/save/result flow | target/filter/freshness | `CANONICAL_EVENT` | integrated Measure family |
| Component create/edit | `[D]` two guarded writers | selection/local stale mirroring | `CANONICAL_EVENT` | Add/Edit families |
| Placement | `[D]` draft/ghost/save flow | coordinates/hit/painter geometry | `UI_LOCAL` / `CANONICAL_EVENT` | placement families |
| Canvas/Wizard | `[D]` gate/transform/photo/painters | z-order, selection, fit identity | `UI_LOCAL` / `ZERO_WRITE` | intake/render/pan/zoom families |
| Inspector/evidence | `[D]` projected summaries | selection/measurement | `ZERO_WRITE` | readiness/safety/trace families |
| Local rail/focus/responsive | `[D]` five tools, hidden default, exact 900 cutover | outer shell is inspect-only | `UI_LOCAL` | six-width routed, panel/focus cases |
| Freshness | `[D]` shared scaffold seam | branch reachability/banner count | `ZERO_WRITE` | unknown/stale and integration cases |

## Relevant tests and helpers

The mapped companion `test/widget/board_canvas_screen_test.dart` owns 165
declarations across these families:

| Family | Stable helpers / fixtures | Representative coverage |
| --- | --- | --- |
| State/harness | `_inlineProjectState`, `_wizardIntake`, `_componentNavigatorState`, `_harness`, `_routerHarness` | Empty/project state, intake/warning, canonical routes, shared-shell composition. |
| Local responsive/panels | `_openWideContextMode`, `_tapWidgetByKey` | Six routed widths, hidden default, five retained rail controls, panel/focus restoration, no Project hub/rail. |
| Canvas/Wizard rendering | `_wizardIntakePainter`, `_wizardPhotoLayer`, `_boardCanvasPainter`, `_compositedPixelColor` | Gate, photo, z-order, fit, rotation, non-actionability. |
| Interaction/painter | `_selectPlacement`, `_tapCanvasAtNormalized`, `_hoverWidgetByKey`, `_canvasSemanticsLabels` | Selection, hover, filter, hit geometry, footprints, pins, semantics. |
| Writer boundaries | Four fake writers and event builders | Explicit requests, guards, returned events, stale projection. |
| Freshness | explicit freshness fixture and shared banner constants | Fresh default, unknown/stale rendering, usable workspace. |

## Dangerous combinations

- Reintroducing a local Project hub/rail would duplicate shared-shell metadata
  and navigation ownership.
- Changing the Board 900 cutover with shell framing/threshold can recreate a
  rich-to-compact inversion; destination geometry and shell ownership must be
  evaluated separately.
- Default mode plus selection/focus topology can make retained panels appear or
  restore unexpectedly.
- Filtering couples navigator entries, hits, previews, badges, and measurement
  targets.
- Wizard fit/photo/painter changes can desynchronize layers or overlap
  placement interaction.
- Restoring per-branch freshness insertion can duplicate the banner.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One local panel/focus correction | `_WorkbenchToolRail`, focus widgets | shared shell remains external | panel/focus cases |
| One local responsive correction | `constraints.maxWidth >= 900` | shell 1228/framing | routed six-width Board case |
| One navigator/filter change | `_ComponentCategory`, `_ComponentNavigatorPanel` | hits, targets, badges | navigator/filter family |
| One Wizard render correction | fit/photo/painter anchors | placement hit path | exact overlay cases |
| One freshness change | `_buildScaffold` | provider/both branches | warning + integration cases |

## Future extraction seams

- `[S]` Selection/navigator state, canvas geometry, Wizard overlay, and each
  writer-oriented panel remain cohesive but unmeasured extraction candidates.
- `[S]` Local panel/focus chrome could be isolated only without recreating
  project-wide navigation ownership.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for symbol, flow, boundary, test, or structure drift.
Recheck hidden default, retained panel inventory, focus restoration, local 900
cutover, and absence of Project navigation when local chrome changes. Recheck
writer/result mirroring, selection/filter, geometry, Wizard layers, and
freshness scaffold when those owners change.

## Known uncertainty

- `[P]` Local returned-event mirroring is `PROJECTION_STATE`; canonical append
  remains inside imported writer ownership.
- `[P]` Optional photo existence is not preflighted before toggle display;
  decode/read failure stays a neutral render state.
- `[S]` The outer shared shell is route-layer composition and is intentionally
  not imported or width-aware here.
