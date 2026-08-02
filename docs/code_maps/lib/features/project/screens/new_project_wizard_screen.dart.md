# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS.md`

## File purpose

Owns the accepted seven-step New Project Wizard and every authoritative
widget-local draft used by it. Step 1 captures project metadata; optional Step
2 transforms one local photo; Step 3 edits a contour; optional Step 4 places
generic visual candidates; required Step 5 captures raw human problem
observations through a controlled child editor; and Steps 6–7 remain honest
placeholders. The screen owns every authoritative draft, retains values across
navigation and responsive rebuilds, tracks visited steps independently,
derives required-step status from current gates, and reaches no project,
canonical, event, fact, file-copy, or ZIP write path.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Step catalogue and dispatch | `_wizardSteps`, `_WizardStepDefinition`, `_buildEditorCard`, `_buildPlaceholder` | Defines the seven Estonian steps, dispatches Steps 1–5, and keeps Steps 6–7 non-functional. |
| Step 1 draft and folder picker | `NewProjectWizardScreen`, `directoryPicker`, `platformInfo`, `_projectNameController`, `_selectedParentPath`, `_pickFolder` | Owns injected/default folder selection and transient Step 1 values without creating a project. |
| Parent photo draft and picker | `_photoPath`, `_photoTransform`, `_isPickingPhoto`, `_photoPickerError`, `_canPickPhoto`, `_pickPhoto` | Owns one native-desktop image path, locked extension filter, cancel/error handling, and default replacement view. |
| Photo mutation contract | `_setPhotoTranslation`, `_setPhotoScale`, `_normalizedPhotoRotation`, `_setPhotoRotation`, `_setPhotoOpacity`, `_resetPhotoView`, `_removePhoto` | Validates transform inputs, clamps scale/opacity, normalizes rotation, preserves opacity on reset, clears the complete draft on remove, and marks mutations dirty. |
| Photo Step 2 integration | `_buildPhotoAlignmentStep`, `_buildPhotoEmptyState`, `NewProjectWizardPhotoEditor` | Renders the optional photo-only editor, platform copy, selected path, recovery controls, and zero-write boundary note. |
| Contour state and interaction | `_contourPoints`, `_contourClosed`, `_canAdvanceFromContour`, `_handleContourTap`, `_handleContourPointerMove`, `_deleteSelectedContourPoint`, `_resetContour`, `_closeContour` | Owns editor-normalized points, selection/drag state, reopening mutations, and the closed-only Step 3 gate. |
| Contour editor and photo background | `_buildContourStep`, `_buildContourCanvas`, `wizard-contour-stack`, `wizard-contour-photo-layer`, `_WizardContourPainter` | Paints the photo as an inert bottom layer and editable contour state above it, or operates normally without a photo. |
| Candidate style, state, and interaction | `_componentCandidates`, `_componentCurrentShape`, `_componentCurrentSizeScale`, `_componentCurrentRotation`, `_WizardComponentCandidate`, `_componentCandidateKeyAt`, `_handleComponentTap`, `_handleComponentPointerDown` | Owns immutable stable-key candidates and current-style inheritance; empty pointer-down preserves selection so each completed empty tap adds once, while candidate tap/select/drag/cancel remain distinct. |
| Component editor, controls, and layered guides | `_buildComponentPlacementStep`, `_buildComponentCanvas`, `_buildComponentControls`, `wizard-component-status`, `wizard-component-shape-grid`, `wizard-component-rotation-value`, `wizard-component-boundary-note`, `_WizardComponentPlacementPainter`, `_WizardComponentMarkerGeometry` | Keeps photo/contour inert below candidates; compacts status and full boundary meaning; exposes equal-width 2×2 shapes, size, curved rotation/reset/signed-value controls, and unchanged geometry/hit behavior. |
| Problem draft and Step 5 integration | `_problemDescriptionDraft`, `_canAdvanceFromProblemDescription`, `_handleProblemDescriptionChanged`, `_buildProblemDescriptionStep`, `NewProjectWizardProblemDescription` | Owns the raw five-value observation draft, effective-change dirty handling, required Step 5 dispatch/gate/progress, and the child presentation seam. |
| Navigation, progress, and actions | `_currentStep`, `_visitedSteps`, `_isRequiredStep`, `_requiredStepIsValid`, `_canAdvanceFromStep`, `_goNext`, `_goBack`, `_canNavigateToVisitedStep`, `_navigateToVisitedStep`, `_buildProgressTile`, `_buildActionBar` | Tracks entered steps independently, permits backward and gate-valid forward visited jumps, derives required completion from live Step 1/3/5 gates, and exposes actions only on available non-active tiles. |
| Responsive shell and cancellation | `build`, `SingleChildScrollView`, `_buildWideProgress`, `_buildCompactProgress`, `_cancelWizard` | Preserves one parent draft through wide/compact rebuilds, coordinates editor gestures with scrolling, and confirms dirty cancellation. |

## State and data flow

1. `[D]` Step 1 controllers/path remain in `_NewProjectWizardScreenState`; folder selection stores only a returned string and marks the draft dirty.
2. `[D]` `_pickPhoto` is disabled for web/mobile, requests one `jpg/jpeg/png/webp`, reads no bytes, and stores only a nonblank supported path.
3. `[D]` Picker cancel preserves the complete draft; exception/rejected extension sets visible error without replacing path or transform.
4. `[D]` Accepted selection/replacement assigns the path plus zero translation, scale 1, rotation 0, and opacity 0.65.
5. `[D]` Translation keeps finite components; scale clamps to `0.25..8.0`, rotation normalizes to `[-π, π)`, and opacity clamps to `0.0..1.0`.
6. `[D]` Effective photo mutations dirty the draft; reset preserves path/opacity, while remove clears path, transform, and picker error.
7. `[D]` Step 2 passes path/transform/callbacks but no contour or candidate state to the child editor.
8. `[D]` Steps 3–4 wrap the optional photo layer in `IgnorePointer` below their painters.
9. `[D]` All three editors read the parent transform independently; photo changes never rewrite contour/candidate geometry.
10. `[D]` Contour add/move/delete/reset/close changes only editor-normalized local state; closure plus three points is the sole Step 3 gate.
11. `[D]` Each candidate keeps a local key, editor-normalized center, one of four shapes, size `0.50..2.50`, and rotation `[-π, π)`.
12. `[D]` Empty pointer-down returns without clearing selection or arming drag, so tap-up adds one candidate; candidate pointer-down selects/arms drag, candidate tap adds nothing, drag moves only, and pointer end/cancel adds nothing.
13. `[D]` `_WizardComponentMarkerGeometry` derives the 8-pixel floor, `3.5%` relative scale, shape ratios, rotation, complete bounds, and at-least-56×56 hit target; closest center/insertion order resolves overlaps.
14. `[D]` `_handleProblemDescriptionChanged` ignores equal drafts; effective updates replace the raw five-value parent draft and dirty it; validity alone uses `description.trim().isNotEmpty`.
15. `[D]` Navigation mutates only `_currentStep` and `_visitedSteps`; backward visited jumps always work, while forward visited jumps revalidate every crossed Step 1/3/5 gate without dirtying or mutating drafts.
16. `[D]` Progress derives its count from `_wizardSteps`; active is `Praegune samm`, every visited valid required step is `Valmis` regardless of ordering, every visited non-complete step is `Vaadatud`, and only unvisited is `Järgmine samm`.
17. `[D]` `_buildActionBar` derives the final boundary, gates Step 5 without rewriting raw text, and exposes no create action.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material/Foundation | framework and UI state | Provides widget state, pointer/gesture input, painting, semantics, responsive layout, dialogs, and platform detection. |
| `FilePicker` | outbound picker service | Selects a parent directory and, on supported native desktop, one filtered image path. |
| `PlatformInfo` / `DefaultPlatformInfo` | inbound capability service | Supplies the mobile capability boundary. |
| `NewProjectWizardPhotoEditor` / `NewProjectWizardPhotoLayer` | child presentation dependency | Renders and edits the parent-owned photo draft in Step 2 and reuses it read-only below Steps 3–4. |
| `NewProjectWizardProblemDescription` | child presentation dependency | Edits the parent-owned five-value Step 5 draft through value/onChanged/compact only. |
| GoRouter | outbound UI navigation | Routes confirmed or untouched cancellation to `/`. |

There is no Riverpod, `ProjectCreator`, project-state provider, canonical
writer, materializer, projection, or project-model dependency.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Step 1 values, current/visited steps, dirty/picker flags | `UI_LOCAL` | Mutate transient widget state only; navigation alone never dirties a draft. |
| Photo path and `NewProjectWizardPhotoTransform` | `UI_LOCAL` | Remain parent-owned presentation draft values and produce no canonical alignment output. |
| Contour points and interaction state | `UI_LOCAL` | Remain editor-local and never become `board_normalized`. |
| Candidate keys, positions, visual style, selection, and current style | `UI_LOCAL` | Remain private generic visual proposals; effective selected/add/move/delete mutations touch only the Wizard draft. |
| Problem-description draft and effective callback | `UI_LOCAL` | Retains raw human observations in the Wizard parent; equality suppresses identical assignments. |
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
- `[D]` Problem text is displayed and gated only; it is not diagnosed,
  inferred, normalized, persisted, or converted into a canonical fact.
- `[D]` Steps 6–7 and the final action area execute no workflow.
- `[D]` Progress status, availability, and direct navigation derive from
  transient visitation plus existing gates and create no project state.
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
| Step 4 candidate interaction/style | `[D]` empty pointer-down preserves selection; tap-up adds once; parent style and immutable candidates retain shape, scale, rotation, and keys. | selection, drag/cancel, dirty state, controls, navigation | `UI_LOCAL` | repeated exact-one add; select-versus-add; drag/cancel non-add; inheritance; selected-only edits |
| Step 4 geometry/hit testing | `[D]` painter derives shape path, responsive pixels, rotation, selected outline, and rotated/minimum target. | candidate selection/drag and contour guide | `ZERO_WRITE` | size floor/ratios; rotated ends/corners; closest-center overlaps |
| Step 4 layering | `[D]` inert photo precedes contour/candidate painter. | candidate style/geometry and guide snapshot | `UI_LOCAL` | layer order; fixed geometry/style; no-photo operation |
| Step 5 observation draft | `[D]` parent equality, raw storage, child seam, and trimmed-only validity are distinct. | navigation, progress, cancellation, child editor | `UI_LOCAL` | empty/whitespace gate; five-value retention; effective/no-op dirty behavior |
| Navigation/retention | `[D]` one parent state survives step and size changes. | progress, responsive shell | `UI_LOCAL` | Step 2–5 round trips and resize |
| Progress/gating | `[D]` `_visitedSteps` is ordering-independent; indexes 0, 2, and 4 use their live gates for status and forward-jump availability. | catalogue, action bar, responsive progress | `UI_LOCAL` | current/visited/unvisited; all three gates; invalidation/restoration; navigation non-dirty |
| Dirty cancellation | `[D]` each effective mutation assigns `_draftTouched`. | Step 1/contour/candidate mutations | `UI_LOCAL` | cancellation regressions plus source inspection |
| Responsive gestures | `[D]` compact/wide branches reuse normalized parent state. | child pan gesture, candidate scroll physics | `UI_LOCAL` | 1440×900; 390×760; drag-versus-scroll |
| Protected boundary | `[D]` no creator, project route, canonical, or persistent dependency exists. | router harness and final placeholder | `ZERO_WRITE` | zero-write traversal |

## Relevant tests and helpers

Primary integration suite:
`test/widget/new_project_wizard_screen_test.dart`, 62 widget tests. It covers
Step 1, exact seven-step shell, optional photo Step 2, filtered picker,
transform/opacity bounds, layered Step 3/4 reuse, invariant contour/candidate
geometry, four marker shapes, current-style inheritance, selected-only
mutation, repeated exact-one add and cancel separation, compact status/2×2
shape/rotation controls, canvas-relative geometry, direct visited navigation,
all three gate/status invalidation-restoration paths, responsive interaction,
accessibility, and zero-write traversal.

Focused child suite:
`test/widget/new_project_wizard_photo_editor_test.dart`, 7 widget tests. It
covers default/hidden/full opacity, photo-only rendering, transform controls,
normalized drag, reset, render-error recovery, and wide/compact layouts.

Problem child suite:
`test/widget/new_project_wizard_problem_description_test.dart`, 9 tests. It
covers the immutable model, keys/copy/semantics, raw callbacks, no-op and
external synchronization including selection retention, occurrence choices,
responsive layouts, and the local-only boundary.

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
- `[D]` Changing pointer-down selection, tap-up addition, and drag cleanup
  together can drop an empty tap or create an accidental candidate.
- `[D]` Changing painter paths, responsive size, rotated bounds, and pointer
  hit testing together can leave visible marker areas unselectable or make
  overlap resolution nondeterministic.
- `[D]` Changing photo/candidate gestures and ancestor scrolling together can
  move the page, the editable layer, or both.
- `[D]` Changing picker cancel/error paths and replacement state together can
  destroy a valid draft.
- `[D]` Changing problem equality, child synchronization, Step 5 gating, and
  dirty/progress paths together can lose raw text, cursor selection, or honest
  completion semantics.
- `[D]` Changing visitation, gate iteration, tile semantics, and responsive
  progress together can bypass a required step or misstate availability.
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
- Progress only: `_visitedSteps`, `_requiredStepIsValid`,
  `_canNavigateToVisitedStep`, `_buildProgressTile`, `_goNext`,
  `_buildActionBar`, and exact gate/status/semantics tests.
- Step 5 only: `_problemDescriptionDraft`, its effective mutation handler,
  dispatch/gate/progress branches, child seam, and focused/integration tests;
  exclude diagnosis, persistence, and canonical problem data.
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

Review for `SYMBOL_DRIFT` when step, photo, contour, candidate, problem-draft,
child, painter, or action anchors change; `FLOW_DRIFT` when picker, transform,
inheritance, hit testing, Step 5 validity/equality, navigation, dirty, or
progress flow changes; `BOUNDARY_DRIFT` when a draft leaves widget state;
`TEST_DRIFT` when the 62/7/9-test contract changes; and `STRUCTURE_DRIFT` when
editor ownership moves between files.

## Known uncertainty

- `[D]` Visible Step 1–4 headings still contain explicit ordinal text. The
  catalogue count and navigation bounds are length-derived, but focused
  regression coverage for every visible ordinal is limited.
- `[D]` The visible Step 5 ordinal is also explicit while the total remains
  length-derived.
- `[D]` Nested field semantics may be verbose in some accessibility readers;
  focused tests verify labels and nodes, not end-to-end spoken output.
- `[D]` Dirty-cancellation widget setup may already be dirty from earlier
  steps; production assignments independently establish photo, contour, and
  candidate add/move/delete/selected-style dirty mutations and exclude
  no-selection style changes.
- `[D]` The 8-pixel visibility floor flattens part of the compact 50%–76%
  scale range while preserving the stored `0.50..2.50` value.
- `[D]` Circle rotation controls remain enabled, but painting intentionally
  uses zero effective rotation while retaining the stored value for a later
  shape change.
- `[D]` Rotation controls inherit a pre-existing `Semantics` wrapper without
  a semantic activation action; the accepted implementation audit records
  this as an evidence-only NIT.
- `[D]` Responsive automation covers two fixed sizes, not every device or
  physical pointer.
- `[D]` Zero-write is established by reachable call paths and test harnesses,
  not by a filesystem monitor.
