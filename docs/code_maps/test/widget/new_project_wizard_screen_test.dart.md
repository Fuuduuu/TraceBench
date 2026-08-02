# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `AUTO — >3,000 lines + 3+ test families`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_INTERACTION_POLISH_V1_LOCK_PASS.md`

## File purpose

Exercises the seven-step zero-write New Project Wizard through controlled
platform, picker, router, viewport, pointer, semantics, problem-editor, and
private painter/geometry seams. Its 62 widget tests preserve Step 1, contour,
component, cancellation, and the final boundary while proving photo reuse,
marker visuals, exact-one addition, compact Step 4 controls, direct visited
navigation, live-gate progress, retention, and responsive operability.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Platform and photo-picker seams | `_TestPlatformInfo`, `_MutableTestPlatformInfo`, `_FakePhotoFilePicker`, `_installPhotoPicker` | Supplies deterministic desktop/mobile capability and records the native picker request, outcomes, cancel, and exception. |
| Isolated route and folder harness | `_buildWizardApp`, `GoRouter`, `directoryPicker`, `/new-project`, `/` | Hosts only transient Home/Wizard destinations and a zero-write parent-folder callback. |
| Shared field and navigation helpers | `_pumpFrames`, `_enterText`, `_tapKey`, `_completeStepOne`, `_openPhotoAlignmentStep`, `_openContourStep`, `_openComponentPlacementStep`, `_openProblemDescriptionStep`, `_completeProblemDescription`, `_openReviewStep` | Drives the photo-first order, accepted gates, and retained visited-step state through stable keys. |
| Contour geometry and painter inspection | `_contourCanvasRect`, `_tapContourAt`, `_dragContourPoint`, `_contourPainter`, `_paintedContourPoints`, `_addTriangle`, `_closeContour` | Converts normalized test input, mutates contour state, and reads immutable private painter snapshots. |
| Photo editor and transform inspection | `_photoEditor`, `_photoTransform`, photo picker tests | Reads the child editor’s parent-supplied path/transform callbacks and checks filter, bounds, opacity, reset, replace, remove, and retention. |
| Component style, geometry, and painter inspection | `_componentCanvasRect`, `_tapComponentAt`, `_tapComponentFromCentreOffset`, `_dragComponentFromCentreOffset`, `_componentGeometry`, `_paintedComponentStyles`, `_setComponentSize` | Drives candidate controls and centre/edge pointers, then observes immutable key/position/style snapshots, derived paths/bounds/targets, selection, and the contour guide. |
| Step 1 and catalogue contract | seven-step label, field, gate, path/copy, retention, multiline tests | Preserves the foundation and checks the seven accepted labels and initial navigation. |
| Contour contract | Step 3 empty/add/drag/delete/reset/close/reopen tests | Proves editor-normalized mutation and the closed-only Step 3 `Edasi` gate. |
| Component contract | Step 4 status/grid/rotation/boundary, repeated-add, cancellation, geometry/hit, drag/delete/round-trip tests | Proves compact controls, full boundary meaning, exact-one empty taps, select/add and drag/cancel separation, immutable candidate style/key isolation, deterministic targets, deletion, and retention. |
| Photo-first layering contract | optional/Vaadatud, desktop picker, photo-below-guides, cancel/exception, bounds, reset/replace/remove tests | Proves parent ownership, photo-only Step 2, inert bottom layers in Steps 3–4, and fixed contour/candidate state after photo changes. |
| Problem draft, retention, progress, placeholders, and dirty contract | Step 5 empty/whitespace/raw tests, all-five-value retention, no-op callback, `_progressStep`, `_expectProgressStatus`, `_progressHasTapAction`, `_progressHasButtonFlag`, Steps 6–7 | Proves live Step 1/3/5 status invalidation/restoration, gate-safe visited jumps, non-dirty navigation, retained drafts, and honest placeholders. |
| Responsive and protected boundary | compact photo drag, wide/compact contour/component/progress tests, mobile actions, `no creator...` | Exercises 1440×900 and 390×760, pointer/keyboard/semantics availability, gesture-versus-scroll behavior, and zero-write traversal. |

## State and data flow

1. `[D]` `_buildWizardApp` injects platform/folder values, starts at `/new-project`, and exposes `/` only for cancellation.
2. `[D]` `_FakePhotoFilePicker` records request arguments, returns path/null/error, and restores the prior global picker in teardown.
3. `[D]` Step helpers encode Step 2 photo, ungated Step 2→3, closed Step 3→4, and Step 4→5 navigation.
4. `[D]` Geometry helpers convert normalized input through rendered rectangles; dynamic painter inspection avoids public production test hooks.
5. `[D]` Photo helpers invoke parent callbacks and inspect clamping, normalization, retention, dirty paths, and the four-extension/no-byte picker request.
6. `[D]` Optional Step 2 advances without photo and becomes `Vaadatud`, never `Valmis`.
7. `[D]` Layer-order assertions place the same photo/transform below contour/candidate painters and prove geometry survives replacement/removal.
8. `[D]` Cancel/error preserves the photo draft; separate tests cover bounds, reset, replacement, removal, navigation/resize, and compact drag versus scroll.
9. `[D]` Marker tests cover compact status, equal-width 2×2 keyed shapes, signed curved rotation/reset, full boundary copy, current-style inheritance, immutable updates, responsive geometry, and painter paths.
10. `[D]` Centre-offset tests cover elongated ends/rotated corners, 56×56 targets, closest-center overlaps, and insertion-order ties.
11. `[D]` Contour/candidate tests retain normalized geometry, closure, key/order, selection and clamp while proving each user-paced empty tap adds once and candidate select/drag/cancel never adds.
12. `[D]` Step 5 tests distinguish empty/whitespace validity from preserved raw text, retain all five values through Step 6/earlier mutations/resize, and exercise effective versus identical callbacks.
13. `[D]` Candidate/current style and problem snapshots survive navigation, earlier steps, resize, and photo changes without cross-mutation.
14. `[D]` Progress tests distinguish current/visited/unvisited states, navigate backward and gate-valid forward in both layouts, and invalidate/restore Step 1/3/5 status without dirty navigation.
15. `[D]` The final traversal stays on `/new-project` with no creator, project-state, filesystem, canonical, or project-route action.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `flutter_test` | test driver | Pumps widgets, drives controls/pointers, changes view size, and inspects transient widget/painter state. |
| Flutter Material | harness UI | Supplies router app, controls, geometry, keys, `Stack`, `Opacity`, and `CustomPaint`. |
| `FilePicker` | replaced global test seam | Captures the supported desktop picker contract without host file access. |
| `NewProjectWizardScreen` | mapped subject | Supplies all parent state, step, layer, and boundary behavior under test. |
| `NewProjectWizardProblemDescription` | child subject | Exposes the parent-owned Step 5 value/onChanged/compact contract for integration inspection. |
| `PlatformInfo` | outbound capability seam | Controls folder/photo mobile boundaries. |
| GoRouter | isolated route harness | Hosts only `/` and `/new-project`. |

The suite creates no creator/project/filesystem, event/fact/projection,
materializer, Board Canvas, or ZIP fixture.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Picker closures and `_FakePhotoFilePicker` | `ZERO_WRITE` | Return in-memory results and never open or copy a source file. |
| Text, taps, drags, callbacks, navigation, dialogs, and viewport changes | `UI_LOCAL` | Mutate only widget/test-binding state; teardown resets global seams and size. |
| Dynamic photo/painter/marker-geometry inspection | `ZERO_WRITE` | Reads immutable transient snapshots and derived presentation paths/bounds without adding a production output path. |
| Route assertions | `ZERO_WRITE` | Observe only the isolated harness URI. |

No test assigns project state, calls `ProjectCreator`, writes a source/project
file, emits an event/fact, converts canonical coordinates, or creates ZIP output.

## Zero-write zones

- `[D]` Picker outcomes are synthetic paths; no image bytes or filesystem mutation is used.
- `[D]` Photo transforms, contour points, candidates, and painter snapshots remain in memory.
- `[D]` Candidate style, paths, sizes, rotations, bounds, and hit rectangles are inspected as transient derived values only.
- `[D]` The router has no `/project` destination.
- `[D]` View size and global picker replacement are restored by teardown.
- `[D]` Protected-boundary assertions inspect reachable UI, not persistence.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Seven-step order | `[D]` Helpers encode Step 2 photo, Step 3 contour, Step 4 components. | progress, placeholders, action bounds | `ZERO_WRITE` | exact labels; Step 1 advance; Steps 5–7 |
| Picker/platform | `[D]` Fake records the precise request and outcomes. | parent error/cancel state | `UI_LOCAL` | desktop filter; cancel/exception; mobile |
| Photo transform | `[D]` Child callbacks expose parent normalization. | child editor focused suite | `UI_LOCAL` | defaults; clamps; reset/replace/remove |
| Layer order/invariance | `[D]` Stack child indexes and snapshots establish bottom photo layers. | contour/component painters | `ZERO_WRITE` | photo below independent geometry |
| Contour editor | `[D]` Existing gesture/painter helpers retain Step 3 behavior. | reordered setup and photo layer | `UI_LOCAL` | add/drag/delete/reset/close/reopen |
| Component controls/style | `[D]` keyed compact status, 2×2 geometry, icon/tooltip/semantics, signed value, and candidate snapshots distinguish presentation from mutation. | selection, dirty cancellation, navigation | `UI_LOCAL` | compact panel; shapes; rotation/reset; inheritance; isolation |
| Component geometry/hit | `[D]` painter geometry exposes responsive paths, ratios, rotation, bounds, and target rectangles. | raw pointer helpers and candidate ordering | `ZERO_WRITE` | 8px floor; default size; elongated/rotated edges; 56px target; overlaps |
| Component editor | `[D]` pointer-lifetime helpers and snapshots separate empty add from candidate select/drag/cancel. | both guide layers, key/style retention | `UI_LOCAL` | repeated exact-one add; cancel; drag-without-add; delete/round-trip |
| Retention/resize | `[D]` Parent draft is compared across three steps and view sizes. | progress and responsive shell | `UI_LOCAL` | photo draft survives navigation/resize |
| Dirty cancellation | `[D]` Mutations precede dialog checks. | already-dirty shared setup | `UI_LOCAL` | contour/candidate cancellation plus source |
| Problem description | `[D]` stable child fields and parent gate/progress/equality are exercised together. | child focused suite, navigation, cancellation | `UI_LOCAL` | empty/whitespace/normal gate; all-five retention; effective/no-op update |
| Progress/placeholders | `[D]` Semantics action/flag helpers and status finders observe independent visitation plus live gates. | catalogue, all three gates, action bar | `UI_LOCAL` | inert current/unvisited; backward/forward visited; invalidation/restoration; placeholders |
| Responsive gestures | `[D]` Fixed sizes and scroll offsets exercise layout branches. | child editor pan and page scroll | `UI_LOCAL` | wide/compact; compact photo/candidate drag |
| Protected boundary | `[D]` Harness exposes no project route or persistent collaborator. | final action copy | `ZERO_WRITE` | no creator/project-state/project-route |

## Relevant tests and helpers

The 62-test suite contains:

- 7 Step 1/catalogue/foundation tests;
- 7 contour-specific interaction and closure tests;
- 18 component status/style/geometry/hit/add/select/drag/cancel/retention tests;
- 10 photo order/picker/layer/transform/retention/platform tests;
- 10 problem-draft/cancellation/placeholder tests;
- 9 responsive/progress/navigation/gate-status tests; and
- 1 explicit creator/project-state/project-route boundary traversal.

Key helpers are `_buildWizardApp`, `_completeStepOne`, the step-entry helpers,
`_FakePhotoFilePicker`, `_installPhotoPicker`, `_photoEditor`, `_photoTransform`,
both normalized geometry families, `_tapComponentFromCentreOffset`,
`_dragComponentFromCentreOffset`, `_componentGeometry`,
`_paintedComponentStyles`, `_setComponentSize`, and the progress/painter helpers.

The linked 9-test problem-child suite isolates its model, controller selection
retention, raw/no-op callbacks, keys/copy/semantics, responsive layouts, and boundary.

## Dangerous combinations

- `[D]` Changing helper step counts together with subject order can make a
  wrong catalogue appear correct.
- `[D]` Changing fake-picker capture and production picker arguments together
  can hide an expanded platform or data-loading contract.
- `[D]` Changing Stack keys/index assertions and production layer order
  together can hide photo/guide inversion.
- `[D]` Changing dynamic painter fields and invariance expectations together
  can erase fixed-geometry evidence.
- `[D]` Changing current-style controls, candidate snapshot helpers, and
  inheritance/isolation assertions together can hide cross-candidate or dirty-
  state regressions.
- `[D]` Changing pointer-lifetime helpers with production pointer-down/tap-up
  handling can hide dropped empty taps or accidental drag-completion adds.
- `[D]` Changing marker geometry fields, centre-offset pointer helpers, and
  edge/overlap expectations together can make an incomplete target appear
  correct.
- `[D]` Changing gesture helpers and ancestor-offset assertions together can
  hide page movement.
- `[D]` Changing Step 5 helpers, child callback inspection, parent equality,
  gate/progress expectations, and retention fixtures together can hide raw-
  value, cursor, dirty, or completion regressions.
- `[D]` Changing progress semantics helpers, visited setup, gate mutation, and
  production tile actions together can hide a bypass or false status.
- `[D]` Adding creator, filesystem, canonical, or project-state fixtures
  would weaken the explicit boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- One picker outcome plus `_FakePhotoFilePicker` capture and the matching
  parent branch.
- One photo mutation test plus `_photoTransform` and the corresponding parent
  callback.
- One Step 3 or Step 4 layer-order assertion plus the matching production
  `Stack`; preserve independent geometry snapshots.
- One contour or candidate mutation family plus its normalized input and
  painter helper.
- One candidate-style mutation plus `_paintedComponentStyles`, its control,
  invariance assertions, and next-versus-selected summary.
- One marker-geometry or hit-target rule plus `_componentGeometry`, the
  matching centre-offset pointer helper, and painter/hit assertion.
- One progress/navigation rule plus `_openReviewStep`, the progress semantics
  helpers, its required gate mutation/restoration, and both layout branches.
- One Step 5 rule plus `_openProblemDescriptionStep`, child field/callback
  inspection, its parent branch, and the linked focused child test.
- One responsive size with explicit teardown and scroll-offset evidence.

## Future extraction seams

Descriptive, non-authorizing possibilities:

- `[S]` Photo picker setup may become a shared harness only if global restore
  behavior stays explicit.
- `[S]` Normalized canvas geometry helpers may be shared while keeping each
  editor’s coordinate meaning distinct.
- `[S]` Step-entry helpers may be factored if gates remain visible rather than
  silently bypassed.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helper, key, route, problem callback, candidate,
geometry, painter, or stack anchors change; `FLOW_DRIFT` when step entry,
picker, selection, Step 5 gate/equality/retention, dirty, or progress changes;
`BOUNDARY_DRIFT` when persistent/canonical fixtures enter; `TEST_DRIFT` when
the 62/9-test families change; and `STRUCTURE_DRIFT` when integration moves.

## Known uncertainty

- `[D]` The exact-label test checks membership for all seven labels, not their
  displayed sequence as one ordered list.
- `[D]` Visible ordinal coverage is selective even though step count,
  progress count, navigation bounds, and final detection are exercised.
- `[D]` Focused semantics assertions do not prove end-to-end screen-reader
  verbosity; nested Step 5 semantics remain an accepted accessibility NIT.
- `[D]` Dirty-cancellation setup is already dirty from earlier steps;
  production assignments independently prove selected-style/add/move/delete
  mutation coverage and exclude next-style-only changes.
- `[D]` The compact 8-pixel render floor intentionally collapses part of the
  lower slider range without mutating the stored size scale.
- `[D]` Circle rotation controls remain enabled and the suite proves retained
  stored rotation rather than a visual rotational difference.
- `[D]` Rotation controls retain an accepted pre-existing `Semantics` wrapper
  without a semantic activation action; tests verify labels, tooltips, icons,
  and the signed value, not that inherited activation action.
- `[D]` Actual desktop image decoding and deleted-path behavior require
  manual smoke; this suite uses synthetic picker paths and widget structure.
- `[D]` Zero-write is proved by harness/call-path inspection rather than a
  filesystem monitor.
