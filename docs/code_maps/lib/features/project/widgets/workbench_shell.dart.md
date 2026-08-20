# Code Map: `lib/features/project/widgets/workbench_shell.dart`

- Source: `lib/features/project/widgets/workbench_shell.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_WORKBENCH_DESTINATION_CHROME_BATCH_1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the reusable loaded-project Workbench chrome around a router-supplied
destination child and the presentation-only dark surface used by simple
read-only destinations. It is the sole ordered owner of the 12 top-level
project destinations, active-parent selection, dark shared visual vocabulary,
Home and beginner-mode controls, breadcrumb, and compact/persistent navigation.
It owns transient route and presentation state only; it does not read project
state or own destination business logic, writers, persistence, freshness, or
route declarations.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Shared visual vocabulary | `WorkbenchShellColors`, `background`, `panel`, `greenTint` | Exposes the atomic dark Workbench color set used by the shell and retained Overview content. |
| Read-only destination surface | `WorkbenchDestinationSurface`, `workbench-destination-surface`, `ListTileThemeData`, `ExpansionTileThemeData` | Applies the existing color vocabulary through a local Theme and Material boundary with only `child` and widget `key` inputs. |
| Destination data model | `WorkbenchDestination`, `id`, `label`, `location`, `icon` | Defines one immutable navigation-entry shape. |
| Ordered destination inventory | `workbenchDestinations`, `Board Canvas`, `Project Overview`, `Teadaolevad faktid` | Owns the exact ordered 12-entry top-level project model; Home is not an entry. |
| Active workflow parent | `activeWorkbenchDestination`, `/project/components/add`, `/project/components/edit`, `/project/measure-sheet` | Maps Add/Edit to Components and Measure Sheet/legacy alias to Measurements before selecting an entry. |
| Shell state and inputs | `WorkbenchShell`, `_WorkbenchShellState`, `GoRouterState.of`, `beginnerModeProvider` | Reads current URI and transient beginner mode while retaining the router-supplied child. |
| Responsive frame | `_wideBreakpoint`, `_navigationWidth`, `workbench-shell`, `workbench-wide-navigation`, `workbench-compact-drawer` | Keeps navigation compact below 1228 and persistent at/above 1228 with a fixed 244-pixel rail. |
| Home and mode controls | `workbench-home-button`, `workbench-beginner-mode-button`, `context.go('/')` | Returns Home separately and toggles only the existing UI-local beginner mode. |
| Breadcrumb | `_WorkbenchBreadcrumb`, `workbench-breadcrumb`, `_BreadcrumbSeparator` | Renders horizontally scrollable BenchBeep/Töölaud/active-destination context. |
| Navigation renderer | `_WorkbenchNavigation`, `_WorkbenchDestinationTile`, `workbench-destination-`, `context.go(destination.location)` | Renders one scroll-safe model, active semantics, compact drawer close, and exact `go` navigation. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed source. The map uses no line-number anchors.

## Ordered navigation contract

The sole top-level project inventory is:

1. `/project` — Board Canvas
2. `/project/overview` — Project Overview
3. `/project/components` — Komponendid
4. `/project/measurements` — Mõõtmised
5. `/project/pins` — Pinnid
6. `/project/not-populated` — Täitamata
7. `/project/photos` — Foto tõendid
8. `/project/reference-images` — Viitepildid
9. `/project/graph` — Advanced graph
10. `/project/events` — Sündmused
11. `/project/known-facts` — Teadaolevad faktid
12. `/project/report` — Raport

Home is a separate AppBar action. Add Component, Edit Component, and Measure
Sheet remain workflow destinations and select their top-level parent rather
than becoming additional entries.

## State and data flow

1. A loaded read-only destination may wrap its existing body in
   `WorkbenchDestinationSurface`; the wrapper derives a local Theme from the
   ambient theme, applies only existing Workbench colors, and renders the
   supplied child inside one keyed Material surface.
2. The router constructs one `WorkbenchShell(child: matchedDestination)` after
   `ProjectGate` has admitted loaded state.
3. `GoRouterState.of(context).uri.path` supplies the current path;
   `activeWorkbenchDestination` normalizes workflow paths and returns one of
   the 12 immutable entries.
4. `beginnerModeProvider` supplies the existing transient display mode. The
   mode control flips only that provider value.
5. A `LayoutBuilder` compares available shell width with exactly `1228.0`.
   Below it, one drawer-backed navigation model is reachable through the menu;
   at/above it, one `244.0`-wide persistent `ListView` is rendered.
6. Home and destination actions call `go`; compact destination selection first
   closes the drawer, then navigates.
7. The router-provided child remains expanded beside the persistent rail or
   occupies the full body under compact navigation. Destination code receives
   no shell width and owns no shell breakpoint.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material/layout/semantics/theme | framework UI | Supplies the local destination Theme/Material treatment plus Scaffold, AppBar, drawer, responsive layout, scrolling, and selected-state presentation. |
| GoRouter | inbound state / outbound navigation | Supplies current URI and `go` for Home and destination changes. |
| `beginnerModeProvider` from `app.dart` | UI-local read/write | Supplies and toggles the existing presentation mode only. |
| router-provided `child` | inbound destination | Renders the matched destination without inspecting or changing it. |
| `lib/app/router.dart` | construction owner | Places one shell inside the loaded-project gate for the project subtree. |
| Project Overview | visual-token consumer | Reuses the same dark vocabulary without owning shell chrome. |
| Six Batch-1 read-only destination owners | outbound consumers | Reuse the destination surface around their unchanged loaded bodies. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `WorkbenchDestinationSurface` theme and child composition | `ZERO_WRITE` | Reads ambient theme, applies existing presentation tokens, and renders an opaque child; it has no title, route, provider, action, freshness, or writer input. |
| Destination metadata and active selection | `ZERO_WRITE` | Pure immutable values and path normalization. |
| Responsive shell, breadcrumb, navigation rendering | `ZERO_WRITE` | Reads constraints/state and builds widgets only. |
| `context.go('/')` and destination `go` | `UI_LOCAL` | Change transient router location without invoking domain writers. |
| beginner-mode assignment | `UI_LOCAL` | Mutates only the existing presentation provider. |
| compact drawer close | `UI_LOCAL` | Mutates Navigator presentation before the route change. |
| child composition | `ZERO_WRITE` | Passes through the router-owned destination unchanged. |

The file does not read or assign `projectStateProvider`, call any V2 writer,
append an event, mutate facts/evidence/freshness, access project files, load or
materialize a project, or change Project ZIP behavior. Destination labels and
navigation do not transfer destination write authority into the shell.

## Zero-write zones

- `WorkbenchShellColors`, `WorkbenchDestinationSurface`, destination metadata,
  and workflow-parent selection are pure presentation/navigation definitions.
- Breadcrumb, active semantics, and both navigation renderers only display
  current state.
- The shell child is opaque; downstream effects remain destination-owned.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Destination surface | `[D]` one local Theme/Material wrapper with a child slot | six loaded read-only destination bodies and global theme | `ZERO_WRITE` | seven-case routed Batch-1 regression |
| Destination inventory | `[D]` one const ordered list | router paths/names and destination availability | `ZERO_WRITE` | inventory and all-route matrices |
| Active selection | `[D]` exact path normalization | Add/Edit/Measure workflows and aliases | `ZERO_WRITE` | workflow/alias selection case |
| Router/provider shell identity | `[D]` stateful wrapper receives changing child | ShellRoute and provider scope | `ZERO_WRITE` | shell and gate identity tests |
| Responsive cutover | `[D]` 1228 threshold and 244 rail | Board 900, Overview 960, outer framing | `ZERO_WRITE` | six-width shell/Board/Overview cases |
| Home navigation | `[D]` separate AppBar `go('/')` | launcher and provider lifetime | `UI_LOCAL` | Home/project round trip |
| Beginner mode | `[D]` one provider assignment | other mode consumers | `UI_LOCAL` | leaf and Home round-trip survival |
| Shared colors | `[D]` public constants used by Overview | Overview cards/preview/actions | `ZERO_WRITE` | shell-copy/color assertions |

## Relevant tests and helpers

- `test/widget/workbench_shell_test.dart` directly covers the ordered model,
  workflow-parent mapping, same shell identity, provider survival, compact
  reachability, exact 1228 cutover, Home round trip, representative routes,
  aliases, and zero writer/event/fact/file/freshness mutation. Its routed
  Batch-1 matrix covers seven loaded cases across six URIs, one shell AppBar,
  one keyed destination surface, active breadcrumb/selection, preserved body
  signatures, both Events modes, and stable project/fact/event identities plus
  recursive file-listing observation.
- `test/widget/project_gate_test.dart` proves the gate remains outside the
  shell, null recovery is shell-free, and one shell identity spans all 15 real
  loaded destinations plus nested push/pop.
- Routed Board Canvas and Overview suites cover `959`, `960`, `1227`, `1228`,
  `1229`, and `1500` without destination responsive inversion.

## Dangerous combinations

- Changing the shell cutover without both retained destination thresholds and
  framing can reintroduce rich-to-compact inversion.
- Duplicating the destination list in a destination screen can drift order,
  paths, active semantics, or zero-write evidence.
- Turning Home into a list entry or adding workflow leaves as top-level entries
  changes product navigation ownership.
- Reading project state here would blur the gate/provider boundary; moving the
  gate inside the shell would expose chrome during recovery.
- Adding route, title, provider, freshness, or action ownership to
  `WorkbenchDestinationSurface` would turn a presentation wrapper into a
  competing destination or business owner.
- Copying only part of `WorkbenchShellColors` back into Overview can create two
  competing visual vocabularies.

## Safe SNIPER slices

- One destination metadata change: exact list entry, router owner, active-state
  mapping, and matching shell/gate route evidence.
- One workflow-parent mapping: `activeWorkbenchDestination` and the focused
  unit/widget alias-selection case.
- Responsive shell only: `_wideBreakpoint`, `_navigationWidth`, both keyed
  navigation modes, and all three six-width suites.
- Home/mode control only: AppBar action, provider/route assertions, and Home
  round trip.
- Shared visual token only: exact color constant and Overview consumers.
- Read-only surface only: `WorkbenchDestinationSurface`, the seven loaded
  consumer branches, and the routed Batch-1 chrome/body/zero-write matrix.

## Future extraction seams

- `[S]` Destination metadata could become a pure navigation model in a smaller
  owner if router and test inventories remain independently verifiable.
- `[S]` Breadcrumb and destination tile are cohesive presentation units but do
  not currently require separate ownership.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when shell, destination-surface, breakpoint, key, or
color anchors change; `FLOW_DRIFT` when active mapping, drawer close, `go`,
child, or provider flow changes; `BOUNDARY_DRIFT` if project state, freshness,
writers, files, or persistence enter; `TEST_DRIFT` when Batch-1, identity,
route, responsive, or no-write evidence moves; and `STRUCTURE_DRIFT` when
navigation or destination-surface ownership splits.

## Known uncertainty

- `[D]` The shell proves navigation calls no writer in this owner; downstream
  destination behavior remains outside its boundary.
- `[D]` The threshold is derived from current destination framing; future
  framing changes require a fresh joint calculation.
- `[S]` Extraction seams are descriptive only and authorize no refactor.
