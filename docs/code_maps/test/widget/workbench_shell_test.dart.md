# Code Map: `test/widget/workbench_shell_test.dart`

- Source: `test/widget/workbench_shell_test.dart`
- Type: `test`
- Status: `MAINTAINED`
- Qualification: `SCORE 7/12 — eight tests across inventory, active selection, shell/provider identity, responsive navigation, Home round-trip, alias, and zero-write families`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Provides focused contract evidence for the shared loaded-project Workbench
shell. Two unit tests verify its sole ordered destination model and workflow-
parent selection. Six widget tests use the production router to verify one
shell/provider identity across leaves, compact reachability, the exact 1228
persistent cutover, Home/project survival, representative zero-write routes,
and alias selection. Four writer sentinels plus event/fact/freshness/file
checks protect the navigation-only boundary.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Expected destination contract | `_expectedDestinationPaths`, `owns the exact ordered top-level destination inventory` | Defines the exact ordered 12 paths and excludes Home/Add/Edit/Measure Sheet. |
| Loaded fixture | `_loadedProject`, `ProjectionFreshness.fresh`, `evt-workbench-shell-readonly` | Builds one identifiable loaded project with a seeded event and report. |
| Writer sentinels | `_UnexpectedAddComponentWriter`, `_UnexpectedEditComponentWriter`, `_UnexpectedPlacementWriter`, `_UnexpectedSaveMeasurementWriter` | Count and fail any unexpected canonical writer call. |
| Router/provider/file harness | `_RouterSession`, `_pumpRouter`, `ProviderContainer`, `fixture.txt` | Creates a temporary fixture, overrides project/mode/writers, mounts the production router/theme, and exposes observations. |
| Route settling | `_pumpUntilRouterPath`, `routeInformationProvider` | Waits for expected URI plus Navigator transition completion. |
| Active selection contract | `maps workflow routes to their top-level active destinations`, `activeWorkbenchDestination` | Verifies Add/Edit -> Components and Measure Sheet -> Measurements while canonical Canvas selects itself. |
| Shell/provider identity | `keeps one shell identity and providers across project leaf navigation`, `WorkbenchShell`, `same(session.loadedProject)` | Proves one on/offstage shell, identical element/state, loaded-project identity, beginner mode, and events across a leaf change. |
| Compact and persistent responsive modes | `renders one reachable compact navigation model`, `persistent navigation starts at the safe 1228 width`, `workbench-wide-navigation`, `workbench-compact-menu-button` | Proves reachable drawer navigation and exact six-width shell cutover. |
| Home/provider round trip | `Home round trip preserves project and beginner mode`, `workbench-home-button` | Verifies separate Home control and loaded project/mode survival through re-entry. |
| Navigation mutation guards | `shared destination controls navigate exact routes without state writes`, `calls`, `listSync` | Checks representative exact routes with stable project/facts/events/freshness/files and zero writer calls. |
| Workflow and alias selection | `workflow and aliases select one canonical shell destination`, `/project/measurements/new`, `/project/board-canvas` | Verifies workflow-parent selection and both compatibility redirects settle on canonical shell entries. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed test source. The map uses no line-number anchors.

## Qualification evidence

The reproducible worksheet is retained in the matching audit artifact. Compact
result: physical size `0`; independent responsibilities `2`; multiple
protected/provider/writer/file boundaries `2`; three-plus behavior families
`2`; recurring whole-file analysis `0`; coupled blast-radius ambiguity `1`;
total `7/12`. At least two non-size dimensions are nonzero, so the committed
test file qualifies without a human override or automatic trigger.

## State and data flow

1. `_pumpRouter` creates a temporary project directory with one unchanged file,
   a loaded project with one event, four fail-on-call writers, a provider
   container, and the production router.
2. The inventory unit test compares production locations with the exact 12-path
   expectation, proves uniqueness, excludes `/` and workflow leaves, and
   verifies every top-level entry selects itself.
3. The active-selection unit test verifies Components and Measurements parent
   mapping for destination-specific workflow paths.
4. The identity widget test records the shell element/state, toggles beginner
   mode, moves to Components, and requires the same shell, project object,
   event collection, and mode value.
5. The compact case opens one drawer, selects Measurements, and retains one
   shell. The responsive case checks 959, 960, 1227, 1228, 1229, and 1500.
6. Home navigation preserves project and beginner mode, and direct re-entry to
   `/project` reveals Board Canvas inside one shell.
7. Representative destination taps preserve exact project/fact/event/freshness
   values, all four zero call counts, and the recursive file listing.
8. Workflow and compatibility paths select one canonical parent entry after
   redirect settlement.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `WorkbenchShell`, destination model/helpers | system under test | Supplies inventory, active selection, keys, responsive chrome, Home/mode controls, and navigation. |
| `buildTraceBenchRouter`, `GoRouter` | production harness | Supplies real shell composition, routes, aliases, and current URI. |
| `projectStateProvider`, `beginnerModeProvider` | fixture/observation | Injects loaded state/mode and proves identity/survival. |
| `BoardCanvasScreen` | destination observation | Proves Home re-entry reaches canonical `/project`. |
| Four V2 writer interfaces/providers | protected-boundary sentinels | Fail/count any unexpected add/edit/placement/measurement call. |
| Project/manifest/fact/event models | fixture | Build typed state with event/fact/freshness observations. |
| Flutter tester/layout/navigation APIs | driver | Control surface size, drawer, taps, scrolling, and element/state identity. |
| `dart:io` Directory/File | fixture boundary | Creates and later deletes one noncanonical temporary tree. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Inventory and active-selection unit tests | `ZERO_WRITE` | Read pure production metadata/functions only. |
| Router/destination navigation | `UI_LOCAL` | Changes transient route location/drawer state. |
| Beginner-mode toggle | observed `UI_LOCAL` | Verifies only the existing presentation provider changes. |
| Project/provider identity assertions | `ZERO_WRITE` | Read and compare existing in-memory objects/values. |
| Four writer sentinels | exercised `CANONICAL_EVENT` boundary | All call counts remain zero during shell navigation. |
| Temp fixture setup/teardown | `NONCANONICAL_FILE` | Test-only file creation/deletion outside product persistence. |
| Recursive file listing | `ZERO_WRITE` | Observes unchanged paths only. |

## Zero-write zones

- Inventory, active-state, shell identity, responsive presentation, Home round
  trip, and alias assertions contain no explicit product save action.
- Navigation stops at destination presentation.
- Writer, event, fact, freshness, provider, and file observations prove absence
  of mutation for the exercised shell paths.

## Impact matrix

| Family | Direct evidence | Coupling | Write class | Escalation |
| --- | --- | --- | --- | --- |
| Inventory/active mapping | `[D]` pure production model/functions | router paths and workflows | `ZERO_WRITE` | two unit tests + route owners |
| Harness | `[D]` production router/providers/four writers/temp file | all widget cases | setup | full target |
| Shell identity/providers | `[D]` element/state/object identity | ShellRoute/gate/provider scope | `ZERO_WRITE` | identity case + gate matrix |
| Compact navigation | `[D]` drawer/menu/tap | route and scroll reachability | `UI_LOCAL` | compact case |
| Persistent cutover | `[D]` six exact widths | shell/Board/Overview responsive owners | `ZERO_WRITE` | cutover + destination suites |
| Home round trip | `[D]` exact route and provider values | launcher/router lifetime | `UI_LOCAL` | Home case + Home suite |
| No-write routes | `[D]` values/calls/file listing | four writers/project state | `ZERO_WRITE` | representative route loop |
| Workflows/aliases | `[D]` selected ListTiles and canonical URIs | router redirects | `UI_LOCAL` | alias-selection case |

## Relevant tests and helpers

- Eight declarations: two `test` and six `testWidgets`.
- `_expectedDestinationPaths` is the exact expected order; production
  `workbenchDestinations` remains independently owned by the shell.
- `_RouterSession`, `_pumpRouter`, and `_pumpUntilRouterPath` own common routed
  setup/settling.
- The four `_Unexpected*Writer` classes make the zero-call boundary explicit.
- `test/widget/project_gate_test.dart` extends identity evidence across all 15
  real destinations, shell-free null state, nested push/pop, and file bytes.
- Routed Overview and Board suites independently pair the same six widths with
  destination geometry.

## Dangerous combinations

- Changing `_expectedDestinationPaths` together with production metadata can
  hide an unintended inventory change; router/map evidence must remain paired.
- Finder count alone does not prove shell lifetime; element and State identity
  checks must remain.
- Checking only shell navigation mode can miss destination responsive inversion.
- Route URI equality may precede Navigator completion; retain bounded settling
  before destination assertions.
- Temp fixture changes must remain test-only and cleanup-safe.
- Removing writer/file/fact/event assertions would weaken the zero-write claim.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Destination order | expected path list and inventory unit test | router/shell model | inventory + all-route gate matrix |
| Workflow parent | active-selection unit test | router workflows/aliases | unit + alias widget case |
| Shell identity | identity widget test | ShellRoute/gate/provider scope | identity + loaded gate matrix |
| Responsive cutover | six-width case | Board/Overview geometry | all three responsive cases |
| Home/mode survival | Home round-trip case | launcher/router lifetime | Home case + Home suite |
| No-write navigation | representative route loop and sentinels | destination writers | loop + gate mutation matrix |

## Future extraction seams

- `[S]` Six-width expectations could be a pure shared fixture only if each
  destination continues to assert its own geometry.
- `[S]` Repeated shell/provider invariants could become an expectation helper
  if object/value evidence remains explicit.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for fixture/helper/test-name `SYMBOL_DRIFT`, route/drawer/
provider `FLOW_DRIFT`, writer/file/mode `BOUNDARY_DRIFT`, behavior-family
`TEST_DRIFT`, or shell/harness `STRUCTURE_DRIFT`. Recheck exact declaration
count, ordered 12 paths, six widths, all four writer sentinels, and provider/
file guards whenever imported contracts change.

## Known uncertainty

- `[D]` Representative shell route taps do not cover every destination; the
  gate suite owns the exact loaded 15-route matrix.
- `[P]` File listing equality proves the exercised fixture tree stayed stable,
  not all possible external filesystem behavior.
- `[S]` Extraction observations are descriptive and non-authorizing.
