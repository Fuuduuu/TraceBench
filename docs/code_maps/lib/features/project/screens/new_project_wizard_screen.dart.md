# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Owns the seven-step New Project Wizard, its retained Step 1–5 draft, compact
shell/progress/workspaces/review/success presentation, Step 3-latched shared
Step 3/4 reference plane, live gates, typed creation request/result handling,
exactly-once success handoff, persistent Step 7, and sole explicit `/project`
open action.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Widget and dependency contract | `NewProjectWizardScreen`, `directoryPicker`, `platformInfo`, `createProject`, `onProjectCreated` | Accepts optional picker/platform/creator/handoff seams while retaining production defaults. |
| Retained draft and reference plane | `_projectNameController`, `_selectedParentPath`, `_photoPath`, `_contourPoints`, `_componentCandidates`, `_problemDescriptionDraft`, `_referenceFrameAspectRatio`, `_referenceFrameRect`, `_normalizedReferenceFramePoint` | Owns Step 1–5 UI draft and one Step 3-latched fitted Step 3/4 coordinate plane. |
| Required gates and visited navigation | `_canAdvanceFromStepOne`, `_canAdvanceFromContour`, `_canAdvanceFromProblemDescription`, `_allCreationGatesAreValid`, `_visitedSteps`, `_canNavigateToVisitedStep`, `_buildProgressTile` | Rechecks Steps 1/3/5 and permits only gate-safe visited navigation. |
| Compact shell and responsive progress | `build`, `WizardCompactShell`, `_buildHeader`, `_buildWideProgress`, `_buildCompactProgress`, `wizard-compact-progress-scroll`, `_buildEditorCard` | Composes wide/compact shell, header, custom progress, page scroll, and step body without using `WizardCompactNavigation`. |
| Step 1 and child editors | `_buildStepOne`, `_buildPhotoAlignmentStep`, `NewProjectWizardPhotoEditor`, `_buildProblemDescriptionStep`, `NewProjectWizardProblemDescription` | Hosts primary/advanced fields plus accepted compact Step 2 and Step 5 children while retaining parent values/callbacks. |
| Step 3 contour workspace | `_buildContourStep`, `_buildContourCanvas`, `_buildContourControls`, `WizardCompactWorkspace`, `wizard-contour-workspace-panel`, `wizard-contour-inspector-panel` | Presents fitted contour canvas and inspector, with stacked layout below the workspace threshold. |
| Step 4 candidate workspace | `_buildComponentPlacementStep`, `_buildComponentCanvas`, `_buildComponentControls`, `_buildComponentRotationControl`, `wizard-component-workspace-panel`, `wizard-component-inspector-panel` | Presents noncanonical visual candidates, 2×2 shape order, curved rotation controls, and fitted canvas/inspector. |
| Review and request | `_buildCreationRequest`, `_buildReviewStep`, `_buildReviewSection`, `_buildReviewValue`, `_editReviewStep`, `wizard-review-summary` | Maps the complete draft to typed intake and renders all values plus five edit routes without ellipsis. |
| Creation and sanitized failures | `_WizardCreationStatus`, `_createProject`, `_recordCreationFailure`, `ProjectCreationResult`, `sanitizedMessage`, `_WizardCreationError` | Guards activation, invokes creation once, exhaustively handles results, and shows only safe retryable copy. |
| Handoff and terminal route | `_projectHandoffCompleted`, `widget.onProjectCreated?.call`, `_buildCreatedStep`, `WizardCompactSuccessCard`, `_openCreatedProject`, `context.go('/project')` | Hands successful state to the app once, stays on Step 7, and opens only after `Ava projekt`. |
| Draft painters and hit testing | `_WizardContourPainter`, `_WizardComponentPlacementPainter`, `_WizardComponentMarkerGeometry`, `_handleContourPointerDown`, `_handleComponentPointerDown` | Renders and manipulates noncanonical contour/candidates in the shared reference frame only. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `68/68` selected anchors resolve as exact substrings in the
committed `HEAD` source; zero are missing.

## State and data flow

1. Step 1 starts visited and all draft values remain in controllers or typed
   UI-local fields.
2. Step 1 requires nonblank name and destination; Step 3 requires three
   points plus explicit closure; Step 5 requires nonblank description.
3. The first accepted Step 3 contour action latches the inner-canvas aspect.
   `_referenceFrameRect` center-fits it for Steps 3/4; photo, contour,
   candidates, input, dragging, paint, and hit testing share it, and bars are
   inert. Step 2 retains its independent preview.
4. `build` selects overall compact below `1050`, outer padding below `600`,
   and page scroll; Step 3/4 workspaces stack below `780`. Step 1 support
   stacks below `820`, headings/actions below `560`, and review values below
   `520`.
5. Compact progress uses a horizontal `SingleChildScrollView` and `Row` of
   parent-owned progress tiles. Status derives from current, visited, and live
   gates; parent forward copy remains `Järgmine samm`.
6. Step 2 and Step 5 children emit callbacks into parent state. Step 3/4
   inspectors use compact controlled primitives; candidate canvas dragging
   temporarily disables ancestor page scrolling.
7. Step 6 renders every draft field and five `Muuda` routes, then revalidates
   all gates before one typed request.
8. Pending/succeeded guards prevent duplicate creation. Every failure remains
   on Step 6 with the full draft and fixed or sanitized copy.
9. Success invokes `onProjectCreated` once before recording terminal state and
   moving to persistent Step 7. No success branch auto-routes.
10. The sole `Ava projekt` action calls `context.go('/project')`.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material/foundation | framework UI | Supplies state, responsive layout, gestures, semantics, painters, and platform flags. |
| GoRouter | outbound navigation | Performs cancellation/Home and explicit terminal `/project` navigation. |
| File picker and `PlatformInfo` | outbound platform seams | Select desktop parent/photo paths and keep mobile actions honest. |
| `ProjectCreator` request/results | outbound creation contract | Creates the generated project or returns typed failure. |
| `WizardIntake` / `ProjectState` | outbound request and success values | Carry noncanonical intake and hydrated success handoff. |
| Photo/problem editor widgets | child presentation | Emit existing parent-owned Step 2/5 values and callbacks. |
| Compact tokens/widgets | child presentation | Supply feature-local visual primitives and controlled composites. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Draft, visits, reference aspect, selection, and creation status | `UI_LOCAL` | Mutate only retained Wizard state. |
| `_buildCreationRequest` | `ZERO_WRITE` | Constructs an in-memory typed value. |
| `_createProject` creator call | `NONCANONICAL_FILE` | Delegates generated-project creation; no file is written directly here. |
| `onProjectCreated` | `PROJECTION_STATE` | Hands accepted hydrated state to the app-owned provider boundary. |
| Painters, compact shell, progress, review, and success display | `ZERO_WRITE` | Render local/caller values only. |
| `_openCreatedProject` | `UI_LOCAL` | Changes route only after explicit terminal activation. |

The Wizard creates no canonical event, fact, component, placement,
measurement, coordinate, net, diagnosis, or electrical assertion. Visual
candidates remain human-authored noncanonical proposals. Visible failures do
not consume `rawDetail`, stdout, stderr, exception, or stack data.

## Zero-write zones

- Gates, progress, compact layout, semantics, review, result display, and
  reference-frame fit persist nothing.
- Painters and hit tests affect only UI-local contour/candidate drafts.
- Step 7 display and route activation add no project content.
- Mobile-unavailable actions do not invoke desktop pickers.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Draft/reference/gates | `[D]` Local fields and fitted helpers own the values. | Step 2, both canvases, progress, request | `UI_LOCAL` | latch/resize/inert-bar, retention, live-gate tests |
| Shell/progress | `[D]` Breakpoints and tiles are parent-defined. | action bar and child layouts | `ZERO_WRITE` / `UI_LOCAL` | exact labels, visited semantics, breakpoints, 200% tests |
| Step 3/4 workspaces | `[D]` Both use `WizardCompactWorkspace` and one fitted frame. | painters, hit testing, page scroll | `UI_LOCAL` | wide/stacked geometry, drag isolation, candidate families |
| Child editors | `[D]` Parent passes values/callbacks. | compact primitive file | `UI_LOCAL` | photo/problem focused suites and integration |
| Review/request | `[D]` Five sections map complete draft fields. | creator/intake model | `ZERO_WRITE` / `UI_LOCAL` | complete review/five edits and exact request tests |
| Creation/failure | `[D]` Guard and exhaustive switch are local. | ProjectCreator results | `NONCANONICAL_FILE` / `UI_LOCAL` | gate revalidation, duplicate, all failure tests |
| Handoff/Step 7 | `[D]` Latch precedes terminal route availability. | app provider/router | `PROJECTION_STATE` / `UI_LOCAL` | exactly-once handoff, persistent success, inert/open route |

## Relevant tests and helpers

`test/widget/new_project_wizard_screen_test.dart` contains 76 widget tests
covering all seven steps, draft/gates/navigation, shared reference geometry,
photo/problem integrations, contour/candidates, compact shell/workspaces,
complete review, creation results, handoff, Step 7, breakpoints, keyboard,
semantics, drag isolation, and 200% text. Compact primitive/editor suites add
focused presentation evidence; creator/intake/loader and Project ZIP suites
own persistent bytes and hydration.

## Dangerous combinations

- Changing fitted-frame mapping separately from photo, painter, pointer, or
  hit-test paths can split coordinate spaces.
- Changing progress and gate derivation together can make invalid visited
  steps appear complete or navigable.
- Changing shell breakpoints and child compact flags together can hide
  overflow or move canvas drag into ancestor scrolling.
- Changing request/review separately can persist values the user did not see.
- Changing duplicate guard and handoff latch can duplicate filesystem work or
  provider assignment.
- Adding automatic terminal routing breaks persistent Step 7 ordering.

## Safe SNIPER slices

- One gate plus matching status/navigation assertions.
- Shell/progress presentation only; keep gate derivation and action copy.
- One Step 3/4 workspace presentation branch; preserve shared frame helpers.
- Step 6 rendering only; preserve request construction.
- One typed failure plus safe-copy assertions.
- Step 7 presentation only; preserve explicit route separation.

## Future extraction seams

- `[S]` Review rendering could move to a controlled child with all five edit
  callbacks and complete values.
- `[S]` Creation-result handling could move to a controller if handoff order,
  mounted checks, and duplicate guards stay explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` on gates, breakpoints, frame helpers, step builders,
creation/result, handoff, or route anchors; `FLOW_DRIFT` on draft-to-review-to-
request or success ordering; `BOUNDARY_DRIFT` if raw diagnostics/canonical
writes enter; `TEST_DRIFT` when the 76-test families move; and
`STRUCTURE_DRIFT` when presentation or creation ownership relocates.

## Known uncertainty

- `[D]` Step 2 preview intentionally need not match the Step 3-authored frame.
- `[D]` At widths `780–1049`, the overall shell is compact while Step 3/4
  workspace remains side-by-side; accepted audit classifies this deliberate.
- `[D]` Step 7 ID uses `SelectableText`; no Copy ID capability exists.
- `[P]` Pixel-perfect styling is not golden-tested, while overflow,
  reachability, behavior, and semantic coverage are direct.
