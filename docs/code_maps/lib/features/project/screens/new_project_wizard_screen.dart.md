# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS.md`

## File purpose

Owns the accepted six-step New Project Wizard. Step 1 captures a widget-local
project draft; Step 2 owns the transient contour editor and its closed-only
navigation gate; Step 3 owns a private generic component-candidate editor that
uses the closed contour only as a visual guide; Steps 4–6 remain honest
placeholders. The screen retains local draft state across navigation,
distinguishes functional completion from viewed optional work, coordinates
candidate dragging with page scrolling, confirms dirty cancellation, and
performs no project, directory, file, event, fact, projection, or ZIP write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Step catalogue | `_wizardSteps`, `_WizardStepDefinition` | Defines the six Estonian steps, with functional Steps 2–3 and placeholder Steps 4–6. |
| Picker and Step 1 draft | `NewProjectWizardScreen`, `directoryPicker`, `platformInfo`, `_projectNameController`, `_selectedParentPath`, `_pickFolder` | Owns injected/default picker behavior and transient Step 1 values. |
| Contour state and gate | `_contourPoints`, `_selectedContourPointIndex`, `_draggingContourPointIndex`, `_draggingContourPointer`, `_contourClosed`, `_canAdvanceFromContour` | Owns all transient Step 2 contour state and its forward-navigation precondition. |
| Contour geometry and interaction | `_normalizedContourPoint`, `_contourPointOnCanvas`, `_contourPointAt`, `_handleContourTap`, `_handleContourPointerDown`, `_handleContourPointerMove`, `_handleContourPointerEnd`, `_deleteSelectedContourPoint`, `_resetContour`, `_closeContour` | Clamps, hit-tests, adds, selects, drags, deletes, resets, reopens, and closes editor-local contour points. |
| Contour editor and painter | `_buildContourStep`, `_buildContourCanvas`, `_buildContourControls`, `_WizardContourPainter` | Renders contour controls, semantics, grid, open/closed path, numbered points, and selection from immutable snapshots. |
| Component candidate state | `_componentCandidates`, `_nextComponentDraftKey`, `_selectedComponentDraftKey`, `_draggingComponentDraftKey`, `_draggingComponentPointer`, `_WizardComponentCandidate` | Owns stable widget-local draft keys, editor-normalized positions, selection, and active pointer state. |
| Component geometry and interaction | `_normalizedComponentPosition`, `_componentPositionOnCanvas`, `_componentCandidateKeyAt`, `_handleComponentTap`, `_handleComponentPointerDown`, `_handleComponentPointerMove`, `_handleComponentPointerEnd`, `_deleteSelectedComponentCandidate` | Adds, selects, drags, clamps, and deletes only the selected generic candidate. |
| Component editor and semantics | `_buildComponentPlacementStep`, `_buildComponentCanvas`, `_buildComponentControls`, `_buildComponentStateRow` | Renders optional Step 3, text/icon count and selection state, delete control, boundary copy, and responsive editor/control layout. |
| Component painter and contour guide | `_WizardComponentPlacementPainter`, `guideContourPoints`, `guideClosed`, `candidates`, `selectedDraftKey` | Paints the closed contour as a read-only guide and candidate markers from immutable snapshots. |
| Navigation and cancellation | `_goNext`, `_goBack`, `_cancelWizard`, `_currentStep` | Enforces Step 1 and Step 2 gates, retains local state, and confirms touched-draft cancellation. |
| Responsive shell, progress, and scroll | `build`, `SingleChildScrollView`, `_buildWideProgress`, `_buildCompactProgress`, `_buildProgressTile`, `_buildEditorCard` | Chooses layout, labels completion versus `Vaadatud`, and disables ancestor scrolling only during a hit-candidate drag. |
| Step 1, placeholders, and actions | `_buildStepOne`, `_buildPlaceholder`, `_buildActionBar`, `_WizardSafetyCard` | Preserves Step 1 behavior, keeps Steps 4–6 non-functional, leaves Step 3 ungated, and exposes no final create action. |

## State and data flow

1. `[D]` Step 1 stores three controller values and `_selectedParentPath`
   locally. Text changes and accepted nonblank folder selection arm
   `_draftTouched`; selecting a folder creates or validates nothing.
2. `[D]` `_contourPoints` stores values normalized only to the Step 2 editor
   rectangle and clamped to `0.0..1.0`; the values are not canonical
   `board_normalized` coordinates.
3. `[D]` Contour tap and raw-pointer flows select or mutate only local points.
   Add, move, delete, and reset reopen a closed contour and mark the draft
   dirty; explicit close requires at least three points and also marks dirty.
4. `[D]` `_canAdvanceFromContour` requires closure plus at least three retained
   points. `_goNext` enforces only the Step 1 and Step 2 gates.
5. `[D]` `_WizardComponentCandidate` contains only a monotonically allocated
   local `draftKey` and a transient editor-normalized `position`; the list and
   selection never leave `_NewProjectWizardScreenState`.
6. `[D]` `_handleComponentTap` selects the nearest candidate inside the fixed
   hit radius or creates one candidate at a clamped empty-canvas position.
   Selection alone does not dirty the draft; creation does.
7. `[D]` Matching raw-pointer moves replace only the hit candidate with
   `movedTo(nextPosition)`, clamp its center to `0.0..1.0`, preserve its key,
   and mark the draft dirty. Pointer end/cancel clears drag ownership.
8. `[D]` `_deleteSelectedComponentCandidate` removes only the selected stable
   key, clears selection/drag tracking, and marks the draft dirty. There is no
   reset-all action, placement limit, or polygon-containment check.
9. `[D]` While `_draggingComponentDraftKey` is non-null, the ancestor
   `SingleChildScrollView` uses `NeverScrollableScrollPhysics`; an
   empty-canvas pointer retains default page scrolling because it owns no
   candidate drag key.
10. `[D]` `_buildComponentCanvas` passes immutable contour and candidate
    snapshots to `_WizardComponentPlacementPainter`. The painter reads the
    closed contour only as a guide and paints no identity or validity claim.
11. `[D]` Forward/back navigation changes only `_currentStep`, so contour state
    survives Step 2 -> Step 3 -> Step 2 and candidate keys/positions survive
    Step 3 -> Step 4 -> Step 3.
12. `[D]` `_buildProgressTile` marks functional Step 2 complete only while
    closed, labels visited optional Step 3 and placeholders `Vaadatud`, and
    never treats Step 3 as an `Edasi` gate.
13. `[D]` Wide editors use a 430-pixel canvas beside controls; compact or
    constrained editors stack a 300-pixel canvas above controls. Steps 4–6 and
    the final action area execute no workflow.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework and UI state | Provides widget state, pointer/tap input, geometry, painting, semantics, responsive layout, dialogs, fields, and controls. |
| `FilePicker` | outbound picker service | Selects a parent directory when no picker callback is injected. |
| `PlatformInfo` / `DefaultPlatformInfo` | inbound capability service | Supplies the mobile/non-mobile folder-picker gate. |
| GoRouter | outbound UI navigation | Routes cancellation to `/`. |

There is no Riverpod, `ProjectCreator`, project-state provider, canonical
writer, materializer, projection, or project-model dependency.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Step 1 controllers, selected path, current step, picker and dirty flags | `UI_LOCAL` | Mutate transient widget state only. |
| Contour points, selection, drag tracking, closure, and mutation handlers | `UI_LOCAL` | Mutate only the Wizard state's editor-local draft. |
| Component candidates, stable draft keys, positions, selection, and drag tracking | `UI_LOCAL` | Mutate only the private Step 3 visual-candidate draft. |
| `_WizardContourPainter` and contour/status rendering | `ZERO_WRITE` | Read immutable point snapshots and paint/describe UI without persistence. |
| `_WizardComponentPlacementPainter` and component/status rendering | `ZERO_WRITE` | Read immutable guide/candidate snapshots and paint/describe proposals without persistence. |
| `_goNext`, `_goBack`, action gating, and progress classification | `UI_LOCAL` | Change or derive only visible Wizard navigation state. |
| Conditional `SingleChildScrollView.physics` | `UI_LOCAL` | Coordinates transient pointer ownership with visible page scrolling only. |
| `context.go('/')` | `ZERO_WRITE` | Navigates Home without assigning project state or saving the draft. |

The file contains no project creation, filesystem write, canonical coordinate,
event/fact append, schema, writer, materializer, projection, Project ZIP,
Board Canvas, confirmed component identity/placement, measurement, net, or
diagnosis call path.

## Zero-write zones

- `[D]` Editor-normalized points never leave `_NewProjectWizardScreenState`.
- `[D]` Candidate keys and editor-normalized positions never leave
  `_NewProjectWizardScreenState`.
- `[D]` `_WizardContourPainter` draws only transient presentation geometry.
- `[D]` `_WizardComponentPlacementPainter` treats the contour as a read-only
  guide and candidates as presentation markers.
- `[D]` Candidate copy explicitly disclaims identity, type, value, designator,
  package, footprint, pins, contacts, board side, connectivity, net,
  measurement and diagnosis.
- `[D]` Folder selection stores only a returned string.
- `[D]` Steps 4–6 and the final action area execute no workflow.
- `[D]` Cancellation, progress, palette, pills, and safety copy persist
  nothing.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Contour state/gate | `[D]` Closure plus point count controls Step 2 advance. | `_goNext`, action bar, progress | `UI_LOCAL` | Empty state; explicit closure; reopen; round-trip |
| Contour normalization and interaction | `[D]` Pointer positions are clamped, hit-tested, and applied only to local points. | Canvas size, painter, scrollable shell | `UI_LOCAL` | Add; select/drag/clamp; reopen |
| Delete/reset/close | `[D]` Explicit controls clear or close local state and dirty the draft. | Selection/status controls, gate | `UI_LOCAL` | Delete; reset; closure; reopen |
| Component state and identity | `[D]` Stable local keys and normalized positions remain private draft data. | Painter snapshots, selection copy | `UI_LOCAL` | Empty/add; stable-key delete; round-trip |
| Component add/select/drag/delete | `[D]` Tap and pointer flows mutate only the selected local candidate and clamp its center. | Hit radius, scroll physics, semantics | `UI_LOCAL` | Add/select; drag/clamp; selected delete |
| Read-only contour guide | `[D]` Step 3 receives immutable contour points and closure only for painting. | Step 2 state and painter conversion | `ZERO_WRITE` | Closed guide; outside-polygon candidate |
| Navigation retention | `[D]` Step changes retain contour and candidate state. | Progress and editor rebuilding | `UI_LOCAL` | Step 2/3 and Step 3/4 round-trips |
| Dirty cancellation | `[D]` Every contour mutation and candidate add/move/delete sets `_draftTouched`. | Step 1 dirty sources, cancel dialog | `UI_LOCAL` | Contour and candidate cancellation tests |
| Progress and gating | `[D]` Step 2 completion depends on closure; Step 3 is optional and visited-only. | Action bar, wide/compact progress | `ZERO_WRITE` | Ungated Step 3; `Vaadatud`; placeholders |
| Responsive pointer/scroll | `[D]` Layout changes hierarchy; candidate drag alone suppresses ancestor scrolling. | Canvas geometry, pointer ownership | `UI_LOCAL` | Step 3 wide/compact; compact scroll-offset assertion |
| Final zero-write boundary | `[D]` No creator route/action or persistent dependency exists. | Step 6 and router harness | `ZERO_WRITE` | Protected-boundary traversal |

## Relevant tests and helpers

Primary suite: `test/widget/new_project_wizard_screen_test.dart`, with 34
widget tests. Contour-focused helpers remain `_openContourStep`,
`_contourCanvasRect`, `_tapContourAt`, `_dragContourPoint`,
`_contourPainter`, `_paintedContourPoints`, `_paintedContourIsClosed`,
`_addTriangle`, and `_closeContour`.

Component-focused helpers are `_openComponentPlacementStep`,
`_componentCanvasRect`, `_tapComponentAt`, `_dragComponentCandidate`,
`_componentPainter`, `_paintedComponentCandidates`,
`_paintedComponentDraftKeys`, `_paintedComponentPositions`,
`_paintedSelectedComponentDraftKey`, `_paintedComponentGuidePoints`, and
`_paintedComponentGuideIsClosed`.

The suite preserves all Step 1/Step 2 contracts and directly covers Step 3
empty/guide/ungated state, outside-contour addition, stable keys, selection,
dragging and edge clamping, selected-only deletion, Step 4 round-trip
retention, candidate dirty cancellation, `Vaadatud` semantics, Steps 4–6
placeholders, wide/compact operability, compact drag-versus-scroll behavior,
and the absence of a creation path.

## Dangerous combinations

- `[D]` Changing normalization, hit radius, pointer identity, and scroll
  behavior together can make dragging select, scroll, or clamp incorrectly.
- `[D]` Changing closure mutations, navigation gates, and progress together can
  enable `Edasi` for an open contour or show false completion.
- `[D]` Changing delete/reset with selection and drag tracking can leave stale
  indices or pointer ownership.
- `[D]` Changing candidate hit testing, stable keys, pointer ownership, and
  ancestor scroll physics together can move the page, the wrong candidate, or
  both.
- `[D]` Changing shared dirty state and cancellation can silently discard
  contour, candidate, or Step 1 work.
- `[D]` Changing Step 3 progress and the shared action bar together can
  accidentally introduce a completion gate or false `Valmis` state.
- `[D]` Adding persistence, canonical coordinates, creator/project-state, or
  Board Canvas coupling would cross the accepted boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Point geometry only: `_normalizedContourPoint`,
  `_contourPointOnCanvas`, `_contourPointAt`, plus drag/clamp tests.
- One mutation only: its handler, matching control, status/gate effects, and
  focused test; preserve reopen and dirty semantics.
- Painter only: `_WizardContourPainter` plus painter-state assertions; exclude
  state ownership and persistence.
- Component state only: `_WizardComponentCandidate` and its state fields plus
  stable-key/retention tests; exclude persistence and canonical coordinates.
- Component interaction only: normalization, hit testing, one handler, scroll
  coordination, and matching focused tests.
- Component painter only: `_WizardComponentPlacementPainter`, immutable guide
  and candidate snapshots, and painter assertions.
- Gate/progress only: `_canAdvanceFromContour`, `_goNext`, `_buildActionBar`,
  `_buildProgressTile`, and closure/optional-Step-3 progress tests.
- One responsive branch only: the relevant Step 2 or Step 3 layout, canvas
  height, scroll coupling, and matching overflow test.
- Step 1, picker, or cancellation-only changes must preserve contour state and
  component state plus the zero-write boundary.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` The contour editor and painter could become a component if state
  ownership, dirty callbacks, and editor-normalized semantics remain explicit.
- `[S]` The component editor and painter could become a component if stable
  draft-key ownership, pointer/scroll coordination, and zero-write semantics
  remain explicit.
- `[S]` Progress presentation may be separable if Step 2 functional completion
  remains distinct from optional Step 3 and placeholder viewing.
- `[S]` Pointer geometry may be isolated behind a pure helper without creating
  canonical coordinate authority.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when contour/component state, handlers, controls,
painters, keys, or step anchors change; `FLOW_DRIFT` when input, mutation,
closure, selection, pointer/scroll ownership, navigation, dirty, or progress
ordering changes; `BOUNDARY_DRIFT` when points/candidates leave widget state or
persistence/canonical behavior enters; `TEST_DRIFT` when interaction,
responsive, progress, or zero-write coverage changes; and `STRUCTURE_DRIFT`
when Step 2 or Step 3 ownership moves to another file or service.

## Known uncertainty

- `[D]` The dirty-cancellation test reaches Step 2 through `_openContourStep`,
  whose Step 1 helper already dirties the draft; production source, rather
  than that test alone, proves each contour mutation sets `_draftTouched`.
- `[D]` The candidate dirty-cancellation test also reaches Step 3 through
  already-dirty Step 1/Step 2 setup; production source independently proves
  candidate add, move, and delete set `_draftTouched`.
- `[D]` Responsive tests cover 1440×900 and 390×760, not every intermediate
  size or physical input device.
- `[D]` Compact coverage asserts that candidate dragging does not move the
  ancestor scroll offset. Default empty-canvas page scrolling is demonstrated
  by the source's null drag-key path rather than a separate widget assertion.
- `[D]` The editors intentionally do not claim contour validity, component
  identity, dimensions, physical validity, or electrical meaning.
