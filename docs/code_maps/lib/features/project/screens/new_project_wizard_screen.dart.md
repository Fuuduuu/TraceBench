# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS.md`

## File purpose

Owns the seven-step New Project Wizard UI, its complete retained Step 1–5
draft, required creation gates, progress/edit navigation, noncanonical intake
request construction, guarded project creation, exhaustive typed-result
handling, safe failure presentation, exactly-once successful-state handoff,
terminal Step 7, and the sole explicit transition to canonical `/project`.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Widget and dependency contract | `NewProjectWizardScreen`, `directoryPicker`, `platformInfo`, `createProject`, `onProjectCreated` | Accepts optional platform/picker/creator/handoff seams while retaining production defaults. |
| Retained Step 1–5 draft | `_projectNameController`, `_advancedStepOneExpanded`, `_selectedParentPath`, `_photoPath`, `_contourPoints`, `_componentCandidates`, `_problemDescriptionDraft` | Owns primary/advanced project data, photo, contour, visual candidates, and problem description in UI state. |
| Required creation gates | `_canAdvanceFromStepOne`, `_canAdvanceFromContour`, `_canAdvanceFromProblemDescription`, `_allCreationGatesAreValid` | Derives current validity for required Steps 1, 3, and 5 and rechecks all gates at creation. |
| Visited progress and navigation | `_visitedSteps`, `_requiredStepIsValid`, `_canNavigateToVisitedStep`, `_buildProgressTile` | Tracks visits independently, derives Valmis from live gates, and guards backward/forward tile navigation. |
| Typed request construction | `_buildCreationRequest`, `ProjectCreationRequest`, `WizardIntake`, `sourcePhotoPath` | Converts the complete retained draft into typed noncanonical creation input. |
| Step 6 review and editing | `_buildReviewStep`, `_buildReviewSection`, `_editReviewStep`, `wizard-review-summary` | Shows the complete draft and five functional Muuda paths before creation. |
| Creation state machine | `_WizardCreationStatus`, `_createProject`, `_recordCreationFailure` | Owns idle/creating/failed/succeeded transitions, invocation, and retryable failure state. |
| Exhaustive result switch | `ProjectCreationSuccess`, `ProjectCreationMobilePlaceholder`, `ProjectCreationCollision`, `ProjectCreationInvalidDestination`, `ProjectCreationPythonNotFound`, `ProjectCreationMaterializerFailed`, `ProjectCreationPhotoFailed`, `ProjectCreationFailed` | Handles every sealed creation result subtype without a fallback branch. |
| Sanitized failure boundary | `sanitizedMessage`, `_creationError`, `_WizardCreationError` | Displays fixed safe copy or typed sanitized messages and retains the Step 6 draft. |
| Duplicate guard and handoff latch | `_projectHandoffCompleted`, `_creationStatus == _WizardCreationStatus.creating`, `widget.onProjectCreated?.call` | Suppresses pending/succeeded reactivation and invokes successful state handoff once. |
| Terminal Step 7 | `_buildCreatedStep`, `wizard-created-success`, `_createdProjectState` | Persists success presentation with project name, technical ID, and location. |
| Explicit project opening | `_openCreatedProject`, `context.go('/project')`, `wizard-open-project-button`, `_buildActionBar` | Makes Ava projekt the only terminal route action and performs no automatic redirect. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. The inventory has 52 unique anchors.

- Literal source symbols/strings: 50; each resolves as an exact source
  substring.
- Qualified source expressions: 2 —
  `widget.onProjectCreated?.call` and `context.go('/project')`. Each resolves
  as the exact owner/member invocation.
- Exact test-name references: 0.

## State and data flow

1. The widget begins with Step 1 active, Step 1 marked visited, and every draft
   field owned locally by controllers or typed UI values.
2. Step 1 requires a nonblank project name and selected parent; Step 3 requires
   at least three points and a closed contour; Step 5 requires a nonblank
   problem description.
3. Optional Steps 2 and 4 retain photo and visual-candidate presentation input
   but do not gate forward progress.
4. Progress status uses active step, independent visited state, and live gate
   validity; a visited required step can become invalid after editing.
5. Step 6 renders all Step 1–5 values and routes each Muuda action back to its
   corresponding draft section.
6. `_createProject` revalidates all three gates, sets creating state, selects
   the injected creator or `ProjectCreator().createProject`, and builds one
   typed request.
7. Pending or already-succeeded state rejects another activation.
8. Each failure subtype records only fixed/sanitized visible copy, remains on
   Step 6, and preserves the complete editable draft for retry.
9. Success first invokes `onProjectCreated` through a one-shot latch, then
   records the returned state, moves to Step 7, and stays there.
10. `Ava projekt` checks succeeded state and explicitly calls
    `context.go('/project')`; no success branch redirects automatically.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material/foundation | framework UI | Supplies stateful widgets, responsive rendering, painters, gestures, semantics, and platform flags. |
| GoRouter | outbound navigation | Performs cancellation/Home and explicit terminal `/project` transitions. |
| File picker | outbound platform seam | Selects desktop parent directories and optional photos. |
| `ProjectCreator` request/results | outbound storage contract | Creates the generated project or returns a typed failure. |
| `WizardIntake` models | outbound noncanonical model | Carry problem, contour, photo transform, and visual candidates. |
| `ProjectState` | success/handoff value | Supplies terminal display and app-owned projection handoff. |
| Wizard photo/problem widgets | child editors | Own specialized Step 2 and Step 5 input interaction. |
| `PlatformInfo` | platform seam | Keeps mobile folder/photo behavior honest and non-invoking. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controllers, draft collections, visited/progress, and status | `UI_LOCAL` | Mutate only transient Wizard state. |
| `_buildCreationRequest` | `ZERO_WRITE` | Constructs typed request/intake values without persistence. |
| `_createProject` creator invocation | `NONCANONICAL_FILE` | Calls the separately owned generated-project storage path; the Wizard writes no file directly. |
| `onProjectCreated` callback | `PROJECTION_STATE` | Hands the returned hydrated state to the app; the Wizard owns no provider. |
| `_openCreatedProject` | `UI_LOCAL` | Changes only the current route after success. |
| Painters and editor rendering | `ZERO_WRITE` | Render or manipulate noncanonical draft geometry only. |

The request's contour, photo transform, and visual candidates are human-authored
noncanonical presentation input. The Wizard does not create canonical events,
facts, components, placements, measurements, evidence, diagnoses, nets,
board-side assertions, or electrical semantics. It never reads `rawDetail`,
process output, exception text, or stack data for visible failure copy.

## Zero-write zones

- Draft capture, gates, progress status, review summaries, painters, semantics,
  responsive layout, and result classification do not persist data.
- `_buildCreationRequest` creates an in-memory value only.
- Step 7 display and explicit navigation do not create additional project
  content.
- Mobile folder/photo actions show honest unavailable copy without invoking
  their desktop pickers.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Dependency contract | [D] Constructor fields select defaults/injections. | app router builder and test harness | `ZERO_WRITE` | injection and inertness tests |
| Draft/gates | [D] Controllers and getters own current validity. | progress, review, request | `UI_LOCAL` | advanced, retention, live-gate tests |
| Progress navigation | [D] visited set and gate checks are separate. | all required/optional steps | `UI_LOCAL` | visited invalidation/status tests |
| Request construction | [D] every typed field is mapped locally. | WizardIntake and ProjectCreator | `ZERO_WRITE` | no-photo/photo request tests |
| Step 6 | [D] five sections and edit actions are explicit. | all draft zones | `UI_LOCAL` | complete review/edit test |
| Creation state | [D] guard, await, and exhaustive switch are local. | ProjectCreator results | `NONCANONICAL_FILE` / `UI_LOCAL` | duplicate/failure tests |
| Handoff | [D] one-shot boolean guards callback. | app provider assignment | `PROJECTION_STATE` | Wizard success and Home handoff tests |
| Step 7/navigation | [D] success state and button are distinct. | router `/project` and Canvas provider read | `UI_LOCAL` | wait-then-open and inert-route tests |
| Editors/painters | [D] geometry stays in draft collections. | photo/problem child widgets | `UI_LOCAL` / `ZERO_WRITE` | contour/candidate/photo families |

## Relevant tests and helpers

Primary evidence is `test/widget/new_project_wizard_screen_test.dart` with 69
widget tests. Its maintained families cover exact step labels, advanced Step 1
fields, all editors and draft retention, live required gates, visited progress,
complete Step 6 review and five edit paths, exact request mapping, pending
single-call behavior, every typed result plus thrown exceptions, exactly-once
handoff, persistent Step 7, and explicit opening. App-level provider ordering
is covered in `test/widget/benchbeep_home_screen_test.dart`. Storage and
hydration are covered by creator/intake/loader unit tests.

## Dangerous combinations

- Changing `_visitedSteps` and gate logic together can reintroduce
  index-derived completion or invalid forward navigation.
- Changing request construction and review display separately can create
  unseen persisted values.
- Changing pending guards and the handoff latch together can duplicate
  filesystem creation or provider assignment.
- Reading raw failure fields while editing visible errors can expose process
  or filesystem details.
- Auto-routing in the success branch would violate persistent Step 7 and
  provider-before-route ordering.
- Treating candidates as canonical objects would cross protected identity,
  placement, and electrical boundaries.

## Safe SNIPER slices

- One required gate only: getter, progress use, and its edit/revalidation tests.
- Step 6 presentation only: review builders and complete edit-round-trip test;
  exclude request mapping.
- One typed failure only: result case, safe copy, and exhaustive failure test.
- Terminal presentation only: `_buildCreatedStep` and display assertions;
  preserve explicit navigation separation.
- Explicit route action only: `_openCreatedProject`, action button, and
  wait-then-open tests.

## Future extraction seams

- [S] Creation-state/result handling could move into a controller if draft
  ownership, latch ordering, and mounted checks remain explicit.
- [S] Review rendering could become a child widget after edit callbacks and
  exact draft values are retained.
- [S] Large contour/candidate painter helpers may move without changing
  noncanonical ownership.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when constructor seams, gates, state-machine/result,
handoff, or terminal anchors change; `FLOW_DRIFT` when draft/review/create/
handoff/navigation ordering changes; `BOUNDARY_DRIFT` when raw diagnostics or
canonical writes enter; `TEST_DRIFT` when focused families change; and
`STRUCTURE_DRIFT` when editors, review, or creation logic move.

## Known uncertainty

- [D] Persistent byte correctness belongs to `ProjectCreator` and its tests;
  this map proves request and caller behavior.
- [D] Provider assignment belongs to `app.dart`; the Wizard proves callback
  order and one-shot invocation.
- [D] Desktop folder/photo picking is supported; mobile actions intentionally
  report unavailable behavior and do not invoke pickers.
- [P] Pixel-perfect visual styling is not guaranteed by behavioral widget
  tests; overflow, interaction, and semantics are covered.
