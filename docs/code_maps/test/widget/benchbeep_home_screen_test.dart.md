# Code Map: `test/widget/benchbeep_home_screen_test.dart`

- Source: `test/widget/benchbeep_home_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 11/12`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md`

## File purpose

Exercises the accepted BenchBeep Home launcher, its real `TraceBenchApp`
wiring, the active Home-to-Wizard path, and the existing ZIP/directory/sample
project acquisition paths across eighteen widget tests. It covers identity,
action availability, responsive layout, hover styling, load-parent separation,
project-state handoff, `/new-project`, canonical Board Canvas routing, errors,
and exit confirmation. It reads sample data but writes no project, event, fact,
projection, directory, or ZIP file.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Acquisition seams and fixtures | `_FakeFilePicker`, `_bundledSampleZipBytes`, `Archive`, `ZipEncoder` | Supplies ZIP/directory results, records picker use, and encodes tracked sample files into memory-only ZIP bytes. |
| Observation and state helpers | `_expectCanonicalBoardCanvas`, `_waitForProjectState`, `_waitForLoadedProject`, `_directoryBackedProjectState`, `_actionBorderColor` | Bounds loading, constructs in-memory state, and observes route, screen, and hover state. |
| Isolated Home harness | `_homeHarness`, `BenchBeepHomeScreen`, `onCreateProject` | Injects every Home callback and project availability without the full app shell. |
| Identity and action state | `BenchBeep Home is a black/gold board-selection launcher`, `launcher has no hidden legacy compatibility anchors` | Verifies brand/copy/assets, removed legacy UI, active new-project state, and remaining deferred actions. |
| Create callback isolation | `new project action is enabled, unbadged, and invokes only its callback` | Proves the card is enabled/unbadged and invokes exactly the create callback. |
| Real Home-to-Wizard route | `new project action opens the existing Wizard route` | Uses `TraceBenchApp` to prove `/new-project`, `NewProjectWizardScreen`, and null project state. |
| Responsive and interaction behavior | `wide layout keeps choices left and stacks detail over hero`, `medium layout stacks the hierarchy with all actions reachable`, `launcher action hover uses subtle gold accent` | Verifies geometry, reachability, overflow absence, and hover styling. |
| Sample and continuation flows | bundled sample, missing-project, loaded-project tests | Covers project-state gating and accepted `/project` routing. |
| Directory acquisition flows | folder cancel/success/error/injected-load tests | Covers cancel, success, invalid, injected-loader, provider, and navigation branches. |
| Load-parent and ZIP flows | load-parent separation and ZIP cancel/success tests | Separates parent navigation from child actions and covers ZIP branches. |
| Exit confirmation | `exit dialog cancels safely and confirms exactly once` | Verifies copy, colors, border, cancellation, and one confirmed callback. |

## State and data flow

1. `[D]` `_homeHarness` constructs `BenchBeepHomeScreen` with defaults for all
   seven callback fields, including `onCreateProject`.
2. `[D]` The primary launcher test pumps `TraceBenchApp`, checks black/gold
   identity, and proves the new-project action has a non-null tap while the
   phone action remains disabled.
3. `[D]` The isolated create test injects counters, taps
   `benchbeep_home_new_project_deferred`, and proves only the create counter
   increments exactly once.
4. `[D]` The real app test taps the same key, waits for router transition,
   observes `NewProjectWizardScreen` and `/new-project`, and proves
   `projectStateProvider` is still null.
5. `[D]` Responsive tests change `tester.view`, inspect widget rectangles, and
   reset view state in teardown.
6. `[D]` `_FakeFilePicker` replaces `FilePicker.platform` for ZIP or directory
   scenarios and records requested options; teardown restores the original when
   available.
7. `[D]` Bundled sample loading assigns in-memory state through
   `TraceBenchApp`; the test then enters `/project`.
8. `[D]` Directory tests use the fake platform picker, an injected invalid
   loader, or a deterministic in-memory state loader.
9. `[D]` ZIP success reads accepted sample bytes, encodes them in memory,
   injects them through the fake picker, and awaits provider state.
10. `[D]` `_expectCanonicalBoardCanvas` proves the accepted Board Canvas
    destination and `/project`.
11. `[D]` Load-parent interaction changes detail without incrementing ZIP or
    folder callback counts; child buttons invoke each callback independently.
12. `[D]` Exit tests prove cancel is zero calls and one confirmation increments
    exactly once.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:async` | test timing | Supplies bounded timeout/error behavior. |
| `dart:io` | sample input and path construction | Reads accepted sample files/directories and constructs platform paths; no output is written. |
| `dart:typed_data` | in-memory fixture | Holds encoded sample ZIP bytes. |
| `dart:ui` | test presentation | Supplies pointer kind, colors, and viewport sizes. |
| `package:archive/archive.dart` | in-memory encoding | Builds selected ZIP payload bytes without writing a ZIP file. |
| `package:file_picker/file_picker.dart` | global test seam | Supplies fake ZIP and directory picker results. |
| Flutter Material and `flutter_test` | widget harness/driver | Pump, tap, hover, inspect geometry, and assert state. |
| Riverpod | provider harness | Hosts and reads `projectStateProvider`. |
| GoRouter | route observation | Exposes `/new-project` and `/project`. |
| `TraceBenchApp` and `projectStateProvider` | mapped integration owner | Supply real launcher wiring and in-memory project state. |
| `BenchBeepHomeScreen` | mapped subject | Supplies the isolated launcher callback contract and UI. |
| `NewProjectWizardScreen` | route observable | Confirms the accepted create action reaches the existing Wizard. |
| `ProjectDirectoryOpenAction` | action subject | Supplies injected valid/invalid directory loading branches. |
| `ProjectLoader` and project models | reader/fixture contracts | Load accepted sample data and construct in-memory state. |
| `BoardCanvasScreen` | success observable | Confirms the canonical existing-project destination. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_FakeFilePicker` counters and captured arguments | `ZERO_WRITE` | Mutate only in-memory test-double state. |
| `FilePicker.platform` replacement | `ZERO_WRITE` | Changes process-global test configuration and is teardown-scoped; it writes no selected path. |
| `_bundledSampleZipBytes` | `ZERO_WRITE` | Reads tracked files and returns encoded bytes in memory; no ZIP file is created. |
| `_directoryBackedProjectState` | `ZERO_WRITE` | Constructs in-memory models and no persisted facts/events. |
| `_homeHarness`, view changes, and counters | `ZERO_WRITE` | Mutate only test/widget state and reset through teardown where applicable. |
| Home-to-Wizard interaction | `ZERO_WRITE` | Drives router/UI state only and asserts project state remains null. |
| Bundled, ZIP, and directory success interactions | `PROJECTION_STATE` | Drive accepted production branches that assign loader-returned state to Riverpod. |
| Invalid/cancel flows | `ZERO_WRITE` | Leave project state null and create no destination. |

No test calls `ProjectCreator.createProject`, constructs a creation request,
writes a directory/file, appends a canonical event/fact, runs a materializer,
writes a projection, or creates Project ZIP output. Sample ZIP encoding is
memory-only.

## Zero-write zones

- `[D]` Finder, geometry, color, copy, and route assertions persist nothing.
- `[D]` The create callback test uses in-memory counters only.
- `[D]` The real Home-to-Wizard test proves `projectStateProvider` stays null.
- `[D]` `_FakeFilePicker` returns configured values without operating a native
  picker or writing selected data.
- `[D]` The invalid directory test supplies a loader that throws before any
  filesystem operation.
- `[D]` The injected valid directory loader returns an in-memory fixture.
- `[D]` Real sample directory/ZIP paths are read by accepted loader flows only.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Home harness contract | `[D]` Constructor defaults mirror all callback fields. | Home constructor and launcher rail | `ZERO_WRITE` | Most isolated Home tests |
| Identity/action assertions | `[D]` Keys, labels, badge count, and tap states define launcher truth. | `_LauncherRail`, `_ModeButton` | `ZERO_WRITE` | Black/gold launcher; legacy anchors |
| Create callback | `[D]` Independent counters prove exactly one callback. | Home constructor, launcher rail | `ZERO_WRITE` | Enabled/callback-isolation test |
| Real create route | `[D]` Full app transition proves Wizard and null state. | App Home wiring, router, Wizard | `ZERO_WRITE` | Home-to-Wizard route test |
| Responsive geometry | `[D]` View size drives rectangle relationships. | Home breakpoints and fixed body sizes | `ZERO_WRITE` | Wide and medium layout |
| Hover styling | `[D]` Mouse movement changes the extracted border color. | `_ActionButtonState` | `UI_LOCAL` | Gold hover accent |
| Sample continuation | `[D]` Bundled loading changes provider state before `/project`. | App loader, project provider, router | `PROJECTION_STATE` | Bundled sample handoff |
| Directory and ZIP | `[D]` Fakes/injected seams cover cancel, errors, and success. | Acquisition actions, loader, provider | `ZERO_WRITE`; `PROJECTION_STATE` | Folder and ZIP tests |
| Load-parent separation | `[D]` Parent changes detail while child counters stay zero. | `_selectLoadDetail`, child buttons | `UI_LOCAL` | Load-parent test |
| Exit dialog | `[D]` Cancel/confirm counts and styles cover the branch. | `_MenuBar._confirmExit`, parent callback | `UI_LOCAL`; `ZERO_WRITE` | Exit dialog |

## Relevant tests and helpers

The file contains exactly eighteen `testWidgets` cases across launcher
identity, create navigation, responsive presentation, action semantics, project
acquisition/state, existing-project routing, and exit behavior.

Key helpers are `_FakeFilePicker`, `_bundledSampleZipBytes`,
`_expectCanonicalBoardCanvas`, `_waitForProjectState`,
`_waitForLoadedProject`, `_directoryBackedProjectState`,
`_actionBorderColor`, and `_homeHarness`.

Primary mapped production subjects are `lib/app/app.dart`,
`lib/features/home/screens/benchbeep_home_screen.dart`, and the routed Wizard.
Inspect-only coupled owners include `lib/app/router.dart`,
`lib/features/project/screens/home_screen.dart`, and `ProjectLoader`.

## Dangerous combinations

- `[D]` Changing `_homeHarness`, callback counters, and constructor assertions
  together can hide a missing or misthreaded create callback.
- `[D]` Changing action key, badge count, and tap assertions together can erase
  evidence that the create card is active while the phone card remains deferred.
- `[D]` Changing real app routing and null-state assertions together can hide a
  creator or project-state regression.
- `[D]` Changing picker globals and teardown together can leak fake state.
- `[D]` Changing wait helpers, provider assignment, and route assertions
  together can turn bounded state observation into timing-sensitive success.
- `[D]` Replacing accepted readers/fakes with `ProjectCreator` or write-capable
  services would cross protected test boundaries.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Create action availability only: launcher identity plus the isolated callback
  test; exclude router and acquisition flows.
- Home-to-Wizard route only: real `TraceBenchApp`, the create card, Wizard
  observable, `/new-project`, and null project state.
- Load-parent separation only: its named test and ZIP/folder counters; exclude
  real picker/loader behavior.
- Exit presentation only: the final test and `_MenuBar._confirmExit`; exclude
  window-manager integration.
- One acquisition branch only: its fake/injected seam and focused test; inspect
  provider/router coupling and exclude creator behavior.
- One responsive breakpoint only: the named geometry test and root layout
  branch; exclude action semantics.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Picker setup/restoration may be a reusable test helper if global-state
  isolation remains explicit.
- `[S]` Route assertions may share a helper if `/new-project` and `/project`
  state preconditions remain distinct.
- `[S]` Sample archive construction may be separable from widget interaction
  if its tracked-input contract remains visible.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helper, key, callback, test-name, route, or
screen anchors change; `FLOW_DRIFT` when create routing, picker, loader,
provider, or navigation ordering changes; `BOUNDARY_DRIFT` when real creation
or persistent writes enter the suite; `TEST_DRIFT` when covered action states,
layouts, acquisition branches, or exit assertions change; and
`STRUCTURE_DRIFT` when harness and integration responsibilities move.

## Known uncertainty

- `[D]` The suite does not directly test startup-intro completion or router
  disposal.
- `[D]` The Home create route is tested at the launcher-to-Wizard boundary;
  detailed Wizard behavior belongs to its own focused suite.
- `[D]` Real ZIP/folder success tests depend on accepted sample inputs and
  loader behavior beyond this mapped file.
- `[D]` Global picker restoration remains conditional on a captured original
  platform instance.
