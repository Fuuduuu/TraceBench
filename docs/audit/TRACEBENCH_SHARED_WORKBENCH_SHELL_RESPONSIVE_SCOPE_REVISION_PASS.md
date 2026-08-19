# TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS

Status: `REVIEW_REQUIRED`

## Pass identity

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS
Lane: B
Mode: SCOPE_REVISION / DOCS_ONLY / PHASE_1
Baseline: 862594f3dc72f71783984b935f000fefccec7100
```

This artifact revises one responsive clause in the accepted Shared Workbench
Navigation Shell scope. It does not implement or repair the product. It
withdraws the unsafe fixed 960-pixel persistent-navigation contract, derives
one exact shell-owned safe threshold from live source constants, freezes the
existing eight-path implementation draft, and reserves one recovery child
with the same exact eight-path allowlist.

## Live baseline and entry state

Read-only Git verification established:

- repository: `C:\dev\TraceBench`;
- branch: `main`;
- `HEAD == origin/main ==
  862594f3dc72f71783984b935f000fefccec7100`;
- parent: `bcf791f10c52a4ef2f45490f5472e2c22dee328b`;
- subject: `docs: scope shared workbench shell`;
- divergence: `0 0`;
- cached paths: `0`; and
- unmerged paths: `0`.

The baseline commit preserves the accepted
`TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS`. Its direct implementation
produced an exactly eight-path working draft whose responsive contract is now
blocked. The three generated-plugin Windows status entries are the known
content-identical EOL/stat residue and have no substantive diff.

## Exact current Phase-1 material set

This docs-only revision may author exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS.md`

No sixth path is authorized. Phase 1 may reconcile only the three route-owner
tops, add one neutral `REVIEW_REQUIRED` ledger row, and create this artifact
with exactly one named empty verdict block. No Dart, test, map, map-index,
package, tool, asset, schema, generated/platform, or Windows substantive byte
may change.

## Frozen eight-path implementation draft

The foreign implementation draft is exactly:

1. `lib/app/router.dart`
2. `lib/features/project/widgets/workbench_shell.dart`
3. `lib/features/project/screens/project_overview_screen.dart`
4. `lib/features/board_canvas/screens/board_canvas_screen.dart`
5. `test/widget/workbench_shell_test.dart`
6. `test/widget/project_gate_test.dart`
7. `test/widget/project_overview_screen_test.dart`
8. `test/widget/board_canvas_screen_test.dart`

The following are `worktree` byte observations measured before any Phase-1
scope edit. They are local freeze evidence only, not durable committed-source
anchors. The exact command was:

```powershell
$paths = @(<the eight repository-relative paths above>)
foreach ($path in $paths) {
  $item = Get-Item -LiteralPath $path
  $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
  "$path`t$($item.Length)`t$hash"
}
```

| Frozen implementation path | Representation | Bytes | SHA-256 |
| --- | --- | ---: | --- |
| `lib/app/router.dart` | `worktree` | 5715 | `EBC03E2A631373EE8DB5F2F10A56C8FD6F14ED756C9E742B9BD02864FB49CCAC` |
| `lib/features/project/widgets/workbench_shell.dart` | `worktree` | 12026 | `442661EBBECF53997733A426F48DE95626DC855C9F2A4B9E1919778BBEFA8C24` |
| `lib/features/project/screens/project_overview_screen.dart` | `worktree` | 27383 | `A08A823831FFE0E50F06B3657794AFAD784CF49714FD0D8A1B4CC99F1D4B4DBD` |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `worktree` | 447366 | `ED441499DFDA36C073B1D3D12F4A6746AF026B68CF4B7F6FABB0EEE2AB0D8633` |
| `test/widget/workbench_shell_test.dart` | `worktree` | 17291 | `27D48BB668E698B36B8B9991E0F6A3573AFA8242622875C0065084A6712144C8` |
| `test/widget/project_gate_test.dart` | `worktree` | 17692 | `9EE65ECC09C70D4ED30BD53C8E03CE4B30E4643E03C00ABCABFC800CC9ED19C7` |
| `test/widget/project_overview_screen_test.dart` | `worktree` | 23294 | `C78F4A0718FC1674959806C51D58617D4F3E8582D4FAB478B3F3F4A7018144B4` |
| `test/widget/board_canvas_screen_test.dart` | `worktree` | 378063 | `6BC48762806C10CF2FE836A8BCB1551A72C4AACEFA58C690DF61D1E3DB538659` |

Phase-1 completion requires the same command to reproduce all eight local
pairs exactly after validation. These paths are evidence only during this
pass and confer no current implementation authority.

## Accepted-scope conflict

The accepted scope fixed persistent shared navigation at widths of at least
`960` logical pixels. Live routed composition is:

```text
ShellRoute -> ProjectGate -> WorkbenchShell -> matched destination
```

The shell switches at `960` and removes `244` horizontal pixels when it
activates persistent navigation. Board Canvas independently switches its
destination-local layout at `900` pixels after its own framing. The resulting
source-derived states match the supplied routed observation:

| Viewport | Shell mode under old rule | Board local width | Board result |
| ---: | --- | ---: | --- |
| 959 | compact | `959 - 36 = 923` | rich |
| 960 | persistent | `960 - 244 - 36 = 680` | compact fallback |
| 1200 | persistent | `1200 - 244 - 36 = 920` | rich |

This rich -> compact -> rich inversion violates the retained destination
geometry contract. The old `TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS` is
therefore not retried. Its compatible eight-path draft remains preserved for
one bounded responsive-recovery child.

## Exact safe-persistence derivation

### Shared shell

Live `lib/features/project/widgets/workbench_shell.dart` defines:

- `_WorkbenchShellState._navigationWidth = 244.0`;
- the currently conflicting `_wideBreakpoint = 960.0`; and
- a body `Row` whose persistent branch inserts exactly
  `SizedBox(width: _navigationWidth)` before `Expanded(child: widget.child)`.

The AppBar and breadcrumb affect vertical composition but add no horizontal
inset to the body child. Therefore persistent navigation removes exactly
`244` logical pixels from every destination's available width.

### Board Canvas

Live `BoardCanvasScreen` retains:

- outer `EdgeInsets.fromLTRB(10, 8, 10, 8)`: `20` horizontal pixels;
- inner `EdgeInsets.all(8)`: `16` horizontal pixels;
- `DecoratedBox`: no additional layout inset; and
- `useWorkbenchShell = constraints.maxWidth >= 900`: retained local rich
  threshold `900`.

The destination `LayoutBuilder` receives
`viewport - persistentNavigation - 36`. Its exact minimum persistent-shell
viewport is:

```text
244 + 20 + 16 + 900 = 1180
```

### Project Overview

Live `ProjectOverviewScreen.build` and `_WorkbenchShellLayout` retain:

- `SingleChildScrollView` padding
  `EdgeInsets.fromLTRB(12, 12, 12, 16)`: `24` horizontal pixels;
- `ConstrainedBox(maxWidth: 1320)`, which does not reduce the derived
  threshold because the required local width is `960`; and
- `isWide = constraints.maxWidth >= 960`: retained local wide threshold
  `960`.

The destination layout receives
`viewport - persistentNavigation - 24`. Its exact minimum persistent-shell
viewport is:

```text
244 + 24 + 960 = 1228
```

### Selected shared threshold

One shell-owned threshold must protect both retained destinations:

```text
max(Board 1180, Overview 1228) = 1228 logical pixels
```

The locked shell constant is therefore exactly `1228.0`. This is arithmetic
from live source constants, not an approximate design preference.

## Revised responsive contract

The recovery child must:

1. keep shared project navigation compact below `1228` logical pixels;
2. switch to persistent, scroll-safe navigation at and above `1228`;
3. keep the same ordered metadata and active-state semantics in both modes;
4. ensure widening never produces a destination rich -> compact -> rich
   inversion merely because shell navigation changed mode;
5. keep Board Canvas's destination-local `900` comparison byte-for-behavior;
6. keep Overview's destination-local `960` comparison byte-for-behavior;
7. keep Board horizontal framing `36` and Overview horizontal framing `24`;
8. keep all destination geometry, preview sizing, panels, writers, and
   content behavior unchanged; and
9. keep shell-width knowledge entirely in `WorkbenchShell` and its tests.

The exact monotonic expectations around the selected cutover are:

| Viewport | Revised shell mode | Board local width/result | Overview local width/result |
| ---: | --- | --- | --- |
| 959 | compact | `923`, rich | `935`, stacked |
| 960 | compact | `924`, rich | `936`, stacked |
| 1227 | compact | `1191`, rich | `1203`, wide |
| 1228 | persistent | `948`, rich | `960`, wide |
| 1229 | persistent | `949`, rich | `961`, wide |
| 1500 | persistent | `1220`, rich | `1232`, wide |

`1500` is the locked comfortably-wide automated example. At that width, the
Overview board preview receives
`1500 - 244 - 24 - 252 - 12 - 24 = 944` pixels; because `944 >= 900`, its
frozen height branch is at least `430`. Another wider value may supplement but
not replace the five exact boundary-adjacent widths.

## Exact recovery-child reservation

```text
PASS_ID: TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_RECOVERY_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / RESPONSIVE_RECOVERY / UI_LOCAL
```

The future child may write exactly:

1. `lib/app/router.dart`
2. `lib/features/project/widgets/workbench_shell.dart`
3. `lib/features/project/screens/project_overview_screen.dart`
4. `lib/features/board_canvas/screens/board_canvas_screen.dart`
5. `test/widget/workbench_shell_test.dart`
6. `test/widget/project_gate_test.dart`
7. `test/widget/project_overview_screen_test.dart`
8. `test/widget/board_canvas_screen_test.dart`

No ninth path, deletion, rename, move, map/index edit, package, asset, tool,
schema, generated file, platform file, or doc edit is reserved. The recovery
child activates only after independent acceptance of this exact revision,
explicit bounded verdict recording, and exact human staging, commit, and push
of the five current scope paths.

## Exact recovery symbol and responsibility closure

| Future path | Authorized recovery zone | Inspect-only/frozen within the path |
| --- | --- | --- |
| `lib/app/router.dart` | Preserve the draft's one pathless `ShellRoute`, one outer `ProjectGate`, and exact loaded-shell composition. | Root/Wizard/error builders, all paths/names/nesting/destinations, two redirects, and public topology. |
| `lib/features/project/widgets/workbench_shell.dart` | `_WorkbenchShellState._wideBreakpoint`; its `LayoutBuilder` mode decision; persistent/compact navigation keys and geometry. | `_navigationWidth = 244.0`, 12-entry metadata, active resolver, Home/mode/breadcrumb behavior, colors, navigation callbacks, provider ownership, and every nonresponsive behavior. |
| `lib/features/project/screens/project_overview_screen.dart` | No new responsive source change; retain the existing donor draft while proving its exact framing and `_WorkbenchShellLayout` behavior. | `constraints.maxWidth >= 960`, `EdgeInsets.fromLTRB(12, 12, 12, 16)`, `maxWidth: 1320`, summary, preview, freshness, workflows, inert tools, providers, and all content geometry. |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | No new responsive source change; retain the existing local-navigation removal draft while proving its exact framing and `useWorkbenchShell` behavior. | `constraints.maxWidth >= 900`, outer/inner padding, every remaining panel/focus mode, writers, geometry, painters, Wizard intake, evidence, and freshness. |
| `test/widget/workbench_shell_test.dart` | Replace the unsafe 1000-persistent expectation; cover shell mode, identity, metadata, providers, Home, aliases, and representative route navigation with the exact new boundary. | Existing zero-write and active-parent assertions may not weaken. |
| `test/widget/project_gate_test.dart` | Retain shell-free null-route coverage; add/strengthen loaded-project exactly-one-gate/one-shell/same-identity coverage across all 15 real destinations. | Cancel, typed/generic failure, success URI retention, canonical Home, aliases, nested push/pop, and writer guards. |
| `test/widget/project_overview_screen_test.dart` | Use the production router for responsive geometry at the exact six widths; assert shell mode and stacked/wide monotonicity with existing keyed zones. | Freshness, preview/placeholder, workflows, inert controls, copy, identifiers, routes, and event preservation. |
| `test/widget/board_canvas_screen_test.dart` | Use the production router for responsive geometry at the exact six widths; assert shell mode and rich-layout continuity with `board_canvas_workbench_shell` and `board_canvas_control_band`. | All local panel/focus, writer, selection, geometry, painter, Wizard, evidence, and freshness families. |

No destination source may receive shell-width input or a threshold offset.
If this closure requires a ninth file or a destination breakpoint/geometry
change, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Route, gate, navigation, and provider invariants

Preserve exactly:

- one pathless `ShellRoute` around only the `/project` subtree;
- builder order `ShellRoute -> ProjectGate -> WorkbenchShell -> child`;
- shell-free null recovery at the requested URI;
- one gate, one shell, and one requested destination for loaded state;
- one shell element/state identity across project-leaf `go` navigation;
- one ordered 12-entry top-level navigation model, with Home separate;
- Add/Edit selecting Components and Measure Sheet selecting Measurements;
- all 15 real route paths, names, relative nesting, destination types, and
  deep-link behavior;
- aliases `/project/board-canvas -> /project` and
  `/project/measurements/new -> /project/measure-sheet`;
- loaded `/project -> push('/project/overview') -> pop()` returning to
  canonical `/project` and Board Canvas;
- project-state object identity and beginner-mode value across project leaves
  and Home/project round trips; and
- one lifetime application router and one `MaterialApp.router`.

Shell navigation remains `UI_LOCAL` plus `ZERO_WRITE`: it may change route
location and toggle only the existing beginner-mode provider. It must not call
a writer, append an event, mutate facts/evidence/freshness, touch project
files, load, materialize, persist, or change Project ZIP behavior.

## Exact 15-destination loaded-shell contract

The child must keep the existing shell-free null-route matrix and add or
strengthen a loaded-state loop for exactly:

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

For every loaded destination, assert exact URI, expected destination type,
exactly one `ProjectGate`, exactly one `WorkbenchShell` including offstage
search, no recovery copy, the same shell `Element` and `State` while `go`
moves among leaves, the same loaded `ProjectState`, and no writer/event/file/
fact/freshness mutation. The two aliases remain separate redirect tests and
must not inflate the real-destination count.

## Focused responsive regression contract

Production-router tests, not direct destination mounts, must cover exactly
`959`, `960`, `1227`, `1228`, `1229`, and `1500` for both Board Canvas and
Project Overview.

At every width verify:

- the router location is the requested canonical destination;
- exactly one shared shell is mounted;
- `workbench-compact-menu-button` is present and
  `workbench-wide-navigation` absent below `1228`;
- `workbench-wide-navigation` is present and the compact menu absent at and
  above `1228`;
- no overflow or exception occurs; and
- provider identity and state remain unchanged.

Board assertions use existing public test keys to prove rich layout remains
present and `board_canvas_control_band` remains absent at all six widths.
Overview assertions use `overview-workbench-zone` and
`overview-actions-panel`: stacked at `959/960`, wide at `1227/1228/1229/1500`,
with same-top and horizontal separation in the wide state. At `1500`, retain
the routed geometry evidence exactly: action rail width at most `260`,
workbench-zone width greater than three times the action-rail width, and board
preview height at least `430`. The former direct-mount four-times dominance
expectation is invalid under the real shell width and is replaced only by this
routed three-times contract.

The exact shell boundary may additionally have a compact pure-shell unit
assertion, but direct `WorkbenchShell` mounting cannot replace routed Board
and Overview coverage.

## Preserved product and architecture boundaries

The recovery child must preserve:

- Board Canvas as canonical `/project` and the primary workbench;
- Overview as `/project/overview` with retained summary, counters, sample
  identity, board-normalized preview/painters, placeholder, one freshness
  banner, workflow actions, and inert future tools;
- every Board Canvas remaining panel/focus mode, Measure Sheet push, all four
  writers, selection, geometry, painters, Wizard-intake rendering, evidence,
  and freshness;
- one router lifetime, launcher/splash, acquisition, ProjectGate open/recovery,
  Wizard cancel/success and explicit handoff, provider meaning, and Home
  behavior;
- all route names/paths/nesting/redirects and destination-owned app bars;
- events, facts, evidence, freshness, Project ZIP, canonical and protected
  semantics; and
- maps/index, docs, packages, tools, assets, schemas, generated/platform
  files, Windows substantive content, `_incoming`, and scratch.

The double-AppBar presentation is recorded only as a later product/manual-
smoke observation. It is neither a responsive acceptance failure nor repair
authority in this scope. Do not alter shell or destination app bars under the
recovery child.

## CODE_MAP_PREFLIGHT

`docs/code_maps/CODE_MAP_INDEX.md` was checked first, then
`docs/code_maps/CODE_MAP_STANDARD.md` and only the applicable maintained maps.
All six mapped targets are `MAINTAINED` against committed baseline source.
The working draft is unfinished and cannot update a map.

| Relevant target | Current map/qualification | Inspected or future changed zones | Direct dependencies and blast evidence | Write class | Disposition |
| --- | --- | --- | --- | --- | --- |
| `lib/app/router.dart` | maintained human-override map | route factory/project tree; preserve draft pathless shell and gate order | GoRouter, `ProjectGate`, `WorkbenchShell`, 15 destinations, gate tests `[D]` | `ZERO_WRITE` + `UI_LOCAL` | `UPDATE_REQUIRED` after accepted implementation |
| `lib/features/project/widgets/workbench_shell.dart` | no committed target or map | future `_wideBreakpoint` and shell `LayoutBuilder`; new target excluded from committed-source mapping | GoRouter, beginner provider, Flutter layout, shell tests `[D]` | `UI_LOCAL` + `ZERO_WRITE` | `NOT_APPLICABLE` at committed baseline; requalify accepted committed source later |
| `lib/features/project/screens/project_overview_screen.dart` | maintained automatic map | zones 1/2/8/10 from retained donor draft; zone 3 responsive threshold/framing inspect-only and frozen | project/beginner providers, router, Flutter layout, Overview tests `[D]` | `UI_LOCAL` + `ZERO_WRITE` | `UPDATE_REQUIRED` after accepted implementation |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | maintained automatic map | zones 1/11 from retained navigation-removal draft; responsive `useWorkbenchShell`/framing inspect-only and frozen | provider, GoRouter, layout, Board tests `[D]`; writers excluded | `UI_LOCAL` + `ZERO_WRITE` in scoped zones | `UPDATE_REQUIRED` after accepted implementation |
| `test/widget/workbench_shell_test.dart` | no committed target or map | new routed responsive, identity, navigation, provider, zero-write families | production router/shell/providers/fakes `[D]` | exercises `UI_LOCAL` + `ZERO_WRITE` | `NOT_APPLICABLE` at committed baseline; requalify accepted committed source later |
| `test/widget/project_gate_test.dart` | maintained `SCORE 7/12` map | zones 1/4/6/8 plus loaded all-15 one-shell identity evidence | production router, gate, providers, destination types `[D]` | exercises `UI_LOCAL`, `ZERO_WRITE`, observed `PROJECTION_STATE` | `UPDATE_REQUIRED` after accepted implementation |
| `test/widget/project_overview_screen_test.dart` | maintained `SCORE 7/12` map | zones 2/6 with real routed six-width monotonic evidence; all content families retained | production router, Overview keys, providers `[D]` | exercises `UI_LOCAL` + `ZERO_WRITE` | `UPDATE_REQUIRED` after accepted implementation |
| `test/widget/board_canvas_screen_test.dart` | maintained automatic map | zones 1/2/10/11 with real routed six-width monotonic evidence; writer/geometry/freshness families retained | production router, Canvas keys, providers/fakes `[D]` | exercises `UI_LOCAL` + `ZERO_WRITE`; writers inspect-only | `UPDATE_REQUIRED` after accepted implementation |

Inspect-only direct owners are dispositioned as follows:

- `lib/app/app.dart`, Home/splash maps, Wizard source/test maps, and the
  edit-component test map: `REVIEWED_NO_CHANGE`;
- unmapped `lib/features/project/widgets/project_gate.dart`: its accepted
  `SCORE 5/12` remains `NOT_APPLICABLE`; and
- unmapped freshness integration: `NOT_APPLICABLE` under its accepted
  below-threshold cohesive test status.

No current map is stale against committed source, no map conflicts with the
revised reservation, and the human's exact scope decision authorizes the
coherent existing draft plus one responsive recovery. No map/index edit is
authorized in this pass or child. Separately scoped maintenance occurs only
against accepted committed implementation source.

## Recovery implementation validation contract

Run all Flutter commands sequentially and record fresh counts:

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

Also prove the exact eight-path child set, empty cached/unmerged sets, one
pathless shell, one route-layer gate, exact 15/2 route inventory, exact
12-entry navigation model, the `1228.0` shell cutover, unchanged destination
threshold/framing constants, loaded all-15 shell identity, no Board-local
project hub, no duplicate Overview destination navigation, no weakened tests,
and no substantive docs/map/package/platform/Windows change.

## Recovery manual-smoke contract

Manual smoke is mandatory after recovery automation and before independent
implementation audit:

1. At a compact supported desktop width, open loaded Board Canvas and
   Overview; confirm compact shared navigation and usable destination content.
2. Immediately below `1228`, confirm compact shared navigation while both
   destinations retain their wide/rich local layout.
3. At exactly `1228`, confirm persistent navigation appears without either
   destination falling back.
4. Immediately above `1228` and at a comfortably wide desktop size, confirm
   persistent navigation, reachability, scrollability, and no overflow.
5. Navigate representative project destinations; confirm one shell, correct
   active state, and no duplicate navigation model.
6. Toggle beginner mode, navigate Home, and re-enter; confirm project and mode
   identity survive.
7. Exercise null deep-link recovery, both aliases, and nested back navigation.
8. Record the double-AppBar presentation as a later product observation only;
   do not repair or use it to expand this responsive child.

If the host cannot be resized to one exact automated boundary value, record
that limitation; the exact routed widget regressions remain mandatory. The
future implementation audit packet must say
`USE ONLY AFTER MANUAL SMOKE PASS`.

Manual smoke for this docs-only revision is `NOT_APPLICABLE`.

## Route and activation

```text
TRACEBENCH_SHARED_WORKBENCH_SHELL_SCOPE_LOCK_PASS
   [accepted and committed at 862594f]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_IMPL_PASS
   [blocked eight-path draft; superseded; do not retry]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_RECOVERY_IMPL_PASS
   [conditional on accepted and pushed revision]
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> committed-source Code Map maintenance [when required]
-> NEEDS_USER_DECISION [non-executable]
```

No route-cleanup, ninth implementation path, destination-responsive repair,
double-AppBar repair, or second child is inserted.

## Stop conditions

Stop if:

- the five-path Phase-1 or eight-path recovery allowlist cannot remain exact;
- any frozen implementation byte moves during this docs-only revision;
- the shell navigation width, Board framing/threshold, or Overview
  framing/threshold differs from the derived constants;
- the safe threshold cannot remain one shell-owned `1228.0` value;
- preserving monotonic behavior requires a destination breakpoint, framing,
  geometry, or shell-width input change;
- one pathless `ShellRoute`, gate-outside-shell ordering, public topology,
  aliases, deep links, nested back behavior, or one-router lifetime changes;
- providers, Wizard/acquisition, writers, files, events, facts, evidence,
  freshness, Project ZIP, or another protected semantic drifts;
- loaded-project shell identity across all 15 real destinations cannot be
  proven through the existing test owners;
- double-AppBar repair or another excluded cleanup becomes necessary;
- a relevant committed-source map is stale, conflicting, or unverifiable;
- validation, route agreement, exact-set, freeze, manual-smoke, audit, or
  boundary evidence fails; or
- any staging, commit, push, stash, reset, restore, clean, or Windows
  normalization is attempted by Codex.

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

Also prove baseline/route agreement; exact five authored scope paths; exact
eight foreign implementation paths; all eight frozen worktree hash/size pairs;
empty cached and unmerged sets; one neutral ledger row; one unique marker pair
with whitespace-only verdict interior; no current map/index edit; no
substantive Windows diff; manual smoke `NOT_APPLICABLE`; and no false claim of
this pass's own acceptance, audit result, staging, commit, or push.

## Bounded Phase-2 recording authority

An independent `scope-lock-post-audit` result may authorize exactly two
logical coordinates:

1. the whitespace-only interior of the uniquely marked verdict block at the
   end of this artifact; and
2. the Status cell of this PASS_ID's existing row in
   `docs/AUDIT_INDEX.md`.

Only the returned `AUDIT_VERDICT`, `SAFE_FOR_STAGING`, exact
`SAFE_STAGING_SET`, `PHASE_2_RECORDING_AUTHORIZATION`, `BOUNDARY_RESULT`, and
`SELF_REFERENCE_AUDIT` may be copied into those coordinates. The expected
accepted staging set is the exact five current Phase-1 paths. Every artifact-
exterior byte, ledger Description byte, route-owner byte, implementation
draft byte, and other repository byte is frozen during Phase 2.

## TOOL_SKILL_CHECK

- Relevant capability found: loader-qualified `tracebench-scope-lock` and
  `tracebench-prompt-authoring`; local Git, `rg`, `tools/doctor.py`, and
  `tools/validate_all.py`.
- Capability actually used: `tracebench-scope-lock` for the exact
  current/future authority, one-child reservation, threshold proof,
  allowlists, tests, boundaries, stops, and verdict block;
  `tracebench-prompt-authoring` for the genuine post-change canonical audit
  handoff and accompanying SNIPER payload.
- Why applicable: this is an immediate docs-only scope revision reserving one
  exact future Flutter child and producing a real five-file audit diff.
- External tool required: `NO`; repo policy leaves external plugins/MCP off
  for this docs-only pass.

`tracebench-audit-reconciliation` is not applicable because no pushed artifact
with missing audit evidence is being reconciled. No capability widened either
allowlist.

## MODEL_ROUTING_CHECK

`MODEL_ROUTING_CHECK result: PASS`. Lane B routes this scope revision through
Codex, then independent Claude Code `scope-lock-post-audit`, then human-only
bounded verdict recording and exact staging/commit/push. The recovery child
requires human manual smoke before its independent implementation audit.

## SELF_REFERENCE_AUDIT

- The artifact and its unique ledger row use neutral `REVIEW_REQUIRED`.
- The designated verdict-block interior is whitespace-only.
- The touched artifact, ledger, and route owners record no verdict, safety,
  acceptance, commit, or push result for this Phase-1 revision.
- Generic audit/staging policy is distinguished from claims about this pass.
- The eight-path draft and baseline commit are evidence, not acceptance of the
  recovery child.
- Historical fixed-960 authority is explicitly superseded and non-authorizing.

## Independent audit focus

Apply `scope-lock-post-audit` from `docs/AUDIT_CONTRACT.md` to the exact five
scope paths. Verify the live baseline, exact five/eight sets, all frozen
worktree hash/size pairs, arithmetic `1180`/`1228` derivation, selected
`1228.0` shell threshold, frozen destination breakpoints/geometry, six-width
routed monotonic regression contract, loaded all-15 shell identity, retained
pathless-shell/gate/route/provider/zero-write invariants, Standard-defined map
dispositions, double-AppBar deferral, validation, route agreement, neutral
ledger row, unique empty verdict block, self-reference result, and exact
two-coordinate Phase-2 boundary.

<!-- TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS_VERDICT_BLOCK_BEGIN -->
AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS
<!-- TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_SCOPE_REVISION_PASS_VERDICT_BLOCK_END -->
