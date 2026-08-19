# TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS

Status: `REVIEW_REQUIRED`

## Pass identity

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS
Lane: B
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: bcf791f10c52a4ef2f45490f5472e2c22dee328b
```

This artifact locks Shared Workbench Navigation Shell v1. It reserves one
exact eight-path implementation child and does not implement, accept, stage,
commit, or push that child.

## Live baseline and route evidence

Read-only Git verification established:

- repository: `C:\dev\TraceBench`;
- branch: `main`;
- `HEAD == origin/main ==
  bcf791f10c52a4ef2f45490f5472e2c22dee328b`;
- parent: `efcf14ccfaba31eb223ba73ce67df3b748f97ac0`;
- subject: `docs: optimize Claude audit handoff`;
- divergence: `0 0`;
- cached paths: `0`;
- unmerged paths: `0`; and
- substantive content diff: `0`.

The status-only changes in
`windows/flutter/generated_plugin_registrant.cc`,
`windows/flutter/generated_plugin_registrant.h`, and
`windows/flutter/generated_plugins.cmake` are the known content-identical
Windows EOL/stat residue. They remain outside both allowlists.

Commit `bcf791f10c52a4ef2f45490f5472e2c22dee328b` completes the accepted
`TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_IMPL_PASS`. The human selected
this product scope as the next route decision, so no route-header cleanup pass
is inserted:

```text
TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_IMPL_PASS
   [completed at bcf791f]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS
   [conditional on accepted and pushed scope]
-> committed-source Code Map maintenance [when required]
-> NEEDS_USER_DECISION [non-executable]
```

No earlier runtime allowlist is inherited.

## Exact Phase-1 material set

This scope may author exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS.md`

No sixth path is authorized. Phase 1 is limited to reconciling the three
route-owner tops, adding one neutral `REVIEW_REQUIRED` ledger row, and
creating this artifact with one named empty verdict block. Runtime, tests,
maps, and the Code Map index remain unchanged in this phase.

## Current shell ownership

Committed source has four separate ownership fragments:

1. `lib/app/app.dart` owns one lifetime `GoRouter`, one lifetime
   `MaterialApp.router`, launcher transitions, startup-intro state, and the
   application-level provider lifetime. That ownership is correct and remains
   inspect-only.
2. `lib/app/router.dart` owns the unchanged public route graph. It currently
   repeats `ProjectGate(child: ...)` in each of 15 real project destination
   builders and keeps the two compatibility aliases as redirects.
3. `ProjectOverviewScreen` privately owns Home navigation, the beginner-mode
   control, breadcrumb, dark Workbench vocabulary, responsive Overview
   content layout, workflow buttons, destination buttons, and inert future
   tools alongside its summary, preview, and freshness content.
4. `BoardCanvasScreen` separately owns `_ProjectNavigationHub`, a `Projekt`
   rail action, and a default `projectNavigation` context-panel mode. Its hub
   repeats Home plus 11 project destinations and therefore competes with the
   Overview navigation model.

`ProjectGate` already has the correct null/loaded responsibility: null state
renders the existing recovery surface without changing the requested URI;
loaded state renders its child. It does not need a source change.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was checked first. All six existing targets
that will change have matching `MAINTAINED` maps, and the maps agree with
committed source:

| Future target | Map result | Exact changed zones |
| --- | --- | --- |
| `lib/app/router.dart` | `docs/code_maps/lib/app/router.dart.md` — `MAINTAINED` | `buildTraceBenchRouter`; guarded project tree; 15 builders; two redirects; add one pathless `ShellRoute`, move the one gate outside the shell, preserve every public route |
| `lib/features/project/screens/project_overview_screen.dart` | `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md` — `MAINTAINED` | zones 1, 2, 8, and 10: provider/chrome split, `_WorkbenchMenuBreadcrumb`, destination part of `_ActionRailCard`, and `_ProjectHomeShellColors`; summary/preview/freshness zones remain Overview-owned |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md` — `MAINTAINED` | zones 1 and 11: `_WorkbenchContextPanelMode`, default mode, project-panel switch, `_WorkbenchToolRail`, and `_ProjectNavigationHub`; all writer/canvas/freshness zones excluded |
| `test/widget/project_gate_test.dart` | `docs/code_maps/test/widget/project_gate_test.dart.md` — `MAINTAINED` | zones 1, 4, 6, and 8: exact route inventory, router harness, null/loaded shell ordering, aliases, Home, and back-stack evidence |
| `test/widget/project_overview_screen_test.dart` | `docs/code_maps/test/widget/project_overview_screen_test.dart.md` — `MAINTAINED` | zones 2, 3, 5, 8, 9, and 10: routed harness, route identity, moved shell/nav assertions, retained Overview content/workflows/inert controls, and zero-write evidence |
| `test/widget/board_canvas_screen_test.dart` | `docs/code_maps/test/widget/board_canvas_screen_test.dart.md` — `MAINTAINED` | zones 1, 2, 10, and 11: routed harness, shell baseline, removal/migration of Project-hub coverage, retained local panel/focus and zero-write boundaries |

The explicit multi-zone combinations are authorized because each is one
coherent ownership move: Overview donates only shared chrome/navigation and
its visual vocabulary; Board Canvas removes only its competing navigation
subsystem. Splitting either extraction would create duplicate ownership.

There is no maintained map for
`lib/features/project/widgets/project_gate.dart`; its accepted qualification
remains `SCORE 5/12 — NOT_APPLICABLE`, and its source is inspect-only. The two
new Dart targets have no committed source yet, so they must be qualified from
accepted committed implementation source during the later Code Map
maintenance pass. A missing pre-implementation map for a scoped new file is
not treated as implementation authority.

Direct router consumers were also bounded. `lib/app/app.dart`, the Home and
splash suites, the Wizard source/suite, the edit-component suite, and
`test/integration/projection_stale_banner_end_to_end_test.dart` remain
inspect-only regression owners; their responsibilities do not require edits.

## Chosen shell architecture

The implementation must add one reusable `WorkbenchShell` and its sole
project-navigation metadata owner in
`lib/features/project/widgets/workbench_shell.dart`.

`lib/app/router.dart` must add one pathless `ShellRoute` around only the
existing `GoRoute(path: 'project', name: 'board-canvas', ...)` subtree. The
shell route is justified because a wrapper repeated in 15 destination
builders would create replacement shells, while wrapping only the parent
`GoRoute` would leave its shell page behind nested destination pages. One
pathless shell route is the smallest structure that keeps one mounted shell
across project-leaf navigation.

The required builder ordering is:

```text
ShellRoute.builder
-> ProjectGate
-> WorkbenchShell
-> matched project destination child
```

The `ShellRoute` adds no path, name, redirect, provider, router, or product
destination. Do not add a `parentNavigatorKey`, `StatefulShellRoute`, parallel
router, or route reparenting beyond this pathless wrapper. Because a
`ShellRoute` introduces a nested navigator, existing back behavior must be
proved rather than assumed.

The shell owns only:

- Home navigation via the existing router and `go('/')`;
- the project breadcrumb and active destination label;
- the existing `beginnerModeProvider` toggle as a `UI_LOCAL` state change;
- one ordered project-destination metadata list;
- wide persistent project navigation;
- compact reachable project navigation without overflow;
- selected/active presentation and semantics; and
- the reusable dark Workbench frame/color vocabulary.

At widths of at least 960 logical pixels, project navigation is a persistent,
scroll-safe side list. Below 960, the same metadata is reachable from a compact
drawer/menu and is not simultaneously rendered as a second navigation model.
Every enabled navigation item uses `go`, selected state is visually and
semantically distinguishable, and the shell adds no disabled placeholder that
looks actionable.

The ordered top-level project destination metadata is exactly:

1. Board Canvas — `/project`
2. Project Overview — `/project/overview`
3. Components — `/project/components`
4. Measurements — `/project/measurements`
5. Pins — `/project/pins`
6. Not Populated — `/project/not-populated`
7. Photos — `/project/photos`
8. Reference Images — `/project/reference-images`
9. Graph — `/project/graph`
10. Events — `/project/events`
11. Known Facts — `/project/known-facts`
12. Report — `/project/report`

Home is a separate shell control, not a thirteenth project destination.
`/project/components/add` and `/project/components/edit` remain separate
workflow destinations and select Components in the shell.
`/project/measure-sheet` remains a separate workflow destination and selects
Measurements. The two aliases settle on their existing canonical paths before
active-state presentation. No Add/Edit/Measure consolidation is authorized.

## ProjectGate ordering and route invariants

`ProjectGate` must wrap `WorkbenchShell`, never the reverse. The 15 repeated
leaf wrappers in `router.dart` are replaced by this one gate instance for the
matched project subtree; the gate source stays byte-frozen.

With null project state:

- the exact existing recovery UI appears;
- neither `WorkbenchShell` nor the requested destination mounts;
- the original requested URI remains unchanged; and
- Home recovery still uses canonical `/`.

With loaded state:

- exactly one `ProjectGate`, one `WorkbenchShell`, and the requested
  destination mount;
- the same shell element/state identity survives `go` between project leaves;
- the loaded `projectStateProvider` object and `beginnerModeProvider` value
  survive project navigation and Home/project round trips; and
- shell navigation performs no writer call, event append, fact mutation,
  filesystem write, freshness change, or persistence operation.

All public route paths, names, relative nesting, deep links, and destination
constructors stay unchanged. The 15 real destinations remain:

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

The aliases remain exactly:

- `/project/board-canvas` -> `/project`;
- `/project/measurements/new` -> `/project/measure-sheet`.

Nested push/pop must retain current semantics: from loaded `/project`,
`push('/project/overview')` followed by pop returns to canonical `/project`
and Board Canvas with the same providers and one shell. Shell top-level
destination and Home actions use `go`, not `push`.

## Overview donor boundary

`ProjectOverviewScreen` remains a named destination and is not deleted. It
donates only shared shell/navigation ownership:

- its AppBar Home/mode controls and `_WorkbenchMenuBreadcrumb` move to the
  shared shell;
- the destination-navigation portions of `_ActionRailCard` move into the
  single metadata owner and are removed from Overview; and
- `_ProjectHomeShellColors` moves atomically to reusable
  `WorkbenchShellColors` rather than being copied or partially forked.

Overview retains its provider/null branch, board-normalized placement filter,
`ProjectionStaleBanner`, manifest/counter/sample summary, read-only placement
preview and painters, placeholder state, responsive workbench-zone/action-rail
content layout, Measure Sheet/Add/Edit workflow actions, and all inert future
tools with null callbacks. Destination-owned business logic and writers do
not move.

## Board Canvas boundary

Board Canvas remains canonical `/project` and the primary project workbench.
Only its competing project-navigation subsystem is removed:

- remove the `projectNavigation` enum value and restore the default context
  mode to `hidden`;
- remove the project-navigation switch branch;
- remove the `Projekt` rail toggle and `_WorkbenchToolRail.projectTool`; and
- remove `_ProjectNavigationHub` plus its 12 local action keys/routes.

The shared shell suite inherits the exact navigation/no-write contract. Board
Canvas retains every other rail mode, Measure Sheet push behavior, focus
hide/restore behavior, component/measurement/placement writers, selection,
geometry, painters, Wizard-intake rendering, inspector/evidence panels,
responsive canvas composition, and freshness seam.

## Exact future implementation allowlist

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / SHARED_WORKBENCH_SHELL / UI_LOCAL
```

The exact future write allowlist is:

1. `lib/app/router.dart`
2. `lib/features/project/widgets/workbench_shell.dart` — new
3. `lib/features/project/screens/project_overview_screen.dart`
4. `lib/features/board_canvas/screens/board_canvas_screen.dart`
5. `test/widget/workbench_shell_test.dart` — new
6. `test/widget/project_gate_test.dart`
7. `test/widget/project_overview_screen_test.dart`
8. `test/widget/board_canvas_screen_test.dart`

No ninth path, deletion, rename, move, package, generated file, or map edit is
authorized. The child activates only after independent acceptance, bounded
verdict recording, and exact human staging, commit, and push of this five-path
scope.

## Exact implementation symbol closure

| Future path | Authorized symbols/responsibilities |
| --- | --- |
| `lib/app/router.dart` | `buildTraceBenchRouter`; add one pathless `ShellRoute`; move one `ProjectGate` outside `WorkbenchShell`; preserve root, Wizard, 15 real routes, two aliases, and error surface |
| `lib/features/project/widgets/workbench_shell.dart` | new `WorkbenchShell`, `WorkbenchDestination`, sole ordered `workbenchDestinations`, active-path resolver, responsive wide/compact navigation, Home/breadcrumb/mode controls, and `WorkbenchShellColors` |
| `lib/features/project/screens/project_overview_screen.dart` | `ProjectOverviewScreen.build`, `_WorkbenchMenuBreadcrumb`, destination portion of `_ActionRailCard`, `_ProjectHomeShellColors`; extract shell ownership while retaining all content/workflow/freshness responsibilities |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `_WorkbenchContextPanelMode`, `_contextPanelMode`, project switch branch, project rail toggle, `_WorkbenchToolRail`, `_ProjectNavigationHub`; remove only the competing navigation subsystem |
| `test/widget/workbench_shell_test.dart` | new focused production-router shell, metadata, responsive, active-state, navigation, provider, alias, back-stack, identity, and zero-write coverage |
| `test/widget/project_gate_test.dart` | `_projectDestinations`, `_RouterSession`, `_pumpRouter`, null/loaded/success/Home/all-15/alias cases, one-gate/one-shell ordering, shell-free recovery, and push/pop regression |
| `test/widget/project_overview_screen_test.dart` | `_pumpProjectOverview`, route/shell assertions, retained summary/preview/freshness/workflow/inert-control cases, moved destination assertions, and zero-write coverage |
| `test/widget/board_canvas_screen_test.dart` | `_projectHubDestinations`, `_projectHubActionKeys`, `_revealProjectHubAction`, default-panel/rail/focus tests; migrate shared navigation coverage and retain every local writer/geometry/freshness family |

## Focused automated test contract

The implementation must add or strengthen focused evidence for:

1. exactly one mounted shell, including `skipOffstage: false`, on
   representative loaded `/project`, Overview, read-only, and workflow
   destinations;
2. the same shell element/state identity across project-leaf `go` navigation;
3. the exact ordered 12-entry metadata list, unique canonical paths, Home as a
   separate control, and absence of Add/Edit/Measure Sheet as top-level items;
4. active selection for every canonical entry plus Components selection on
   Add/Edit and Measurements selection on Measure Sheet;
5. persistent scroll-safe wide navigation at representative 1000/1400 widths;
6. reachable compact navigation at representative phone width with no
   overflow or simultaneous second navigation model;
7. Home navigation to `/`, then re-entry to `/project`, with the same loaded
   project object and beginner-mode value;
8. beginner-mode toggle survival across route changes;
9. null deep-link recovery at the exact requested URI with no shell or
   destination, followed by successful provider handoff revealing exactly one
   shell without URI replacement;
10. all 15 real destinations, both unchanged aliases, canonical Home recovery,
    deep-link behavior, and no duplicate shell after redirects;
11. loaded `/project` -> `push('/project/overview')` -> pop returning to
    canonical Board Canvas with one shell and unchanged providers;
12. Overview remaining reachable with its manifest/counter/sample summary,
    read-only preview/placeholder, exactly one freshness banner, workflow
    actions, and inert future tools unchanged;
13. Board Canvas starting with its local right panel hidden, exposing no local
    Project hub/rail, while retained panel modes and focus restoration work;
14. shell navigation leaving provider events, all writer fakes, project files,
    projection freshness, facts, and evidence unchanged; and
15. one lifetime application router remaining the same across Home/project
    transitions, with Wizard cancel/success handoff ordering unchanged.

Existing Home, splash, Wizard, edit-component, freshness-integration, gate,
Overview, Board Canvas, destination, acquisition, responsive, writer,
geometry, and freshness tests must not be weakened. Test counts must be
re-derived live after the implementation rather than copied from map
qualification snapshots.

## Future automated validation

The implementation child must run, fresh:

```text
dart format --output=none --set-exit-if-changed lib/app/router.dart lib/features/project/widgets/workbench_shell.dart lib/features/project/screens/project_overview_screen.dart lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/workbench_shell_test.dart test/widget/project_gate_test.dart test/widget/project_overview_screen_test.dart test/widget/board_canvas_screen_test.dart
flutter test test/widget/workbench_shell_test.dart
flutter test test/widget/project_gate_test.dart
flutter test test/widget/project_overview_screen_test.dart
flutter test test/widget/board_canvas_screen_test.dart
flutter test test/widget/benchbeep_home_screen_test.dart
flutter test test/widget/benchbeep_splash_screen_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart
flutter test test/widget/edit_component_screen_test.dart
flutter test test/integration/projection_stale_banner_end_to_end_test.dart
flutter analyze --no-pub
py -3 tools/doctor.py
py -3 tools/validate_all.py
flutter test
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch
```

Also prove the exact eight-path material set, empty staged/unmerged sets, one
`ShellRoute`, one route-layer `ProjectGate`, no Board Canvas
`projectNavigation`/`_ProjectNavigationHub`/project rail, no duplicate Overview
destination navigation, the exact 15/2 route inventory, and no substantive
diff in maps, packages, generated files, or Windows content.

## Manual smoke contract

The implementation manual smoke is required before its independent audit:

1. Open a loaded project and confirm Board Canvas plus one shared shell.
2. Navigate through representative project destinations and confirm active
   state and no duplicate navigation model.
3. Resize between wide and compact layouts; confirm persistent/reachable
   navigation and no overflow.
4. Toggle beginner mode, change route, and confirm the value survives.
5. Navigate Home, re-enter the project, and confirm project/mode state survives.
6. Open a null-project deep link; confirm exact recovery with no shell, then
   recover without URI replacement.
7. Exercise both compatibility aliases and confirm their frozen destinations.
8. Exercise nested back navigation and confirm return to canonical Board
   Canvas with the same loaded state.

Manual smoke for this docs-only scope is `NOT_APPLICABLE`. The implementation
audit packet must say `USE ONLY AFTER MANUAL SMOKE PASS`.

## Code Map dispositions after implementation

Do not edit maps in the implementation child. After accepted implementation
is committed, route a separate committed-source maintenance pass when these
dispositions are confirmed:

- `UPDATE_REQUIRED`:
  `lib/app/router.dart`,
  `lib/features/project/screens/project_overview_screen.dart`,
  `lib/features/board_canvas/screens/board_canvas_screen.dart`,
  `test/widget/project_gate_test.dart`,
  `test/widget/project_overview_screen_test.dart`, and
  `test/widget/board_canvas_screen_test.dart`;
- `QUALIFICATION_REQUIRED` from committed source:
  `lib/features/project/widgets/workbench_shell.dart` and
  `test/widget/workbench_shell_test.dart`; create maps/index rows only if the
  Code Map Standard qualifies them;
- `REVIEWED_NO_CHANGE`:
  `lib/app/app.dart`, the Home and splash maps, the Wizard source/test maps,
  and the edit-component test map; and
- `NOT_APPLICABLE / REVIEWED_NO_CHANGE`:
  unmapped `project_gate.dart` and the unmapped freshness integration, both
  inspect-only.

The maintenance pass is docs/maps-only and must inspect accepted committed
source rather than editing runtime or tests.

## Frozen boundaries and exclusions

The future implementation must not change:

- `lib/app/app.dart`, router lifetime/disposal, launcher, startup intro,
  acquisition, window close, or one-`MaterialApp.router` behavior;
- `project_gate.dart`, its recovery UI/open action, requested-URI retention,
  or loader/provider handoff;
- New Project Wizard source, cancel/success ordering, creation, or explicit
  open handoff;
- any public URI, route name, alias destination, deep-link meaning, or error
  surface;
- Add/Edit/Measure Sheet behavior, writers, or consolidation boundaries;
- Overview summary, counters, sample identity, board-normalized preview,
  painter, placeholder, freshness banner, workflow actions, or inert future
  tools;
- Board Canvas writers, measure flow, selection, geometry, painters,
  Wizard-intake rendering, local tool modes, focus behavior, evidence panels,
  or freshness seam;
- destination-owned app bars/business logic or general light-theme
  modernization;
- project-state or beginner-mode meaning, provider lifetime, persistence,
  Project ZIP behavior, events, facts, evidence, freshness, protected
  semantics, or canonical write boundaries; or
- maps/index, docs, packages, assets, schemas, tools, generated files,
  platform files, `_incoming`, scratch, and Windows substantive content.

No WorkbenchShell destination-owned writer, loader, file access, event
append, fact mutation, materialization, or persistence call is authorized.

## Stop conditions

Stop the implementation if:

- a ninth Dart path, map/doc write, `project_gate.dart`, `app.dart`, Wizard,
  destination owner, package, or platform path is required;
- one pathless `ShellRoute` cannot preserve the exact route graph or back
  behavior without a navigator key, route reparenting, or public URI change;
- the gate cannot remain outside the shell or null recovery mounts shell
  chrome;
- provider identity, beginner-mode state, Wizard semantics, aliases, deep
  links, Home behavior, or route names drift;
- destination writers/business logic must move into the shell;
- preserving Overview/Board Canvas content requires excluded cleanup or
  destination visual modernization;
- an existing maintained map conflicts with source, or a nonallowlisted
  mapped responsibility must change; or
- any scope-relevant focused, analyzer, repository, full-suite, freeze, or
  manual-smoke validation fails.

## Phase-1 validation contract

Run:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch
```

Also prove exactly five substantive scope paths, empty cached and unmerged
sets, unchanged Dart/test/map/index/Windows substantive content, matching
Current/Next tuples across the three route owners, one unique neutral ledger
row, one marker pair with whitespace-only interior, manual smoke
`NOT_APPLICABLE`, and no false audit/acceptance/staging/commit/push claim.

## Bounded Phase-2 recording authority

An independent `scope-lock-post-audit` result may authorize exactly two
logical coordinates:

1. the whitespace-only interior of the uniquely marked verdict block at the
   end of this artifact;
2. the Status cell of this PASS_ID's existing row in
   `docs/AUDIT_INDEX.md`.

Only the returned `AUDIT_VERDICT`, `SAFE_FOR_STAGING`, exact
`SAFE_STAGING_SET`, and `PHASE_2_RECORDING_AUTHORIZATION` may be copied into
those coordinates. The expected accepted staging set is the exact five
Phase-1 paths. Every artifact-exterior byte, ledger Description byte,
route-owner byte, and other repository byte is frozen during Phase 2.

## TOOL_SKILL_CHECK

- Relevant capability found: loader-qualified `tracebench-scope-lock` and
  `tracebench-prompt-authoring`; Git, `rg`, `tools/doctor.py`, and
  `tools/validate_all.py`.
- Capability used: `tracebench-scope-lock` for exact current/future authority,
  lifecycle, symbol closure, allowlists, tests, boundaries, stops, and verdict
  block; `tracebench-prompt-authoring` for the genuine post-change Claude
  handoff.
- Code Map capability: the maintained index/standard and only the applicable
  maps were used before exact source/test zones.
- External tool required: `NO`.

No capability expanded either allowlist. `tracebench-audit-reconciliation`
is not applicable because no pushed audit artifact is being reconciled.

## MODEL_ROUTING_CHECK

`MODEL_ROUTING_CHECK result: PASS`. Lane B ownership is Codex for this product
scope, Claude Code for independent `scope-lock-post-audit`, and the human for
any authorized verdict recording plus exact staging, commit, and push. The
future visual implementation requires manual smoke before Claude's
`implementation-post-audit`.

## SELF_REFERENCE_AUDIT

- This artifact and its ledger row use neutral `REVIEW_REQUIRED` status.
- The designated verdict-block interior is empty.
- No touched artifact, ledger row, or route owner records an audit verdict,
  staging-safety result, acceptance, commit, or push for this scope.
- Child activation remains conditional and time-invariant.
- Baseline and predecessor statements are committed Git evidence, not claims
  about this Phase-1 diff's later pipeline state.
- Historical route sections are explicitly non-authorizing.

## Independent audit focus

Apply `scope-lock-post-audit` from `docs/AUDIT_CONTRACT.md` to the exact five
scope paths. Verify the live baseline, route reconciliation, exact five/eight
allowlists, one pathless-shell architecture, gate ordering, exact 15/2 route
inventory, donor/removal boundaries, multi-zone authorization, focused tests,
manual-smoke and map-maintenance route, protected exclusions, validation
evidence, empty verdict block, neutral ledger row, and bounded two-coordinate
recording authority.

<!-- TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

<!-- TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
