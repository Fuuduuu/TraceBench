# Code Map: `test/widget/new_project_wizard_screen_test.dart`

- Source: `test/widget/new_project_wizard_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 6/12 — multi-family responsive/navigation regression surface`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md`

## File purpose

Exercises the accepted six-step zero-write New Project Wizard through injected
platform and picker seams. Its eighteen widget tests cover exact Estonian
labels, Step 1 fields and gates, selected-path safety copy, navigation and draft
retention, placeholder honesty, cancellation, responsive layout, progress
semantics, and the absence of any creator/project-state/final-create path. The
suite performs no project-directory, event, fact, projection, materializer,
ZIP, or other persistent write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Platform seam | `_TestPlatformInfo`, `isMobile` | Supplies deterministic mobile or non-mobile platform state. |
| Picker seam | `_buildWizardApp`, `directoryPicker`, local `pickerOpened` | Injects deterministic picker closures and proves the mobile gate suppresses picker invocation. |
| Isolated route harness | `_buildWizardApp`, `GoRouter`, `/`, `/new-project` | Hosts only Home and Wizard routes and injects picker/platform dependencies. |
| Interaction helpers | `_pumpFrames`, `_enterText`, `_tapKey`, `_completeStepOne` | Pump bounded frames, drive stable widget keys, and populate the complete Step 1 draft without advancing the Wizard. |
| Shell and field contract | six-step and four-field tests | Verifies exact labels and locked Step 1 inputs. |
| Gate and path contract | disabled-gate tests, valid advance, path/copy test | Proves the name/path preconditions, raw selected-path display, and honest zero-write copy. |
| Navigation and placeholder contract | retention, placeholder, multiline tests | Proves draft preservation, Steps 2–6 visibility, and multiline input behavior. |
| Cancellation contract | untouched, dirty, continue, confirmed-cancel tests | Covers direct Home return and both dialog outcomes. |
| Responsive contract | wide desktop and compact no-overflow tests | Exercises both product layout branches without Flutter exceptions. |
| Progress semantics | `progress distinguishes completion from viewed placeholders` | Proves only completed Step 1 is `Valmis` and visited placeholder steps are `Vaadatud`. |
| Protected boundary | `no creator, project-state, or project-route action is reachable` | Traverses to Step 6 and proves no create CTA or `/project` transition exists. |

## State and data flow

1. `[D]` Tests construct `_TestPlatformInfo` and pass deterministic
   `directoryPicker` closures through `_buildWizardApp`.
2. `[D]` `_buildWizardApp` creates a `GoRouter` with `/` and `/new-project`,
   starts at `/new-project`, and renders `NewProjectWizardScreen`.
3. `[D]` `_completeStepOne` uses `_enterText` for project name, device name,
   and additional information, then uses `_tapKey` on `wizard-pick-folder`.
   Tests that advance invoke `_tapKey` on `wizard-next` separately.
4. `[D]` Shell tests assert the six exact labels and the four Step 1 controls.
5. `[D]` Gate tests vary project name and selected path independently and
   inspect `wizard-next.onPressed`.
6. `[D]` The path/copy test selects a folder, asserts the returned path, and
   verifies final creation is not implemented and selection creates no folder
   or file.
7. `[D]` Retention tests populate all fields, navigate forward/back, and prove
   every value plus the selected path remains.
8. `[D]` Placeholder traversal advances through Steps 2–6, verifies each
   keyed placeholder and honest copy, and proves no next action on Step 6.
9. `[D]` Cancellation tests observe the router at `/` only for untouched or
   confirmed cancellation; continue leaves the draft and current step intact.
10. `[D]` Responsive tests set wide and compact view sizes and assert no
    exception before resetting the view in teardown.
11. `[D]` Progress tests inspect status text within keyed progress tiles while
    advancing through placeholders.
12. `[D]` The final boundary test traverses the Wizard and proves creator,
    project-state, create-action, and `/project` observables are absent.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `flutter_test` | test driver | Pumps widgets, drives keyed actions, changes view size, and asserts visible state. |
| Flutter Material | widget harness | Supplies `MaterialApp.router`, fields, buttons, labels, and keys. |
| `NewProjectWizardScreen` | mapped subject | Supplies the widget plus picker and platform injection seams. |
| `PlatformInfo` | outbound test seam | Controls the mobile capability gate. |
| GoRouter | outbound navigation harness | Hosts `/` and `/new-project` and exposes the resulting path. |

There is no Riverpod, `ProjectCreator`, `ProjectCreationRequest`,
`projectStateProvider`, project-model, Board Canvas, or materializer fixture.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Injected `directoryPicker` closures and local `pickerOpened` | `ZERO_WRITE` | Return configured strings or observe whether the mobile-gated picker was invoked; they perform no filesystem work. |
| `_TestPlatformInfo` | `ZERO_WRITE` | Returns a configured capability flag only. |
| `_buildWizardApp` and route observation | `ZERO_WRITE` | Create and inspect transient test/router state only. |
| `_pumpFrames`, `_enterText`, `_tapKey`, `_completeStepOne`, view changes, and navigation | `UI_LOCAL` | Mutate widget/test presentation state and reset viewport state through teardown. |
| Cancellation and progress observations | `ZERO_WRITE` | Drive transient UI/router state without project persistence. |

No test invokes a real or fake creator, constructs a creation request, assigns
application project state, writes a directory/file, appends a canonical
event/fact, runs a materializer, writes a projection, or creates Project ZIP
output.

## Zero-write zones

- `[D]` Injected `directoryPicker` closures return configured paths without
  operating on the host filesystem.
- `[D]` The mobile test's local `pickerOpened` boolean proves the picker
  closure remains uninvoked.
- `[D]` `_TestPlatformInfo` is a pure capability value.
- `[D]` The router harness contains only transient Home/Wizard destinations.
- `[D]` Finder, copy, geometry, semantics, and route expectations persist
  nothing.
- `[D]` Every draft value remains inside the widget under test.
- `[D]` Step 6 has no create action, creator seam, project state, or `/project`
  destination.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Platform seam | `[D]` `isMobile` controls picker availability. | Subject `_isMobile`, `_pickFolder` | `ZERO_WRITE` | Mobile picker test |
| Picker seam | `[D]` Injected closures provide the selected path; local `pickerOpened` proves mobile suppression. | Subject picker state and gate | `ZERO_WRITE` | Path/copy, gate, retention, traversal, and mobile tests |
| Route harness | `[D]` Only `/` and `/new-project` exist. | Subject cancellation | `ZERO_WRITE` | All cancellation and no-project-route tests |
| Step shell and fields | `[D]` Exact labels/keys define accepted UI. | `_wizardSteps`, `_buildStepOne` | `ZERO_WRITE` | Shell and four-field tests |
| Step 1 gate | `[D]` Name and path are tested independently. | `_canAdvanceFromStepOne`, action bar | `UI_LOCAL` | Two disabled tests and valid advance |
| Draft retention | `[D]` Values survive step rebuilds. | Controllers, selected path, navigation | `UI_LOCAL` | Back/forward retention |
| Placeholder/final boundary | `[D]` Traversal observes copy and no final action. | `_buildPlaceholder`, action bar | `ZERO_WRITE` | Steps 2–6; protected boundary |
| Cancellation | `[D]` Dirty state selects dialog and route outcomes. | `_draftTouched`, `_cancelWizard` | `UI_LOCAL`; `ZERO_WRITE` | Untouched, continue, confirm |
| Responsive layout | `[D]` View size drives wide/compact branches. | Subject `LayoutBuilder`s | `ZERO_WRITE` | Wide and compact no-overflow |
| Progress status | `[D]` Keyed tiles distinguish functional completion from viewing. | `_buildProgressTile` | `ZERO_WRITE` | Progress semantics |

## Relevant tests and helpers

The eighteen `testWidgets` cases cover:

- exact six-step labels;
- all four Step 1 fields;
- missing-name and missing-path gate halves;
- valid advance and selected-path/zero-write copy;
- full Step 1 draft retention;
- visible non-functional Steps 2–6;
- multiline additional information;
- untouched, continue, and confirmed cancellation;
- mobile picker suppression;
- wide and compact no-overflow behavior;
- `Valmis` versus `Vaadatud`; and
- absence of creator, project state, create CTA, and `/project`.

Key helpers are `_TestPlatformInfo`, `_buildWizardApp`, `_pumpFrames`,
`_enterText`, `_tapKey`, and `_completeStepOne`. `_completeStepOne` enters
project name, device name, and additional information, then taps
`wizard-pick-folder`; it deliberately does not tap `wizard-next`.

## Dangerous combinations

- `[D]` Changing helper setup and gate assertions together can hide a required
  field regression.
- `[D]` Changing the route harness and cancellation assertions together can
  conceal unwanted persistence or destination behavior.
- `[D]` Changing draft-entry helpers and retention expectations together can
  erase evidence of a lost field.
- `[D]` Changing placeholder traversal and progress assertions together can
  relabel viewed non-functional steps as complete.
- `[D]` Changing view sizes and overflow expectations together can miss a
  responsive breakpoint regression.
- `[D]` Adding a creator fake or project-state fixture would weaken the explicit
  proof that no creation path is reachable.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- One gate half: the relevant field setup and disabled-button assertion;
  exclude picker or route changes.
- Safety copy only: the selected-path/copy test and `_WizardSafetyCard`;
  exclude navigation semantics.
- Draft retention only: `_completeStepOne`, explicit forward/back key taps, and
  value assertions.
- Cancellation only: the three cancellation tests and isolated route harness.
- Progress semantics only: keyed progress tiles and the
  `Valmis`/`Vaadatud` assertions.
- One responsive branch only: its view size and no-exception assertion.
- Final zero-write boundary only: Step 6 traversal plus absence of create and
  `/project` observables.

## Future extraction seams

Descriptive, non-authorizing possibilities:

- `[S]` Draft-entry helpers may be shared if individual gate conditions remain
  independently visible.
- `[S]` Progress-tile assertions may be separated from traversal if functional
  completion and viewing stay distinct.
- `[S]` View-size setup may become a helper if teardown remains explicit.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when named helpers, keys, tests, labels, routes, or
screen anchors change; `FLOW_DRIFT` when picker, draft, navigation,
cancellation, or progress ordering changes; `BOUNDARY_DRIFT` when creator,
project state, persistent work, or a final create action enters the suite;
`TEST_DRIFT` when covered variants or assertions change; and
`STRUCTURE_DRIFT` when the isolated harness or helper responsibilities move.

## Known uncertainty

- `[D]` No test covers picker exceptions, picker cancellation, whitespace-only
  picker output, or completion after unmount.
- `[D]` Responsive tests prove no Flutter exception at two sizes but do not
  exhaust every intermediate width.
- `[D]` The no-creation test proves the reachable UI and route graph contain no
  create path; static absence is additionally established by source inspection.
- `[P]` Future functional behavior for placeholder steps is outside this map.
