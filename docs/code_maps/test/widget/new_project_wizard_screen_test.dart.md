# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 8/12 — 27-test multi-family contour/navigation/responsive protected-boundary surface`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CONTOUR_V1_LOCK_PASS.md`

## File purpose

Exercises the accepted six-step zero-write New Project Wizard through injected
platform and picker seams. Its 27 widget tests cover Step 1 foundation
behavior, the functional Step 2 contour editor, navigation and state
retention, dirty cancellation, honest progress, responsive layouts, and the
absence of any creator, project-state, canonical, or persistent-write path.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Platform and picker seams | `_TestPlatformInfo`, `_buildWizardApp`, `directoryPicker`, local `pickerOpened` | Supplies deterministic platform state and zero-write picker closures. |
| Isolated route harness | `_buildWizardApp`, `GoRouter`, `/`, `/new-project` | Hosts only transient Home and Wizard destinations. |
| Shared interaction helpers | `_pumpFrames`, `_enterText`, `_tapKey`, `_completeStepOne`, `_openContourStep` | Drives stable keys, bounded frames, Step 1 completion, and Step 2 entry. |
| Contour geometry helpers | `_contourCanvasRect`, `_tapContourAt`, `_dragContourPoint` | Converts normalized test positions to rendered canvas input and performs bounded raw-pointer drags. |
| Painter inspection helpers | `_contourPainter`, `_paintedContourPoints`, `_paintedContourIsClosed`, `_addTriangle`, `_closeContour` | Reads private painter state dynamically and constructs a reusable closed triangle. |
| Step 1 and shell contract | six-step, field, gate, path/copy, retention, multiline tests | Preserves accepted Step 1 and six-step foundation behavior. |
| Contour empty/add/gate contract | `Step 2 starts empty...`, `empty-canvas taps...`, `explicit closure...` | Proves empty state, point addition, the three-point close precondition, and the closed-only `Edasi` gate. |
| Contour edit contract | drag/clamp, delete, reset, reopen tests | Proves selection, editor-bound dragging, deletion, reset, and reopen after every post-closure mutation. |
| Retention and dirty contract | `Step 3 round-trip...`, `contour mutation participates...` | Proves Step 2 state retention and cancellation after contour work. |
| Placeholder and progress contract | placeholder traversal, progress test | Proves functional Step 2 completion, `Vaadatud` for Steps 3–5, and terminal Step 6 as current. |
| Responsive and protected boundary | wide/compact tests, `no creator...` | Exercises both layout branches and proves no create/project route is reachable. |

## State and data flow

1. `[D]` `_buildWizardApp` injects deterministic picker/platform values into
   `NewProjectWizardScreen`, starts at `/new-project`, and exposes `/` only for
   cancellation.
2. `[D]` `_completeStepOne` enters the three text fields and taps the folder
   action but does not advance. `_openContourStep` adds the separate
   `wizard-next` tap.
3. `[D]` `_tapContourAt` locates `wizard-contour-canvas`, converts an
   editor-normalized test position to rendered coordinates, taps, and pumps
   bounded frames.
4. `[D]` `_dragContourPoint` converts normalized endpoints, starts one gesture,
   performs two pointer moves with bounded pumps, releases it, and pumps the
   resulting state.
5. `[D]` Painter helpers dynamically read the private painter's point snapshot
   and closure flag without importing or exposing its private type.
6. `[D]` `_addTriangle` adds three points; `_closeContour` then taps the
   explicit close action. Tests add navigation separately.
7. `[D]` Contour tests inspect rendered text/icons, button callbacks, painter
   points, clamped values, closure, and route state. They operate only on
   widget/test state.
8. `[D]` The Step 3 round-trip test closes, advances, returns, and re-reads the
   retained painter state.
9. `[D]` Progress tests close Step 2 before advancing, then verify Step 2
   `Valmis` and visited Steps 3–5 `Vaadatud`.
10. `[D]` The final traversal remains on `/new-project` and proves no create
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
| Text/key helpers, contour taps/drags, navigation, dialogs, and viewport changes | `UI_LOCAL` | Mutate only the widget/test binding state; viewport state is reset in teardown. |
| `_TestPlatformInfo` | `ZERO_WRITE` | Returns one configured capability flag. |

No test invokes a creator, assigns project state, writes a directory/file,
appends an event/fact, materializes a projection, or creates ZIP output.

## Zero-write zones

- `[D]` Injected picker closures return strings and touch no filesystem.
- `[D]` Normalized contour positions and painter snapshots remain in test/UI
  memory.
- `[D]` The route harness contains no `/project` route or project-state owner.
- `[D]` No creator fake, persistent fixture, temp directory, event, fact,
  projection, or ZIP helper exists.
- `[D]` View-size changes are transient and reset through teardown.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Step 2 entry/empty state | `[D]` Shared helper enters the editor after valid Step 1. | Step 1 gate and picker | `UI_LOCAL` | Valid advance; empty state |
| Tap/add and close gate | `[D]` Normalized taps add points and button callbacks expose availability. | Subject hit testing and action bar | `UI_LOCAL` | Add/below-three; explicit closure |
| Drag/clamp | `[D]` Two raw-pointer moves drive one selected point beyond bounds. | Canvas geometry and scroll shell | `UI_LOCAL` | Select/drag/clamp |
| Delete/reset/reopen | `[D]` Keyed controls and painter state expose mutation results. | Selection, closure, dirty state | `UI_LOCAL` | Delete; reset; reopen |
| Painter state | `[D]` Dynamic helpers read point and closure fields. | Private painter implementation | `ZERO_WRITE` | Closure, mutation, round-trip |
| Retention | `[D]` State is compared after Step 3 and back. | Navigation and progress | `UI_LOCAL` | Step 3 round-trip |
| Dirty cancellation | `[D]` Contour mutation precedes cancel dialog assertions. | Shared Step 1 helper | `UI_LOCAL` | Contour mutation cancellation |
| Progress/placeholders | `[D]` Closed Step 2 is complete; later placeholders are viewed. | Progress tiles and placeholder traversal | `ZERO_WRITE` | Progress; Steps 3–6 |
| Responsive layout | `[D]` Two view sizes exercise wide and compact Step 2. | Subject breakpoints and scroll | `ZERO_WRITE` | Wide 1440×900; compact 390×760 |
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
- `Step 3 round-trip retains contour points and closure`; and
- `contour mutation participates in dirty-draft cancellation`.

The remaining eighteen tests preserve shell/Step 1 fields and gates, honest
zero-write copy, Step 1 retention, placeholder traversal, multiline input,
three cancellation branches, mobile picker suppression, wide/compact
overflow, progress semantics, and absence of a creation route.

Key helpers are `_TestPlatformInfo`, `_buildWizardApp`, `_pumpFrames`,
`_enterText`, `_tapKey`, `_completeStepOne`, `_openContourStep`,
`_tapContourAt`, `_dragContourPoint`, painter inspection, `_addTriangle`, and
`_closeContour`.

## Dangerous combinations

- `[D]` Changing normalized helper geometry and subject hit testing together
  can make a broken drag appear correct.
- `[D]` Changing `_addTriangle`, `_closeContour`, and closure assertions
  together can hide the explicit close precondition.
- `[D]` Changing shared Step 1 setup and dirty-cancel assertions together can
  hide which mutation armed dirty state.
- `[D]` Changing painter internals and dynamic inspection together can erase
  closed-loop evidence.
- `[D]` Adding creator, filesystem, project-state, or canonical fixtures would
  weaken the explicit zero-write proof.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- One contour mutation test plus its keyed control/painter assertions.
- Drag/clamp only: `_dragContourPoint`, point inspection, and the matching
  subject geometry handlers.
- Closure gate only: `_addTriangle`, `_closeContour`, button state, and the
  explicit-closure test.
- Retention only: close, advance/back, and retained point/closure assertions.
- One responsive size only with explicit teardown.
- Step 1, cancellation, progress, or final-boundary regression only; preserve
  all contour helpers unless their contract changes.

## Future extraction seams

Descriptive, non-authorizing possibilities:

- `[S]` Canvas geometry helpers may be shared if normalized semantics and
  rendered-coordinate conversion remain explicit.
- `[S]` Painter inspection could use a public semantic seam only through a
  separately authorized production/test change.
- `[S]` Step setup helpers may be split if gate conditions remain independently
  visible.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helpers, keys, titles, routes, painter fields, or
screen anchors change; `FLOW_DRIFT` when Step 1/Step 2 setup, gestures,
mutation, closure, retention, or cancellation ordering changes;
`BOUNDARY_DRIFT` when persistent/canonical fixtures enter; `TEST_DRIFT` when
covered variants or assertions change; and `STRUCTURE_DRIFT` when the harness
or contour tests move to another file.

## Known uncertainty

- `[D]` `contour mutation participates in dirty-draft cancellation` is not
  independently regression-sensitive to the contour mutation because
  `_openContourStep` calls `_completeStepOne`, which already dirties Step 1.
  Production source independently proves add, move, delete, reset, and close
  set `_draftTouched`.
- `[D]` Responsive tests cover two fixed sizes, not every intermediate width or
  real touch/mouse device.
- `[D]` Dynamic painter inspection couples the suite to private painter field
  names even though it avoids a public production seam.
- `[D]` Zero-write is established by source/call-path inspection and reachable
  UI assertions, not by a filesystem monitor.
