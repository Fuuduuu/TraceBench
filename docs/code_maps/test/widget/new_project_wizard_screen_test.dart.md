# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 8/12 — 34-test multi-family contour/component/navigation/responsive protected-boundary surface`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_COMPONENT_PLACEMENT_V1_LOCK_PASS.md`

## File purpose

Exercises the accepted six-step zero-write New Project Wizard through injected
platform and picker seams. Its 34 widget tests cover Step 1 foundation
behavior, the functional Step 2 contour editor, the optional Step 3 generic
component-candidate editor, navigation and state retention, dirty
cancellation, honest progress, responsive pointer/scroll behavior, and the
absence of any creator, project-state, canonical, or persistent-write path.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Platform and picker seams | `_TestPlatformInfo`, `_buildWizardApp`, `directoryPicker`, local `pickerOpened` | Supplies deterministic platform state and zero-write picker closures. |
| Isolated route harness | `_buildWizardApp`, `GoRouter`, `/`, `/new-project` | Hosts only transient Home and Wizard destinations. |
| Shared navigation helpers | `_pumpFrames`, `_enterText`, `_tapKey`, `_completeStepOne`, `_openContourStep`, `_openComponentPlacementStep` | Drives stable keys, bounded frames, Step 1 completion, closed Step 2, and Step 3 entry. |
| Contour geometry helpers | `_contourCanvasRect`, `_tapContourAt`, `_dragContourPoint` | Converts normalized test positions to rendered canvas input and performs bounded raw-pointer drags. |
| Painter inspection helpers | `_contourPainter`, `_paintedContourPoints`, `_paintedContourIsClosed`, `_addTriangle`, `_closeContour` | Reads private painter state dynamically and constructs a reusable closed triangle. |
| Component geometry and pointer helpers | `_componentCanvasRect`, `_tapComponentAt`, `_dragComponentCandidate` | Converts editor-normalized candidate positions to rendered input and performs bounded candidate drags. |
| Component painter inspection | `_componentPainter`, `_paintedComponentCandidates`, `_paintedComponentDraftKeys`, `_paintedComponentPositions`, `_paintedSelectedComponentDraftKey`, `_paintedComponentGuidePoints`, `_paintedComponentGuideIsClosed` | Reads private candidate, selection, position, and contour-guide snapshots dynamically. |
| Step 1 and shell contract | six-step, field, gate, path/copy, retention, multiline tests | Preserves accepted Step 1 and six-step foundation behavior. |
| Contour contracts | empty/add/gate, drag/clamp, delete/reset/reopen tests | Proves point addition and editing, the explicit three-point close precondition, the closed-only `Edasi` gate, and reopen after every post-closure mutation. |
| Component placement contract | `Step 3 starts empty...`, `empty-canvas tap adds...`, `selection and dragging...`, `deletion removes only...` | Proves read-only contour guidance, optional navigation, stable keys, add/select/drag/clamp, and selected-only deletion. |
| Retention, dirty, placeholder, and progress contract | Step 4 round-trip, candidate/contour dirty tests, placeholder traversal, progress test | Proves retained local state, dirty cancellation, Step 3 `Vaadatud`, and Steps 4–6 placeholders. |
| Responsive and protected boundary | Step 2/Step 3 wide/compact tests, `no creator...` | Exercises layout branches, candidate drag-versus-page-scroll behavior, and the absence of a create/project route. |

## State and data flow

1. `[D]` `_buildWizardApp` injects deterministic picker/platform values into
   `NewProjectWizardScreen`, starts at `/new-project`, and exposes `/` only for
   cancellation.
2. `[D]` `_completeStepOne` enters the three text fields and taps the folder
   action but does not advance. `_openContourStep` adds the separate
   `wizard-next` tap; `_openComponentPlacementStep` also creates and closes a
   three-point contour before advancing to Step 3.
3. `[D]` `_tapContourAt` locates `wizard-contour-canvas`, converts an
   editor-normalized test position to rendered coordinates, taps, and pumps
   bounded frames.
4. `[D]` `_dragContourPoint` converts normalized endpoints, starts one gesture,
   performs two pointer moves with bounded pumps, releases it, and pumps the
   resulting state.
5. `[D]` Contour painter helpers dynamically read the private painter's point
   snapshot and closure flag without importing or exposing its private type;
   `_addTriangle` and `_closeContour` construct the shared closed guide.
6. `[D]` `_tapComponentAt` and `_dragComponentCandidate` use the same
   editor-normalized-to-rendered conversion for `wizard-component-canvas`.
   Candidate dragging deliberately performs two pointer moves so the
   production scroll-ownership transition is observable.
7. `[D]` Component painter helpers dynamically read candidate keys, positions,
   selection, and the contour-guide snapshot without exposing the private
   candidate or painter types.
8. `[D]` Step 3 tests verify the empty and ungated initial state, the closed
   read-only contour guide, outside-polygon addition, stable-key selection,
   clamped dragging, and deletion of only the selected candidate.
9. `[D]` Round-trip tests compare retained contour state after Step 3 -> Step 2
   and candidate keys/positions after Step 3 -> Step 4 -> Step 3. Dirty tests
   exercise both editor families before cancellation.
10. `[D]` Compact Step 3 records the ancestor `Scrollable` offset before and
    after a hit-candidate drag and requires it to remain unchanged.
11. `[D]` Progress tests close Step 2 before advancing, then verify Step 2
    `Valmis`, optional Step 3 `Vaadatud`, placeholder Steps 4–5 `Vaadatud`,
    and Step 6 current-state semantics.
12. `[D]` The final traversal remains on `/new-project` and proves no create
    action or `/project` transition exists.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `flutter_test` | test driver | Pumps widgets, drives pointer/key actions, changes view size, and asserts UI/painter state. |
| Flutter Material | widget harness | Supplies router app, controls, geometry, icons, `CustomPaint`, and keys. |
| `NewProjectWizardScreen` | mapped subject | Supplies picker/platform seams and all Wizard behavior under test. |
| `PlatformInfo` | outbound test seam | Controls the mobile picker gate. |
| GoRouter | outbound navigation harness | Hosts `/` and `/new-project` and exposes the current URI. |

There is no Riverpod, creator, project request/state, Board Canvas, filesystem,
event/fact, projection, materializer, or ZIP fixture.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Picker closures, painter inspection, route and finder expectations | `ZERO_WRITE` | Return configured values or observe transient state without host or canonical writes. |
| Text/key helpers, contour/component taps and drags, navigation, dialogs, and viewport changes | `UI_LOCAL` | Mutate only the widget/test binding state; viewport state is reset in teardown. |
| Contour/component painter inspection | `ZERO_WRITE` | Reads immutable private painter snapshots dynamically without introducing an outward data path. |
| `_TestPlatformInfo` | `ZERO_WRITE` | Returns one configured capability flag. |

No test invokes a creator, assigns project state, writes a directory/file,
appends an event/fact, materializes a projection, or creates ZIP output.

## Zero-write zones

- `[D]` Injected picker closures return strings and touch no filesystem.
- `[D]` Normalized contour positions and painter snapshots remain in test/UI
  memory.
- `[D]` Candidate draft keys, normalized positions, selection, and painter
  snapshots remain in test/UI memory.
- `[D]` The route harness contains no `/project` route or project-state owner.
- `[D]` No creator fake, persistent fixture, temp directory, event, fact,
  projection, or ZIP helper exists.
- `[D]` View-size changes are transient and reset through teardown.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Step 2 entry and contour contract | `[D]` Shared helpers enter, mutate, close, and inspect the contour editor. | Step 1 gate, action bar, painter | `UI_LOCAL` | Empty/add; drag/clamp; delete/reset/reopen; closure |
| Step 3 entry and guide | `[D]` Shared setup supplies one closed contour and advances separately. | Step 2 gate and component painter | `ZERO_WRITE` | Empty/ungated Step 3; closed guide |
| Candidate add/select | `[D]` Empty-canvas taps add one candidate; hit taps select without adding. | Subject hit radius and selection copy | `UI_LOCAL` | Outside-contour add; stable keys; selection |
| Candidate drag/clamp and scroll | `[D]` Two raw-pointer moves update one candidate and retain the ancestor offset. | Canvas geometry, pointer ownership, scroll physics | `UI_LOCAL` | Selected drag; edge clamping; compact offset |
| Candidate deletion and identity | `[D]` Key and painter snapshots distinguish selected-only removal. | Selection and drag cleanup | `UI_LOCAL` | Stable-key selected delete |
| Painter state | `[D]` Dynamic helpers read contour and component snapshots. | Both private painter implementations | `ZERO_WRITE` | Closed loop/guide; mutation; round-trips |
| Retention | `[D]` Contour and candidate snapshots are compared after forward/back navigation. | Navigation and progress | `UI_LOCAL` | Step 3 and Step 4 round-trips |
| Dirty cancellation | `[D]` Contour and candidate mutations precede cancel-dialog assertions. | Shared already-dirty setup | `UI_LOCAL` | Contour and candidate cancellation |
| Progress/placeholders | `[D]` Closed Step 2 is complete; optional Step 3 and later placeholders are viewed. | Progress tiles, action bar, traversal | `ZERO_WRITE` | Ungated Step 3; progress; Steps 4–6 |
| Responsive layout | `[D]` Two view sizes exercise wide/compact Step 2 and Step 3. | Subject breakpoints, canvas sizes, scroll | `ZERO_WRITE` | Step 2/Step 3 at 1440×900 and 390×760 |
| Protected boundary | `[D]` Final traversal finds no create action or project route. | Harness route graph | `ZERO_WRITE` | `no creator...` |

## Relevant tests and helpers

The nine contour-specific test titles are:

- `Step 2 starts empty and keeps Edasi disabled`;
- `empty-canvas taps add points but closure needs three`;
- `a point can be selected, dragged, and clamped to the editor`;
- `selected point can be deleted`;
- `reset clears points, selection, closure, and the Step 2 gate`;
- `explicit closure paints a closed loop and enables Edasi`;
- `adding, moving, and deleting after closure each reopen it`;
- `Step 3 starts empty, renders the closed contour guide, and stays ungated`;
- `contour mutation participates in dirty-draft cancellation`.

The seven additional component-specific test titles are:

- `empty-canvas tap adds and selects one generic candidate`;
- `selection and dragging change only the selected clamped position`;
- `deletion removes only the selected stable draft candidate`;
- `Step 4 round-trip retains candidate keys and positions`;
- `candidate mutation participates in dirty-draft cancellation`;
- `Step 3 wide desktop layout is operable without overflow`; and
- `Step 3 compact layout is operable without overflow`.

The remaining eighteen tests preserve shell/Step 1 fields and gates, honest
zero-write copy, Step 1 retention, placeholder traversal, multiline input,
three cancellation branches, mobile picker suppression, Step 2
wide/compact behavior, progress semantics, and absence of a creation route.

Key helpers are `_TestPlatformInfo`, `_buildWizardApp`, `_pumpFrames`,
`_enterText`, `_tapKey`, `_completeStepOne`, `_openContourStep`,
`_openComponentPlacementStep`, `_tapContourAt`, `_dragContourPoint`,
`_tapComponentAt`, `_dragComponentCandidate`, both painter-inspection families,
`_addTriangle`, and `_closeContour`.

## Dangerous combinations

- `[D]` Changing normalized helper geometry and subject hit testing together
  can make a broken drag appear correct.
- `[D]` Changing `_addTriangle`, `_closeContour`, and closure assertions
  together can hide the explicit close precondition.
- `[D]` Changing component hit testing, pointer ownership, the two-move gesture,
  and scroll-offset assertions together can hide candidate/page movement.
- `[D]` Changing stable-key generation, painter inspection, and selected-delete
  expectations together can hide replacement or wrong-candidate deletion.
- `[D]` Changing shared Step 1 setup and dirty-cancel assertions together can
  hide which mutation armed dirty state.
- `[D]` Changing either painter's internals and dynamic inspection together can
  erase closed-loop, guide, candidate, or selection evidence.
- `[D]` Adding creator, filesystem, project-state, or canonical fixtures would
  weaken the explicit zero-write proof.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- One contour mutation test plus its keyed control/painter assertions.
- Drag/clamp only: `_dragContourPoint`, point inspection, and the matching
  subject geometry handlers.
- Closure gate only: `_addTriangle`, `_closeContour`, button state, and the
  explicit-closure test.
- One component mutation test plus component geometry/painter assertions.
- Component scroll coordination only: `_dragComponentCandidate`, scroll-offset
  assertion, and the matching pointer-ownership branch.
- Retention only: close, advance/back, and retained contour or candidate
  assertions.
- One responsive size only with explicit teardown.
- Step 1, cancellation, progress, or final-boundary regression only; preserve
  all contour/component helpers unless their contract changes.

## Future extraction seams

Descriptive, non-authorizing possibilities:

- `[S]` Canvas geometry helpers may be shared if normalized semantics and
  rendered-coordinate conversion remain explicit.
- `[S]` Painter inspection could use a public semantic seam only through a
  separately authorized production/test change.
- `[S]` Step setup helpers may be split if gate conditions remain independently
  visible.
- `[S]` Candidate gesture and scroll-offset setup may be isolated if it still
  proves both candidate movement and ancestor-scroll stability.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helpers, keys, titles, routes, painter fields, or
screen anchors change; `FLOW_DRIFT` when Step 1/Step 2/Step 3 setup, gestures,
mutation, closure, selection, pointer/scroll ownership, retention, or
cancellation ordering changes;
`BOUNDARY_DRIFT` when persistent/canonical fixtures enter; `TEST_DRIFT` when
covered variants or assertions change; and `STRUCTURE_DRIFT` when the harness
or contour/component tests move to another file.

## Known uncertainty

- `[D]` `contour mutation participates in dirty-draft cancellation` is not
  independently regression-sensitive to the contour mutation because
  `_openContourStep` calls `_completeStepOne`, which already dirties Step 1.
  Production source independently proves add, move, delete, reset, and close
  set `_draftTouched`.
- `[D]` `candidate mutation participates in dirty-draft cancellation` has the
  same limitation because Step 3 setup already dirties Steps 1 and 2.
  Production source independently proves candidate add, move, and delete set
  `_draftTouched`.
- `[D]` Responsive tests cover two fixed sizes, not every intermediate width or
  real touch/mouse device.
- `[D]` Compact coverage directly proves a hit-candidate drag does not move the
  ancestor scroll offset. Ordinary empty-canvas page scrolling is established
  by source/call-path inspection rather than a separate widget assertion.
- `[D]` Dynamic painter inspection couples the suite to private contour and
  component painter field names even though it avoids a public production seam.
- `[D]` Zero-write is established by source/call-path inspection and reachable
  UI assertions, not by a filesystem monitor.
