# TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS

## Identity

```text
PROJECT: TraceBench / BenchBeep
ROLE: Codex — product scope-lock author
PASS_ID: TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 93e66fbb83876f8d17edfffe25ba0266184360b7
Manual smoke: NOT_APPLICABLE for this docs-only Phase 1
```

## Result

`SCOPE_LOCKED` for one exact, mechanical, read-only first implementation
batch. This Phase 1 makes no product or implementation change. It resolves the
live 15-destination chrome inventory, freezes all writer/business and route
boundaries, and reserves only
`TRACEBENCH_WORKBENCH_DESTINATION_CHROME_READ_ONLY_BATCH_1_IMPL_PASS`.

The batch is intentionally limited to six small destinations whose loaded
presentation branches contain only route-title AppBars and no AppBar actions.
There are seven such loaded branches because Events has separate beginner and
advanced branches, and both mount the redundant title AppBar. A single reusable
presentation wrapper is added to the existing Workbench shell owner so every
loaded destination branch uses the existing dark shell token vocabulary. Board
Canvas, Overview, every writer-bearing workflow, Photos, Graph, Reference
Images, and Report are outside the child.

## Live baseline

Live pre-write verification established:

- repository: `C:\dev\TraceBench`;
- branch: `main`;
- `HEAD == origin/main ==
  93e66fbb83876f8d17edfffe25ba0266184360b7`;
- parent: `8266e1e178cee885a80f2584712862b4f714842d`;
- subject: `docs: refresh shared workbench shell code maps`;
- divergence: `0 0`;
- cached paths: `0`;
- unmerged paths: `0`;
- substantive content diff: `0`;
- the three generated-plugin paths under `windows/` remain known EOL/stat
  residue with zero substantive content diff.

## Authority and route

```text
TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS
  [committed at 93e66fbb83876f8d17edfffe25ba0266184360b7]
-> TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS
-> TRACEBENCH_WORKBENCH_DESTINATION_CHROME_READ_ONLY_BATCH_1_IMPL_PASS
-> automated validation
-> human manual smoke
-> independent implementation audit
-> committed-source Code Map maintenance
-> NEEDS_USER_DECISION
```

No later destination batch is armed by this route.

## Exact current Phase-1 material set

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS.md`

No sixth path is authorized. All Dart, tests, maps/index, packages, assets,
schemas, tools, platform files, and Windows substantive bytes are frozen.

## Sniper source closure

The committed router contains exactly 15 real project destinations and two
redirect aliases. Classification used the maintained router and Workbench shell
maps first, then each destination's exact `build`, `Scaffold`, `AppBar`, top
action, surface/theme, and directly corresponding focused-test zones. Large
mapped source/test owners were not whole-file reread.

Real destinations:

1. `/project`
2. `/project/overview`
3. `/project/components`
4. `/project/components/add`
5. `/project/components/edit`
6. `/project/measurements`
7. `/project/measure-sheet`
8. `/project/not-populated`
9. `/project/pins`
10. `/project/events`
11. `/project/graph`
12. `/project/known-facts`
13. `/project/photos`
14. `/project/reference-images`
15. `/project/report`

The aliases `/project/board-canvas -> /project` and
`/project/measurements/new -> /project/measure-sheet` remain redirects, not
additional real destinations.

## Classification vocabulary

- `A — SHELL_NATIVE`: already relies on the shared shell for project chrome.
- `B — DOUBLE_CHROME_SIMPLE`: duplicate title chrome over a surface already
  coherent with the shell and no AppBar action to migrate.
- `C — DOUBLE_CHROME_WITH_ACTIONS`: an inner AppBar action must be preserved,
  relocated, or proved redundant before removal.
- `D — LEGACY_LIGHT_SURFACE`: duplicate chrome and a light/default Material
  surface require one localized shell-token presentation boundary.
- `E — DEFER`: complexity or a protected writer/file/ZIP/responsive boundary
  makes the destination unsuitable for the first mechanical batch.

No live route qualifies for `B`: the title-only candidates also use legacy
light/default Material surfaces and therefore classify as `D` or, where
complexity requires it, `E`.

## Destination classification table

| Route | Screen owner | Current chrome | AppBar actions | Surface style | Classification | Proposed disposition | Required source/test paths |
|---|---|---|---|---|---|---|---|
| `/project` | `BoardCanvasScreen` | shared shell plus local `Board Canvas` AppBar | read-only render/write status pill in the AppBar action slot | destination body is already dark, but the local AppBar remains pale/default | `E — DEFER` | Freeze. A later dedicated product batch may move the status pill into the existing destination-local control/status band before considering AppBar removal. Do not change Canvas geometry, tools, writers, focus, freshness, or responsive behavior. | `lib/features/board_canvas/screens/board_canvas_screen.dart`; `test/widget/board_canvas_screen_test.dart` |
| `/project/overview` | `ProjectOverviewScreen` | shared shell only | none | existing dark Workbench tokens | `A — SHELL_NATIVE` | No source or test change. Use as the visual/reference destination for shared chrome. | inspect-only `lib/features/project/screens/project_overview_screen.dart`; `test/widget/project_overview_screen_test.dart` |
| `/project/components` | `ComponentListScreen` | shared shell plus title-only `Komponentide nimekiri` AppBar | none | default/light Scaffold with `ListView.builder`, `ProjectionStaleBanner`, and `ListTile` rows | `D — LEGACY_LIGHT_SURFACE` | First batch: remove the local title AppBar and use the reusable shell-token destination surface without changing projected component data or ordering. The shell breadcrumb `Komponendid` becomes the sole visible route title. | `lib/features/known_facts/screens/component_list_screen.dart`; `test/widget/workbench_shell_test.dart` |
| `/project/components/add` | `AddComponentScreen` | shared shell plus title-only `Add component` AppBar | none; save/cancel controls remain in the form body | default/light writer form | `E — DEFER` | Freeze writer and form. Any later workflow batch may remove only duplicate chrome after map/bootstrap preflight and dedicated writer regressions. | `lib/features/components/screens/add_component_screen.dart`; `test/widget/add_component_screen_test.dart` |
| `/project/components/edit` | `EditComponentScreen` | shared shell plus title-only `Edit component` AppBar | none; save/cancel controls remain in the form body | default/light writer form | `E — DEFER` | Freeze writer, selection, save/cancel, and navigation handoff. Later dedicated workflow batch only. | `lib/features/components/screens/edit_component_screen.dart`; `test/widget/edit_component_screen_test.dart` |
| `/project/measurements` | `MeasurementListScreen` | shared shell plus title-only `Mõõtmised` AppBar | none | default/light Scaffold with `ListView.builder`, `ProjectionStaleBanner`, and `ListTile` rows; beginner mode controls only the existing trailing value | `D — LEGACY_LIGHT_SURFACE` | First batch: remove the local title AppBar and use the reusable shell-token destination surface without changing projection, ordering, detail copy, or beginner-mode behavior. The shell breadcrumb is text-identical: `Mõõtmised`. | `lib/features/known_facts/screens/measurement_list_screen.dart`; `test/widget/workbench_shell_test.dart` |
| `/project/measure-sheet` | `MeasureSheetScreen` | shared shell plus title-only `Measure sheet` AppBar | none; measurement-entry actions remain in body controls | default/light responsive writer workflow | `E — DEFER` | Freeze all measurement writers, focus, form/table layout, success behavior, and responsive geometry. Later dedicated workflow batch only. | `lib/features/measure_sheet/screens/measure_sheet_screen.dart`; `test/widget/measure_sheet_screen_test.dart` |
| `/project/not-populated` | `NotPopulatedScreen` | shared shell plus title-only `Puudub populeerimine` AppBar | none | default/light Scaffold with `ListView`, `ProjectionStaleBanner`, and block-icon `ListTile` rows | `D — LEGACY_LIGHT_SURFACE` | First batch: remove the local title AppBar and use the reusable shell-token destination surface without changing excluded-footprint facts, ordering, icons, or copy. The shell breadcrumb `Täitamata` becomes the sole visible route title. | `lib/features/known_facts/screens/not_populated_screen.dart`; `test/widget/workbench_shell_test.dart` |
| `/project/pins` | `PinListScreen` | shared shell plus title-only `Pinnid` AppBar | none | default/light Scaffold with `ListView.builder`, `ProjectionStaleBanner`, and `ListTile` rows | `D — LEGACY_LIGHT_SURFACE` | First batch: remove the local title AppBar and use the reusable shell-token destination surface without changing pin facts, grouping, or copy. The shell breadcrumb is text-identical: `Pinnid`. | `lib/features/known_facts/screens/pin_list_screen.dart`; `test/widget/workbench_shell_test.dart` |
| `/project/events` | `EventsViewerScreen` | shared shell plus two loaded title-only `Sündmused` AppBars: one in the beginner branch and one in the advanced branch | none in either branch | beginner: default/light Scaffold with centered `Advanced režiim vajalik` text; advanced: default/light Scaffold with `ListView.builder`, `ExpansionTile` rows, and monospace JSON payload text | `D — LEGACY_LIGHT_SURFACE` | First batch: consolidate both loaded branches through the reusable shell-token destination surface and remove both local AppBars. Preserve beginner/advanced behavior, provider ownership, event data, expansion/content behavior, route behavior, and zero writers. The shell breadcrumb is text-identical: `Sündmused`. | `lib/features/events/screens/events_viewer_screen.dart`; `test/widget/workbench_shell_test.dart` |
| `/project/graph` | `BoardGraphScreen` | shared shell plus `Board graph` AppBar | beginner-mode toggle duplicates the shell-owned mode control | default/light Scaffold around graph/focus/filter content | `C — DOUBLE_CHROME_WITH_ACTIONS` | Defer to a focused action batch. Prove the shell toggle is the same provider action, retain it as the reachable control, then retire the redundant inner toggle while preserving graph/filter/focus behavior. | `lib/features/board_graph/screens/board_graph_screen.dart`; `test/widget/board_graph_screen_test.dart`; `test/widget/workbench_shell_test.dart` |
| `/project/known-facts` | `KnownFactsViewerScreen` | shared shell plus title-only `Known facts` AppBar | none | default/light Scaffold with `SingleChildScrollView`, a `Column`, `ProjectionStaleBanner`, and monospace JSON `Text` | `D — LEGACY_LIGHT_SURFACE` | First batch: remove the local title AppBar and use the reusable shell-token destination surface without changing serialized fact content, freshness presentation, or zero-write behavior. The shell breadcrumb `Teadaolevad faktid` becomes the sole visible route title. | `lib/features/known_facts/screens/known_facts_viewer_screen.dart`; `test/widget/workbench_shell_test.dart` |
| `/project/photos` | `PhotoListScreen` | shared shell plus title-only `Photos` AppBar | none | default/light Cards with freshness and projected-photo content | `D — LEGACY_LIGHT_SURFACE` | Later read-only batch. Preserve photo projection, stale/unknown presentation, beginner mode, ordering, and file identities; do not mix it into the six-owner first batch. | `lib/features/photos/screens/photo_list_screen.dart`; `test/widget/photo_list_screen_test.dart` |
| `/project/reference-images` | `ReferenceImagesScreen` | shared shell plus title-only `Reference images` AppBar | none; import is already a body action | default/light file/sidecar workflow with responsive list/preview | `E — DEFER` | Freeze import, sidecar, error, selection, list/preview, and filesystem behavior. A later dedicated file-boundary batch must complete missing-map preflight first. | `lib/features/reference_images/screens/reference_images_screen.dart`; `test/widget/reference_images_screen_test.dart` |
| `/project/report` | `CustomerReportScreen` | shared shell plus title-only `Customer report` AppBar | none; Export ZIP is already a body action | default/light report and export surface | `E — DEFER` | Freeze report generation, reload, provider state, export action, and Project ZIP contract. Later dedicated protected-boundary batch only. | `lib/features/report/screens/customer_report_screen.dart`; `test/widget/customer_report_screen_test.dart` |

## Recommended first batch

The first child is a coherent eight-path batch rather than 15 independent
destination edits:

- one existing presentation/token owner;
- six small read-only destination owners;
- one existing production-router shell suite.

All seven loaded AppBar branches across the six owners are title-only. Events
owns two of those branches, and completing only one is forbidden. No AppBar
action, writer, workflow handoff, or layout system must move. This keeps the
batch within the requested six-to-eight owner/test boundary and avoids mixing
writer, file, ZIP, graph-action, Canvas, or Overview responsibilities.

## Reusable destination-surface contract

The child may add `WorkbenchDestinationSurface` to
`lib/features/project/widgets/workbench_shell.dart` with these exact
responsibilities:

- expose a child slot and key `workbench-destination-surface`;
- provide the loaded destination body with a dark Material surface and a
  localized theme derived only from existing `WorkbenchShellColors`;
- keep shell background, panel/card, rule, primary text, muted text, and accent
  roles coherent without introducing a competing palette;
- own no AppBar, route title, breadcrumb, Home control, beginner-mode control,
  router call, provider read/write, destination action, writer, loading state,
  null-project branch, or business rule;
- avoid changing global `ThemeData`, shell navigation geometry, or destination
  layout geometry.

Each of the six destination owners must replace every loaded
`Scaffold(appBar: title-only AppBar, body: existingBody)` presentation branch
with this wrapper around the same existing body. Components, Measurements, Not
Populated, Pins, and Known Facts each have one loaded branch. Events has two:
the `isBeginnerMode` branch and the advanced branch. Both Events branches must
be consolidated; fixing only the advanced branch does not satisfy the child.
Any direct-mount null state, provider access, data transformation, body tree,
ordering, keys, text, expansion behavior, and freshness behavior remain
byte-for-byte or semantically unchanged as required by formatting/import
adjustments.

## Chrome action migration plan

| Destination group | Live AppBar action | Locked treatment |
|---|---|---|
| first-batch Components, Measurements, Not Populated, Pins, Events, Known Facts | none in any of the seven loaded branches | No migration. Remove every redundant route-title AppBar, including both Events branches. |
| Overview | none | No change; already shell-native. |
| Board Canvas | read-only render/write status pill | Defer. Preserve the pill exactly; a later batch may relocate it into an existing destination-local status/control band before removing the AppBar. |
| Graph | beginner-mode toggle | Defer. The shell already exposes the same provider-backed control; later tests must prove equivalence and reachability before retiring the duplicate. |
| Add, Edit, Measure Sheet | body-local save/cancel/measurement controls | No AppBar migration. Freeze all body actions and writers for a later workflow-specific batch. |
| Photos | none | Later read-only surface batch; no action migration. |
| Reference Images | import button already in body | Keep the body action in place; file/sidecar behavior frozen. |
| Report | Export ZIP already in body | Keep the body action in place; Project ZIP behavior frozen. |

The shared Workbench Home, breadcrumb/title, beginner-mode control, 12-entry
navigation, active selection, and responsive compact/persistent affordances are
not destination actions and remain solely owned by `WorkbenchShell`.

## Expected route-title chrome transitions

Removing destination-owned route-title AppBars makes the shell breadcrumb the
only visible route title. The child must not change shell labels.

| Route | Removed source AppBar title | Retained shell breadcrumb | Expected result |
|---|---|---|---|
| `/project/components` | `Komponentide nimekiri` | `Komponendid` | Intentional title transition. |
| `/project/measurements` | `Mõõtmised` | `Mõõtmised` | Text-identical. |
| `/project/not-populated` | `Puudub populeerimine` | `Täitamata` | Intentional title transition. |
| `/project/pins` | `Pinnid` | `Pinnid` | Text-identical. |
| `/project/events` | `Sündmused` in both loaded branches | `Sündmused` | Text-identical in beginner and advanced modes. |
| `/project/known-facts` | `Known facts` | `Teadaolevad faktid` | Intentional title transition. |

The three transitions are expected chrome consolidation outcomes, not
destination-content regressions. “Unchanged content” throughout this lock
excludes the intentionally removed destination-owned route-title chrome.

## Exact future implementation allowlist

The only armed child is:

```text
PASS_ID: TRACEBENCH_WORKBENCH_DESTINATION_CHROME_READ_ONLY_BATCH_1_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS / DESTINATION_CHROME / UI_LOCAL_ZERO_WRITE
Baseline: accepted committed result of this scope-lock pass
```

It may write exactly:

1. `lib/features/project/widgets/workbench_shell.dart`
2. `lib/features/known_facts/screens/component_list_screen.dart`
3. `lib/features/known_facts/screens/measurement_list_screen.dart`
4. `lib/features/known_facts/screens/not_populated_screen.dart`
5. `lib/features/known_facts/screens/pin_list_screen.dart`
6. `lib/features/events/screens/events_viewer_screen.dart`
7. `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
8. `test/widget/workbench_shell_test.dart`

No ninth path. If implementation or required regression evidence needs another
source or test owner, the child stops with `BLOCKED_ALLOWLIST_MISMATCH`; it does
not trade paths or expand the batch.

## Locked implementation invariants

1. `WorkbenchShell` remains the sole project-level top chrome owner.
2. Exactly one `AppBar` is mounted for every loaded presentation branch of each
   first-batch route, keyed `workbench-shell-app-bar`. This is branch-complete:
   Events satisfies it with both `beginnerModeProvider == false` and
   `beginnerModeProvider == true`.
3. All seven local title-AppBar branches across the six owners disappear; the
   shared breadcrumb/title remains the only route-identity top chrome.
4. Every loaded body branch uses `WorkbenchDestinationSurface` and only
   existing `WorkbenchShellColors`; no global theme or new palette is
   introduced.
5. The ordered 12-entry navigation model, active selection, compact drawer,
   persistent rail, threshold `1228`, Home, and beginner-mode controls remain
   unchanged.
6. All 15 real route paths/names/builders and both redirects remain unchanged.
7. `ShellRoute -> ProjectGate -> WorkbenchShell -> destination`, deep-link,
   nested push/pop, Home, and browser/back behavior remain unchanged.
8. Project identity, `projectStateProvider`, `beginnerModeProvider`, file
   identity, freshness, facts, events, and evidence/status presentation remain
   unchanged across navigation.
9. All four canonical writer calls and every event/fact mutation count remain
   zero while visiting the six first-batch read-only destinations.
10. No acquisition, Wizard, Board Canvas, Overview, Add/Edit/Measure, Graph,
    Photos, Reference Images, Report, ZIP, or filesystem behavior changes.

## Focused regression contract for the child

The child strengthens `test/widget/workbench_shell_test.dart` without weakening
its existing eight behavior families.

Using the production router and a loaded project fixture, routed regressions
must cover exactly seven loaded presentation cases across the six URIs:

- `/project/components`;
- `/project/measurements`;
- `/project/not-populated`;
- `/project/pins`;
- `/project/events` with `beginnerModeProvider == false`;
- `/project/events` with `beginnerModeProvider == true`;
- `/project/known-facts`.

For every loaded presentation case it proves:

- `find.byKey(Key('workbench-shell-app-bar'))` finds exactly one widget and the
  total mounted `AppBar` count is exactly one;
- `find.byKey(Key('workbench-destination-surface'))` finds exactly one widget;
- the shell breadcrumb and exact active destination control remain correct;
- no removed destination title AppBar exists as a second top-chrome widget;
- the destination background/panel/text presentation resolves through
  `WorkbenchShellColors`, with no light full-screen Scaffold surface;
- representative existing body data remains visible;
- `projectStateProvider`, `beginnerModeProvider`, loaded project object/file
  identity, facts, events, freshness, and evidence/status data are unchanged;
- add/edit/delete/record writer-call counters remain zero.

For both routed Events cases, the test additionally proves:

- the same loaded `ProjectState` and provider identity remain mounted;
- `beginnerModeProvider == false` renders the existing advanced body, including
  reachable `ExpansionTile` event content;
- `beginnerModeProvider == true` renders the existing beginner body containing
  `Advanced režiim vajalik`;
- exactly one shell-owned AppBar and one destination surface are present;
- no destination-owned `Sündmused` AppBar remains; and
- writer requests and event/fact mutations remain zero.

The route-title assertions explicitly accept
`Komponentide nimekiri -> Komponendid`,
`Puudub populeerimine -> Täitamata`, and
`Known facts -> Teadaolevad faktid`. They also prove that `Mõõtmised`,
`Pinnid`, and `Sündmused` remain text-identical while being rendered only by
the shell chrome.

The existing shell suite must continue to prove:

- exact ordered 12-entry inventory;
- workflow-parent selection;
- one gate/one shell identity over all 15 real destinations;
- compact navigation below `1228` and persistent navigation at/above `1228`;
- Home and mode behavior;
- zero-write route navigation;
- routed monotonic geometry at `959`, `960`, `1227`, `1228`, `1229`, and
  `1500` where already owned by the committed shell regressions.

Inspect-only regressions, run without edits:

- `test/widget/measurement_list_screen_test.dart`;
- `test/widget/not_populated_screen_test.dart`;
- `test/widget/events_viewer_beginner_screen_test.dart`;
- `test/widget/events_viewer_advanced_screen_test.dart`;
- `test/integration/projection_stale_banner_end_to_end_test.dart`, which covers
  Component, Measurement, Not Populated, Pin, and Known Facts surfaces;
- `test/widget/project_gate_test.dart`;
- analyzer, repository validators, and the full Flutter suite.

The two direct Events suites remain frozen behavior regressions. In particular,
`events_viewer_beginner_screen_test.dart` does not mount the production
router/Workbench shell and therefore cannot substitute for either routed shell-
chrome Events case above.

The child must rederive live test names and counts; this lock freezes behavior,
not stale numeric totals.

## Manual smoke contract

Manual smoke is `NOT_APPLICABLE` for this docs-only Phase 1. It is mandatory
after the child and before the independent final implementation audit:

1. Load a representative project and visit Components, Measurements, Not
   Populated, Pins, Events, and Known Facts from the shared navigation.
2. At each destination verify one shared header/breadcrumb, no second AppBar,
   and a coherent dark body. Verify Components, Measurements, and Pins retain
   their existing row/list content; Not Populated retains its committed list,
   block-icon, and copy; both beginner and advanced Events bodies remain
   readable, including advanced `ExpansionTile` content; and Known Facts
   retains its monospace JSON/text content.
3. Verify only the shell breadcrumb/title remains. Treat
   `Komponentide nimekiri -> Komponendid`,
   `Puudub populeerimine -> Täitamata`, and
   `Known facts -> Teadaolevad faktid` as expected. “Unchanged content” excludes
   the removed destination-owned route-title chrome.
4. At `959` pixels verify compact shared navigation; at `1228` and `1500`
   verify persistent shared navigation and unchanged active selection.
5. Deep-link directly to at least Components and Events; use Home, browser/back,
   and route re-entry; verify project and mode state survive.
6. In a disposable project, exercise one representative writer workflow outside
   the changed batch, such as Add Component, and verify its save/cancel behavior
   and resulting project data remain intact.
7. Revisit Board Canvas and Overview as frozen reference destinations and
   confirm their local geometry/content did not change.
8. Capture compact and wide screenshots for the audit packet, including at
   least one list-heavy and one event/fact destination.

Double-AppBar consolidation outside the six first-batch routes is an expected
later product observation, not a failure of this child.

## Code Map preflight and dispositions

The registry is `34 maps / 34 rows`, all `MAINTAINED`, at the live baseline.
This scope and its child do not edit maps or `CODE_MAP_INDEX.md`.

| Owner/map | Disposition after accepted child | Reason |
|---|---|---|
| `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md` | `UPDATE_REQUIRED` | New public destination presentation boundary and dependency surface. |
| `docs/code_maps/test/widget/workbench_shell_test.dart.md` | `UPDATE_REQUIRED` | New six-route/seven-loaded-branch single-AppBar, dark-surface, provider-identity, title-transition, and zero-write regression family. |
| `docs/code_maps/lib/app/router.dart.md` | `REVIEWED_NO_CHANGE` | All 15 routes, two aliases, shell/gate topology, builders, and navigation semantics remain frozen. |
| `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md` | `REVIEWED_NO_CHANGE` | Overview is reference-only and already shell-native. |
| `docs/code_maps/test/widget/project_overview_screen_test.dart.md` | `REVIEWED_NO_CHANGE` | No Overview source/test responsibility changes. |
| `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md` | `REVIEWED_NO_CHANGE` | Canvas chrome, status, writers, geometry, and body remain frozen. |
| `docs/code_maps/test/widget/board_canvas_screen_test.dart.md` | `REVIEWED_NO_CHANGE` | No Canvas behavior or test responsibility changes. |
| `docs/code_maps/lib/features/board_graph/screens/board_graph_screen.dart.md` | `REVIEWED_NO_CHANGE` | Graph action consolidation is deferred and unarmed. |
| `docs/code_maps/lib/features/components/screens/edit_component_screen.dart.md` | `REVIEWED_NO_CHANGE` | Edit workflow is deferred and unarmed. |
| `docs/code_maps/test/widget/edit_component_screen_test.dart.md` | `REVIEWED_NO_CHANGE` | Writer regressions remain unchanged. |
| `docs/code_maps/lib/features/measure_sheet/screens/measure_sheet_screen.dart.md` | `REVIEWED_NO_CHANGE` | Measure workflow is deferred and unarmed. |
| `docs/code_maps/test/widget/measure_sheet_screen_test.dart.md` | `REVIEWED_NO_CHANGE` | Writer/responsive regressions remain unchanged. |
| `docs/code_maps/lib/features/report/screens/customer_report_screen.dart.md` | `REVIEWED_NO_CHANGE` | Report/Project ZIP behavior is deferred and unarmed. |
| `docs/code_maps/test/widget/customer_report_screen_test.dart.md` | `REVIEWED_NO_CHANGE` | Report/export regressions remain unchanged. |

The six small first-batch source owners have no map and remain
`NOT_APPLICABLE` at the current committed source. They are respectively 45,
47, 35, 38, 52, and 39 physical lines; each has one cohesive renderer zone,
at most one protected read-only input surface, no writer, no recurring
whole-file tax, and exact single-symbol closure. None reaches `SCORE 6/12` with
two non-size dimensions above zero, and none meets an automatic trigger. The
later committed-source maintenance pass must requalify each changed file
against the Code Map Standard before deciding whether a first map is required.
That later pass does not pre-authorize a map here.

The currently unmapped Add Component and Reference Images source/test owners
have enough independent writer/file-boundary behavior to require a fresh
Standard qualification before any future implementation scope. If a future
pass targets them without the required maintained map state, it stops with
`BLOCKED_CODE_MAP_REQUIRED`. This finding is a reason to defer, not authority to
create maps in the present pass.

## Deferred destinations

- Board Canvas: dedicated status-placement/product batch only.
- Add Component and Edit Component: dedicated writer-form batch only.
- Measure Sheet: dedicated measurement-writer/responsive batch only.
- Graph: dedicated redundant-action equivalence batch only.
- Photos: later read-only dark-surface batch.
- Reference Images: dedicated file/sidecar batch after map qualification.
- Report: dedicated Project ZIP/report batch only.
- Overview: no consolidation work currently required.

No deferred item is a child, alternate route, or implied permission under this
scope.

## Frozen boundaries

The current Phase 1 and reserved first child freeze:

- `lib/app/router.dart`, all route paths/names/nesting/builders/redirects, and
  nested navigator behavior;
- `ProjectGate`, loader/acquisition, Wizard, launcher/splash, and router lifetime;
- Board Canvas, Overview, Graph, Photos, Add/Edit/Measure, Reference Images,
  Report, and all their source/tests;
- provider meaning/lifetime, writer APIs/call paths, event envelopes, facts,
  evidence status/lifecycle, freshness, board-plane semantics, and Project ZIP;
- destination non-chrome copy, forms, tables, canvases, previews, filters,
  body actions, responsive breakpoints, and layout geometry;
- global themes/tokens, Workbench inventory/thresholds, maps/index, governance,
  packages, assets, schemas, tools, fixtures, generated/platform files, and
  Windows substantive content.

## Stop conditions

Stop the child without implementation completion if:

- a ninth path is required;
- a first-batch AppBar contains or acquires a functional action;
- router, ProjectGate, provider, writer, freshness, event/fact/evidence, or
  Project ZIP behavior must change;
- Board Canvas, Overview, Graph, Photos, Add/Edit/Measure, Reference Images, or
  Report must be edited;
- the reusable surface requires a global theme, new competing palette, route or
  provider ownership, destination layout redesign, or non-chrome copy change;
- a mapped owner is stale/conflicting or an applicable map is missing;
- exact single-AppBar, dark-surface, identity, zero-write, focused, analyzer,
  validator, or full-suite regressions fail for a scope-relevant reason;
- an excluded cleanup becomes necessary.

## Tool and skill check

- Repo-local `.agents/skills/tracebench-scope-lock` was used because this is an
  immediate docs-only reservation of an exact future route and allowlist.
- Repo-local `.agents/skills/tracebench-prompt-authoring` was used to make the
  child executable, bounded, auditable, and packet-complete.
- The brainstorming capability was used only to evaluate and select the
  coherent six-destination batch split; it created no extra authority or file.
- `docs/CODEX_TOOLING_POLICY.md` classifies external tooling as off for this
  docs-only pass. No external tool or plugin is applicable or used.

## Required validation

Phase 1 must finish with fresh evidence from:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch
git diff --numstat -- windows/
```

It must also prove route agreement across the three route owners, an exact
five-path substantive material set, one neutral `REVIEW_REQUIRED` ledger row,
one unique empty verdict block, unchanged maps/index, empty cached/unmerged
sets, and zero Windows substantive diff.

## Canonical CLAUDE_AUDIT_PACKET

```text
CLAUDE_AUDIT_PACKET

PASS_ID:
TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS

AUDIT_TYPE:
PHASE_1_SCOPE_LOCK

AUTHORITY:
- baseline 93e66fbb83876f8d17edfffe25ba0266184360b7
- docs/POHIKIRI.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_CONTRACT.md
- docs/code_maps/CODE_MAP_STANDARD.md

EXACT_MATERIAL_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS.md

VERIFY:
- exact clean committed baseline plus preserved Windows EOL/stat residue
- all 15 real destinations and two redirects are classified from live source
- first child is exactly eight paths and contains only six title-only read-only
  destination owners, seven loaded AppBar branches, one existing shell
  presentation owner, and one shell suite
- Events has exactly two loaded presentation branches; the future routed shell
  regression covers `beginnerModeProvider == false` and `true`, with one shell
  AppBar, one destination surface, the corresponding existing Events body, the
  same loaded project/provider identity, and zero writers in both cases
- current AppBar literals are exactly `Komponentide nimekiri`, `Mõõtmised`,
  `Puudub populeerimine`, `Pinnid`, `Sündmused`, and `Known facts`
- body inventory is source-accurate: ListTile row bodies for Components,
  Measurements, Not Populated, and Pins; beginner text plus advanced
  ExpansionTile content for Events; and SingleChildScrollView monospace JSON
  Text for Known Facts
- the expected title transitions are exactly `Komponentide nimekiri ->
  Komponendid`, `Puudub populeerimine -> Täitamata`, and `Known facts ->
  Teadaolevad faktid`; Measurements, Pins, and Events remain text-identical
- WorkbenchShell remains sole project-level chrome/navigation owner
- first-batch AppBars have no actions and all content/provider/freshness/writer
  boundaries are frozen
- Board Canvas, Overview, all writer/file/ZIP-sensitive destinations, router,
  ProjectGate, maps/index, and all nonallowlisted bytes are frozen
- Code Map dispositions use Standard vocabulary and missing-map stop boundaries
- test and manual-smoke contracts prove single chrome, dark coherence,
  reachability, responsive stability, identity, route behavior, and zero writes
- one empty verdict block and neutral REVIEW_REQUIRED ledger cell

RETURN:
AUDIT_VERDICT: ACCEPT_AS_IS | NEEDS_SMALL_PATCH | REJECT
SAFE_FOR_STAGING: YES | NO
SAFE_STAGING_SET: exact paths or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES | NO
BOUNDARY_RESULT: PASS | FAIL
SELF_REFERENCE_AUDIT: PASS | FAIL
BLOCKERS
NITS
```

## Accompanying CLAUDE_SNIPER_PACKET

```text
CLAUDE_SNIPER_PACKET

AUDIT_MODE:
SNIPER / VERIFY_NOT_REDISCOVER

AUTHORITY:
- PASS_ID TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS
- baseline 93e66fbb83876f8d17edfffe25ba0266184360b7
- active authority docs/ACTIVE_SCOPE_LOCK.md

EXACT_MATERIAL_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS.md

READ:
- exact five-path diff
- maintained router and Workbench shell maps
- exact map/source zones named in the artifact classification and dispositions
- exact artifact verdict block and this PASS_ID ledger row

DO_NOT_READ_BY_DEFAULT:
- unrelated CURRENT_STATE/PASS_QUEUE history
- unrelated audit artifacts or ledger history
- unrelated maps
- whole large destination source/test files outside named AppBar/Scaffold,
  action, surface/theme, and focused regression zones

VERIFY_INDEPENDENTLY:
- baseline, branch, divergence, cached/unmerged, material set, Windows freeze
- 15 routes, two redirects, class table, first-batch title-only action absence
- both Events loaded branches and both routed shell-test modes are explicitly
  required, with branch-specific body reachability, identity, and zero writes
- all six current AppBar literals, corrected body-widget inventories, three
  expected title transitions, and three text-identical shell titles match source
- exact eight-path child allowlist and every frozen boundary
- route-owner agreement, Code Map claims, test/manual smoke completeness
- empty verdict block, neutral ledger, validators, and self-reference safety

EXACT_SYMBOL_ZONES:
- lib/app/router.dart -> buildTraceBenchRouter and 15 project builders/two redirects
- lib/features/project/widgets/workbench_shell.dart -> WorkbenchShellColors,
  WorkbenchShell.build, activeWorkbenchDestination, responsive navigation
- six first-batch owners -> build, null branch, every loaded
  Scaffold/AppBar/body boundary; Events includes both `isBeginnerMode` and
  advanced branches
- Board Canvas -> _buildScaffold and read-only status-pill action only
- Board Graph -> build AppBar mode action only
- remaining destinations -> build AppBar/body-action/surface boundary only
- test/widget/workbench_shell_test.dart -> production-router fixture, inventory,
  responsive, Home/mode, all-route identity, explicit Events false/true routed
  cases, title transitions, and zero-write zones

DIRECT_COMMANDS:
- py -3 tools/doctor.py
- py -3 tools/validate_all.py
- git diff --check
- git diff --cached --check
- git diff --name-status
- git status --short --branch
- git diff --numstat -- windows/

FROZEN_AREAS:
- all Dart/tests/maps/index
- route topology, ProjectGate, providers, writers, events/facts/evidence,
  freshness, Project ZIP, global theme/tokens, packages/assets/schemas/tools,
  generated/platform/Windows substantive bytes

EXPAND_ONLY_IF:
- a named anchor fails
- map and source conflict
- material set or route inventory mismatches
- validation evidence conflicts
- a concrete potential blocker requires one dependency hop

EXPANSION_RULE:
One dependency hop at a time; state the contradiction or finding first.

RETURN:
Only the canonical audit fields required above, plus blockers and nits.
```

## Phase-2 recording boundary

If and only if the independent audit authorizes recording, Phase 2 may edit
exactly two logical coordinates:

1. the interior of the designated verdict block below; and
2. this PASS_ID's existing `docs/AUDIT_INDEX.md` Status cell.

Everything else remains byte-frozen. Phase 2 does not stage, commit, or push.

<!-- TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

<!-- TRACEBENCH_WORKBENCH_DESTINATION_CHROME_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
