# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3,000 lines + 3+ test families`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_COMPACT_DESIGN_V1_LOCK_PASS.md`

## File purpose

Provides 76 widget tests for the complete New Project Wizard. Its in-memory
router/platform/picker/creator harnesses verify the seven-step draft, compact
presentation, shared reference geometry, gates/navigation, review/create,
safe failures, exactly-once handoff, persistent success, and explicit route
without writing canonical data or a real generated project.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Test app and platform seams | `_buildWizardApp`, `_TestPlatformInfo`, `_MutableTestPlatformInfo`, `_FakePhotoFilePicker` | Hosts the Wizard with controlled routing, viewport, platform, picker, creator, and handoff collaborators. |
| Navigation helpers | `_completeStepOne`, `_openContourStep`, `_openComponentPlacementStep`, `_openProblemDescriptionStep`, `_completeProblemDescription`, `_openReviewStep` | Drive legal step transitions through visible actions. |
| Geometry helpers | `_contourCanvasRect`, `_componentCanvasRect`, `_tapContourAt`, `_tapComponentAt`, `_dragContourPoint`, `_dragComponentCandidate` | Derive pointer locations from rendered canvases and exercise normalized mapping. |
| Draft/read helpers | `_progressStep`, `_ComponentStyleSnapshot`, `_paintedComponentStyles`, `_componentPainter` | Read progress, candidate style, and painter state. |
| Step 1 and gate family | `seven-step shell renders the exact Estonian step labels`, `Step 1 renders all four locked fields`, `valid name and selected path advance to Step 2` | Proves step order, primary/advanced fields, destination/name gates, and retention. |
| Contour/reference family | `Step 3 starts empty and keeps Edasi disabled`, `explicit closure paints a closed loop and enables Edasi`, `Step 3 latches one fitted reference frame that Step 4 reuses after resize` | Proves contour editing, closure gate, latched aspect, resize stability, and inert bars. |
| Candidate family | `empty-canvas tap adds and selects one generic candidate`, `marker geometry uses relative size, floor, and shape ratios`, `Step 4 to Step 5 round-trip retains candidate geometry` | Proves noncanonical candidate add/select/style/drag/delete/retention and hit testing. |
| Photo/problem family | `desktop picker uses the locked filter and default photo view`, `compact photo drag moves the photo without moving page scroll`, `effective Step 5 edit participates in dirty cancellation` | Proves optional photo/editor behavior, layering, compact drag isolation, problem draft, and cancellation. |
| Compact responsive/accessibility family | `all locked shell breakpoints remain overflow-free`, `compact parent remains readable and reachable at 200% text`, `eligible progress actions support Enter and Space in order` | Proves shell/workspace thresholds, focus/keyboard/semantics, complete copy, and no overflow. |
| Review/create/result family | `Step 6 shows the complete draft and all five edit round-trips`, `create activation revalidates all three live required gates`, `every typed failure and thrown exception is safely retryable` | Proves complete review, exact requests, duplicate guards, exhaustive failures, and retry retention. |
| Handoff/success/route family | `creation and project routing stay inert until activation`, `success hands off once, shows returned state, waits, then opens project` | Proves provider callback ordering, persistent Step 7, one action, and explicit `/project`. |

## Anchor inventory and verification

Selection rule: extract every backtick-delimited token from the responsibility
table's Stable symbol anchors column and de-duplicate in first-appearance
order. All `40/40` selected helper/type/test-title anchors resolve as exact
substrings in committed `HEAD`; zero are missing.

## State and data flow

1. Harnesses inject fake platform, picker, creator, and handoff callbacks into
   one Material/GoRouter app.
2. Helper functions use visible controls and rendered canvas rectangles rather
   than calling private production methods.
3. Geometry tests compute pointer coordinates from current fitted surfaces,
   then inspect painters, review values, and request snapshots.
4. Responsive tests set and restore view size/text scale, exercising `1050`,
   `780`, `820`, `600`, `560`, and `520` behavior families.
5. Creation callbacks return typed results or throw; assertions inspect safe
   UI state, invocation counts, handoff count, and router location.
6. No harness invokes a real creator, filesystem writer, provider container,
   materializer, exporter, or Project ZIP tool.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter/`flutter_test` | test driver | Pumps, focuses, taps, drags, changes view/text scale, reads semantics and painters. |
| GoRouter | local route harness | Proves cancellation and explicit success navigation. |
| File picker platform interface | fake collaborator | Supplies deterministic desktop photo paths and cancellation/errors. |
| Wizard screen/editor/models | mapped subject and values | Supplies all UI, request, result, and success behavior under test. |
| Compact widget types | presentation inspection | Identifies shell/workspace composites and controlled presentation. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Pumped Wizard draft, fake callbacks, counters, and router | `UI_LOCAL` | Mutate only in-memory test state. |
| Fake creator request capture | `ZERO_WRITE` | Records typed input and returns configured value without disk access. |
| Handoff capture | `PROJECTION_STATE` | Records callback invocation; no real app provider is assigned. |
| Painter/semantics/review/request inspection | `ZERO_WRITE` | Reads rendered or captured state only. |

No test writes events, facts, components, placements, measurements, Project
ZIP bytes, or generated project directories.

## Zero-write zones

- Picker, creator, and platform collaborators are fakes.
- Contour/candidates remain widget-local visual drafts.
- Router state stays inside the local harness.
- View/text-scale mutations are restored with teardown.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Step order/draft/gates | `[D]` Visible actions and fields are direct. | progress and cancellation | `UI_LOCAL` | Step 1, required gate, retention families |
| Reference frame/contour | `[D]` Pointer positions derive from rendered rectangles. | photo and candidate painter | `UI_LOCAL` | latch, resize, inert bars, closure/edit tests |
| Candidate workspace | `[D]` Style/painter/hit targets are inspected. | Step 3 plane and review | `UI_LOCAL` | add/drag/delete/style/hit/round-trip tests |
| Compact presentation | `[D]` Keys, sizes, text, focus, and exceptions are read. | editor focused suites | `ZERO_WRITE` / `UI_LOCAL` | breakpoints, 200%, keyboard, drag isolation |
| Review/request | `[D]` Complete values and captured request are compared. | intake/creator tests | `ZERO_WRITE` | five edits; no-photo/photo request tests |
| Failure/duplicate | `[D]` Typed callbacks and invocation counts are controlled. | result hierarchy | `UI_LOCAL` | revalidation, pending, all failures |
| Handoff/route | `[D]` Callback counts and route state are explicit. | app provider ordering | `PROJECTION_STATE` / `UI_LOCAL` | inert, success wait, open tests |

## Relevant tests and helpers

The 76 tests form step/gate, contour/reference, candidate, photo, problem,
cancellation, compact responsive/accessibility, review/request, failure,
handoff, and route families. Direct companion evidence lives in
`wizard_compact_widgets_test.dart`, both editor suites, creator/intake/loader
tests, and Project ZIP tests.

## Dangerous combinations

- Changing geometry helpers and expectations with production mapping can hide
  a coordinate regression.
- Changing fake creator behavior with duplicate/failure assertions can make a
  second invocation invisible.
- Changing breakpoint sizes and layout expectations together can stop testing
  the exact threshold edges.
- Replacing visible-control navigation with private-state manipulation would
  weaken end-to-end gate proof.
- Adding a real filesystem creator would cross the suite boundary.

## Safe SNIPER slices

- One required gate and its progress/navigation test family.
- Shared Step 3/4 frame helpers plus latch/resize/inert-bar tests.
- One candidate behavior plus painter/hit-test assertion.
- One breakpoint/accessibility scenario with explicit teardown.
- Step 6 display only or one typed result only.
- Step 7 handoff or explicit route only, preserving separation.

## Future extraction seams

- `[S]` Geometry families could move to a focused suite after shared rendered-
  rectangle helpers become stable.
- `[S]` Typed result families could split while retaining full-draft and
  router/handoff visibility.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helpers, exact test titles, keys, or production
anchors change; `FLOW_DRIFT` when draft/gate/reference/create/handoff order
changes; `BOUNDARY_DRIFT` if real persistence/canonical fixtures enter;
`TEST_DRIFT` when the 76-test families move; and `STRUCTURE_DRIFT` when
harnesses or major families split.

## Known uncertainty

- `[D]` Persistent project bytes and provider assignment are proved in their
  owning suites, not here.
- `[D]` `780–1049` side-by-side workspace and compact horizontal progress are
  asserted as accepted deliberate presentation.
- `[P]` Pixel-perfect styling is not golden-tested; behavioral geometry,
  overflow, semantics, and text completeness are covered.
