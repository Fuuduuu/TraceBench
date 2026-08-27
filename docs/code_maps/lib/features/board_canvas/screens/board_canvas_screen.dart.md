# Code Map: `lib/features/board_canvas/screens/board_canvas_screen.dart`

- Source: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — >5000 lines + 3+ responsibility categories`
- Audit evidence: `docs/audit/TRACEBENCH_PHOTO_IMPORT_CANONICAL_WRITE_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the Visual First Board Canvas destination: responsive local Workbench,
selection/navigation, rendering, inspection, UI-local drafts, read-only Wizard
intake, freshness presentation, four host-owned V2 writer call paths, and the
host seam for existing-project canonical photo import. Photo selection,
preview, copy, event write, session application, and event-derived list
presentation are delegated to `PhotoWorkbenchPanel` and its service owners;
this host supplies wide, compact, and zero-component entry points. It does not
confirm alignment or render a confirmed aligned-photo background.

The file imports normal pure libraries for measurement projection and placement
geometry, immutable `BoardCanvasPalette`, and two same-library parts:
`wizard_intake_overlay.part.dart` owns Wizard fit/photo/painter declarations,
while `component_navigator.part.dart` owns the private Stateless navigator.
Mutable state, callbacks, non-Wizard painters, routes, session handoffs, and
canonical writer orchestration stay host-owned or explicitly delegated.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen orchestration | `BoardCanvasScreen`, `_BoardCanvasScreenState`, `_WorkbenchContextPanelMode`, `_buildScaffold` | Watches project state, derives presentation inputs, and composes all Canvas branches. |
| 2. Typed selection and preview | `CanvasSelection`, `EmptyCanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection`, `_setCanvasSelection`, `_setPreviewPlacementKeys` | Owns volatile selection, hover preview, and clearing behavior. |
| 3. Navigator and filtering | `_ComponentCategory`, `_ComponentNavigatorPanel`, `_toggleHideUnmeasuredComponents`, `measurementCountsByComponents`, `measurementValueBadgesByComponents` | Owns host callbacks/filter state while consuming delegated navigator and pure measurement projection. |
| 4. Measurement entry | `_IntegratedMeasurePanelState`, `_saveMeasurement`, `_MeasureTargetRow`, `applyCanonicalEvent` | Builds human-entered measurement drafts, calls the existing writer, and hands back the returned event with captured generation. |
| 5. Component create/edit | `_confirmRightPanelComponentCreation`, `_confirmRightPanelMetadataEdit`, `_RightPanelComponentCreationSection`, `_RightPanelMetadataEditSection` | Validates explicit identity creation and metadata edits before existing writer calls. |
| 6. Placement draft/save | `_AddComponentTemplateBuilderPanel`, `_PlacementEditorDraftState`, `_confirmAddComponentTemplatePlacement`, `_PlacementSaveTarget` | Owns template/ghost/editor drafts, normalized guards, explicit placement save, and session result handoff. |
| 7. Canvas interaction and Wizard state | `hasWizardIntakePresentation`, `_CanvasPanelState`, `_selectPlacementAt`, `_fitCanvasView`, `_scheduleWizardInitialFit`, `_wizardPhotoFile` | Keeps intake usable with zero components and owns pan/zoom/tap/fit behavior around read-only Wizard input. |
| 8. Rendering and geometry | `_WizardIntakeFitTransform`, `_WizardIntakePhotoLayer`, `_WizardIntakePainter`, `_BoardBackgroundPainter`, `_BoardPlacementPainter`, `footprintVisualKind`, `renderedPlacementContains` | Consumes delegated Wizard rendering and pure placement geometry while retaining Board painters/drawing/semantics. |
| 9. Inspector and evidence | `_InspectorPanel`, `_PhotoAlignmentReadinessPanel`, `_BoardCanvasSafetyEvidenceDisclosure`, `_MeasurementSummaryCard`, `_VisualTraceMetadataCard` | Presents accepted placement, measurement, alignment-readiness, safety, and trace metadata without promotion. |
| 10. Canonical photo-import host | `photoEventItemsFromEvents`, `_buildPhotoWorkbenchPanel`, `PhotoWorkbenchPanel`, `board_canvas_zero_component_photo_entry` | Derives event-backed photo rows and mounts the delegated import panel for directory-backed zero-component projects and normal Canvas layouts. |
| 11. Local rail, focus, and responsive chrome | `constraints.maxWidth >= 900`, `_WorkbenchToolRail`, `_CompactPhotoPanelButton`, `board_canvas_rail_photos_tool`, `board_canvas_compact_photos_action`, `_CanvasFocusRestoreBar` | Keeps the 900 rich-layout cutover, six retained panel tools including Fotod, compact entry, and focus hide/restore. |
| 12. Projection freshness | `ProjectionFreshness`, `ProjectionStaleBanner`, `_buildScaffold` | Inserts one authoritative nonblocking banner above project-backed Canvas branches. |

## Anchor inventory and verification

Every backtick-delimited stable anchor resolves as an exact host substring.
`_ComponentNavigatorPanel` and the three `_WizardIntake*` types resolve as host
consumer references while declarations live in their named parts. Pure
measurement and geometry names resolve as call sites while declarations live
in imported normal libraries. `PhotoWorkbenchPanel` and
`photoEventItemsFromEvents` likewise resolve as host consumers of delegated
photo owners. Key-name anchors resolve as exact key literals. No line-number
anchors are used.

## Local Workbench contract

- `_WorkbenchContextPanelMode` contains `hidden`, `inspector`, `placements`,
  `measure`, `addComponentTemplates`, `safetyEvidence`, and `photos`.
- Rich layout starts hidden. Measure, Add, Inspector, Placements, Safety, and
  Fotod are the six retained local tools; project-wide navigation remains in
  the outer shared Workbench shell.
- Canvas focus hides local rail/context chrome and restores the selected mode,
  including Fotod.
- `constraints.maxWidth >= 900` remains the destination-local rich cutover;
  the shared shell owns its independent 1228 navigation threshold.
- Compact Canvas exposes `board_canvas_compact_photos_action`; rich Canvas
  exposes `board_canvas_rail_photos_tool`. Both open the same delegated panel.

## State and data flow

- `[D]` `projectStateProvider` supplies `ProjectState`; components, placements,
  pins, measurements, traces, alignments, Wizard intake, warnings, freshness,
  and `photoEventItemsFromEvents(projectState.events)` become presentation
  inputs.
- `[D]` A directory-backed project with zero components, no Wizard intake, and
  no accepted photo event receives the explicit
  `board_canvas_zero_component_photo_entry`. A successful import adds an event,
  so the next rebuild enters the normal Canvas even while components remain
  empty.
- `[D]` `_buildPhotoWorkbenchPanel` supplies current state, current
  `ProjectSession`, event-derived photo rows, optional injected picker/preview/
  import services, and a callback that reopens Fotod after accepted application.
- `[D]` Photo picker/preview/draft state stays in the panel. Explicit import
  delegates safe copy and event writing; the panel applies the exact returned
  event using a captured session generation. This host creates no parallel
  photo canonical state.
- `[D]` Host-owned category, typed selection, filter, preview keys, and local
  placement drafts flow into the Stateless navigator through callbacks.
- `[D]` Measurement and placement inputs cross pure normal-library boundaries;
  results return to unchanged host consumers with no write transfer.
- `[D]` Wizard fit/photo/painter inputs remain read-only beneath canonical Board
  placements. Accepted photo-import events do not enter that old Wizard layer.
- `[D]` Four direct host writer invocations remain split `3 + 1` between
  `_BoardCanvasScreenState` and `_IntegratedMeasurePanelState`; the photo writer
  is behind the delegated panel/service chain.
- `[D]` Every returned canonical event flows through current
  `ProjectSession.applyCanonicalEvent`, which rejects stale/duplicate outcomes
  and promotes accepted projection stale.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider`, `ProjectSession`, `ProjectState`, `ProjectionFreshness` | input / projection update | Supplies accepted state and owns generation-guarded event application, dedup, and stale promotion. |
| `photo_event_read_model.dart` | imported pure read model | Derives accepted V1 `photo_added` presentation rows from event history. |
| `photo_import_service.dart` | injected type boundary | Allows Board tests/host construction to supply the delegated import workflow. |
| `photo_workbench_panel.dart` | child workflow owner | Owns picker/preview/draft/confirmation/import/session handoff and photo list. |
| `measurement_projection.dart` | imported pure helper | Owns endpoint/count/badge/caution presentation derivation. |
| `placement_geometry.dart` | imported pure helper | Owns center/body/visual sizing, classification, envelopes, and upright hit testing. |
| `BoardCanvasPalette` | immutable presentation input | Supplies exact static Canvas colors without state/theme/writer ownership. |
| `wizard_intake_overlay.part.dart` | same-library render dependency | Owns Wizard fit transform, background-photo layer, and painter. |
| `component_navigator.part.dart` | same-library child | Owns the private Stateless navigator while callbacks/state remain here. |
| BoardFact facts and `WizardIntake` | read inputs | Supply projected canonical facts and optional noncanonical intake presentation. |
| Four V2 writer providers | outbound canonical boundaries | Existing component-create/edit, placement, and measurement writes. |
| `dart:io` | local read input | Reads only a validated optional Wizard background photo. |
| Flutter/GoRouter | UI and route output | Owns rendering/interaction and Measure Sheet navigation only. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| component create/edit, placement save, measurement save | `CANONICAL_EVENT` | `[D]` Four explicit host-owned writer actions retain existing guards. |
| four host `applyCanonicalEvent` calls | `PROJECTION_STATE` | `[D]` Captured generation delegates dedup/current-state composition/stale promotion to session. |
| `_buildPhotoWorkbenchPanel` child flow | delegated `NONCANONICAL_FILE` + `CANONICAL_EVENT` + `PROJECTION_STATE` | `[D]` The panel/service owners enforce explicit confirmation, safe copy, writer, and generation guard. |
| photo list and Wizard photo layer | `ZERO_WRITE` | `[D]` Event-derived rows and noncanonical Wizard background are separate read-only presentation sources. |
| selection, drafts, panels, focus, filters | `UI_LOCAL` | `[D]` Transient host state only. |
| painters, inspectors, readiness, summaries | `ZERO_WRITE` | `[D]` Derive/render accepted inputs without promotion. |

Canonical meaning remains writer/schema/materializer-owned. Photo evidence does
not prove components, pins, nets, measurements, electrical function, damage,
suspect state, traces, or alignment.

## Zero-write zones

- Navigation, panel choice, focus, selection, filters, previews, painter output,
  inspectors, readiness, and accepted-photo rows are noncanonical.
- Wizard background presentation and canonical imported-photo presentation are
  distinct; neither is a confirmed aligned Canvas background in this source.
- Pure measurement/geometry helpers and same-library rendering parts own no
  provider, mutable State, event append, or project-file mutation.
- The host does not reopen `ProjectSession`, schema, materializer, Project ZIP,
  camera, EXIF, homography, alignment math, or alignment confirmation.

## Impact matrix

| Change zone | Coupling / risk | Write class | Relevant evidence |
| --- | --- | --- | --- |
| Photo host/entry | zero-component gate, wide/compact modes, panel lifecycle | UI + delegated writes | canonical photo-import widget group + service/writer suites |
| Navigator/filter | visibility, hits, targets, badges | `UI_LOCAL` / `ZERO_WRITE` | navigator/filter and helper families |
| Four host writers | selection, generation, dedup, freshness | canonical + projection | exact writer families + session unit suite |
| Canvas/geometry/Wizard | transforms, hits, z-order, semantics | `UI_LOCAL` / `ZERO_WRITE` | pure geometry and Wizard overlay groups |
| Inspector/evidence | projected summaries and protected wording | `ZERO_WRITE` | inspector/readiness/safety cases |
| Responsive/focus | 900 cutover, six tools, compact Fotod action | `UI_LOCAL` | routed-width and panel/focus cases |
| Freshness | both project-backed scaffold branches | `ZERO_WRITE` presentation | stale/unknown cases |

## Relevant tests and helpers

| Family | Stable anchors | Representative coverage |
| --- | --- | --- |
| Canonical photo import | `canonical photo import workbench`, `_FakePhotoSourcePicker`, `_FakePhotoSourcePreviewLoader`, `_FakePhotoImportService` | Wide/compact entry, cancel/success, zero components, single-shot/uncertain result, read-only session, project switch, unsupported platform. |
| Local panels/responsive | `_routerHarness`, `_openWideContextMode`, `_tapWidgetByKey` | Six widths, hidden default, six retained tools, focus restoration. |
| Writer/session | fake V2 writers, event builders, `SeededProjectSession` | Explicit guards, request values, event application, stale promotion, duplicate no-op. |
| Rendering/Wizard | `_wizardIntakePainter`, `_wizardPhotoLayer`, `_boardCanvasPainter`, `_compositedPixelColor` | Gate, fit, z-order, background photo, rotation, footprints, and semantics. |
| Pure helpers | placement geometry and measurement read-model groups | Direct deterministic geometry/count/badge/caution contracts. |
| Boundaries | `board canvas source keeps read-only data-path boundaries` | Host/part/library ownership and absent aligned-photo authoring. |

## Dangerous combinations

- Removing the zero-component photo entry makes the accepted product flow
  unreachable before component creation.
- Showing an imported event row from widget-local state instead of events can
  hide failed/stale session application.
- Applying an in-flight photo result to a captured notifier rather than current
  session/generation can mutate a newer project.
- Confusing Wizard background with canonical import can reuse an intake path
  instead of creating the required collision-safe project-local copy/event.
- Adding aligned-photo rendering or confirmation here would cross this host's
  current read/presentation ownership into a separate write/transform design.
- Shared responsive tests must pair shell keys with local Canvas layout keys;
  otherwise one cutover can mask another.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Photo entry | zero-component key, compact/rail keys | `_buildPhotoWorkbenchPanel` and mode switch | six photo-workbench widget cases |
| Photo session application | panel construction/callback | current notifier and project rebuild | project-switch case + session suite |
| One host writer | matching confirm/save method | captured generation/result branch | matching family + session suite |
| One panel/focus behavior | `_WorkbenchContextPanelMode`, rail/focus helpers | six retained modes | panel/focus/routed cases |
| One Wizard render behavior | Wizard consumer anchors | named part and painter order | exact overlay case |
| One pure projection/geometry behavior | imported helper call | exact helper owner and consumers | direct helper case |

## Future extraction seams

- `[S]` Photo workflow remains correctly delegated; an aligned-background
  renderer would require its own locked pure-transform/render seam.
- `[S]` Other cohesive host panels may be extracted only without moving
  writer, session, route, or protected semantic ownership.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for photo entry/panel/service injection, event-derived
photo inputs, zero-component gate, context modes/tools/keys, session handoff,
writer count, responsive cutovers, helper/part ownership, painters, routes,
freshness, linked production maps, or Board test-family changes. Recheck six
photo-workbench widget cases, `184 = 161 testWidgets + 23 test`, three owning
groups, six retained local tools, and absence of alignment-confirm/background
symbols after related changes. Formatting and line movement alone do not stale
the map.

## Known uncertainty

- `[D]` Board Canvas hosts the photo panel but does not own its filesystem or
  canonical writer semantics; those maps must be consulted for write review.
- `[P]` Private painter/source-string tests are more structure-sensitive than
  public widget behavior.
- `[D]` Existing Wizard background rendering is noncanonical intake and must
  not be inferred to render newly imported canonical photos.
