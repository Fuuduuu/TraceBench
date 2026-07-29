# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_LOCK_PASS.md`

## File purpose

Owns the accepted six-step New Project Wizard. Step 1 captures a widget-local
project draft; Step 2 owns a widget-local contour editor with transient
editor-normalized points, selection, dragging, explicit closure, navigation
gating, and responsive painting; Steps 3–6 remain honest placeholders. The
screen retains draft state across navigation, distinguishes functional
completion from viewed placeholders, confirms dirty cancellation, and performs
no project, directory, file, event, fact, projection, or ZIP write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Step catalogue | `_wizardSteps`, `_WizardStepDefinition` | Defines the six Estonian steps and distinguishes functional Step 2 from placeholder Steps 3–6. |
| Picker and Step 1 draft | `NewProjectWizardScreen`, `directoryPicker`, `platformInfo`, `_projectNameController`, `_selectedParentPath`, `_pickFolder` | Owns injected/default picker behavior and transient Step 1 values. |
| Contour state and gate | `_contourPoints`, `_selectedContourPointIndex`, `_draggingContourPointIndex`, `_draggingContourPointer`, `_contourClosed`, `_canAdvanceFromContour` | Owns all transient Step 2 contour state and its forward-navigation precondition. |
| Geometry and hit testing | `_normalizedContourPoint`, `_contourPointOnCanvas`, `_contourPointAt` | Converts pointer positions to clamped editor-normalized values and finds the nearest point within the fixed hit radius. |
| Contour interaction | `_handleContourTap`, `_handleContourPointerDown`, `_handleContourPointerMove`, `_handleContourPointerEnd` | Adds or selects points and performs raw-pointer dragging without exposing contour state outside the widget. |
| Contour mutations | `_deleteSelectedContourPoint`, `_resetContour`, `_closeContour`, `_draftTouched` | Deletes, resets, or explicitly closes the contour; every contour-content or closure mutation marks the draft dirty. |
| Navigation and cancellation | `_goNext`, `_goBack`, `_cancelWizard`, `_currentStep` | Enforces Step 1 and Step 2 gates, retains local state, and confirms touched-draft cancellation. |
| Responsive shell and progress | `build`, `_buildWideProgress`, `_buildCompactProgress`, `_buildProgressTile`, `_buildEditorCard` | Chooses wide/compact layouts and labels functional completion versus viewed placeholders. |
| Contour editor UI | `_buildContourStep`, `_buildContourCanvas`, `_buildContourControls`, `_buildContourStateRow` | Renders the editor, semantic status, text/icon controls, candidate-boundary copy, and responsive canvas/control placement. |
| Contour painter | `_WizardContourPainter`, `paint`, `shouldRepaint` | Paints the grid, open polyline or closed loop, numbered points, and selected-point ring from an immutable point snapshot. |
| Step 1, placeholders, and actions | `_buildStepOne`, `_buildPlaceholder`, `_buildActionBar`, `_WizardSafetyCard` | Preserves Step 1 behavior, keeps Steps 3–6 non-functional, and exposes no final create action. |

## State and data flow

1. `[D]` Step 1 stores three controller values and `_selectedParentPath`
   locally. Text changes and accepted nonblank folder selection arm
   `_draftTouched`; selecting a folder creates or validates nothing.
2. `[D]` `_contourPoints` stores `Offset` values normalized only to the current
   editor rectangle and clamped to `0.0..1.0`. The values are not named or
   treated as canonical `board_normalized` coordinates.
3. `[D]` `_handleContourTap` selects a hit point without changing contour
   geometry, closure, or dirty state, or adds a new normalized point, selects
   it, reopens the contour, and marks the draft dirty.
4. `[D]` Raw pointer down records the hit point and pointer identity. Matching
   pointer moves update only that point, clamp it to the editor, reopen a closed
   contour, and mark the draft dirty; pointer end/cancel clears drag tracking.
5. `[D]` Delete removes the selected point and clears selection/drag state.
   Reset clears all contour state. Both reopen the contour and mark the draft
   dirty.
6. `[D]` `_closeContour` requires at least three points and an open contour,
   then marks it closed and dirty. `_canAdvanceFromContour` independently
   requires closure and at least three retained points.
7. `[D]` `_goNext` enforces the Step 1 name/path gate and the Step 2 closure
   gate. Forward/back navigation changes only `_currentStep`, so contour points
   and closure survive a Step 2 -> Step 3 -> Step 2 round-trip.
8. `[D]` `_buildProgressTile` marks prior Step 1 complete, marks prior Step 2
   complete only while `_contourClosed`, and labels visited Steps 3–5
   `Vaadatud`; terminal Step 6 can only be current or future.
9. `[D]` `_buildContourCanvas` passes an unmodifiable point snapshot plus
   selection and closure to `_WizardContourPainter`. Semantics and controls
   state point count, selection, and open/closed state with text and icons.
10. `[D]` Wide Step 2 uses a 430-pixel canvas beside controls; compact or
    constrained Step 2 stacks a 300-pixel canvas above controls.
11. `[D]` Steps 3–6 remain placeholders. Step 6 exposes no create CTA and the
    screen has no creator, project-state, persistence, or canonical-write path.

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
| `_WizardContourPainter` and contour/status rendering | `ZERO_WRITE` | Read immutable point snapshots and paint/describe UI without persistence. |
| `_goNext`, `_goBack`, action gating, and progress classification | `UI_LOCAL` | Change or derive only visible Wizard navigation state. |
| `context.go('/')` | `ZERO_WRITE` | Navigates Home without assigning project state or saving the draft. |

The file contains no project creation, filesystem write, canonical coordinate,
event/fact append, schema, writer, materializer, projection, Project ZIP,
Board Canvas, component, measurement, net, or diagnosis call path.

## Zero-write zones

- `[D]` Editor-normalized points never leave `_NewProjectWizardScreenState`.
- `[D]` `_WizardContourPainter` draws only transient presentation geometry.
- `[D]` Candidate copy explicitly disclaims dimension, identity, physical, and
  electrical meaning.
- `[D]` Folder selection stores only a returned string.
- `[D]` Steps 3–6 and the final action area execute no workflow.
- `[D]` Cancellation, progress, palette, pills, and safety copy persist
  nothing.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Contour state/gate | `[D]` Closure plus point count controls Step 2 advance. | `_goNext`, action bar, progress | `UI_LOCAL` | Empty state; explicit closure; reopen; round-trip |
| Normalization/hit testing | `[D]` Pointer positions are clamped and hit-tested in editor pixels. | Canvas size and painter conversion | `ZERO_WRITE` | Add; select/drag/clamp |
| Add/select/drag | `[D]` Tap and raw pointer flows mutate only local points. | Scrollable shell, semantics | `UI_LOCAL` | Add; select/drag; reopen |
| Delete/reset/close | `[D]` Explicit controls clear or close local state and dirty the draft. | Selection/status controls, gate | `UI_LOCAL` | Delete; reset; closure; reopen |
| Painter | `[D]` Open and closed paths plus selection are rendered from a snapshot. | Palette and canvas geometry | `ZERO_WRITE` | Closed-loop painter state; point inspection |
| Navigation retention | `[D]` Step changes retain contour state. | Progress and editor rebuilding | `UI_LOCAL` | Step 3 round-trip |
| Dirty cancellation | `[D]` All actual contour mutations set `_draftTouched`. | Step 1 dirty sources, cancel dialog | `UI_LOCAL` | Contour mutation cancellation; existing cancel tests |
| Progress semantics | `[D]` Step 2 completion depends on closure; placeholders remain viewed. | Wide/compact progress | `ZERO_WRITE` | Progress distinction |
| Responsive editor | `[D]` Layout thresholds change hierarchy and height only. | Scroll shell and controls | `ZERO_WRITE` | 1440×900 and 390×760 overflow tests |
| Final zero-write boundary | `[D]` No creator route/action or persistent dependency exists. | Step 6 and router harness | `ZERO_WRITE` | Protected-boundary traversal |

## Relevant tests and helpers

Primary suite: `test/widget/new_project_wizard_screen_test.dart`, with 27
widget tests. Contour-focused helpers are `_openContourStep`,
`_contourCanvasRect`, `_tapContourAt`, `_dragContourPoint`,
`_contourPainter`, `_paintedContourPoints`, `_paintedContourIsClosed`,
`_addTriangle`, and `_closeContour`.

The suite directly covers empty/gated state, point addition, the three-point
closure precondition, selection, dragging, clamping, deletion, reset, explicit
closed-loop state, reopen after add/move/delete, Step 3 round-trip retention,
dirty cancellation, Step 2 `Valmis`, placeholder `Vaadatud`, both responsive
layouts, Step 1 regression behavior, and the absence of a creation path.

## Dangerous combinations

- `[D]` Changing normalization, hit radius, pointer identity, and scroll
  behavior together can make dragging select, scroll, or clamp incorrectly.
- `[D]` Changing closure mutations, navigation gates, and progress together can
  enable `Edasi` for an open contour or show false completion.
- `[D]` Changing delete/reset with selection and drag tracking can leave stale
  indices or pointer ownership.
- `[D]` Changing shared dirty state and cancellation can silently discard
  contour or Step 1 work.
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
- Gate/progress only: `_canAdvanceFromContour`, `_goNext`, `_buildActionBar`,
  `_buildProgressTile`, and closure/progress tests.
- One responsive branch only: `_buildContourStep`, canvas height, and the
  matching overflow test.
- Step 1, picker, or cancellation-only changes must preserve contour state and
  the zero-write boundary.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` The contour editor and painter could become a component if state
  ownership, dirty callbacks, and editor-normalized semantics remain explicit.
- `[S]` Progress presentation may be separable if Step 2 functional completion
  remains distinct from placeholder viewing.
- `[S]` Pointer geometry may be isolated behind a pure helper without creating
  canonical coordinate authority.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when contour state, handlers, controls, painter,
keys, or step anchors change; `FLOW_DRIFT` when input, mutation, closure,
navigation, dirty, or progress ordering changes; `BOUNDARY_DRIFT` when points
leave widget state or persistence/canonical behavior enters; `TEST_DRIFT` when
interaction, responsive, progress, or zero-write coverage changes; and
`STRUCTURE_DRIFT` when Step 2 ownership moves to another file or service.

## Known uncertainty

- `[D]` The dirty-cancellation test reaches Step 2 through `_openContourStep`,
  whose Step 1 helper already dirties the draft; production source, rather
  than that test alone, proves each contour mutation sets `_draftTouched`.
- `[D]` Responsive tests cover 1440×900 and 390×760, not every intermediate
  size or physical input device.
- `[D]` The editor intentionally does not test or claim self-intersection,
  dimensions, board identity, physical validity, or electrical meaning.
