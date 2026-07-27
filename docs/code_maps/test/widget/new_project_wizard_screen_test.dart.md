# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 6/12 — multi-family UI regression surface with protected-state fixtures`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

## File purpose

Exercises the current New Project Wizard through injected platform, picker,
and creator seams. It covers destination preconditions, blank optional-field
forwarding, successful provider/navigation behavior, selected typed failures,
sanitized error presentation, and the mobile picker gate. Its creator is a
fake, so the suite performs no project-directory, event-store, projection-file,
materializer, or other persistent write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Platform seam | `_TestPlatformInfo`, `isMobile` | Supplies deterministic mobile or non-mobile platform state. |
| Creator seam and request capture | `_FakeProjectCreator`, `createProject`, `requests` | Records submitted requests and returns a selected `ProjectCreationResult` without invoking real creation. |
| Picker seam | `_FakeDirectoryPicker`, `getDirectoryPath` | Supplies a deterministic directory through the default `FilePicker.platform` path. |
| In-memory project fixture | `_inlineProjectState` | Constructs a minimal `ProjectState` with configurable stale state. |
| Isolated widget/router harness | `_buildWizardApp` | Hosts only `/new-project` and injects creator, picker callback, and platform dependencies. |
| Destination precondition | `folder selection required before create` | Verifies create-before-selection feedback and absence of a creator request. |
| Success request and routing | `optional fields may be blank and create succeeds` | Uses the default picker/provider seams, captures blank fields, and observes `/project` and fresh-projection UI. |
| Failure presentation | `collision shows error`, `materializer failure shows sanitized message` | Verifies collision copy and sanitized materializer output without selected raw details. |
| Mobile picker gate | `mobile placeholder shown and directory picker is not opened` | Verifies the mobile folder action does not invoke the injected picker. |

## State and data flow

1. `[D]` Tests construct `_TestPlatformInfo` and `_FakeProjectCreator`; most
   inject a picker callback through `_buildWizardApp`.
2. `[D]` `_buildWizardApp` creates a `GoRouter` with only `/new-project`, then
   wraps it in `ProviderScope` and `MaterialApp.router`.
3. `[D]` Interactions use `wizard-pick-folder` and `wizard-create`.
4. `[D]` `_FakeProjectCreator.createProject` appends each submitted request to
   `requests` and returns its handler-provided result.
5. `[D]` The missing-destination test taps create without selecting a folder,
   then observes the location message and an empty request list.
6. `[D]` The success test replaces `FilePicker.platform`, overrides
   `projectCreatorProvider`, and uses `buildTraceBenchRouter` because success
   leaves `/new-project`.
7. `[D]` Its fake returns `_inlineProjectState(stale: false)`. The production
   branch installs that state and navigates; the test observes
   `BoardCanvasScreen`, `/project`, and no stale banner.
8. `[D]` Collision and materializer fakes select typed SnackBar branches. The
   latter test verifies the supplied traceback/path fragments are not shown.
9. `[D]` The mobile test taps only the folder action and proves its picker
   callback was not invoked.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `flutter_test` | outbound test driver | Pumps widgets, drives keyed actions, settles frames, and asserts visible state. |
| `package:flutter/material.dart` | outbound widget harness | Supplies `Widget`, `MaterialApp.router`, and `ValueKey` types used by the harness and interactions. |
| `NewProjectWizardScreen` | mapped subject | Supplies the widget and direct creator, picker, and platform injection seams. |
| `ProjectCreator` and creation results | outbound fake/contract dependency | Capture requests and select success or typed failure paths. |
| `PlatformInfo` and `FilePicker` | outbound test seams | Control the platform gate and default directory-picker path. |
| `GoRouter` and `buildTraceBenchRouter` | outbound navigation harness | Host isolated or full routes and expose the resulting path. |
| Riverpod and `projectCreatorProvider` | outbound dependency injection | Supply provider scope and replace the creator on the success path. |
| `ProjectManifest`, `KnownFacts`, `ProjectState` | outbound fixture models | Build the in-memory success result. |
| `BoardCanvasScreen`, `ProjectionStaleBanner` | outbound success observables | Confirm the current destination and fresh-projection presentation. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_FakeProjectCreator.createProject` and `requests` | `ZERO_WRITE` | Mutate only an in-memory test capture; the override prevents real creator filesystem and process behavior. |
| `FilePicker.platform` replacement | `ZERO_WRITE` | Mutates process-global test configuration with conditional teardown; it writes no selected directory. |
| `_inlineProjectState` | `ZERO_WRITE` | Constructs in-memory models; its known facts and events are fixture values, not persisted canonical data. |
| `_buildWizardApp` and route observation | `ZERO_WRITE` | Create and inspect transient test/router state only. |
| Successful create interaction | `PROJECTION_STATE` | Drives the production branch that installs fake-returned state in Riverpod; the suite does not materialize or persist it. |
| SnackBar observations | `UI_LOCAL` | Exercise transient message state only. |

No test invokes the real creator's directory, skeleton, materializer,
hydration, cleanup, event-store initialization, projection-file, schema, or
Project ZIP behavior.

## Zero-write zones

- `[D]` `_inlineProjectState` creates only in-memory model objects.
- `[D]` `_FakeProjectCreator` prevents real creation side effects.
- `[D]` Empty `events` and known-fact collections are fixture inputs.
- `[D]` `_TestPlatformInfo` and `_FakeDirectoryPicker` return configured
  values without operating on the host filesystem.
- `[D]` Finder expectations and route inspection do not persist state.
- `[D]` The suite contains no fact, writer, board, outline, component, or
  placement operation.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Platform seam | `[D]` `isMobile` controls the subject gate. | `_isMobile`, `_pickFolder`, `_createProject` | `ZERO_WRITE` | Mobile picker gate |
| Creator seam | `[D]` Captures requests and returns typed results. | Request contract and result switch | `ZERO_WRITE` | All except the picker-only mobile assertion |
| Picker seam | `[D]` Callbacks cover most tests; global picker covers success. | `_pickFolder`, selected-parent state | `ZERO_WRITE` | Success, collision, materializer failure, mobile |
| Project-state fixture | `[D]` Supplies the success result consumed by provider state. | `projectStateProvider`, Board Canvas, stale banner | `ZERO_WRITE`; triggered flow is `PROJECTION_STATE` | Success |
| Destination guard | `[D]` Missing selection sends no request. | `_selectedParentPath`, `_createProject`, `_showMessage` | `UI_LOCAL` | Missing destination |
| Success integration | `[D]` Captures blank fields and observes destination UI. | Provider override, router, Board Canvas | `ZERO_WRITE`; triggered flow is `PROJECTION_STATE` | Success |
| Failure presentation | `[D]` Typed results select collision and sanitized branches. | Result switch, SnackBar content | `UI_LOCAL` | Collision; materializer failure |

## Relevant tests and helpers

- `_TestPlatformInfo` supplies deterministic platform state.
- `_FakeProjectCreator` records calls and prevents real creation.
- `_FakeDirectoryPicker` exercises the default picker path.
- `_inlineProjectState` supplies a minimal in-memory project.
- `_buildWizardApp` supports flows that remain on `/new-project`.
- The five `testWidgets` cases cover the destination guard, blank-field
  success, collision, sanitized materializer failure, and mobile picker gate.

## Dangerous combinations

- `[D]` Changing request capture and blank-field assertions together can hide
  a forwarding regression.
- `[D]` Changing the global picker, provider override, and router harness
  together conflates dependency injection, global state, and routing.
- `[D]` `_buildWizardApp` declares no `/project`; using it for success would
  remove the current full-router coverage.
- `[D]` Changing `_inlineProjectState`, Board Canvas lookup, and stale-banner
  assertions together conflates provider assignment, navigation, and
  projection freshness.
- `[D]` Relaxing sanitized-copy assertions while changing raw fixtures can
  permit sensitive-looking process details to become visible.
- `[D]` Replacing the fake creator with the real service crosses persistent
  boundaries not owned by this widget suite.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Missing-destination assertion: the named test and `creator.requests`;
  exclude picker and success flow.
- Mobile picker gate: `_TestPlatformInfo`, `pickerOpened`, and the named test;
  exclude create submission.
- Collision copy: the collision test and `ProjectCreationCollision`.
- Sanitized materializer presentation: its result fixture and selected
  raw-fragment assertions; exclude creator process behavior.
- Blank-field forwarding: the captured request fields in the success test;
  inspect but exclude persistence contracts.
- Success destination observation: Board Canvas, `/project`, and stale-banner
  assertions; inspect provider/router coupling.

## Future extraction seams

Descriptive, non-authorizing possibilities:

- `[S]` Platform, creator, and picker doubles may be shareable if isolation is
  demonstrated.
- `[S]` `_inlineProjectState` may be shareable after its projection and stale
  assumptions are made explicit.
- `[S]` Full-router success and isolated failure setup may remain separate
  because their route requirements differ.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when named helpers, keys, tests, results, screens, or
banner anchors change; `FLOW_DRIFT` when injection, request capture, provider,
result, or navigation flow changes; `BOUNDARY_DRIFT` when real persistent work
enters the suite; `TEST_DRIFT` when covered variants or assertions change; and
`STRUCTURE_DRIFT` when the isolated/full-router harness split changes.
Formatting, imports, comments, and physical line movement alone do not stale
stable anchors.

## Known uncertainty

- `[D]` No test covers cancel navigation, selected-path rendering, separator
  display, picker cancellation, or an empty picker result.
- `[D]` No test covers busy controls, duplicate submission, `Loon...`, or
  completion after unmount.
- `[D]` No test covers invalid destination, Python-not-found,
  creator-returned mobile-placeholder, or generic failure results.
- `[D]` Success does not assert destination-path forwarding, nonblank optional
  values, or exact provider-state identity.
- `[D]` Only `stale: false` is exercised.
- `[D]` The mobile test covers only the folder action, not mobile submission.
- `[D]` Global picker restoration is conditional on a non-null original.
