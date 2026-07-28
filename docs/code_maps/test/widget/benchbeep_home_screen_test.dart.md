# Code Map: `test/widget/benchbeep_home_screen_test.dart`

- Source: `test/widget/benchbeep_home_screen_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 11/12`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`

## File purpose

Exercises the accepted BenchBeep Home launcher, its `TraceBenchApp` wiring, and
the existing ZIP/directory/sample project acquisition paths across sixteen
widget tests. It covers identity, deferred actions, responsive layout,
hover/focus styling, load-parent separation, project-state handoff, canonical
Board Canvas routing, error presentation, and exit confirmation. It reads
sample data but writes no project, event, fact, projection, or ZIP file.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Picker seam and capture | `_FakeFilePicker`, `pickFiles`, `getDirectoryPath` | Supplies ZIP/directory results and records picker arguments and call counts. |
| In-memory sample ZIP fixture | `_bundledSampleZipBytes`, `Archive`, `ZipEncoder` | Reads four accepted sample files and encodes ZIP bytes in memory. |
| Route and load wait helpers | `_expectCanonicalBoardCanvas`, `_waitForProjectState`, `_waitForLoadedProject` | Bounds asynchronous loading and verifies `/project` plus `BoardCanvasScreen`. |
| Directory-backed state fixture | `_directoryBackedProjectState` | Builds an in-memory `ProjectState` with a supplied directory path. |
| Visual helper | `_actionBorderColor` | Extracts an action container's current border color for hover assertions. |
| Isolated Home harness | `_homeHarness`, `BenchBeepHomeScreen` | Injects all accepted Home callbacks and project availability without the full app shell. |
| Identity and deferred behavior | `BenchBeep Home is a black/gold board-selection launcher`, `launcher has no hidden legacy compatibility anchors` | Verifies brand/copy/assets, removed legacy UI, disabled deferred actions, and current launcher hierarchy. |
| Responsive and interaction behavior | `wide layout keeps choices left and stacks detail over hero`, `medium layout stacks the hierarchy with all actions reachable`, `launcher action hover uses subtle gold accent` | Verifies geometry, reachability, overflow absence, and hover styling. |
| Sample and continuation flows | `launcher preserves bundled sample project handoff`, `launcher cannot continue without a loaded project`, `loaded project keeps direct board canvas handoff` | Covers project-state gating and accepted `/project` routing. |
| Directory acquisition flows | `launcher open folder cancel leaves project state unchanged`, `launcher open folder success opens canonical board canvas`, `open folder invalid selection shows clear error`, `open folder action loads directory-backed project` | Covers cancel, success, invalid, injected-loader, provider, and navigation branches. |
| Load-parent and ZIP flows | `load parent reveals load detail without invoking pickers`, `launcher import project invokes existing ZIP flow directly`, `launcher ZIP success opens canonical board canvas` | Separates parent navigation from child actions and covers ZIP cancel/success. |
| Exit confirmation | `exit dialog cancels safely and confirms exactly once` | Verifies copy, colors, border, cancellation, and one confirmed callback. |

## State and data flow

1. `[D]` `_homeHarness` constructs `BenchBeepHomeScreen` with defaults for the
   seven accepted callback fields; it contains no create-project callback.
2. `[D]` The primary launcher test pumps `TraceBenchApp`, checks black/gold
   identity, and inspects mode `InkWell` tap handlers.
3. `[D]` That test finds `benchbeep_home_new_project_deferred`, expects
   `Loo projekt nullist`, counts three `Tulekul` labels, and proves the
   new-project and phone actions have null taps.
4. `[D]` Responsive tests change `tester.view`, inspect widget rectangles, and
   reset view state in teardown.
5. `[D]` `_FakeFilePicker` replaces `FilePicker.platform` for ZIP or directory
   scenarios and records requested options; teardown restores a captured
   original when available.
6. `[D]` Bundled sample loading assigns in-memory state through
   `TraceBenchApp`; the test then enters `/project`.
7. `[D]` Directory tests either use the fake platform picker, an injected
   invalid loader, or a deterministic in-memory state loader.
8. `[D]` ZIP success reads accepted sample bytes, encodes them in memory,
   injects them through the fake picker, and awaits provider state.
9. `[D]` `_expectCanonicalBoardCanvas` proves the resulting widget and router
   path are the accepted Board Canvas destination.
10. `[D]` Load-parent interaction changes detail without incrementing ZIP or
    folder callback counts; child buttons invoke each callback independently.
11. `[D]` Exit tests use a counter callback and prove cancel is zero and one
    confirmation increments exactly once.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `dart:async` | test timing | Supplies bounded timeout/error behavior. |
| `dart:io` | sample input and path construction | Reads accepted sample files/directories and constructs platform paths; no test output is written. |
| `dart:typed_data` | in-memory fixture | Holds encoded sample ZIP bytes. |
| `dart:ui` | test presentation | Supplies pointer kind, colors, and viewport sizes. |
| `package:archive/archive.dart` | in-memory encoding | Builds the selected ZIP payload without writing it to disk. |
| `package:file_picker/file_picker.dart` | global test seam | Supplies fake ZIP and directory picker results. |
| `package:flutter/material.dart` | widget inspection | Supplies widgets, colors, keys, dialog/button types, and the isolated harness. |
| `flutter_test` | test driver | Pumps, taps, hovers, inspects geometry, and asserts state. |
| Riverpod | provider harness | Hosts and reads `projectStateProvider`. |
| GoRouter | route observation | Exposes the active `/project` path. |
| `TraceBenchApp` and `projectStateProvider` | mapped integration owner | Supply real launcher wiring and in-memory project state. |
| `BenchBeepHomeScreen` | mapped subject | Supplies the isolated launcher callback contract and UI. |
| `ProjectDirectoryOpenAction` | action subject | Supplies injected valid/invalid directory loading branches. |
| `ProjectLoader` and project models | reader/fixture contracts | Load accepted sample data and construct in-memory state. |
| `BoardCanvasScreen` | success observable | Confirms the canonical current destination. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_FakeFilePicker` counters and captured arguments | `ZERO_WRITE` | Mutate only in-memory test-double state. |
| `FilePicker.platform` replacement | `ZERO_WRITE` | Changes process-global test configuration and is teardown-scoped; it writes no selected path. |
| `_bundledSampleZipBytes` | `ZERO_WRITE` | Reads four tracked files and returns encoded bytes in memory; no ZIP file is created. |
| `_directoryBackedProjectState` | `ZERO_WRITE` | Constructs in-memory models and no persisted facts/events. |
| `_homeHarness`, view changes, and dialog counters | `ZERO_WRITE` | Mutate only test/widget state and reset through teardown where applicable. |
| Bundled, ZIP, and directory success interactions | `PROJECTION_STATE` | Drive accepted production branches that assign loader-returned state to Riverpod. |
| Route assertions and launcher detail interactions | `UI_LOCAL` / `ZERO_WRITE` | Observe or mutate transient UI/router state only. |
| Invalid/cancel flows | `ZERO_WRITE` | Leave project state null and create no destination. |

No test calls `ProjectCreator.createProject`, writes a directory/file,
appends a canonical event/fact, runs a materializer, writes a projection, or
creates Project ZIP output. Sample ZIP encoding is memory-only.

## Zero-write zones

- `[D]` Finder, geometry, color, copy, and route assertions persist nothing.
- `[D]` `_FakeFilePicker` returns configured values without operating a native
  picker or writing selected data.
- `[D]` The invalid directory test supplies a loader that throws before any
  filesystem operation.
- `[D]` The injected valid directory loader returns an in-memory fixture.
- `[D]` Real sample directory/ZIP paths are read by accepted loader flows only.
- `[D]` The disabled new-project action has no tap and reaches no Wizard or
  creator behavior.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Home harness contract | `[D]` Constructor defaults mirror all current callback fields. | Home constructor and launcher rail | `ZERO_WRITE` | Most isolated Home tests |
| Identity/deferred assertions | `[D]` Keys, labels, badge count, and null taps define current launcher truth. | `_LauncherRail`, `_ModeButton` | `ZERO_WRITE` | Black/gold launcher; legacy anchors |
| Responsive geometry | `[D]` View size drives explicit rectangle relationships. | Home breakpoints and fixed body sizes | `ZERO_WRITE` | Wide and medium layout |
| Hover styling | `[D]` Mouse movement changes the extracted border color. | `_ActionButtonState` | `UI_LOCAL` | Gold hover accent |
| Sample continuation | `[D]` Bundled loading changes provider state before `/project`. | App loader, project provider, router | `PROJECTION_STATE` | Bundled sample handoff |
| Directory picker | `[D]` Fake result/counters cover cancel and real-sample success. | Directory action, FilePicker, loader | `PROJECTION_STATE` on success | Folder cancel/success |
| Injected directory action | `[D]` Custom loaders isolate invalid and valid branches. | Error copy, provider assignment, callback | `ZERO_WRITE` / `PROJECTION_STATE` | Invalid and injected success |
| Load-parent separation | `[D]` Parent changes detail while child counters remain zero. | `_selectLoadDetail`, ZIP/folder buttons | `UI_LOCAL` | Load parent reveals detail |
| ZIP flow | `[D]` Fake picker and in-memory archive cover cancel/success. | ZIP action, loader, project provider | `PROJECTION_STATE` on success | ZIP direct invocation/success |
| Existing-project navigation | `[D]` Project presence gates continuation and Board Canvas routing. | App Home wiring and router | `ZERO_WRITE` | Cannot continue; loaded project |
| Exit dialog | `[D]` Cancel/confirm counts and style assertions cover the branch. | `_MenuBar._confirmExit`, parent exit callback | `UI_LOCAL` / `ZERO_WRITE` | Exit dialog |

## Relevant tests and helpers

The file contains exactly sixteen `testWidgets` cases across launcher identity,
responsive presentation, action semantics, project acquisition/state, routing,
and exit behavior.

Key helpers are `_FakeFilePicker`, `_bundledSampleZipBytes`,
`_expectCanonicalBoardCanvas`, `_waitForProjectState`,
`_waitForLoadedProject`, `_directoryBackedProjectState`,
`_actionBorderColor`, and `_homeHarness`.

Primary mapped production subjects are `lib/app/app.dart` and
`lib/features/home/screens/benchbeep_home_screen.dart`; inspect-only coupled
owners are `lib/app/router.dart`,
`lib/features/project/screens/home_screen.dart`, and `ProjectLoader`.

## Dangerous combinations

- `[D]` Changing `_homeHarness` and constructor assertions together can hide a
  missing or misthreaded callback.
- `[D]` Changing deferred-card key, badge count, and null-tap assertions
  together can erase evidence of current disabled behavior.
- `[D]` Changing picker globals and teardown together can leak fake state
  between tests.
- `[D]` Changing wait helpers, provider assignment, and route assertions
  together can turn bounded state observation into timing-sensitive success.
- `[D]` Changing sample ZIP construction and ZIP-loader assertions together
  can conceal an acquisition regression.
- `[D]` Changing load-parent and child callback counters together can make the
  parent invoke a picker unnoticed.
- `[D]` Replacing accepted readers/fakes with `ProjectCreator` or write-capable
  services would cross protected test boundaries.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Deferred action availability only: the primary launcher test, the Home mode
  key, badge count, and null tap; exclude acquisition flows.
- One Home callback contract only: `_homeHarness`, the corresponding focused
  callback counter, and the mapped production constructor; exclude unrelated
  actions.
- Load-parent separation only: its named test and ZIP/folder counters; exclude
  real picker/loader behavior.
- Exit presentation only: the final test and `_MenuBar._confirmExit`; exclude
  window-manager integration.
- One acquisition branch only: its fake/injected seam and focused test;
  inspect provider/router coupling and exclude creator behavior.
- One responsive breakpoint only: the named geometry test and root layout
  branch; exclude action semantics.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Picker setup/restoration may be a reusable test helper if global-state
  isolation remains explicit.
- `[S]` Board Canvas route assertion may be shared by other launcher suites.
- `[S]` Sample archive construction may be separable from widget interaction
  if its tracked-input contract remains visible.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when helper, key, callback, test-name, route, or
screen anchors change; `FLOW_DRIFT` when picker, loader, provider, or navigation
ordering changes; `BOUNDARY_DRIFT` when real creation or persistent writes
enter the suite; `TEST_DRIFT` when covered action states, layouts, acquisition
branches, or exit assertions change; and `STRUCTURE_DRIFT` when harness and
integration responsibilities move.

## Known uncertainty

- `[D]` The suite does not directly test startup-intro completion or router
  disposal.
- `[D]` Compact widths below the medium layout are reached by product code but
  have no separately named geometry test here.
- `[D]` The real ZIP/folder success tests depend on accepted sample inputs and
  loader behavior beyond this mapped file.
- `[D]` A separately authorized future slice proposes adding a Home create
  callback to `_homeHarness`, replacing deferred-card assertions with enabled
  routing assertions, and preserving all unrelated tests. Those changes are
  absent from accepted source and would require map review after acceptance.
