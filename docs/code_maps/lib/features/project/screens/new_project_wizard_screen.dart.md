# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

## File purpose

Owns the current single-screen new-project form. It selects a parent
directory, captures three optional text fields, delegates project creation to
`ProjectCreator`, projects the returned success into in-memory application
state and navigation, and presents typed failures as transient messages. It
does not implement the filesystem, materializer, event, or projection writes
performed behind the creator boundary.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Creator provider and injection seams | `projectCreatorProvider`, `NewProjectWizardScreen`, `createState` | Supplies the default creator and optional creator, picker, and platform test seams. |
| Form and transient state lifecycle | `_deviceTypeController`, `_modelController`, `_symptomController`, `_selectedParentPath`, `_isSubmitting`, `dispose` | Owns input controllers, selected-parent state, submit state, and controller disposal. |
| Platform capability gate | `_isMobile`, `DefaultPlatformInfo` | Resolves the injected or default platform and gates both picker and submit entry points. |
| Directory selection | `_pickFolder`, `directoryPicker`, `FilePicker.platform.getDirectoryPath` | Opens the selected picker seam and stores a nonblank returned parent path after a mounted check. |
| Creation request and submission | `_createProject`, `ProjectCreationRequest`, `ProjectCreator.createProject` | Enforces preconditions, locks controls, forwards the selected path and controller text, and awaits the creator result. |
| Success projection and routing | `ProjectCreationSuccess`, `projectStateProvider`, `context.go('/project')` | Installs the returned project state and navigates to the current project destination. |
| Failure and capability feedback | `ProjectCreationCollision`, `ProjectCreationInvalidDestination`, `ProjectCreationPythonNotFound`, `ProjectCreationMaterializerFailed`, `ProjectCreationMobilePlaceholder`, `ProjectCreationFailed`, `_showMessage` | Maps each typed non-success result to current user-visible SnackBar copy. |
| Rendering and interaction locking | `build`, `wizard-pick-folder`, `wizard-create`, `wizard-cancel` | Renders the form, selected path, create/cancel actions, and disables all actions while submitting. |

## State and data flow

1. `[D]` The widget may receive creator, picker, and platform overrides;
   otherwise Riverpod, `FilePicker.platform`, and `DefaultPlatformInfo` supply
   them.
2. `[D]` The three controllers and `_selectedParentPath` hold transient form
   state. `_isSubmitting` controls action availability and create-button copy.
3. `[D]` `_pickFolder` rejects mobile use with a SnackBar, awaits the picker,
   checks `mounted`, ignores null or whitespace-only results, and stores the
   returned path without rewriting it.
4. `[D]` `build` replaces the host path separator only for display. The raw
   selected path remains the value forwarded to the creator.
5. `[D]` `_createProject` rejects mobile use and a missing or blank selected
   parent before invoking `ProjectCreator`.
6. `[D]` A valid submission sets `_isSubmitting`, resolves the injected or
   provided creator, and builds `ProjectCreationRequest` from the selected path
   and the three unnormalized controller strings.
7. `[D]` After the creator completes, a mounted check precedes clearing the
   submit flag and routing the sealed result.
8. `[D]` Success assigns the returned `ProjectState` to
   `projectStateProvider` before navigating to `/project`.
9. `[D]` Every current non-success subtype displays either fixed screen copy or
   the subtype's `sanitizedMessage`; raw failure detail is not read here.
10. `[D]` Cancel navigates to `/` only while controls are enabled.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework and UI state | Provides the stateful screen, controllers, form widgets, buttons, and SnackBars. |
| Riverpod | inbound construction and outbound state | Supplies the default creator and receives the successful `ProjectState`. |
| `FilePicker` | outbound picker service | Selects a parent directory when no picker callback is injected. |
| `Platform` | outbound display utility | Supplies the host separator used only to normalize displayed path text. |
| `PlatformInfo` | inbound capability service | Supplies the mobile/non-mobile gate. |
| `ProjectCreator` and creation result hierarchy | outbound service boundary | Accept the request and return success or a typed failure. |
| `projectStateProvider` | outbound in-memory state | Receives the successful project state before navigation. |
| `GoRouter` | outbound UI navigation | Routes success to `/project` and cancel to `/`. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controllers, `_selectedParentPath`, `_isSubmitting` | `UI_LOCAL` | Mutate only transient widget state. |
| `_pickFolder` | `UI_LOCAL` | Stores a selected path; it does not create or modify the selected directory. |
| `_createProject` → `ProjectCreator.createProject` | `CANONICAL_EVENT` + `NONCANONICAL_FILE` + `PROJECTION_STATE` | The direct call crosses into the maintained creator map's empty event-store initialization, bootstrap-file, materializer, and cleanup boundaries; this screen owns none of those writes. |
| Success → `projectStateProvider` | `PROJECTION_STATE` | Replaces in-memory application project state with the creator-returned state; it does not persist that state. |
| `_showMessage` | `UI_LOCAL` | Mutates transient SnackBar state only. |
| `context.go` | `ZERO_WRITE` | Navigates without writing persistent project state. |
| `_isMobile`, request validation, and `build` | `ZERO_WRITE` | Read capability/form state and render or branch without persistent mutation. |

The file contains no canonical event append, fact creation, schema mutation,
materializer implementation, Project ZIP operation, board/outline/component/
placement write, or direct filesystem write. Creator-side changes require
their own authority and source evidence.

## Zero-write zones

- `[D]` `projectCreatorProvider` constructs a service but performs no creation
  until `_createProject` calls it.
- `[D]` `_isMobile` reads a capability flag only.
- `[D]` Destination validation precedes the creator call.
- `[D]` Display-only path separator replacement does not alter the forwarded
  path.
- `[D]` `build` renders current state and keys without persistent writes.
- `[D]` `dispose` releases controllers and does not persist their values.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Injection seams | `[D]` Widget overrides and provider fallback select dependencies. | `_pickFolder`, `_createProject`, focused fakes | `ZERO_WRITE` | All focused widget tests |
| Form and destination state | `[D]` Controllers and selected path feed the request and rendering. | `build`, `ProjectCreationRequest` | `UI_LOCAL` | Missing destination; blank optional fields |
| Platform and picker gate | `[D]` `_isMobile` guards picker and submit; picker stores the returned path. | `PlatformInfo`, `FilePicker`, feedback | `UI_LOCAL` | Mobile picker gate; success; collision; materializer failure |
| Submission coordinator | `[D]` `_createProject` owns guards, busy state, request forwarding, and the service call. | Creator contract, mounted checks, result switch | `UI_LOCAL`; service call crosses `CANONICAL_EVENT`, `NONCANONICAL_FILE`, `PROJECTION_STATE` | Missing destination; success; collision; materializer failure |
| Success projection and route | `[D]` Provider assignment precedes `/project`. | App router, project destination UI | `PROJECTION_STATE` + `ZERO_WRITE` | Blank optional fields and success |
| Failure feedback | `[D]` Sealed result cases choose fixed or sanitized copy. | Creator result hierarchy, SnackBar | `UI_LOCAL` | Collision; sanitized materializer failure |
| Render and cancel controls | `[D]` `_isSubmitting` disables picker/create/cancel and changes copy. | Submit lifecycle, `/` route | `UI_LOCAL` + `ZERO_WRITE` | No direct busy/cancel coverage |

## Relevant tests and helpers

Primary focused suite:
`test/widget/new_project_wizard_screen_test.dart`.

- `folder selection required before create` covers the missing-parent guard.
- `optional fields may be blank and create succeeds` covers the default picker,
  blank-field forwarding, project destination, and fresh-projection UI.
- `collision shows error` covers collision feedback.
- `materializer failure shows sanitized message` covers sanitized display and
  selected raw-detail suppression.
- `mobile placeholder shown and directory picker is not opened` covers only
  the mobile picker gate.

The suite supplies `_TestPlatformInfo`, `_FakeProjectCreator`,
`_FakeDirectoryPicker`, `_inlineProjectState`, and `_buildWizardApp`.
The maintained `ProjectCreator` map is inspect-only coupled evidence for the
delegated creation boundary.

## Dangerous combinations

- `[D]` Changing raw path forwarding and display normalization together can
  accidentally turn presentation cleanup into filesystem input rewriting.
- `[D]` Changing `_isSubmitting`, mounted checks, and async result handling
  together can permit duplicate calls, stuck controls, or state updates after
  disposal.
- `[D]` Changing provider assignment and success navigation together can route
  before the current project state is available.
- `[D]` Changing the creator result hierarchy and the switch together can lose
  exhaustive typed feedback or expose non-sanitized detail.
- `[D]` Changing optional-field forwarding together with creator normalization
  crosses the UI/service ownership boundary.
- `[D]` Changing platform gating and dependency fallback together can invoke a
  picker or creator on an unsupported platform.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Mobile picker gate only: `_isMobile`, the first `_pickFolder` branch, and
  `_showMessage`; run the mobile picker test and exclude submission.
- Missing-destination guard only: the pre-creator branch of `_createProject`;
  run the required-selection test and exclude picker, creator, and routing.
- Collision copy only: the `ProjectCreationCollision` case and `_showMessage`;
  run the collision test and exclude all creator behavior.
- Sanitized materializer display only: the
  `ProjectCreationMaterializerFailed` case; run its focused test and exclude
  process/materializer ownership.
- Success state/routing only: the success case, provider assignment, and
  `/project`; run the success test and inspect creator-result coupling.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Typed result-to-message selection may be separable from submission.
- `[S]` Directory selection may be separable behind its existing callback
  seam.
- `[S]` Form rendering may be separable from creation coordination if
  controller ownership and submit locking remain explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when named widget, state, provider, picker, request,
result, or key anchors change; `FLOW_DRIFT` when picker, submit, mounted-check,
provider, or navigation order changes; `BOUNDARY_DRIFT` when persistent work
moves into this file or creator-side ownership changes; `TEST_DRIFT` when
covered result branches, request fields, or navigation assertions change; and
`STRUCTURE_DRIFT` when responsibility zones move between widgets or services.
Formatting, imports, comments, and physical line movement alone do not stale
stable anchors.

## Known uncertainty

- `[D]` No focused test covers picker cancellation after opening, blank picker
  output, selected-path rendering, separator display, or cancel navigation.
- `[D]` No focused test covers submit locking, `Loon...`, duplicate submit, or
  completion after unmount.
- `[D]` No focused test covers nonblank optional-field forwarding.
- `[D]` No focused test covers `ProjectCreationInvalidDestination`,
  `ProjectCreationPythonNotFound`, creator-returned
  `ProjectCreationMobilePlaceholder`, or generic `ProjectCreationFailed`.
- `[D]` The success test does not directly assert destination-path forwarding
  or exact provider-state identity.
- `[P]` Router behavior outside the observed `/`, `/new-project`, and
  `/project` paths is outside this map.
