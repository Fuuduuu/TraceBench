# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3,000 lines + 3+ test families`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_REFERENCE_FRAME_GEOMETRY_V1_LOCK_PASS.md`

## File purpose

Exercises the seven-step New Project Wizard across retained drafts, advanced
Step 1 fields, required gates, progress navigation, the Step 3-latched shared
Step 3/4 fitted reference plane, contour/photo/visual-candidate editors,
complete Step 6 review/edit flow, request construction, duplicate protection,
exhaustive safe failure handling, exactly-once project handoff, persistent
Step 7 success, and explicit `/project` navigation.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Harness, platform, and success fixtures | `_TestPlatformInfo`, `_FakePhotoFilePicker`, `_buildWizardApp`, `_createdProjectState` | Supplies deterministic platform, picker, router, creation, and hydrated-state seams. |
| Step 1 advanced draft | `Step 1 advanced drafts retain raw values and never change its gate`, `_completeStepOne` | Preserves primary/advanced raw values and the name-plus-parent gate. |
| Live gates and visited progress | `Step 1 gate status and forward navigation update after editing`, `Step 3 and Step 5 visited statuses invalidate restore and guard forward navigation`, `create activation revalidates all three live required gates`, `_expectProgressStatus` | Proves gate-derived validity, independent visited state, and creation-time revalidation. |
| Contour draft and shared reference plane | `explicit closure paints a closed loop and enables Edasi`, `Step 3 latches one fitted reference frame that Step 4 reuses after resize`, `_addTriangle`, `_contourCanvasRect`, `_componentCanvasRect` | Covers non-degenerate closure, first-action aspect latching, shared fitted Step 3/4 geometry, resize stability, inert letterbox bars, and the Step 3 gate. |
| Visual candidates | `a new marker inherits the complete current style`, `candidate and current style survive navigation resize and photo changes` | Covers candidate style, geometry, persistence, and noncanonical presentation state. |
| Photo draft | `photo stays below independent contour and candidate geometry`, `_openPhotoAlignmentStep` | Covers photo layering and independent transform ownership. |
| Retention and Step 6 editing | `back and forward navigation preserve every Step 1 draft value`, `Step 6 shows the complete draft and all five edit round-trips`, `_openReviewStep` | Proves complete retained draft, summary content, and all five Muuda paths. |
| Request construction | `creation request preserves every no-photo draft value exactly`, `creation request maps photo path and complete transform` | Proves exact no-photo and photo-backed typed request mapping. |
| Duplicate activation | `pending activation is single-call and explicit retry is one call` | Proves pending suppression and one later retry. |
| Exhaustive safe failure handling | `every typed failure and thrown exception is safely retryable` | Covers all result subtypes, sanitized UI copy, retry, and draft retention. |
| Exactly-once handoff and Step 7 | `success hands off once, shows returned state, waits, then opens project` | Proves one callback, returned-state display, persistent terminal step, and explicit open. |
| Pre-activation and route boundary | `creation and project routing stay inert until activation`, `_tapKey` | Proves no early creator/handoff/navigation and preserves the explicit route action. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. The inventory has 29 unique anchors.

- Literal helper/type anchors: 12; each resolves as an exact source substring.
- Qualified member references: 0.
- Exact test-name references: 17; each resolves as the complete string first
  argument of one `testWidgets` declaration, including multiline calls.

## State and data flow

1. `_buildWizardApp` mounts the real Wizard in a GoRouter-backed harness with
   optional platform, picker, creator, and handoff seams.
2. Helpers construct the Step 1, contour, candidate, photo, problem, and review
   drafts through actual UI gestures.
3. A geometry test records the first Step 3 editor aspect, resets and rebuilds
   the contour, resizes the viewport, verifies both Step 3 and Step 4 use the
   same fitted frame, and proves a letterbox tap creates no candidate.
4. Gate tests edit previously visited required steps and prove status and
   forward navigation derive from current Step 1/3/5 validity rather than
   index ordering.
5. Review tests inspect all retained values and round-trip each `Muuda` action.
6. Request tests capture `ProjectCreationRequest` and compare every raw or
   normalized field, including the latched aspect, nullable photo ownership,
   and complete transform.
7. Pending tests hold a creation future open to prove repeated activation
   remains single-call, then allow one explicit retry.
8. Failure tests feed every typed result plus a thrown exception; the Wizard
   remains editable on Step 6 and exposes only fixed/sanitized copy.
9. Success tests return a hydrated state, prove one handoff, inspect Step 7,
   wait without redirect, then invoke the only explicit `/project` action.
10. Tear-down restores surface size and global file-picker state.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter test/Material | harness | Drives widgets, gestures, view sizes, semantics, and assertions. |
| GoRouter | routing harness | Observes `/new-project` and explicit `/project` transitions. |
| File picker | injected/global seam | Supplies folder and photo selection/cancel/error behavior. |
| `NewProjectWizardScreen` | target | Owns draft, creation, failure, success, and navigation behavior. |
| Wizard photo/problem widgets | coupled targets | Own specialized Step 2 and Step 5 editor inputs. |
| `WizardIntake` and `ProjectCreator` types | contract fixtures | Capture requests, including reference-frame metadata, and return all typed outcomes. |
| `ProjectState` models | success fixture | Supply terminal project name, technical ID, location, and intake. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Draft gestures and progress navigation | `UI_LOCAL` | Mutate only mounted widget state. |
| Captured creation requests | `ZERO_WRITE` | Inspect typed values without invoking production storage. |
| Fake result callbacks | `ZERO_WRITE` | Return in-memory typed outcomes and count calls. |
| Handoff callback | `PROJECTION_STATE` | Captures the hydrated state in test memory; no provider/file writer is used. |
| Explicit GoRouter transition | `UI_LOCAL` | Changes only mounted route state. |
| Source-boundary checks | `ZERO_WRITE` | Read source text to preserve absence of forbidden UI writer/raw-detail paths. |

No test calls production `ProjectCreator`, appends events/facts, creates
canonical components/placements/measurements/evidence, or converts visual
candidates into canonical assertions. Candidate and contour values remain
noncanonical Wizard intake presentation.

## Zero-write zones

- Layout, fitted-frame/letterbox geometry, rendering, semantics, progress
  status, cancellation, request capture, result switching, retry, terminal
  display, and route observation are test-local.
- Photo-picker fixtures expose paths/bytes only; this suite performs no
  generated-project copy.
- Failure assertions preserve `rawDetail` and exception text outside the
  visible Wizard UI.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Harness/helpers | [D] Shared helpers drive most families. | router, picker, platform, result models | test-local | all 70 tests |
| Step 1/gates | [D] Current edits drive button/status assertions. | progress tile and creation guard | `UI_LOCAL` | advanced and live-gate tests |
| Contour/reference frame/candidates/photo | [D] Gestures and widget rects inspect latching, fitted bounds, inert bars, and retained geometry. | both editor painters, Step 2 preview, intake request | `UI_LOCAL` | latch/resize/inert-bar plus editor/persistence families |
| Step 6 review | [D] Every summary and edit link is traversed. | all Step 1–5 drafts | `UI_LOCAL` | complete review test |
| Request mapping | [D] Captured object and the latched aspect are compared. | WizardIntake models and ProjectCreator contract | `ZERO_WRITE` | two request tests |
| Pending/failure state | [D] Controlled futures/results expose transitions. | exhaustive result switch | `UI_LOCAL` | duplicate and failure tests |
| Success/handoff | [D] counts, displayed state, and waiting are asserted. | app provider callback and router | `PROJECTION_STATE` / `UI_LOCAL` | success test |
| Inert boundary | [D] pre-activation counts/routes and source checks are explicit. | writer and canonical surfaces | `ZERO_WRITE` | inertness test |

## Relevant tests and helpers

The source contains 70 `testWidgets` tests across shell/Step 1, contour and
shared reference-frame geometry,
candidate, photo, problem, cancellation/responsive, progress, request,
failure, success, and routing families. `_completeStepOne`,
`_addTriangle`, `_openPhotoAlignmentStep`, and `_openReviewStep` build
repeatable UI states. `_createdProjectState` supplies the typed terminal
fixture. `_pumpFrames` provides bounded frame progress; the creation tests do
not depend on an unbounded settle loop.

Complementary app/provider ordering is covered in
`test/widget/benchbeep_home_screen_test.dart`; storage behavior is covered by
`test/unit/project_creator_test.dart`.

## Dangerous combinations

- Weakening live-gate tests while changing progress navigation can reintroduce
  index-derived completion.
- Replacing controlled pending futures with immediate results can hide
  duplicate activation.
- Asserting only one failure subtype can leave raw-detail or thrown-exception
  paths unguarded.
- Auto-navigating after success would invalidate Step 7 persistence and
  provider-before-route ordering.
- Invoking production storage in this suite would mix UI and filesystem
  ownership.
- Weakening fitted-frame or inert-bar assertions while changing both editor
  stacks can hide mixed coordinate spaces or a second Step 4 plane.
- Failing to restore surface size or `FilePicker.platform` can leak state into
  unrelated widget suites.

## Safe SNIPER slices

- Step 1 advanced/gate only: primary helpers and the advanced/live-gate tests.
- One editor family only: its helpers, persistence tests, and request mapping.
- Shared Step 3/4 plane only: `_contourCanvasRect`, `_componentCanvasRect`, the
  exact latch/resize/inert-bar test, and both request tests; preserve Step 2.
- Step 6 review/edit only: `_openReviewStep` and complete round-trip test.
- Duplicate/failure state only: controlled creator callbacks and two focused
  tests.
- Terminal success only: success fixture, handoff count, wait, and explicit
  route assertion.

## Future extraction seams

- [S] Geometry-heavy contour/candidate tests could split after shared gesture
  helpers become a stable test utility.
- [S] Creation-result tests could form a dedicated group if complete draft and
  router harness ownership remain visible.
- [S] Progress semantics could move to a focused suite after retaining
  cross-step invalidation coverage.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when fitted-frame helpers, keys, result types, or
test names change; `FLOW_DRIFT` when reference-plane ownership or draft/gate/
create/handoff/navigation ordering changes; `BOUNDARY_DRIFT` when production
storage, raw diagnostics, or canonical writes enter; `TEST_DRIFT` when the
70-test family changes; and `STRUCTURE_DRIFT` when helper or test families
split.

## Known uncertainty

- [D] Provider assignment itself belongs to the app suite; this file proves
  only the Wizard callback count and ordering.
- [D] Persistent project bytes belong to ProjectCreator unit tests and manual
  smoke, not this widget suite.
- [P] Golden/pixel-perfect rendering is not asserted; layout tests focus on
  reachability, overflow, and behavioral geometry.
