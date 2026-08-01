# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 11/12 — 52-test multi-family marker/photo/contour/navigation/responsive protected-boundary surface`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_MARKER_VISUALS_V2_LOCK_PASS.md`

## File purpose

Exercises the seven-step zero-write New Project Wizard through controlled
platform, folder-picker, photo-picker, router, viewport, pointer, semantics,
and private painter/marker-geometry seams. Its 52 widget tests preserve Step
1, contour, component, cancellation, and final-boundary behavior while proving
the photo-first Step 2, read-only photo reuse below Steps 3–4, independent
marker shape/size/rotation, current-style inheritance, geometric hit testing,
retention, honest progress, and responsive operability.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Platform and photo-picker seams | `_TestPlatformInfo`, `_MutableTestPlatformInfo`, `_FakePhotoFilePicker`, `_installPhotoPicker` | Supplies deterministic desktop/mobile capability and records the native picker request, outcomes, cancel, and exception. |
| Isolated route and folder harness | `_buildWizardApp`, `GoRouter`, `directoryPicker`, `/new-project`, `/` | Hosts only transient Home/Wizard destinations and a zero-write parent-folder callback. |
| Shared field and navigation helpers | `_pumpFrames`, `_enterText`, `_tapKey`, `_completeStepOne`, `_openPhotoAlignmentStep`, `_openContourStep`, `_openComponentPlacementStep` | Drives the photo-first order and each accepted gate through stable keys. |
| Contour geometry and painter inspection | `_contourCanvasRect`, `_tapContourAt`, `_dragContourPoint`, `_contourPainter`, `_paintedContourPoints`, `_addTriangle`, `_closeContour` | Converts normalized test input, mutates contour state, and reads immutable private painter snapshots. |
| Photo editor and transform inspection | `_photoEditor`, `_photoTransform`, photo picker tests | Reads the child editor’s parent-supplied path/transform callbacks and checks filter, bounds, opacity, reset, replace, remove, and retention. |
| Component style, geometry, and painter inspection | `_componentCanvasRect`, `_tapComponentAt`, `_tapComponentFromCentreOffset`, `_dragComponentFromCentreOffset`, `_componentGeometry`, `_paintedComponentStyles`, `_setComponentSize` | Drives candidate controls and centre/edge pointers, then observes immutable key/position/style snapshots, derived paths/bounds/targets, selection, and the contour guide. |
| Step 1 and catalogue contract | seven-step label, field, gate, path/copy, retention, multiline tests | Preserves the foundation and checks the seven accepted labels and initial navigation. |
| Contour contract | Step 3 empty/add/drag/delete/reset/close/reopen tests | Proves editor-normalized mutation and the closed-only Step 3 `Edasi` gate. |
| Component contract | Step 4 empty/guide/style/inheritance/geometry/hit/add/drag/delete/round-trip tests | Proves optional generic placement, four visual shapes, next-versus-selected style, immutable candidate isolation, responsive size/rotation geometry, deterministic targets, stable keys, clamping, selected-only deletion, and retention. |
| Photo-first layering contract | optional/Vaadatud, desktop picker, photo-below-guides, cancel/exception, bounds, reset/replace/remove tests | Proves parent ownership, photo-only Step 2, inert bottom layers in Steps 3–4, and fixed contour/candidate state after photo changes. |
| Retention, progress, placeholders, and dirty contract | Step 2-3-4/resize, candidate/contour dirty, Steps 5–7, progress tests | Proves one retained local draft, viewed versus complete semantics, and honest non-functional later steps. |
| Responsive and protected boundary | compact photo drag, wide/compact contour/component tests, mobile actions, `no creator...` | Exercises 1440×900 and 390×760, gesture-versus-scroll behavior, unsupported platform copy, and zero-write traversal. |

## State and data flow

1. `[D]` `_buildWizardApp` injects only platform and folder-picker values,
   starts at `/new-project`, and exposes `/` only for cancellation.
2. `[D]` `_FakePhotoFilePicker` replaces `FilePicker.platform`, records
   `type`, extensions, `withData`, and `allowMultiple`, then returns a
   path, null, or throws. Teardown restores the prior picker when available.
3. `[D]` `_openPhotoAlignmentStep` completes Step 1 and advances once;
   `_openContourStep` advances again through ungated Step 2;
   `_openComponentPlacementStep` closes Step 3 before advancing.
4. `[D]` Contour/component helpers convert normalized values through the
   rendered rectangle and use bounded pumps. Component edge helpers drive raw
   offsets from marker centers; dynamic painter/geometry inspection avoids
   exposing private production types.
5. `[D]` Photo helpers read the child widget and its authoritative transform
   dynamically; tests invoke callbacks to verify the parent’s clamping,
   normalization, retention, and dirty call paths.
6. `[D]` The picker test requires one custom-file request, the four locked
   extensions, no bytes, no multi-select, path retention, and the default
   65-percent view.
7. `[D]` Optional-progress coverage advances past Step 2 without a photo and
   requires `Vaadatud`, never `Valmis`.
8. `[D]` The layering test inspects child order in
   `wizard-contour-stack` and `wizard-component-stack`, checks the same
   path/transform/opacity, then proves contour points and candidate keys/
   positions survive later replacement and removal.
9. `[D]` Cancel and exception outcomes preserve the existing path and all
   transform fields. Separate tests exercise finite/clamped scale/opacity,
   normalized rotation, reset, replacement, and complete removal.
10. `[D]` The navigation/resize test compares the complete photo draft after
    Step 2 → Step 3 → Step 4 → Step 2 and a viewport change.
11. `[D]` Compact photo dragging records the ancestor scroll offset and
    requires photo translation to change while the page offset remains fixed.
12. `[D]` Marker tests require four keyed/semantic shape controls, default and
    inherited current style, selected-only immutable updates, rotation
    normalization/circle preservation, responsive size/floor/ratios, and
    shape-aware painter geometry.
13. `[D]` Centre-offset pointer tests require elongated ends and rotated
    corners to select/drag, at-least-56×56 hit bounds, closest-center overlap
    selection, and insertion-order ties.
14. `[D]` Existing contour and candidate tests retain normalized geometry,
    closure, key/order, selection, clamp, add/drag/delete, and mutation
    behavior in the reordered catalogue.
15. `[D]` Candidate/current style snapshots survive Step 4 ↔ Step 5, earlier
    steps, wide-to-compact resize, and photo transform/replacement/removal;
    rendered pixels respond to canvas size without stored-value mutation.
16. `[D]` Progress coverage distinguishes Step 1/closed Step 3 `Valmis`
    from viewed Step 2/Step 4/placeholders and reaches Step 7 without a create
    action.
17. `[D]` The final traversal remains on `/new-project` and finds no
    creator, project-state, filesystem, canonical, or project-route action.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `flutter_test` | test driver | Pumps widgets, drives controls/pointers, changes view size, and inspects transient widget/painter state. |
| Flutter Material | harness UI | Supplies router app, controls, geometry, keys, `Stack`, `Opacity`, and `CustomPaint`. |
| `FilePicker` | replaced global test seam | Captures the supported desktop picker contract without host file access. |
| `NewProjectWizardScreen` | mapped subject | Supplies all parent state, step, layer, and boundary behavior under test. |
| `PlatformInfo` | outbound capability seam | Controls folder/photo mobile boundaries. |
| GoRouter | isolated route harness | Hosts only `/` and `/new-project`. |

The suite creates no creator fake, project model, filesystem fixture, event,
fact, projection, materializer, Board Canvas, or ZIP helper.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Picker closures and `_FakePhotoFilePicker` | `ZERO_WRITE` | Return in-memory results and never open or copy a source file. |
| Text, taps, drags, callbacks, navigation, dialogs, and viewport changes | `UI_LOCAL` | Mutate only widget/test-binding state; teardown resets global seams and size. |
| Dynamic photo/painter/marker-geometry inspection | `ZERO_WRITE` | Reads immutable transient snapshots and derived presentation paths/bounds without adding a production output path. |
| Route assertions | `ZERO_WRITE` | Observe only the isolated harness URI. |

No test assigns project state, calls `ProjectCreator`, writes a source/project
file, emits an event/fact, converts canonical coordinates, or creates ZIP
output.

## Zero-write zones

- `[D]` Picker outcomes are synthetic paths; no image bytes or filesystem
  mutation is used.
- `[D]` Photo transforms, contour points, candidates, and painter snapshots
  remain in memory.
- `[D]` Candidate style snapshots and marker paths, sizes, rotations, rotated
  bounds, and hit rectangles are inspected as transient derived values only.
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
| Component current style | `[D]` keyed controls and candidate snapshots distinguish next style from selected mutation. | selection, dirty cancellation, navigation | `UI_LOCAL` | defaults; inheritance; isolation; delete retention |
| Component geometry/hit | `[D]` painter geometry exposes responsive paths, ratios, rotation, bounds, and target rectangles. | raw pointer helpers and candidate ordering | `ZERO_WRITE` | 8px floor; default size; elongated/rotated edges; 56px target; overlaps |
| Component editor | `[D]` key/position/style helpers retain Step 4 behavior. | reordered setup and both guide layers | `UI_LOCAL` | add/drag/clamp/style preservation/delete/round-trip |
| Retention/resize | `[D]` Parent draft is compared across three steps and view sizes. | progress and responsive shell | `UI_LOCAL` | photo draft survives navigation/resize |
| Dirty cancellation | `[D]` Mutations precede dialog checks. | already-dirty shared setup | `UI_LOCAL` | contour/candidate cancellation plus source |
| Progress/placeholders | `[D]` Status copy is read at each visited step. | catalogue and gates | `ZERO_WRITE` | optional Step 2; progress; Steps 5–7 |
| Responsive gestures | `[D]` Fixed sizes and scroll offsets exercise layout branches. | child editor pan and page scroll | `UI_LOCAL` | wide/compact; compact photo/candidate drag |
| Protected boundary | `[D]` Harness exposes no project route or persistent collaborator. | final action copy | `ZERO_WRITE` | no creator/project-state/project-route |

## Relevant tests and helpers

The 52-test suite contains:

- 7 Step 1/catalogue/foundation tests;
- 7 contour-specific interaction and closure tests;
- 15 component guide/style/geometry/hit/interaction/retention tests;
- 10 photo order/picker/layer/transform/retention/platform tests;
- 7 draft/cancellation/placeholder tests;
- 5 responsive/progress tests; and
- 1 explicit creator/project-state/project-route boundary traversal.

Key helpers are `_buildWizardApp`, `_completeStepOne`, the three step-entry
helpers, `_FakePhotoFilePicker`, `_installPhotoPicker`, `_photoEditor`,
`_photoTransform`, both normalized geometry families,
`_tapComponentFromCentreOffset`, `_dragComponentFromCentreOffset`,
`_componentGeometry`, `_paintedComponentStyles`, `_setComponentSize`, and the
dynamic painter-inspection families.

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
- `[D]` Changing marker geometry fields, centre-offset pointer helpers, and
  edge/overlap expectations together can make an incomplete target appear
  correct.
- `[D]` Changing gesture helpers and ancestor-offset assertions together can
  hide page movement.
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
- One progress/placeholder expectation plus exact step-entry helpers.
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

Review for `SYMBOL_DRIFT` when helper, key, route, callback, candidate field,
geometry, painter, or stack anchors change; `FLOW_DRIFT` when step entry,
picker, current-style inheritance, selection, hit testing, layer, gesture,
retention, dirty, or progress order changes; `BOUNDARY_DRIFT` when
persistent/canonical fixtures enter; `TEST_DRIFT` when the 52-test families
or assertions change; and `STRUCTURE_DRIFT` when screen integration moves to
another suite.

## Known uncertainty

- `[D]` The exact-label test checks membership for all seven labels, not their
  displayed sequence as one ordered list.
- `[D]` Visible ordinal coverage is selective even though step count,
  progress count, navigation bounds, and final detection are exercised.
- `[D]` Dirty-cancellation setup is already dirty from earlier steps;
  production assignments independently prove selected-style/add/move/delete
  mutation coverage and exclude next-style-only changes.
- `[D]` The compact 8-pixel render floor intentionally collapses part of the
  lower slider range without mutating the stored size scale.
- `[D]` Circle rotation controls remain enabled and the suite proves retained
  stored rotation rather than a visual rotational difference.
- `[D]` Actual desktop image decoding and deleted-path behavior require
  manual smoke; this suite uses synthetic picker paths and widget structure.
- `[D]` Zero-write is proved by harness/call-path inspection rather than a
  filesystem monitor.
