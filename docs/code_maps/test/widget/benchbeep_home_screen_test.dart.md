# Code Map: `test/widget/benchbeep_home_screen_test.dart`

- Source: `test/widget/benchbeep_home_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 11/12 — broad launcher, acquisition, routing, projection-handoff, responsive, and protected-boundary regression surface with repeated whole-file analysis`
- Audit evidence: `docs/audit/TRACEBENCH_WIZARD_CREATION_WRITE_PATH_LOCK_PASS.md`

## File purpose

Exercises the BenchBeep launcher and real `TraceBenchApp` shell across new
project activation, injected creation, provider handoff, explicit Canvas
opening, bundled/folder/ZIP acquisition, responsive presentation, and exit
behavior. Its creation regression proves the app state is ready while the
Wizard remains on Step 7 and before the explicit `/project` transition.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Harness and project fixtures | `_FakeFilePicker`, `_homeHarness`, `_directoryBackedProjectState`, `_createdWizardProjectState` | Supplies picker seams, isolated Home construction, and noncanonical in-memory project states. |
| Launcher identity and create action | `BenchBeep Home is a black/gold board-selection launcher`, `new project action is enabled, unbadged, and invokes only its callback` | Preserves launcher identity and direct action-callback behavior. |
| Real Wizard route | `new project action opens the existing Wizard route`, `_expectCanonicalBoardCanvas` | Proves launcher-to-Wizard entry and the canonical Canvas destination helper. |
| Creation dependency injection | `injected create callback reaches the Wizard route`, `ProjectCreationRequest` | Proves the app passes the supplied creator into the real Wizard without invoking it early. |
| Provider-before-route handoff | `successful Wizard creation hands app state off before explicit Canvas open`, `_waitForProjectState` | Proves one creation, one provider assignment, persistent Step 7, and explicit later Canvas open. |
| Inert and continuation behavior | `launcher cannot continue without a loaded project` | Preserves disabled continuation until project state exists. |
| Bundled and directory acquisition | `launcher preserves bundled sample project handoff`, `launcher open folder success opens canonical board canvas`, `_waitForLoadedProject` | Covers existing-reader handoff and canonical routing. |
| ZIP acquisition | `launcher import project invokes existing ZIP flow directly`, `launcher ZIP success opens canonical board canvas` | Covers direct ZIP action ownership and successful route transition. |
| Responsive and exit behavior | `wide layout keeps choices left and stacks detail over hero`, `medium layout stacks the hierarchy with all actions reachable`, `exit dialog cancels safely and confirms exactly once` | Preserves desktop/medium geometry, reachability, and exit confirmation. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. The inventory has 21 unique anchors.

- Literal helper/type anchors: 8; each resolves as an exact source substring.
- Qualified member references: 0.
- Exact test-name references: 13; each resolves as the complete string first
  argument of one `testWidgets` declaration, including multiline calls.

## State and data flow

1. Isolated Home tests inject callback counters into `_homeHarness` and verify
   only the selected action fires.
2. Real-app tests create a `ProviderContainer` and render `TraceBenchApp`.
3. The create action opens `/new-project` while project state remains null.
4. The injection test inspects the mounted `NewProjectWizardScreen` and proves
   its `createProject` callback is the app-supplied function.
5. The success test completes the real Wizard draft, returns a fixture
   `ProjectCreationSuccess`, observes exactly one provider assignment, and
   remains on the success step at `/new-project`.
6. Only tapping the terminal open action transitions to canonical `/project`;
   creation and provider counts remain one.
7. Existing-project tests route bundled, directory, and ZIP loader results
   through the same app provider and Canvas destination.
8. Tear-down restores surface size, file-picker globals, subscriptions,
   containers, and temporary fixtures.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter test/Material | harness | Pumps widgets, controls view size, gestures, and assertions. |
| Riverpod | state observation | Creates isolated containers and observes `projectStateProvider`. |
| GoRouter | route observation | Reads mounted route paths and canonical destinations. |
| `TraceBenchApp` and `BenchBeepHomeScreen` | targets | Exercise the real shell and isolated launcher. |
| `NewProjectWizardScreen` and `BoardCanvasScreen` | route targets | Identify the new-project and canonical project destinations. |
| `ProjectCreator` types | fixture contract | Inject typed creation behavior without production filesystem writes. |
| `ProjectLoader`, archive, and file-picker seams | acquisition fixtures | Exercise existing ZIP/directory/bundled flows. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Creation fixture callback | `ZERO_WRITE` | Returns an in-memory `ProjectState` and performs no creator/file operation. |
| `projectStateProvider` observations | `PROJECTION_STATE` | Verify in-memory assignment and identity only. |
| Route gestures | `UI_LOCAL` | Change mounted URI/presentation only. |
| ZIP/directory temporary fixtures | `NONCANONICAL_FILE` | Test-owned disposable input; production read paths remain the subject. |
| Launcher callback counters | `UI_LOCAL` | Count invocation in test memory. |

The creation tests add no event, fact, component, placement, measurement,
evidence, diagnosis, or electrical data. They distinguish app projection
handoff from persistent creation ownership and retain existing Project ZIP
reader boundaries.

## Zero-write zones

- Visual/layout, hover, action availability, injected-callback inspection,
  route observation, disabled continuation, and exit-cancel assertions are
  test-local.
- The created Wizard project fixture contains empty canonical arrays and
  events.
- The provider-handoff test never invokes production `ProjectCreator`.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Harness/fixtures | [D] Shared setup feeds many families. | file picker, provider, router | test-local | all route/acquisition tests |
| New-project action | [D] Direct callback and real route are separate tests. | Home action model and app shell | `UI_LOCAL` | create action and route tests |
| Injection | [D] Mounted Wizard callback identity is asserted. | `TraceBenchApp.createProject` | `ZERO_WRITE` | injected callback test |
| Provider handoff | [D] subscription and identity assertions are explicit. | Wizard success latch and app provider | `PROJECTION_STATE` | successful Wizard creation test |
| Existing acquisition | [D] reader results enter the provider. | ZIP/directory loaders | `PROJECTION_STATE` | bundled/folder/ZIP tests |
| Responsive launcher | [D] controlled surface sizes verify layout. | Home breakpoints and action reachability | `ZERO_WRITE` | wide/medium tests |
| Exit | [D] callback count and dialog behavior are asserted. | window-manager callback | `ZERO_WRITE` | exit test |

## Relevant tests and helpers

The source itself is the focused suite: 20 `testWidgets` tests across launcher,
creation, acquisition, routing, layout, hover, legacy-anchor, and exit
families. `_FakeFilePicker` captures picker requests;
`_waitForProjectState` and `_waitForLoadedProject` bound asynchronous reads;
`_createdWizardProjectState` provides the successful noncanonical intake
fixture; and `_expectCanonicalBoardCanvas` centralizes the `/project`
assertion.

Complementary exact creation-state-machine coverage lives in
`test/widget/new_project_wizard_screen_test.dart`.

## Dangerous combinations

- Weakening the creation count while changing provider assertions can hide a
  duplicate handoff.
- Auto-opening Canvas in the success test would erase the terminal Step 7
  contract.
- Using production `ProjectCreator` in this widget suite would mix storage
  behavior into app handoff evidence.
- Failing to restore `FilePicker.platform` or surface size can leak global
  state into unrelated tests.
- Combining ZIP fixture changes with new-project behavior can blur read versus
  create ownership.

## Safe SNIPER slices

- Isolated launcher action only: `_homeHarness` and one callback test.
- Creation injection only: real app entry plus mounted callback identity.
- Provider handoff only: successful Wizard test, retaining one-call and
  pre-route assertions.
- One acquisition route only: its picker/fixture and canonical Canvas helper.
- One responsive breakpoint only: surface setup, layout assertion, teardown.

## Future extraction seams

- [S] Acquisition-heavy tests could move to a dedicated app-acquisition suite
  if shared launcher and provider assertions stay visible.
- [S] Repeated real-app startup could use a named harness if it retains exact
  provider-container and global teardown ownership.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helpers, callbacks, keys, or target screens
change; `FLOW_DRIFT` when create/provider/navigation order changes;
`BOUNDARY_DRIFT` when tests begin invoking persistent creation or weaken
canonical emptiness; `TEST_DRIFT` when the 20-test family changes; and
`STRUCTURE_DRIFT` when app/launcher acquisition tests split.

## Known uncertainty

- [D] The app-side exactly-once claim is observed through one provider
  subscription plus Wizard callback coverage, not production instrumentation.
- [D] The success fixture proves handoff and navigation, not filesystem
  creation; storage is owned by unit tests.
- [P] Window-manager integration itself is represented by an injected
  callback rather than a real desktop window close.
