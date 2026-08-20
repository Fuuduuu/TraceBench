# Code Map: `lib/app/router.dart`

- Source: `lib/app/router.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `HUMAN OVERRIDE — creation handoff crosses router, screen and provider boundaries and requires durable impact analysis.`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Builds the single application route graph. It keeps `/` and `/new-project`
outside one pathless `ShellRoute`, places only the existing `/project` subtree
inside that shell, and composes its builder as `ProjectGate` outside
`WorkbenchShell` outside the matched destination. All 15 real project targets,
their paths and names, and both compatibility redirects remain registered. The
file owns route construction and navigation topology only; provider reads,
project recovery, destination behavior, and canonical writes remain outside.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Route factory contract | `buildTraceBenchRouter`, `initialLocation`, `homeBuilder`, `newProjectBuilder` | Exposes initial-route, required root-Home, and optional Wizard-construction seams. |
| Root Home route | `path: '/'`, `name: 'home'`, `homeBuilder` | Builds only the caller-supplied canonical root surface. |
| New Project Wizard route | `path: 'new-project'`, `name: 'new-project'`, `NewProjectWizardScreen` | Builds the injected Wizard when supplied or the unchanged const default. |
| Shared project shell and gate | `ShellRoute`, `ProjectGate`, `WorkbenchShell`, `child: WorkbenchShell(child: child)` | Wraps only the project subtree in one gate-outside-shell composition. |
| Canonical Board Canvas route | `path: 'project'`, `name: 'board-canvas'`, `BoardCanvasScreen` | Keeps `/project` as the canonical Canvas destination and parent of its existing child routes. |
| Overview and component routes | `project-overview`, `component-list`, `add-component`, `edit-component` | Registers four unchanged project destinations as bare matched children. |
| Measurement and pin routes | `measurement-list`, `measure-sheet`, `not-populated`, `pin-list` | Registers four unchanged measurement/population/pin destinations. |
| Evidence, media, graph, and report routes | `events`, `known-facts`, `photos`, `reference-images`, `board-graph`, `customer-report` | Registers six unchanged evidence/media/graph/report destinations. |
| Redirects and error surface | `measurements/new`, `board-canvas`, `redirect`, `errorBuilder`, `Unknown route` | Retains two compatibility redirects and renders unresolved-route errors. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed source. The map uses no line-number anchors.

## State and data flow

1. A caller invokes `buildTraceBenchRouter` with an initial URI, a required
   Home builder, and an optional Wizard builder.
2. `GoRouter` consumes the static tree; this factory retains no mutable project
   or provider state.
3. `/` delegates to `homeBuilder`; `/new-project` delegates to the injected
   builder or `const NewProjectWizardScreen()`.
4. One pathless `ShellRoute` contains only the `project` route and its existing
   descendants; it introduces no public path or name.
5. The shell builder creates `ProjectGate(child: WorkbenchShell(child: child))`.
   A null project is stopped by the gate before the shell or destination is
   mounted; loaded state reveals both.
6. The 15 real destinations are bare destination widgets beneath the shared
   composition rather than 15 repeated gate wrappers.
7. Moving among project leaves with `go` retains the shared shell element/state;
   the nested route navigator also preserves the tested `push` then `pop`
   return from Overview to canonical Canvas.
8. `/project/measurements/new` and `/project/board-canvas` remain redirect-only
   aliases and settle on their unchanged canonical URI strings.
9. Unresolved routes render the existing generic error text.

## Project target inventory

The shared gate and shell cover exactly these real targets:

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

The two compatibility aliases are not additional real targets.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework UI | Supplies widget-builder types and the error surface. |
| GoRouter | routing framework | Owns matching, the pathless shell navigator, nesting, redirects, route state, and errors. |
| caller-supplied `homeBuilder` | required inbound contract | Keeps canonical launcher ownership in `app.dart`. |
| `NewProjectWizardScreen` | default outbound destination | Preserves default Wizard construction. |
| `ProjectGate` | outer project wrapper | Applies loaded-project recovery before shared chrome mounts. |
| `WorkbenchShell` | inner project wrapper | Supplies shared project navigation and chrome around the matched child. |
| Project destination screens | outbound destinations | Implement behavior behind the unchanged route inventory. |
| `lib/app/app.dart` | production caller | Supplies Home and Wizard builders and owns router lifetime. |
| `test/widget/project_gate_test.dart` | direct route/gate evidence | Proves null/loaded matrices, all 15 targets, both aliases, shell identity, nested back behavior, provider identity, and zero mutation. |
| `test/widget/workbench_shell_test.dart` | direct shell evidence | Proves destination selection, navigation, responsive shell state, and Home/provider survival. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `buildTraceBenchRouter` and route declarations | `ZERO_WRITE` | Construct navigation objects and widget builders only. |
| `initialLocation` and redirects | `UI_LOCAL` | Select transient URI presentation. |
| `homeBuilder` and `newProjectBuilder` | `ZERO_WRITE` | Invoke widget factories; downstream widgets own any effects. |
| `ShellRoute` builder | `ZERO_WRITE` | Composes gate, shell, and child without reading providers or invoking writers. |
| Destination builders | `ZERO_WRITE` | Instantiate existing screens only. |
| `errorBuilder` | `ZERO_WRITE` | Reads routing failure and renders text. |

The file imports neither Riverpod nor `ProjectState`. Importing `ProjectGate`
and `WorkbenchShell` does not transfer their downstream provider/UI ownership
into the router. There is no event/fact append, filesystem write, Project ZIP
operation, creator call, materializer call, coordinate conversion, or
electrical-semantic mutation here.

## Zero-write zones

- Route metadata and builders describe navigation only.
- The pathless shell composes existing widgets without domain mutation.
- Redirect callbacks return URI strings only.
- Error presentation reads route state and renders text.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Factory/root/Wizard | `[D]` parameters invoke exact builders | app lifecycle, launcher, Wizard handoff | `ZERO_WRITE` / `UI_LOCAL` | Home and Wizard route suites |
| Shared project composition | `[D]` one pathless shell builder wraps one project parent | gate source, shell source, provider scope | `ZERO_WRITE` | gate and shell suites |
| Project route inventory | `[D]` 15 exact builders remain beneath `project` | every destination screen | `ZERO_WRITE` | loaded/null 15-route matrices |
| Nested navigation | `[D]` `ShellRoute` adds the shared route navigator | GoRouter stack behavior | `UI_LOCAL` | focused push/pop regression |
| Redirects | `[D]` two exact target strings remain | canonical Canvas and Measure Sheet | `UI_LOCAL` | alias settlement tests |
| Error surface | `[D]` error text only | GoRouter failure semantics | `ZERO_WRITE` | no focused error test identified |

## Relevant tests and helpers

- `test/widget/project_gate_test.dart` is the focused route-layer owner for
  shell-free null recovery, loaded all-15 coverage, one gate/shell, same shell
  identity, both aliases, nested push/pop, Home recovery, provider identity,
  and byte-level zero-mutation checks.
- `test/widget/workbench_shell_test.dart` covers the shared destination model,
  leaf navigation, workflow-parent selection, responsive cutover, Home round
  trip, and no-write navigation.
- `test/widget/benchbeep_home_screen_test.dart` retains the real app lifetime,
  Wizard handoff, canonical Home, and provider-survival contract.
- Overview, Board Canvas, edit-component, Wizard, and freshness harnesses remain
  direct callers/consumers of the unchanged route paths.

## Dangerous combinations

- Moving `ProjectGate` inside `WorkbenchShell` would expose shared chrome during
  null recovery and contradict the focused null matrix.
- Replacing the one pathless shell with per-leaf wrappers would lose the proven
  shared element/state identity.
- Reparenting routes, adding a parent navigator key, or changing `go`/`push`
  assumptions can alter nested back-stack behavior without changing public URI
  text.
- Changing route inventory and aliases together can strand deep links or hide a
  missing real target.
- Adding provider or writer logic here would cross the navigation-only boundary.

## Safe SNIPER slices

- Factory/root contract: `buildTraceBenchRouter`, builders, production caller,
  and Home/Wizard route evidence.
- Shared composition: `ShellRoute`, its builder, `ProjectGate`,
  `WorkbenchShell`, and gate/shell identity tests.
- One project leaf: its path/name/builder plus the exact 15-target matrix.
- One alias: redirect callback, canonical target, and alias settlement test.
- Nested stack only: shell structure plus the focused push/pop case.

## Future extraction seams

- `[S]` The large project-child route list could move to a pure route-fragment
  builder if all names, nesting, and redirects remain explicit.
- `[S]` Compatibility redirects could be grouped only after equivalent direct
  deep-link evidence exists.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when factory parameters, route paths/names,
`ShellRoute`, `ProjectGate`, `WorkbenchShell`, or screen constructors change;
`FLOW_DRIFT` when wrapper order, null/loaded reveal, redirect, or nested stack
behavior changes; `BOUNDARY_DRIFT` if provider/write ownership enters;
`TEST_DRIFT` when route matrices or shell identity evidence move; and
`STRUCTURE_DRIFT` when the shared subtree or guarded inventory splits.

## Known uncertainty

- `[D]` Route builders prove construction, not downstream destination behavior.
- `[D]` Gate tests prove the current nested `push`/`pop` case; they do not claim
  every possible GoRouter stack sequence.
- `[D]` No focused route-error assertion is identified.
