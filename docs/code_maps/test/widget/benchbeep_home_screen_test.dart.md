# Code Map: `test/widget/benchbeep_home_screen_test.dart`

- Source: `test/widget/benchbeep_home_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 11/12 — broad launcher, acquisition, routing, projection-handoff, responsive, and protected-boundary regression surface with repeated whole-file analysis`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECT_SESSION_OWNER_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Exercises the BenchBeep launcher and real `TraceBenchApp` shell across new-
project entry, one-router identity, Wizard cancellation and guarded creation
handoff, generation-safe bundled/folder/ZIP acquisition, explicit Workbench
Home close with beginner-mode survival, responsive presentation, and exit
behavior. It preserves the creation ordering in which session state is ready
on Step 7 before the Wizard's explicit `/project` action.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Harness and project fixtures | `_FakeFilePicker`, `delayedResult`, `_homeHarness`, `_directoryBackedProjectState`, `_createdWizardProjectState`, `SeededProjectSession` | Supplies immediate/delayed picker seams, isolated Home construction, and seeded in-memory sessions. |
| Launcher identity and create action | `BenchBeep Home is a black/gold board-selection launcher`, `new project action is enabled, unbadged, and invokes only its callback` | Preserves launcher identity and direct action-callback behavior. |
| Router identity and cancel return | `new project action opens the existing Wizard route`, `benchbeep_workbench_router`, `wizard-cancel` | Proves canonical `/`, one router through `/new-project`, and return to the same launcher/router at `/`. |
| Guarded creation injection | `injected create callback is session-guarded on the Wizard route`, `ProjectCreationRequest` | Proves the mounted Wizard receives the app wrapper rather than the raw creator and does not invoke it early. |
| Session-before-route handoff | `successful Wizard creation hands app state off before explicit Canvas open`, `stale Wizard success cannot replace a newer session`, `_prepareValidWizardCreation`, `_waitForProjectState` | Proves accepted Step-7 session installation and explicit later Canvas open, while a stale creator completion preserves the newer session and reports sanitized failure. |
| Loaded entry and explicit Home close | `loaded project keeps direct board canvas handoff`, `Workbench Home clears project while beginner mode survives`, `projectStateProvider`, `beginnerModeProvider`, `_expectCanonicalBoardCanvas` | Seeds a loaded session, enters Canvas, then proves Home clears only project state while the router and beginner mode survive. |
| Inert continuation behavior | `launcher cannot continue without a loaded project` | Preserves disabled continuation until project state exists. |
| Bundled, directory, and ZIP acquisition | `launcher preserves bundled sample project handoff`, `stale bundled load cannot replace a newer generation`, `launcher open folder success opens canonical board canvas`, `stale directory load cannot replace or navigate`, `launcher import project invokes existing ZIP flow directly`, `launcher ZIP success opens canonical board canvas`, `stale ZIP import cannot replace or navigate`, `_waitForLoadedProject` | Covers success/failure/cancel plus stale-generation suppression of state replacement and navigation. |
| Responsive, hover, legacy-absence, and exit behavior | `wide layout keeps choices left and stacks detail over hero`, `medium layout stacks the hierarchy with all actions reachable`, `launcher action hover uses subtle gold accent`, `launcher has no hidden legacy compatibility anchors`, `exit dialog cancels safely and confirms exactly once` | Preserves desktop/medium geometry, reachability, hover treatment, removed legacy anchors, and exit confirmation. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Helper, key, provider, and test-title
anchors resolve as exact substrings in committed source. Exact test titles are
the complete string argument of one `testWidgets` declaration; the map uses no
line-number anchors.

## State and data flow

1. Isolated Home tests inject callback counters into `_homeHarness` and verify
   that only the selected action fires.
2. Real-app tests create a `ProviderContainer`, render `TraceBenchApp`, and
   obtain the startup `GoRouter` from the canonical launcher at `/`.
3. New Project entry reaches `/new-project` on that same router. Wizard cancel
   returns to `/` with the identical router instance.
4. The injection test proves the mounted Wizard receives a session-guarding
   app adapter rather than the raw injected creator.
5. The success test completes the real Wizard draft, returns a fixture
   `ProjectCreationSuccess`, observes exactly one session assignment while
   still at `/new-project`, then explicitly opens `/project` on the same router;
   a delayed stale success cannot replace a newer session.
6. Loaded-entry tests seed `SeededProjectSession` and false beginner mode,
   enter `/project`, then activate Workbench Home. Project state clears while
   beginner mode and the lifetime router survive at `/`.
7. Existing-project tests route generation-current bundled, directory, and ZIP
   results to Canvas; delayed stale completions preserve the newer/null session
   and do not invoke success navigation.
8. Tear-down restores surface size, file-picker globals, subscriptions,
   provider containers, and temporary fixtures.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter test/Material | harness | Pumps widgets, controls view size, drives gestures, and inspects callbacks/presentation. |
| Riverpod / `SeededProjectSession` | state setup/observation | Creates isolated containers, seeds loaded sessions, and observes project/beginner providers. |
| GoRouter | lifecycle/route observation | Reads router identity and canonical URI through launcher, Wizard, Home return, and Canvas re-entry. |
| `TraceBenchApp` and `BenchBeepHomeScreen` | targets | Exercise the real single-router shell and isolated launcher. |
| `NewProjectWizardScreen` and `BoardCanvasScreen` | route targets | Identify `/new-project` and canonical `/project`. |
| `ProjectCreator` types | fixture contract | Inject typed creation behavior without production filesystem writes. |
| `ProjectLoader`, archive, and file-picker seams | acquisition fixtures | Exercise existing ZIP/directory/bundled read flows. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Creation fixture callback | `ZERO_WRITE` | Returns an in-memory `ProjectState` and performs no creator/file operation. |
| Session setup and observations | `PROJECTION_STATE` | Seed and verify guarded in-memory open/close/replacement behavior only. |
| Router identity and route gestures | `UI_LOCAL` | Navigate mounted presentation without router replacement or canonical mutation. |
| ZIP/directory temporary fixtures | `NONCANONICAL_FILE` | Test-owned disposable input; production read paths remain the subject. |
| Launcher callback counters | `UI_LOCAL` | Count invocation in test memory. |

The suite adds no event, fact, component, placement, measurement, evidence,
diagnosis, or electrical data. It distinguishes app projection handoff from
persistent creation ownership and retains existing Project ZIP reader
boundaries.

## Zero-write zones

- Visual/layout, hover, action availability, callback inspection, router
  identity, route observation, disabled continuation, and exit-cancel
  assertions are test-local.
- The created Wizard fixture contains empty canonical arrays and events.
- The provider-handoff test never invokes production `ProjectCreator`.
- Loaded Home state is seeded through the test-only session helper; production
  exposes no test-seeding API.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Harness/fixtures | [D] Shared setup feeds many families. | file picker, provider, router | test-local | route, handoff, and acquisition tests |
| Router identity/cancel | [D] `same` compares launcher, Wizard, and returned Home routers. | app initialization/disposal and Wizard cancel | `UI_LOCAL` | New Project route test |
| Injection | [D] Mounted Wizard wrapper identity differs from the raw creator. | `TraceBenchApp._createProject` | `ZERO_WRITE` | guarded callback test |
| Wizard handoff | [D] accepted/stale state, route, and router assertions are explicit. | Wizard latch, app adapter, ProjectSession | `PROJECTION_STATE` / `UI_LOCAL` | successful and stale creation tests |
| Home close | [D] project null and beginner false are checked after Workbench Home. | shell close-before-go and launcher availability | `PROJECTION_STATE` / `UI_LOCAL` | loaded-entry and explicit-close tests |
| Existing acquisition | [D] accepted/stale reader results are distinguished. | ZIP/directory loaders, neutral actions, ProjectSession | observed `PROJECTION_STATE` | bundled/folder/ZIP success and stale tests |
| Responsive/hover/legacy | [D] controlled surfaces and exact UI anchors are asserted. | Home breakpoints/presentation | `ZERO_WRITE` | wide, medium, hover, legacy-absence tests |
| Exit | [D] callback count and dialog behavior are asserted. | window-manager callback | `ZERO_WRITE` | exit test |

## Relevant tests and helpers

The source contains 25 `testWidgets` tests across launcher identity/actions,
single-router navigation, guarded Wizard handoff, loaded-state Home close,
accepted/stale acquisition, layout, hover, legacy absence, and exit families.
`_FakeFilePicker` captures picker requests; `_waitForProjectState` and
`_waitForLoadedProject` bound asynchronous reads;
`_createdWizardProjectState` provides the successful noncanonical intake
fixture; and `_expectCanonicalBoardCanvas` centralizes `/project` assertions.

Complementary lifecycle/timing evidence lives in
`test/widget/benchbeep_splash_screen_test.dart`; exact Wizard cancellation,
success latch, persistent Step 7, and explicit route coverage lives in
`test/widget/new_project_wizard_screen_test.dart`; canonical Home recovery and
the full gated route matrix live in `test/widget/project_gate_test.dart`.

## Dangerous combinations

- Replacing `same` router checks with URI-only assertions can hide router
  reconstruction.
- Weakening creation counts or generation assertions while changing route
  checks can hide duplicate/stale handoff or early Canvas transition.
- Seeding project state without `SeededProjectSession` would bypass the
  production Notifier contract the suite is meant to exercise.
- Using production `ProjectCreator` would mix storage behavior into app
  handoff evidence.
- Failing to restore `FilePicker.platform` or surface size can leak state into
  unrelated tests.
- Combining ZIP fixture changes with new-project behavior can blur read versus
  create ownership.

## Safe SNIPER slices

- Router identity/cancel only: the real-app startup and New Project route test.
- Creation injection only: mounted wrapper identity on the Wizard route.
- Session-before-route only: successful and stale Wizard tests, retaining
  one-call, Step 7, URI, generation, and router assertions.
- Home close only: loaded-project entry plus explicit project-null and
  beginner-mode-survival assertions.
- One acquisition route only: its picker/fixture, current/stale generation,
  and navigation/result assertions.
- One responsive or exit behavior with its exact setup/teardown.

## Future extraction seams

- [S] Acquisition-heavy tests could move to a dedicated app-acquisition suite
  if shared launcher and provider assertions remain visible.
- [S] Repeated real-app startup could use a named harness if it retains exact
  provider-container, router-observation, and teardown ownership.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helpers, callback keys, providers, or target
screens change; `FLOW_DRIFT` when router identity, Home return, creation,
session generation/open/close, or navigation order changes; `BOUNDARY_DRIFT` when tests invoke
persistent creation or weaken canonical emptiness; `TEST_DRIFT` when the 25-
test family changes; and `STRUCTURE_DRIFT` when lifecycle or acquisition tests
split.

## Known uncertainty

- [D] App-side accepted/stale handoff is observed through provider state,
  generation-sensitive scenarios, and Wizard callback coverage, not production
  instrumentation.
- [D] Router disposal cardinality is source-guarded in the splash suite rather
  than directly counted here.
- [D] The success fixture proves projection handoff and navigation, not
  filesystem creation.
- [P] Window-manager integration is represented by an injected callback rather
  than a real desktop close.
