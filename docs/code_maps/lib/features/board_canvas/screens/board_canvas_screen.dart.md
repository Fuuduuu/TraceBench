# Code Map: `lib/features/board_canvas/screens/board_canvas_screen.dart`

- Source: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — >5000 lines + 3+ responsibilities`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_MEASUREMENT_NORMAL_LIBRARY_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the Visual First Board Canvas destination: its local responsive rich
Workbench, selection/navigation, rendering, inspection, UI-local drafts,
read-only Wizard intake, tri-state freshness presentation, and four existing
writer call paths. It imports `measurement_projection.dart` as the normal
feature-internal owner of deterministic measurement read-model declarations
and is the library host for exactly two temporary same-library parts:
`wizard_intake_overlay.part.dart` physically owns Wizard fit, photo-layer, and
painter declarations, and
`component_navigator.part.dart` physically owns the private Stateless
Navigator panel declaration. Their consumers, all mutable state, all callback
implementations, and all canonical writers remain here; all non-Wizard
painters also remain host-owned. Project-wide navigation belongs to the outer shared
Workbench shell; this file starts its local context panel hidden and contains
no competing Project hub or Project rail action. Source, tests, canonical
owners, and active locks remain authoritative.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen orchestration | `BoardCanvasScreen`, `_BoardCanvasScreenState`, `_WorkbenchContextPanelMode`, `_buildScaffold` | Watches project state, defaults the local context mode to `hidden`, derives inputs, and composes the destination. |
| 2. Typed selection and preview | `CanvasSelection`, `EmptyCanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection`, `_setCanvasSelection`, `_setPreviewPlacementKeys` | Owns volatile component/placement selection and temporary hover-preview keys. |
| 3. Component navigator | `_ComponentCategory`, `_componentCategoryFor`, `_naturalComponentIdCompare`, `_ComponentNavigatorPanel` | Owns category helpers, Navigator state/callback implementations, and the panel consumer; the private Stateless panel declaration in `component_navigator.part.dart` categorizes, sorts, groups, drills into, and previews placed/unplaced components. |
| 4. Visibility filtering and measurement read-model consumption | `_toggleHideUnmeasuredComponents`, `measurementCountsByComponents`, `measurementValueBadgesByComponents`, `_displayDirectionLabel`, `_firstPresentText`, `_CanvasPanel` | Applies hide-unmeasured state to navigator, canvas visibility, targets, hits, previews, and badges; the normal measurement library owns endpoint parsing, association/counting, badge ordering/text, and caution classification, while the two private direction/first-present presentation helpers remain host-owned. |
| 5. Measurement entry | `_IntegratedMeasurePanelState`, `_saveMeasurement`, `_MeasureTargetRow`, `_appendMeasurementEventAndMarkStale` | Builds drafts/targets, calls the existing measurement writer, and mirrors returned events into stale local projection state. |
| 6. Component create/edit | `_RightPanelComponentCreationSection`, `_confirmRightPanelComponentCreation`, `_RightPanelMetadataEditSection`, `_confirmRightPanelMetadataEdit` | Validates explicit identity creation and metadata edits before existing writers. |
| 7. Placement draft/save | `_AddComponentTemplateBuilderPanel`, `_PlacementEditorDraftState`, `_PlacementSaveTarget`, `_confirmAddComponentTemplatePlacement` | Owns template/ghost/editor drafts, normalized guards, and explicit placement save. |
| 8. Canvas interaction, gate, and Wizard state | `hasWizardIntakePresentation`, `_CanvasPanelState`, `_selectPlacementAt`, `_fitCanvasView`, `_scheduleWizardInitialFit`, `_wizardPhotoFile`, `_renderedPlacementContains` | Keeps intake/warnings available with zero components and owns tap/ghost/pan/zoom/photo/fit behavior. |
| 9. Visual and Wizard rendering | `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter`, `_BoardBackgroundPainter`, `_BoardPlacementPainter`, `_FootprintPreviewPainter`, `_RectangularPerimeterTemplatePreviewPainter` | Composes optional Wizard reference content through physically delegated fit/photo/painter owners and retains every non-Wizard painter locally; all rendering is write-free. |
| 10. Inspector and evidence | `_InspectorPanel`, `_PhotoAlignmentReadinessPanel`, `_BoardCanvasSafetyEvidenceDisclosure`, `_MeasurementSummaryCard`, `_VisualTraceMetadataCard` | Presents placement, measurement, alignment, safety, and visual-trace context without promotion. |
| 11. Local rail, panels, focus, and responsive chrome | `constraints.maxWidth >= 900`, `_WorkbenchToolRail`, `_WorkbenchPanelModeButton`, `_CanvasFocusButton`, `_CanvasFocusRestoreBar`, `_BoardCanvasControlBand` | Keeps the destination-local 900 rich-layout cutover, five retained panel tools, hidden default, and focus hide/restore behavior. |
| 12. Projection freshness presentation | `_buildScaffold`, `ProjectionFreshness? projectionFreshness`, `ProjectionStaleBanner` | Inserts one authoritative nonblocking banner above either project-backed Canvas branch. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in the committed host. `_ComponentNavigatorPanel` resolves as
the host consumer call while its declaration lives in committed
`lib/features/board_canvas/widgets/component_navigator.part.dart`. The two
Zone 4 measurement transforms resolve there as host call sites while their
declarations live in committed
`lib/features/board_canvas/logic/measurement_projection.dart`; the two private
display helpers resolve as host declarations. The three
Zone 9 Wizard type names likewise resolve as host consumer references while
their declarations live in committed
`lib/features/board_canvas/rendering/wizard_intake_overlay.part.dart`. The map
uses no line-number anchors and does not attribute either moved declaration
set to the host.

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
- `[D]` Host-owned category, typed-selection, filter, preview-key, and local
  placement-draft state flow into the delegated Stateless Navigator. Its seven
  callbacks return only to host-owned transient state implementations; explicit
  placement save and all canonical writers remain outside the part.
- `[D]` The rich Board Workbench is selected from its own available width at
  900. Under the outer shell's compact/persistent cutover, routed evidence shows
  the Board remains rich at all locked widths.
- `[D]` The only route action retained here is Measure Sheet navigation through
  `context.push('/project/measure-sheet')`; top-level project navigation is
  absent and shared-shell-owned.
- `[D]` Both project-backed `_buildScaffold` call sites pass authoritative
  freshness; the scaffold owns the single banner insertion.
- `[D]` Host-owned `_CanvasPanelState` builds and consumes the delegated Wizard
  fit, photo layer, and painter. The rendering part maps optional photo,
  contour, and candidates into one read-only frame beneath canonical placements
  without taking state, scheduling, control, or placement ownership.
- `[D]` `MeasurementFact` inputs cross the imported normal-library boundary for pure
  endpoint/display normalization, component counts, badge association/order,
  badge text, and caution classification; results return to unchanged host
  consumers with no state or write ownership in the library.
- `[D]` All three State owners and their fields/lifetimes remain physically
  unchanged. Four writer invocations remain split `3 + 1` between
  `_BoardCanvasScreenState` and `_IntegratedMeasurePanelState`, and both
  `projectStateProvider.notifier` mirroring sites remain host-owned.
- `[D]` Explicit create, edit, placement, and measurement actions alone call
  their dedicated providers; returned events are mirrored locally and promote
  freshness through existing state methods.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider`, `ProjectState`, `ProjectionFreshness` | input / local projection update | Supplies accepted state/freshness and receives existing post-write result mirroring. |
| `measurement_projection.dart` | imported normal-library dependency | Owns endpoint grammar, component counts, badge association/order/text, and caution classification through one explicit Known Facts model import; owns no Flutter, State, provider, writer, route, filesystem, event, projection mutation, or part relationship. |
| `wizard_intake_overlay.part.dart` | same-library rendering dependency | Owns Wizard fit transform, photo layer, and painter while sharing host imports, models, and private visual tokens; has no independent imports, state, provider, or writer. |
| `component_navigator.part.dart` | same-library presentation/control dependency | Owns the private Stateless panel declaration while sharing host imports, models, helpers, tokens, and seven callback inputs; all mutable state, callback implementations, and writers remain in the host. |
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
| `measurement_projection.dart` transforms | `ZERO_WRITE` | `[D]` Pure `MeasurementFact` inputs produce counts, display parts, badge lists/text, and caution booleans without mutation. The caution helper is presentation classification, not validity/evidence lifecycle authority. |
| `wizard_intake_overlay.part.dart` fit/photo/painter flow | `ZERO_WRITE` | `[D]` Derives geometry and renders local photo/contour/candidate inputs; `Image.file` is read/render input and no mutation path enters the part. |
| `component_navigator.part.dart` | `UI_LOCAL` | `[D]` Pure grouping/rendering is `ZERO_WRITE`; controls dispatch seven callbacks to host-owned transient category, selection, preview, and local placement-draft state. Canonical placement remains behind the host explicit save writer. |

Canonical event meaning stays writer-owned. This screen does not directly
mutate `known_facts.json`; visual placement remains separate from identity,
contacts, pins, measurements, nets, electrical function, and fault truth.

## Zero-write zones

- Local rail, mode selection, focus, filters, selection, and drafts remain
  transient until an explicit existing save path is used.
- Painters, Wizard intake, inspectors, readiness, safety, and trace summaries
  render accepted inputs only.
- The measurement normal library and Wizard part are `ZERO_WRITE`; the Wizard part's
  `BuildContext` and `Image.file` uses are presentation-only. The Navigator
  part's derivation/rendering is `ZERO_WRITE`, while its aggregate classification
  is `UI_LOCAL` because seven controls dispatch to host-owned transient state.
  Neither remaining part owns a provider, mutable State, event append, project-
  file mutation, projection mutation, or canonical writer; the measurement
  library owns none of those surfaces either.
- No top-level project destination metadata or navigation hub remains here.

## Impact matrix

| Change zone | Direct evidence | Coupling / risk | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Screen orchestration | `[D]` hidden default and retained local composition | panel/focus reachability | `UI_LOCAL` | hidden-default and focus cases |
| Navigator/filter/read model | `[D]` host state/callback consumer plus delegated panel and pure counts/badges | hits, previews, targets, Navigator and measurement part owners | `UI_LOCAL` / `ZERO_WRITE` | navigator/filter families plus direct helper characterizations |
| Measurement | `[D]` draft/save/result flow | target/filter/freshness | `CANONICAL_EVENT` | integrated Measure family |
| Component create/edit | `[D]` two guarded writers | selection/local stale mirroring | `CANONICAL_EVENT` | Add/Edit families |
| Placement | `[D]` draft/ghost/save flow | coordinates/hit/painter geometry | `UI_LOCAL` / `CANONICAL_EVENT` | placement families |
| Canvas/Wizard | `[D]` host gate/consumers plus delegated fit/photo/painter declarations | z-order, selection, fit identity, part boundary | `UI_LOCAL` / `ZERO_WRITE` | intake/render/pan/zoom families plus structural source guard |
| Inspector/evidence | `[D]` projected summaries | selection/measurement | `ZERO_WRITE` | readiness/safety/trace families |
| Local rail/focus/responsive | `[D]` five tools, hidden default, exact 900 cutover | outer shell is inspect-only | `UI_LOCAL` | six-width routed, panel/focus cases |
| Freshness | `[D]` shared scaffold seam | branch reachability/banner count | `ZERO_WRITE` | unknown/stale and integration cases |

## Relevant tests and helpers

The mapped companion `test/widget/board_canvas_screen_test.dart` owns 169
declarations across these families:

| Family | Stable helpers / fixtures | Representative coverage |
| --- | --- | --- |
| State/harness | `_inlineProjectState`, `_wizardIntake`, `_componentNavigatorState`, `_harness`, `_routerHarness` | Empty/project state, intake/warning, canonical routes, shared-shell composition. |
| Local responsive/panels | `_openWideContextMode`, `_tapWidgetByKey` | Six routed widths, hidden default, five retained rail controls, panel/focus restoration, no Project hub/rail. |
| Canvas/Wizard rendering | `_wizardIntakePainter`, `_wizardPhotoLayer`, `_boardCanvasPainter`, `_compositedPixelColor`, `board canvas source keeps read-only data-path boundaries` | Gate, photo, z-order, fit, rotation, non-actionability, and physical Wizard-painter source ownership. |
| Interaction/painter/read model | `_selectPlacement`, `_tapCanvasAtNormalized`, `_hoverWidgetByKey`, `_canvasSemanticsLabels` | Selection, hover, filter, hit geometry, footprints, pins, semantics, endpoint/count helpers, and four direct badge/eligibility/text/caution characterizations. |
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
- Moving or redesigning the part API together with state migration, private
  name promotion, writer semantics, or unrelated refactoring obscures the
  `ZERO_WRITE` boundary and requires separate authority.
- Reordering or extending `wizard_intake_overlay.part.dart` after
  `_WizardIntakePainter` can broaden the focused test's current painter-to-EOF
  source slice; review that structural guard with any declaration-order change.
- Wizard fit/photo/painter changes can desynchronize layers or overlap
  placement interaction.
- Restoring per-branch freshness insertion can duplicate the banner.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One local panel/focus correction | `_WorkbenchToolRail`, focus widgets | shared shell remains external | panel/focus cases |
| One local responsive correction | `constraints.maxWidth >= 900` | shell 1228/framing | routed six-width Board case |
| One navigator/filter change | `_ComponentCategory`, delegated `_ComponentNavigatorPanel` | host callbacks/state, hits, targets, badges | navigator/filter family |
| One measurement read-model change | imported measurement helper anchor plus host display helpers | host consumers and measurement writer stay inspect-only | endpoint/count plus direct helper characterizations |
| One Wizard render correction | delegated fit/photo/painter anchors | host composition, placement hit path, painter-to-EOF structural guard | exact overlay cases + structural source guard |
| One freshness change | `_buildScaffold` | provider/both branches | warning + integration cases |

## Future extraction seams

- `[S]` The two remaining same-library parts are temporary structure, not a
  general extraction convention. The measurement owner is now a normal
  feature-internal library. Any conversion of Wizard/Navigator, additional
  part, or state/controller extraction requires a fresh architecture scope;
  this map authorizes none of those changes.
- `[S]` Local panel/focus chrome could be isolated only without recreating
  project-wide navigation ownership.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for symbol, flow, boundary, test, or structure drift.
Recheck hidden default, retained panel inventory, focus restoration, local 900
cutover, and absence of Project navigation when local chrome changes. Recheck
writer/result mirroring, the normal measurement-library boundary, both
remaining host/part boundaries, selection/filter, geometry, Wizard layers,
and freshness scaffold when those owners change. Recheck the focused
painter-to-EOF source guard whenever the
Wizard part's declaration order or final declaration changes.

## Known uncertainty

- `[P]` Local returned-event mirroring is `PROJECTION_STATE`; canonical append
  remains inside imported writer ownership.
- `[P]` Optional photo existence is not preflighted before toggle display;
  decode/read failure stays a neutral render state.
- `[S]` The outer shared shell is route-layer composition and is intentionally
  not imported or width-aware here.
