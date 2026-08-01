# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS.md`

## File purpose

Owns the accepted seven-step New Project Wizard and every authoritative
widget-local draft used by it. Step 1 captures project metadata; optional Step
2 selects and transforms one local photo; Step 3 edits a contour above the
read-only photo; optional Step 4 places independently styled generic visual
candidates above the photo and read-only contour; Steps 5–7 are honest
placeholders. The screen owns each candidate's shape, canvas-relative size,
rotation, current-style inheritance, geometric rendering, and pointer target.
It retains draft state across navigation and responsive rebuilds,
distinguishes `Valmis` from `Vaadatud`, and reaches no project, canonical,
event, fact, file-copy, or ZIP write path.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Step catalogue and dispatch | `_wizardSteps`, `_WizardStepDefinition`, `_buildEditorCard`, `_buildPlaceholder` | Defines the seven Estonian steps, dispatches Steps 1–4, and keeps Steps 5–7 non-functional. |
| Step 1 draft and folder picker | `NewProjectWizardScreen`, `directoryPicker`, `platformInfo`, `_projectNameController`, `_selectedParentPath`, `_pickFolder` | Owns injected/default folder selection and transient Step 1 values without creating a project. |
| Parent photo draft and picker | `_photoPath`, `_photoTransform`, `_isPickingPhoto`, `_photoPickerError`, `_canPickPhoto`, `_pickPhoto` | Owns one native-desktop image path, locked extension filter, cancel/error handling, and default replacement view. |
| Photo mutation contract | `_setPhotoTranslation`, `_setPhotoScale`, `_normalizedPhotoRotation`, `_setPhotoRotation`, `_setPhotoOpacity`, `_resetPhotoView`, `_removePhoto` | Validates transform inputs, clamps scale/opacity, normalizes rotation, preserves opacity on reset, clears the complete draft on remove, and marks mutations dirty. |
| Photo Step 2 integration | `_buildPhotoAlignmentStep`, `_buildPhotoEmptyState`, `NewProjectWizardPhotoEditor` | Renders the optional photo-only editor, platform copy, selected path, recovery controls, and zero-write boundary note. |
| Contour state and interaction | `_contourPoints`, `_contourClosed`, `_canAdvanceFromContour`, `_handleContourTap`, `_handleContourPointerMove`, `_deleteSelectedContourPoint`, `_resetContour`, `_closeContour` | Owns editor-normalized points, selection/drag state, reopening mutations, and the closed-only Step 3 gate. |
| Contour editor and photo background | `_buildContourStep`, `_buildContourCanvas`, `wizard-contour-stack`, `wizard-contour-photo-layer`, `_WizardContourPainter` | Paints the photo as an inert bottom layer and editable contour state above it, or operates normally without a photo. |
| Candidate style, state, and interaction | `_componentCandidates`, `_componentCurrentShape`, `_componentCurrentSizeScale`, `_componentCurrentRotation`, `_WizardComponentShape`, `_WizardComponentCandidate`, `_setComponentShape`, `_setComponentSizeScale`, `_setComponentRotation`, `_componentCandidateKeyAt` | Owns immutable stable-key candidates, current-style inheritance, selected-only style mutation, add/select/geometric-hit/drag/clamp/delete behavior, and dirty-state branches. |
| Component editor, controls, and layered guides | `_buildComponentPlacementStep`, `_buildComponentCanvas`, `_buildComponentControls`, `wizard-component-stack`, `_WizardComponentPlacementPainter`, `_WizardComponentMarkerGeometry` | Keeps photo and contour inert below candidates, exposes keyed shape/size/rotation/current-style controls, derives shape-aware geometry and hit bounds, and retains no-photo operation. |
| Navigation, progress, and actions | `_goNext`, `_goBack`, `_buildProgressTile`, `_buildActionBar`, `_currentStep` | Enforces only Step 1 and Step 3 gates, derives bounds from `_wizardSteps.length`, and separates completion from visited optional work. |
| Responsive shell and cancellation | `build`, `SingleChildScrollView`, `_buildWideProgress`, `_buildCompactProgress`, `_cancelWizard` | Preserves one parent draft through wide/compact rebuilds, coordinates editor gestures with scrolling, and confirms dirty cancellation. |

## State and data flow

1. `[D]` Step 1 controllers and the selected parent path remain in
   `_NewProjectWizardScreenState`; folder selection stores only a returned
   string and marks the draft dirty.
2. `[D]` `_pickPhoto` is disabled for web/mobile, requests one custom file
   with `jpg/jpeg/png/webp`, reads no bytes, and stores only a nonblank
   supported source path.
3. `[D]` Picker cancel leaves the complete current draft unchanged. Picker
   exception or rejected extension sets visible error state without replacing
   the path or transform.
4. `[D]` Accepted initial selection or replacement assigns the path and a
   default `NewProjectWizardPhotoTransform`: zero translation, scale 1,
   rotation 0, and opacity 0.65.
5. `[D]` Translation accepts finite components without a canonical or
   physical clamp; scale is finite and clamped to `0.25..8.0`; rotation is
   finite and normalized to `[-π, π)`; opacity is finite and clamped to
   `0.0..1.0`.
6. `[D]` Every effective photo transform/opacity change and accepted
   selection/replacement marks `_draftTouched`. Reset marks it dirty while
   preserving path/opacity; remove clears path, transform, and picker error.
7. `[D]` Step 2 passes authoritative path/transform plus callbacks to the
   child editor. It passes no contour or candidate state, so future guides
   cannot move or become authoritative there.
8. `[D]` Steps 3 and 4 instantiate `NewProjectWizardPhotoLayer` only when a
   path exists, wrap it in `IgnorePointer`, and place it before their painter
   in the `Stack`.
9. `[D]` The same parent transform and opacity are read independently by all
   three editor rectangles. Contour points and candidate positions are never
   rewritten, rebased, or converted when the photo changes.
10. `[D]` Contour points remain Step-3 editor-normalized values. Add, move,
    delete, reset, and close mutate only local contour state and dirty the
    draft; closure plus at least three points is the sole Step 3 forward gate.
11. `[D]` Each immutable candidate retains a monotonically allocated local
    key, editor-normalized center, one of four visual shapes, finite size scale
    clamped to `0.50..2.50`, and finite rotation normalized to `[-π, π)`.
12. `[D]` No-selection controls update only the parent current style. Selecting
    loads the candidate style; effective selected edits replace only that
    candidate and dirty the draft; add inherits current style; delete clears
    selection while retaining it; drag changes position only.
13. `[D]` `_WizardComponentMarkerGeometry` derives an at-least-8-pixel minor
    dimension from `3.5%` of the shortest canvas side, applies fixed shape
    ratios and center rotation, and exposes complete rotated bounds plus a
    centered at-least-56×56 hit target. Overlaps resolve by closest center and
    insertion-order ties.
14. `[D]` Forward/back changes only `_currentStep`, so photo, contour,
    candidate values, selection, and current style survive Step 2 ↔ Step 3 ↔
    Step 4, Step 4 ↔ Step 5, photo mutation, and responsive rebuilds.
15. `[D]` Progress derives its item count and labels from `_wizardSteps`.
    Step 1 and a closed Step 3 can be `Valmis`; visited Step 2, Step 4, and
    placeholders are `Vaadatud`.
16. `[D]` `_buildActionBar` derives the final-step boundary from the list
    length and applies no gate to Step 2 or Step 4. The final action remains
    explanatory copy rather than project creation.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material/Foundation | framework and UI state | Provides widget state, pointer/gesture input, painting, semantics, responsive layout, dialogs, and platform detection. |
| `FilePicker` | outbound picker service | Selects a parent directory and, on supported native desktop, one filtered image path. |
| `PlatformInfo` / `DefaultPlatformInfo` | inbound capability service | Supplies the mobile capability boundary. |
| `NewProjectWizardPhotoEditor` / `NewProjectWizardPhotoLayer` | child presentation dependency | Renders and edits the parent-owned photo draft in Step 2 and reuses it read-only below Steps 3–4. |
| GoRouter | outbound UI navigation | Routes confirmed or untouched cancellation to `/`. |

There is no Riverpod, `ProjectCreator`, project-state provider, canonical
writer, materializer, projection, or project-model dependency.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Step 1 values, current step, dirty/picker flags | `UI_LOCAL` | Mutate transient widget state only. |
| Photo path and `NewProjectWizardPhotoTransform` | `UI_LOCAL` | Remain parent-owned presentation draft values and produce no canonical alignment output. |
| Contour points and interaction state | `UI_LOCAL` | Remain editor-local and never become `board_normalized`. |
| Candidate keys, positions, visual style, selection, and current style | `UI_LOCAL` | Remain private generic visual proposals; effective selected/add/move/delete mutations touch only the Wizard draft. |
| Photo/contour/component painters, marker geometry/hit testing, semantics, and progress derivation | `ZERO_WRITE` | Read immutable snapshots, calculate presentation geometry, and render or describe only. |
| `FilePicker.platform.pickFiles` result | `UI_LOCAL` | Stores only the returned source path; no copy, move, metadata, or project write follows. |
| `context.go('/')` | `ZERO_WRITE` | Navigates Home without saving the draft. |

The file contains no source-file mutation, project photo copy, provider,
project-state assignment, canonical coordinate conversion, photo/alignment
fact or event, writer, projection, schema, materializer, AI/OCR/CV, or Project
ZIP call path.

## Zero-write zones

- `[D]` `NewProjectWizardPhotoLayer` is display-only in all three steps.
- `[D]` Opacity 0 hides the image but retains the path and complete transform.
- `[D]` Contour and candidate painters consume immutable local snapshots;
  shape paths, rotated bounds, and pointer targets are derived presentation
  values rather than stored or canonical coordinates.
- `[D]` Photo mutations never mutate contour points or candidates.
- `[D]` Steps 5–7 and the final action area execute no workflow.
- `[D]` Picker errors, progress, semantics, safety copy, and cancellation
  persist nothing.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Catalogue/order | `[D]` Seven definitions drive dispatch, progress, and final bounds. | progress, action bar, placeholders | `ZERO_WRITE` | exact labels; seven-step progress; placeholders |
| Photo picker/state | `[D]` One filtered path installs a default parent transform. | platform gate, error UI, dirty cancellation | `UI_LOCAL` | picker filter/cancel/exception; mobile boundary |
| Photo transform | `[D]` Parent clamps/normalizes values and owns dirty state. | child callbacks, all photo layers | `UI_LOCAL` | bounds; reset/replace/remove; retention |
| Step 2 photo editor | `[D]` Child receives no future guide state. | child editor map and tests | `UI_LOCAL` | optional/Vaadatud; no-guide editor tests |
| Step 3 layering | `[D]` inert photo precedes editable contour painter. | contour gate and gestures | `UI_LOCAL` | layer order; contour invariance; no-photo operation |
| Step 4 candidate style | `[D]` parent current style and immutable candidates own shape, scale, and rotation. | selection, dirty state, controls, navigation | `UI_LOCAL` | four choices; inheritance; selected-only edits; drag/delete retention |
| Step 4 geometry/hit testing | `[D]` painter derives shape path, responsive pixels, rotation, selected outline, and rotated/minimum target. | candidate selection/drag and contour guide | `ZERO_WRITE` | size floor/ratios; rotated ends/corners; closest-center overlaps |
| Step 4 layering | `[D]` inert photo precedes contour/candidate painter. | candidate style/geometry and guide snapshot | `UI_LOCAL` | layer order; fixed geometry/style; no-photo operation |
| Navigation/retention | `[D]` one parent state survives step and size changes. | progress, responsive shell | `UI_LOCAL` | Step 2/3/4 round-trip and resize |
| Progress/gating | `[D]` only indexes 0 and 2 can complete; only 0 and 2 gate. | catalogue and action bar | `ZERO_WRITE` | Step 2/4 Vaadatud; Step 3 Valmis |
| Dirty cancellation | `[D]` each effective mutation assigns `_draftTouched`. | Step 1/contour/candidate mutations | `UI_LOCAL` | cancellation regressions plus source inspection |
| Responsive gestures | `[D]` compact/wide branches reuse normalized parent state. | child pan gesture, candidate scroll physics | `UI_LOCAL` | 1440×900; 390×760; drag-versus-scroll |
| Protected boundary | `[D]` no creator, project route, canonical, or persistent dependency exists. | router harness and final placeholder | `ZERO_WRITE` | zero-write traversal |

## Relevant tests and helpers

Primary integration suite:
`test/widget/new_project_wizard_screen_test.dart`, 52 widget tests. It covers
Step 1, exact seven-step shell, optional photo Step 2, filtered picker,
transform/opacity bounds, layered Step 3/4 reuse, invariant contour/candidate
geometry, four marker shapes, current-style inheritance, selected-only
mutation, canvas-relative size, normalized rotation, shape-aware painter/hit
geometry, overlap resolution, retention, progress, responsive interaction,
accessibility, and zero-write traversal.

Focused child suite:
`test/widget/new_project_wizard_photo_editor_test.dart`, 7 widget tests. It
covers default/hidden/full opacity, photo-only rendering, transform controls,
normalized drag, reset, render-error recovery, and wide/compact layouts.

## Dangerous combinations

- `[D]` Changing catalogue indexes, gates, progress, and headings together can
  gate the wrong step or mislabel optional work.
- `[D]` Changing parent transform normalization and child controls together
  can bypass finite/clamp/rotation invariants.
- `[D]` Changing layer order and contour/candidate mutation code together can
  make a photo change appear to move fixed geometry.
- `[D]` Changing current-style setters, selection loading, candidate copies,
  and dirty assignments together can mutate the wrong candidate or make
  no-selection styling appear persistent.
- `[D]` Changing painter paths, responsive size, rotated bounds, and pointer
  hit testing together can leave visible marker areas unselectable or make
  overlap resolution nondeterministic.
- `[D]` Changing photo/candidate gestures and ancestor scrolling together can
  move the page, the editable layer, or both.
- `[D]` Changing picker cancel/error paths and replacement state together can
  destroy a valid draft.
- `[D]` Adding project state, file copy, canonical coordinates, facts/events,
  or Board Canvas coupling would cross the accepted boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Picker-only: `_canPickPhoto`, `_pickPhoto`, error/empty copy, and focused
  picker tests; exclude file writes and platform expansion.
- One transform mutation: its parent setter, matching child control, all three
  photo layers, dirty assignment, and focused bound/retention tests.
- Step-2 presentation only: `_buildPhotoAlignmentStep` and child editor;
  exclude contour/candidate state and canonical alignment.
- One background layer only: the Step 3 or Step 4 `Stack`, its painter
  invariance, and matching integration assertion.
- One candidate-style field: its current-style setter, immutable candidate
  copy, summary/control, drag preservation, and selected-versus-next tests.
- Marker geometry only: `_WizardComponentMarkerGeometry`, painter paths,
  selected outline, `_componentCandidateKeyAt`, and focused floor/ratio/edge/
  overlap tests; exclude stored position semantics.
- Progress only: `_buildProgressTile`, `_goNext`, `_buildActionBar`, and
  exact seven-step progress tests.
- Contour-only or candidate-only slices must preserve the inert photo layer and
  the other editor family.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Parent photo mutation policy could become a pure helper if dirty
  ownership and widget-local state remain explicit.
- `[S]` Contour and component editors could become child widgets if their
  local keys, pointer ownership, gates, and zero-write semantics remain clear.
- `[S]` Progress presentation could be isolated if completion versus viewing
  remains derived from the same authoritative state.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when step, photo, contour, candidate-style, control,
geometry, painter, or action anchors change; `FLOW_DRIFT` when picker,
transform, current-style inheritance, hit testing, layer order, navigation,
dirty, or progress flow changes; `BOUNDARY_DRIFT` when a path or editor value
leaves widget state; `TEST_DRIFT` when the 52/7-test contract changes; and
`STRUCTURE_DRIFT` when editor ownership moves between files.

## Known uncertainty

- `[D]` Visible Step 1–4 headings still contain explicit ordinal text. The
  catalogue count and navigation bounds are length-derived, but focused
  regression coverage for every visible ordinal is limited.
- `[D]` Dirty-cancellation widget setup may already be dirty from earlier
  steps; production assignments independently establish photo, contour, and
  candidate add/move/delete/selected-style dirty mutations and exclude
  no-selection style changes.
- `[D]` The 8-pixel visibility floor flattens part of the compact 50%–76%
  scale range while preserving the stored `0.50..2.50` value.
- `[D]` Circle rotation controls remain enabled, but painting intentionally
  uses zero effective rotation while retaining the stored value for a later
  shape change.
- `[D]` Responsive automation covers two fixed sizes, not every device or
  physical pointer.
- `[D]` Zero-write is established by reachable call paths and test harnesses,
  not by a filesystem monitor.
