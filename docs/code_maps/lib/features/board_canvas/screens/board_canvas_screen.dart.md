# Code Map: `lib/features/board_canvas/screens/board_canvas_screen.dart`

- Source: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — >5000 lines + 3+ responsibility categories`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the primary Board Canvas workbench shell, rendering/interaction, Inspector
composition, Wizard intake and freshness presentation. Placement workflow/drafts
and explicit writer/Session handling belong to the normal Placement library.
Component create/edit workflow belongs to
`ComponentIdentityPanel` and its screen-lived holder; Measurement State/save/session
workflow belongs to `IntegratedMeasurePanel`. Read-only Inspector presentation
belongs to `BoardCanvasInspectorPanel`; the host supplies resolved inputs and an
opaque module-built Placement editor slot. Additional-photo import and primary
alignment
confirmation are delegated to `PhotoWorkbenchPanel` and its writers.
The host loads the Wizard primary asset, selects event-derived alignments and
composes provisional/confirmed photo rendering without promoting visual evidence.

Pure measurement/placement libraries and the Wizard same-library part retain
their existing ownership. `ComponentNavigator` is a normal imported library;
the host adapts public facts and selected IDs and retains all transient state
and placement actions. The instrument bar replaces shared outer chrome only on
the primary route; secondary pages still use the router's `WorkbenchShell`.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen and freshness | `BoardCanvasScreen`, `_BoardCanvasScreenState`, `_buildScaffold`, `ProjectionStaleBanner` | Watches project state, composes branches and inserts freshness directly below the instrument bar. |
| 2. Selection/preview | `CanvasSelection`, `EmptyCanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection`, `_setCanvasSelection`, `_setPreviewPlacementKeys` | Volatile selection/hover/clear behavior. |
| 3. Navigator/filter | `ComponentCategory`, `ComponentNavigator`, `componentCategoryFor`, `componentPrimaryLabel`, `componentNavigatorPlacementId`, `_toggleHideUnmeasuredComponents`, `measurementCountsByComponents`, `measurementValueBadgesByComponents` | Host category/filter/selection/preview state; public fact-list/selected-ID adapter and intent callbacks. Classification and Navigator presentation belong to the imported library. |
| 4. Measurement composition | `IntegratedMeasurePanel`, `selectedComponentId: selectedEntry?.placement.componentId`, `selectedComponent: selectedEntry?.component`, `advancedDetailsBuilder`, `footprintPreviewBuilder`, `_FootprintPreviewPainter`, `_componentPreviewSemanticsLabel`, `InspectorMeasurementSummaryTile`, `InspectorVisualTraceSummaryTile` | Constructs the child from one resolved placement; builds provenance children using imported Inspector presentation widgets and supplies private footprint rendering. The imported module owns Measurement State/writer/session workflow. |
| 5. Components composition/lifetime | `ComponentIdentityHolder`, `_componentIdentityHolder.dispose()`, `_rightPanelSelectedMetadataComponent`, `_AddComponentTemplateListPanel`, `ComponentIdentityPanel`, `placementSectionBuilder` | Creates/disposes one screen-lived holder, resolves a nullable edit target, retains the Add frame/scroll and supplies Placement children; the module owns create/edit state and writes. |
| 6. Placement composition/lifetime | `BoardCanvasPlacementHolder`, `_placementHolder`, `_onPlacementChanged`, `_PlacementSaveTarget`, `_placementSaveTarget`, `_placementSeedFor`, `_resolvedPlacementSaveValues`, `buildBoardCanvasPlacementChildren`, `buildBoardCanvasPlacementEditor` | Creates/listens/disposes one screen-lived holder; retains selection/eligibility, immutable seeding, current-snapshot center conversion and catalogue/preview builders. Module owns drafts, controls, guards and writer/Session workflow. |
| 7. Interaction/Wizard | `hasWizardIntakePresentation`, `_CanvasPanelState`, `_selectPlacementAt`, `_fitCanvasView`, `_scheduleWizardInitialFit`, `_wizardPhotoFile` | Zero-component intake, pan/zoom/tap/fit and read-only Wizard input. |
| 8. General rendering/geometry | `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter`, `_BoardBackgroundPainter`, `_BoardPlacementPainter`, `footprintVisualKind`, `renderedPlacementContains` | Delegated Wizard/pure geometry plus host Board painters and semantics. |
| 9. Inspector composition/evidence | `BoardCanvasInspectorPanel`, `placement: selectedEntry?.placement`, `component: selectedEntry?.component`, `template: selectedEntry?.template`, `placementDraftSection`, `_BoardCanvasSafetyEvidenceDisclosure` | Resolves Inspector inputs from one selected entry, passes the module-built Placement editor slot and keeps safety disclosure; the imported library declares summaries/readiness without evidence promotion. |
| 10. Photo workflow/primary asset | `_buildPhotoWorkbenchPanel`, `PhotoWorkbenchPanel`, `photoEventItemsFromEvents`, `_reconcilePrimaryPhotoAsset`, `_loadPrimaryPhotoAsset` | Import/align child seam, sole Wizard primary asset load and guarded result callbacks. |
| 11. Instrument bar/local chrome | `board_canvas_instrument_bar`, `board_canvas_project_menu`, `WorkbenchPopupTheme`, `workbenchDestinations`, `beginnerModeProvider`, `_WorkbenchToolRail`, `_CompactPhotoPanelButton`, `_CanvasFocusRestoreBar` | Home, captured warm transient popup, labelled mode, safety status, local rail/context and focus. |
| 12. Alignment selection/render/capture | `_reconcileAlignmentState`, `primaryPhotoAlignmentEventItemsFromEvents`, `_activeAlignment`, `_requestAlignmentBoardPoint`, `_acceptAlignmentBoardPoint`, `AlignedPhotoLayer`, `_PhotoAlignmentReferencePainter` | Primary-only bounded alignment selection, host preview/layer state and normalized board capture. |

## Anchor inventory and verification

Every anchor resolves as a host substring. Wizard part types and imported
Navigator/category/label/placement-ID, Components, Placement, Measurement,
Inspector, geometry, photo, mode and destination-model names are consumer
references; their declarations remain in the named dependency owners.
No line-number anchors are maintained.

## Single-shell and local Workbench contract

- `_buildScaffold` owns one 44 px toolbar, a 1 px bottom rule, Home, project
  identity/menu, renderer/write-safety presentation and `Algaja`/`Edasijõudnu`.
- Home calls session `closeProject` before `go('/')`. The popup reuses the
  exact `workbenchDestinations` inventory and navigates through `go`.
- `WorkbenchPopupTheme` preserves the closed trigger Theme; only the opened
  menu captures shared warm Theme. The thirteen public Canvas constants remain
  value-identical aliases to shared WorkbenchColors.
- Title-layout width below 900 abbreviates identity/safety copy; full safety
  meaning remains in Tooltip/Semantics. This is distinct from Canvas layout.
- Canvas content retains `constraints.maxWidth >= 900` after body padding
  (936 viewport pixels in the tested routed fixture).
- Measure, Add, Inspector, Placements, Safety and Fotod are six retained local
  tools. Global destinations are transient; shared outer navigation is absent.
- Rich context starts hidden. Focus hides local rail/context and restores mode;
  the instrument bar and bottom renderer/status surfaces remain.
- Compact and zero-component Fotod entry use the same delegated photo panel.
- A stale/unknown banner remains immediately below the bar and nonblocking.

## State and data flow

1. [D] Session state supplies facts, events, Wizard intake and freshness.
   Accepted photo rows come directly from events.
2. [D] Primary loading uses only Wizard background relative path plus current
   project ID/directory and injected-loader identity. Context changes cancel
   pending capture, reset asset state and schedule a fresh read; late results
   are ignored unless mounted and load identity still matches.
3. [D] Current primary path, digest and intrinsic dimensions filter event-derived
   alignments through `primaryPhotoAlignmentEventItemsFromEvents`. Additional
   photos and out-of-bounds reopened alignments cannot become the active layer.
4. [D] Project changes reset selection, preview, visibility and opacity (0.65).
   A still-valid selected alignment remains; otherwise highest sequence wins.
5. [D] `_buildPhotoWorkbenchPanel` passes current session, primary load state,
   accepted rows and injectable writer/loader/image seams. Its callbacks update
   host preview/active/layer state and reopen Fotod after accepted application.
6. [D] Leaving Photos, hiding context or focus clears provisional preview and
   completes pending board capture with null in host build reconciliation.
7. [D] Capture intercepts a board tap before placement selection, normalizes
   coordinates into 0..1 and suppresses pan/zoom while awaiting the point.
8. [D] Stack order is Board background, optional Wizard photo, aligned preview
   or confirmed primary photo, Wizard contour/candidates, alignment markers,
   canonical placements, then later cues/warnings. Preview takes precedence.
9. [D] `AlignedPhotoLayer` owns clipping, pointer ignoring, intrinsic raster
   sizing and matrix application. The host uses the already-loaded asset
   directly, not `ProjectAlignedPhotoLayer`'s alternate loading wrapper.
10. [D] Missing/unsafe primary data gives warning; reflected affine geometry
    and provisional solutions have separate visual badges. None append events.
11. [D] Placement, Components and Measurement libraries own their separate
    explicit writer/Session workflows; screen State owns no Placement request,
    writer-provider read, confirmation or returned-event application.
    Photo copy/ensure/confirm and result application stay delegated; host callbacks
    create no parallel canonical rows.
12. [D] Exact canonical results use session generation/dedup/stale handling.
    Read-only Known Facts alignment summaries remain distinct from the live
    event-derived photo layer while the projection is stale.
13. [D] Both Measurement inputs derive from the same resolved visible
    `selectedEntry`; no placement supplies two nulls even for component-only
    selection. The child owns drafts/guards and reads writer/session providers.
14. [D] The advanced builder uses panel context for Theme and constructs imported
    Inspector tiles: trace provenance before measurements, both READ, or empty copy.
    The child retains its ExpansionTile. The footprint builder captures private
    entry/painter ownership and returns Semantics/CustomPaint; only target,
    visual label and count arrive from the child, which retains the 82 px slot.
15. [D] One `ComponentIdentityHolder` is created per screen State and disposed
    with it. Add removal, focus/mode changes and responsive cutover reuse it;
    create/edit drafts, guards and pending status belong to the module.
16. [D] The host resolves nullable `ComponentFact` through current selection and
    Placement fallback. The Add frame passes project/target/holder and a
    `List<Widget>` builder; the child spreads Placement children between create
    and edit in the same Column, with no writer/session callback through the host.
17. [D] Inspector placement/component/template come from the same `selectedEntry`.
    The host resolves `PlacementSeed`, eagerly calls holder `reseedInspector`
    even when the panel is hidden, and passes the module-built editor Widget as
    `placementDraftSection`. The holder owns independent Add/Inspector drafts;
    related-data lookup, badge visibility and safety remain host-owned.
18. [D] One `BoardCanvasPlacementHolder` survives Add/focus/responsive removal;
    the host subscribes once and removes the listener before screen disposal.
    Gesture forwarding writes its anchor/captured Canvas size; rendering reads
    immutable `ghostDraft` values. Catalogue and every painter remain host-owned.
19. [D] Host `resolveSaveValues` captures eligible target identity, not a center.
    The module invokes it again at Save with the current snapshot; X/Y conversion
    uses that same anchor/size pair. The resolved value feeds module bounds and
    request fields, without a host-mediated writer/Session/save callback.
20. [D] Eligibility uses all placements, including hidden photo placements.
    Components receives direct module-built Placement children through the host;
    Inspector receives the opaque editor, preserving existing frames and order.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `ProjectSession`, `projectStateProvider`, `ProjectState` | input / projection | State, close, generation, event application and freshness. |
| `WorkbenchPopupTheme` from shared app_theme.dart | inherited presentation | Opened-menu Theme capture without recoloring closed instrument chrome or renderer. |
| `workbench_shell.dart`, `beginner_mode_provider.dart` | model / UI state | Shared destination inventory and independent mode provider. |
| `photo_event_read_model.dart` | pure input | Accepted photos, exact primary identity and bounded alignments. |
| `photo_workbench_panel.dart` | child workflow | Additional import, point draft, explicit ensure/confirm and session handoff. |
| `photo_event_writer.dart`, `photo_import_service.dart` | injected seams | Delegated canonical/file workflow types. |
| `aligned_photo_layer.dart`, `photo_alignment_transform.dart` | read/render/value seams | Primary asset loading, matrix renderer, typed points and solution data. |
| `measurement_projection.dart`, `placement_geometry.dart` | pure helpers | Counts/badges/caution and geometry/hit tests. |
| `wizard_intake_overlay.part.dart` | same-library part | Wizard rendering declarations. |
| `component_navigator.dart` | imported presentation library | Public `ComponentFact`/`ComponentVisualPlacementFact` inputs, selected component/placement IDs, shared category policy, display label and unchanged placement-key format. Seven intent callbacks leave state and placement actions in this host. |
| `BoardCanvasPalette`, facts, `WizardIntake` | read input | Static colors, canonical projection and noncanonical intake. |
| `board_canvas_placement_panel.dart` | normal workflow / immutable-value library | Screen-lived Placement holder, Add children/editor, guards and explicit writer/Session workflow; host resolves target/geometry and supplies catalogue/preview adapters. |
| `board_canvas_inspector_panel.dart` | normal child / presentation library | Resolved Inspector facts, counts/visibility and opaque Placement editor slot; declares presentation widgets consumed by host Measurement and the separate Placement editor. |
| `component_identity_panel.dart` | normal child library | Component create/edit UI, holder and writer/session workflow; host owns holder lifetime, nullable edit-target resolution and one-way Placement children construction. |
| `integrated_measure_panel.dart` | normal child library | Measurement widget/State/writer/session workflow; stable nullable component inputs, navigation callback and two one-way host builders. |
| Flutter/GoRouter, `dart:async`, `dart:io` | framework/read | Widgets/navigation, capture completion and legacy Wizard image read. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| delegated Placement workflow | `UI_LOCAL` / `CANONICAL_EVENT` / `PROJECTION_STATE` | [D] Module owns drafts and explicit confirmation plus captured Session handoff; host supplies no writer or save callback. |
| Placement holder lifetime / target / geometry / presentation adapters | `UI_LOCAL` / `ZERO_WRITE` | [D] Host subscribes/disposes, resolves eligibility and center conversion, and constructs catalogue/preview widgets without canonical mutation. |
| delegated Components panel | `UI_LOCAL` / `CANONICAL_EVENT` / `PROJECTION_STATE` | [D] Module owns drafts and explicit add/edit calls plus Session handoff; host supplies no save/session callback. |
| Components holder lifetime / Placement children builder | `UI_LOCAL` / `ZERO_WRITE` | [D] Host creates/disposes the holder and delegates Placement children construction; Components and Placement retain their own workflow state/writes. |
| delegated Measurement panel | `UI_LOCAL` / `CANONICAL_EVENT` / `PROJECTION_STATE` | [D] Child owns drafts, explicit V2 writer and generation-guarded Session result; host supplies no save/session callback. |
| Measurement provenance/footprint builders | `ZERO_WRITE` | [D] Host constructs imported Inspector tiles and private painter rendering; no event or projection mutation. |
| Inspector resolved inputs and editor-slot composition | `ZERO_WRITE` | [D] Host supplies current facts and the existing editor Widget; Inspector owns no draft, lookup, provider or writer. |
| Inspector badge / Placement draft handoff | `UI_LOCAL` | [D] Badge setState stays host-owned; Placement holder mutators own draft/ghost changes. Inspector only forwards the badge callback or composes the opaque module editor. |
| delegated photo panel | `NONCANONICAL_FILE` / `CANONICAL_EVENT` / `PROJECTION_STATE` | [D] Child/service owners enforce import or explicit primary ensure/confirm. |
| Home | `PROJECTION_STATE` + `UI_LOCAL` | [D] Existing close before root navigation, no canonical write. |
| mode/menu/selection/layer/focus/capture | `UI_LOCAL` | [D] Transient providers, callbacks and navigation. |
| asset read, renderer, inspector, freshness | `ZERO_WRITE` | [D] Read/presentation only, no event/file mutation. |

Photo geometry does not prove electrical identity, connectivity, measurements,
damage or repair state. Host rendering does not establish a canonical alignment;
that evidence comes only from the explicit delegated confirmation writer.

## Zero-write zones

- Primary asset loading, alignment filtering, transform rendering and warnings.
- Wizard photo/contour, Board painters, markers, inspectors and summaries.
- Draft preview/cancel, navigation, mode, focus and layer controls are
  noncanonical; Home separately clears only in-memory session state.
- No schema, materializer, Project ZIP, homography, EXIF or camera owner enters.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Instrument/navigation | [D] unchanged bar and shared-inventory popup with captured warm Theme | router, Shell model, shared theme, mode/session | `UI_LOCAL` / Home `PROJECTION_STATE` | shell, gate and Single Shell Board cases |
| Primary asset/selection | [D] path/hash/dimensions and guarded load | read model / loader | `ZERO_WRITE` / `UI_LOCAL` | reopen, changed-byte and unavailable cases |
| Photo confirmation seam | [D] child callbacks and injected writer | panel, durable writer, session | delegated `CANONICAL_EVENT` / `PROJECTION_STATE` | confirm/retry/stale groups |
| Preview/capture/render | [D] host state and stack | solver / raster / Wizard | `UI_LOCAL` / `ZERO_WRITE` | exit, raster and composite cases |
| Placement composition/lifetime/center | [D] screen-lived holder, immutable inputs and tap-time geometry adapter | Placement controls/guards/writer/Session, host selection/catalogue/Canvas and Components/Inspector slots | delegated `UI_LOCAL` / `CANONICAL_EVENT` / `PROJECTION_STATE`; host adapters `ZERO_WRITE` | `Placement P0 characterization`, retained save/duplicate/bounds/template/ghost and source-owner cases |
| Components composition/lifetime | [D] one screen holder, nullable target and spread Placement children | module guards/add-edit writers/Session, host selection and Placement frame | delegated `UI_LOCAL` / `CANONICAL_EVENT` / `PROJECTION_STATE`; construction `ZERO_WRITE` | `Components C0 characterization` and host/module source guards |
| Measurement composition | [D] placement-derived inputs and two host builders | module State/writer/session, Inspector tiles and preview painter | delegated `UI_LOCAL` / `CANONICAL_EVENT` / `PROJECTION_STATE`; builders `ZERO_WRITE` | M0 group, four advanced-details/no-placement cases and source-owner guards |
| Inspector composition | [D] one resolved entry, module-built editor Widget and imported presentation declarations | Inspector/Placement libraries, host selection/badge state, Measurement reuse and safety | `ZERO_WRITE` / host `UI_LOCAL` | frozen I0, M0 provenance and source-owner guards |
| Navigator/geometry | [D] public fact/ID adapter, shared classifier/label/key consumers and Wizard part | Stateless Navigator/pure owners, host state/actions and painter hits | `UI_LOCAL` / `ZERO_WRITE` | unchanged host Navigator/geometry families; direct `component_navigator_test.dart` |
| Responsive/freshness | [D] separate bar/content thresholds | router/body padding/banner | `ZERO_WRITE` / `UI_LOCAL` | width matrix, focus and banner cases |

## Relevant tests and helpers

- `test/widget/board_canvas_screen_test.dart` owns Single Shell area/width/banner,
  import, alignment, existing writer, rendering, pure-helper and boundary families.
- The routed area case compares measured Canvas area to pre-edit literals;
  it is fixture evidence, not a runtime layout requirement.
- `test/widget/workbench_shell_test.dart` covers all 12 popup destinations,
  modes, Home, secondary shells and byte-level navigation guards.
- `test/widget/project_gate_test.dart` covers gate/bypass, secondary identity,
  aliases, push/pop and unsettled Material transitions.
- Photo writer/read-model/transform unit suites own delegated contracts.
- `SeededProjectSession` and injected photo/V2 fakes bound widget observations.
- `Components C0 characterization` retains screen lifetime, pending/re-entry,
  repeat-save asymmetry, session/selection and create/Placement/edit order.
- `Inspector I0 characterization` retains wide/compact rendered order and gaps,
  metadata/copy/badge coupling, screen-lived Placement holder draft lifetime/reseeding and placeholder.
  Static guards inspect host, Inspector and existing workflow-module ownership.
- `Placement P0 characterization` retains twelve generated cases for pending,
  late handoff, generation/composition, retry/repeat, focus/935/936, captured
  selection and independent Add/Inspector entry reseeding.

## Dangerous combinations

- Shared-shell counts cannot stand in for primary Canvas composition.
- Import rows, Wizard input and canonical primary identity are distinct.
- Preview/capture must not survive departure from the Photos context.
- Reopened selection needs current digest and intrinsic bounds, not just ALN ID.
- Normalized board geometry, intrinsic raster sizing and Wizard fit have
  separate coordinate bases; altering one can hide a visual regression in another.
- Async results must not mutate a newer project or become local canonical rows.
- Panel absence must not dispose Components or Placement holders; screen disposal must
  suppress late UI updates without suppressing already-started session handoff.

## Safe SNIPER slices

- Instrument bar: `_buildScaffold` plus routing/menu/mode/status tests.
- Primary loading: reconcile/load identity plus changed-byte/reopen cases.
- Preview exit/capture: host clear/completer plus exit/capture cases.
- One delegated photo result: child callback and matching session case.
- Placement composition/center: host resolver/holder bridge plus module guard/request,
  P0 and retained coordinate/bounds evidence; a pure helper uses its own owner.
- One Components input/lifetime/builder seam: inspect module ownership and the
  matching C0 lifetime, selection, Placement-order or source-owner evidence.
- One Measurement input or host builder seam: inspect the module and exact
  M0/advanced-details/no-placement/source-owner evidence.
- Inspector input/editor-slot or reused presentation widget: inspect the module
  and matching I0/M0/static-owner evidence; keep module draft and host painter seams.
- Rendering: one stack layer plus raster/composite evidence.

## Future extraction seams

[S] Pure math, primary asset/rendering, photo authoring, Wizard parts and host
state already form distinct review boundaries. No extraction is prescribed.

## Freshness and review triggers

Review instrument/menu/Home/mode, primary source/identity, event selection,
capture/layer/preview lifecycle, z-order, holder/target/builder and write/session ownership, thresholds,
freshness, Inspector input/slot/presentation ownership, helper/part contracts and linked test evidence.

## Known uncertainty

- [D] Host integration does not prove native picker or real Python atomicity.
- [P] Private painter/source-string assertions are structure-sensitive.
- [D] Known Facts summaries can lag event-derived render state while stale.
- [D] Measurement construction has accepted formatting debt; it does not change
  the verified input/builder contract or authorize source cleanup.
