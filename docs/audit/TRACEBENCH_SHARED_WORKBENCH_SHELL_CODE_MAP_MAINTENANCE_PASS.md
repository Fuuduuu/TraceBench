# TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS

## Pass identity and Phase-1 posture

- Project: TraceBench / BenchBeep
- PASS_ID: `TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS`
- Lane: `A`
- Mode: `DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1`
- Ledger Status: `REVIEW_REQUIRED`
- Manual smoke: `NOT_APPLICABLE`

This pass refreshes six existing maps and creates the first qualifying maps for
the committed Workbench shell source and focused shell suite. It describes
accepted committed source only, changes no executable behavior, and releases
no executable successor beyond `NEEDS_USER_DECISION`.

## Verified committed baseline

- Worktree: `C:\dev\TraceBench`
- Repository: `Fuuduuu/TraceBench`
- Branch: `main`
- `HEAD`: `8266e1e178cee885a80f2584712862b4f714842d`
- local `origin/main`: `8266e1e178cee885a80f2584712862b4f714842d`
- divergence: `0 0`
- subject: `feat: add shared workbench shell`
- parent: `b9853d1066c3b9705e1e903952081075e0672399`

At entry, the cached, unmerged, untracked, and substantive content-diff sets
were empty. Raw porcelain reported only the known three content-identical
generated-plugin Windows EOL/stat entries. This pass preserves that residue.

## Exact Phase-1 material set -- 14

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/router.dart.md`
7. `docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md`
8. `docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md`
9. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
10. `docs/code_maps/test/widget/workbench_shell_test.dart.md`
11. `docs/code_maps/test/widget/project_gate_test.dart.md`
12. `docs/code_maps/test/widget/project_overview_screen_test.dart.md`
13. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
14. `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

No fifteenth path belongs to this pass. The shell source map, shell-test map,
and this artifact are the only new paths.

## Committed implementation evidence

`git diff-tree --no-commit-id --name-status -r
8266e1e178cee885a80f2584712862b4f714842d` returns exactly:

```text
M    lib/app/router.dart
M    lib/features/board_canvas/screens/board_canvas_screen.dart
M    lib/features/project/screens/project_overview_screen.dart
A    lib/features/project/widgets/workbench_shell.dart
M    test/widget/board_canvas_screen_test.dart
M    test/widget/project_gate_test.dart
M    test/widget/project_overview_screen_test.dart
A    test/widget/workbench_shell_test.dart
```

The accepted commit adds 1,446 lines and removes 1,150 across those exact eight
paths. Durable committed Git object identities are:

| Committed target | Physical lines | Declarations | Git object id |
| --- | ---: | ---: | --- |
| `lib/app/router.dart` | 143 | n/a | `96767f6df112625bbb6ff902e03841350357cd19` |
| `lib/features/project/widgets/workbench_shell.dart` | 396 | n/a | `afc84a2776c1355b395806d4b264c4acd3530be6` |
| `lib/features/project/screens/project_overview_screen.dart` | 772 | n/a | `caa51e31957561ab3f4c914d68b4513efe52aba0` |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | 12,414 | n/a | `b696078dd7e21686914e8d2c98268c5ac09a8949` |
| `test/widget/workbench_shell_test.dart` | 568 | 8 (`6` widget + `2` unit) | `74972755ce6ac0126230eb84165aa1947f3fcce9` |
| `test/widget/project_gate_test.dart` | 598 | 12 widget | `1c59d88623713676e81cb7fb02f0ddba30ce99bd` |
| `test/widget/project_overview_screen_test.dart` | 688 | 19 widget | `0bb2a1daad706741e94cd86b37bfb4d55dab8229` |
| `test/widget/board_canvas_screen_test.dart` | 11,268 | 165 (`155` widget + `10` unit) | `d6a6c5cefb98272178a583ebfde3d11905536158` |

The committed implementation evidence supplied with this pass records final
independent audit `ACCEPT_AS_IS`, staging safety `YES`, boundary result `PASS`,
human manual smoke `PASS`, full Flutter `637/637 PASS`, Python validators
`314/314 PASS`, and analyzer zero warnings/errors with the same three infos.
Those are attributed implementation inputs; this docs/maps pass does not
relabel them as freshly rerun product validation.

## Shell-file qualification results

### Production shell

- Candidate: `lib/features/project/widgets/workbench_shell.dart`.
- Entry index/map state: no row and no map.
- Physical size: `396` lines.
- Automatic condition: production file owns five-plus independently testable
  behaviors: ordered 12-entry inventory, workflow-parent selection, one shared
  shell identity, Home navigation, beginner-mode toggle, compact drawer,
  persistent rail/cutover, breadcrumb/active semantics, and zero-write route
  controls.
- Result: `AUTO — 5+ independently testable behaviors`.
- Entry lifecycle result: `BLOCKED_CODE_MAP_REQUIRED`.
- Resolution: create the deterministic map and matching index row at
  `REVIEW_REQUIRED`.

### Focused shell suite

- Candidate: `test/widget/workbench_shell_test.dart`.
- Entry index/map state: no row and no map.
- Physical size: `568` lines -> `0`.
- Independent responsibilities: inventory, active mapping, router/provider/file
  harness, writer sentinels, identity, compact/persistent responsive modes,
  Home round trip, aliases, and mutation guards -> `2`.
- Canonical/protected boundaries: project/provider identity, four canonical-
  writer sentinels, and noncanonical fixture/file observations -> `2`.
- Regression surface: inventory/selection, identity/provider, responsive,
  Home, route/no-write, and alias families -> `2`.
- Whole-file analysis tax: new committed file with no recurring prior broad
  reconstruction -> `0`.
- Blast-radius ambiguity: safe shell changes require adjacent route, provider,
  responsive-destination, and mutation-guard evidence -> `1`.
- Result: `SCORE 7/12`, with four non-size dimensions nonzero.
- Automatic trigger: not required.
- Entry lifecycle result: `BLOCKED_CODE_MAP_REQUIRED`.
- Resolution: create the deterministic map and matching index row at
  `REVIEW_REQUIRED`.

`NOT_APPLICABLE` is invalid for either target at this committed baseline.

## CODE_MAP_PREFLIGHT

### Router

- Entry map/index: existing `MAINTAINED` human-override map.
- Changed zones: project subtree structure and composition at
  `buildTraceBenchRouter`, `ShellRoute`, `ProjectGate`, `WorkbenchShell`, and
  the 15 destination builders.
- Inspect-only coupling: app router lifetime, gate source, shell source,
  destination screens, Home/Wizard builders, aliases, and GoRouter stack.
- Excluded: paths/names/redirect strings, provider/write ownership, app/router
  lifetime, and destination behavior.
- Direct evidence: committed router plus gate/shell focused suites.
- Write class: navigation `ZERO_WRITE` / transient `UI_LOCAL`.
- Disposition: `UPDATE_REQUIRED`; refreshed at `REVIEW_REQUIRED`.

### Workbench shell source

- Entry map/index: missing; qualifying committed production target.
- Changed/new zones: colors, destination metadata/order, workflow-parent
  selection, shell/provider state, 1228/244 responsive frame, Home/mode,
  breadcrumb, navigation rendering, and child composition.
- Inspect-only coupling: router/gate, app-owned beginner provider, Overview
  color consumers, Board/Overview responsive geometry, destination behavior.
- Excluded: project state, writers, persistence, route declarations, and
  destination business logic.
- Direct evidence: committed source plus shell/gate/Overview/Board suites.
- Write class: `ZERO_WRITE` and transient `UI_LOCAL` only.
- Entry lifecycle: `BLOCKED_CODE_MAP_REQUIRED`; first map created.

### Project Overview source

- Entry map/index: existing `MAINTAINED` automatic map.
- Changed zones: removed private shell/Home/mode/breadcrumb/top-level
  navigation, imported shared colors, retained content wrapper, local 960
  layout, summary/preview/freshness, Measure/Add/Edit actions, inert tools.
- Inspect-only coupling: Workbench shell, router, known-facts models, banner.
- Excluded: writer/destination behavior, project loading, top-level navigation,
  and destination breakpoint/geometry changes.
- Direct evidence: committed source and 19-test companion.
- Write class: `ZERO_WRITE` plus transient workflow `UI_LOCAL`.
- Disposition: `UPDATE_REQUIRED`; refreshed at `REVIEW_REQUIRED`.

### Board Canvas source

- Entry map/index: existing `MAINTAINED` automatic map.
- Changed zones: local orchestration and rail/focus chrome only: removed
  `projectNavigation`, Project hub/rail parameter/control, and restored hidden
  context-panel default.
- Inspect-only coupling: outer shell/router and companion responsive evidence.
- Excluded: 900 local cutover, every retained panel/focus path, selection,
  geometry/painters/Wizard/evidence/freshness, and all four writers.
- Direct evidence: one source deletion closure plus companion tests.
- Write class: existing UI-local/render/writer classifications retained.
- Disposition: `UPDATE_REQUIRED`; refreshed at `REVIEW_REQUIRED`.

### Workbench shell test

- Entry map/index: missing; qualifying committed test target.
- Changed/new zones: exact inventory/active mapping, fail-on-call writers,
  production-router harness, shell/provider identity, compact/persistent modes,
  Home round trip, representative route/no-write, and aliases.
- Inspect-only coupling: shell/router/gate, providers, Board/Overview suites.
- Excluded: destination internals, persistence implementation, and all product
  writer execution.
- Direct evidence: eight committed declarations.
- Write class: test-local setup plus observed `ZERO_WRITE`, `UI_LOCAL`, writer,
  and noncanonical fixture boundaries.
- Entry lifecycle: `BLOCKED_CODE_MAP_REQUIRED`; first map created.

### ProjectGate test

- Entry map/index: existing `MAINTAINED`, `SCORE 7/12` map.
- Changed zones: null shell absence, loaded one-gate/one-shell reveal, all-15
  loaded identity/mutation matrix, aliases, route settling, file snapshots, and
  nested push/pop.
- Inspect-only coupling: router, unchanged gate source, Workbench shell,
  providers, loader/open action, destination types, writer double.
- Excluded: gate-source changes, real loader/filesystem behavior, destination
  internals, and writer persistence.
- Direct evidence: 12 committed widget tests.
- Write class: observed route/provider/read and protected absence boundaries.
- Disposition: `UPDATE_REQUIRED`; refreshed at `REVIEW_REQUIRED`.

### Project Overview test

- Entry map/index: existing `MAINTAINED`, `SCORE 7/12` map.
- Changed zones: shared-shell keys/copy, real routed widths
  `959/960/1227/1228/1229/1500`, monotonic row/stack geometry, 1500 preview
  density, retained Measure/Add/Edit routes, and one event guard.
- Inspect-only coupling: Overview/shell/router/providers/banner/destinations.
- Excluded: removed top-level destination ownership and destination internals.
- Direct evidence: 19 committed widget tests.
- Write class: test-local `UI_LOCAL` plus observed `ZERO_WRITE`.
- Disposition: `UPDATE_REQUIRED`; refreshed at `REVIEW_REQUIRED`.

### Board Canvas test

- Entry map/index: existing `MAINTAINED` automatic map.
- Changed zones: removed Project-hub fixtures/families, added routed six-width
  rich-layout proof, hidden local context default, retained panels/focus, and
  negative local Project hub/rail assertions.
- Inspect-only coupling: Board source, outer shell/router, project provider.
- Excluded: existing navigator, writer, painter, Wizard, geometry, evidence,
  freshness, and canonical-boundary families.
- Direct evidence: 165 committed declarations.
- Write class: retained mixed test observation boundaries; no new product write.
- Disposition: `UPDATE_REQUIRED`; refreshed at `REVIEW_REQUIRED`.

## Map refresh results

The eight changed/new maps now record:

1. one pathless project-only `ShellRoute` ordered as
   `ProjectGate -> WorkbenchShell -> destination`;
2. exact preservation of 15 real destinations, two aliases, route names/paths,
   and tested nested push/pop behavior;
3. one sole ordered 12-entry shell inventory, separate Home, workflow-parent
   active mapping, beginner-mode UI state, and zero-write navigation;
4. compact navigation below `1228`, persistent navigation at/above `1228`, and
   fixed `_navigationWidth = 244` without destination width knowledge;
5. Overview donor chrome/navigation removal with summary, counters, sample
   identity, freshness, preview/painters, placeholder, Measure/Add/Edit actions,
   inert future tools, and local `960` layout retained;
6. Board Project hub/rail removal with hidden context default, local `900`
   layout, retained panels/focus, writers, geometry, painters, Wizard, evidence,
   and freshness;
7. shell-free null recovery, loaded all-15 one-gate/one-shell identity, aliases,
   project/provider identity, exact file-byte stability, and zero writer calls;
   and
8. real routed Board/Overview evidence at exactly `959`, `960`, `1227`, `1228`,
   `1229`, and `1500`, proving compact/persistent modes and monotonic retained
   destination geometry.

## Registry and lifecycle evidence

- Actual map files after Phase 1: `34`.
- Registry rows after Phase 1: `34`.
- Orphan maps: `0` expected.
- Unindexed maps: `0` expected.
- `REVIEW_REQUIRED` map headers: `8`.
- Matching `REVIEW_REQUIRED` index cells: `8`.
- Unchanged `MAINTAINED` pairs: `26`.
- New qualifying map/index pairs: `2`.

Only the six existing target Status cells change and two exact rows are added
in `CODE_MAP_INDEX.md`. Unrelated Source, Map file, Type, and Status cells remain
frozen.

## Route result

The three route owners are updated to:

```text
Current: TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

The complete transition is:

```text
TRACEBENCH_SHARED_WORKBENCH_SHELL_RESPONSIVE_RECOVERY_IMPL_PASS
   [accepted and committed at 8266e1e]
-> TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

No implementation or product successor is named, reserved, or armed.

## Frozen-boundary evidence

This pass changes no Dart/test/runtime source, route topology, gate/shell
behavior, provider meaning/lifetime, Home/Wizard/acquisition, destination
writer/business logic, Overview/Board behavior, Project ZIP, event/fact/
evidence/freshness semantics, packages, assets, schemas, tools, generated/
platform content, Windows residue, Code Map Standard, AGENTS, prompting/audit
governance, or unrelated map/index row. Manual smoke is `NOT_APPLICABLE` for
descriptive committed-source maintenance.

## Bounded Phase-2 authority

A clean independent map/pass audit may authorize at most 18 logical writes:

1. fill only the existing verdict-block interior below;
2. mechanically mirror that result in only this PASS_ID's existing ledger
   Status cell;
3-10. promote only the eight changed/new map Status headers from
   `REVIEW_REQUIRED` to `MAINTAINED`; and
11-18. promote only the eight matching Code Map index Status cells.

Every map body, Qualification/Source/Type/Audit-evidence field, route byte,
ledger Description, artifact exterior, unrelated index/ledger cell, and other
repository byte remains frozen. Because two rows/maps are new, the Code Map
index remains material after promotion.

## Independent audit contract

For each of the eight review-target maps, return:

```text
MAP_VERDICT: ACCEPT_AS_IS | ACCEPT_WITH_NITS | BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES | NO
MAP_STATUS_PROMOTION_REQUIRED: YES | NO
```

Then return:

```text
AUDIT_VERDICT: ACCEPT_AS_IS | NEEDS_SMALL_PATCH | REJECT
SAFE_FOR_STAGING: YES | NO
SAFE_STAGING_SET: exact paths or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES | NO
```

Confirm the exact 14-path material set, both qualification results, eight map/
index review pairs, 34/34 registry parity, committed eight-blob closure, and
18-coordinate maximum for any authorized Phase 2.

## Phase-1 validation contract

Run and report:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Also verify exact material scope, exactly three new paths, empty cached/unmerged
sets, 34/34 registry parity, exactly eight review headers/index cells, stable
anchor closure, route-owner agreement, one empty verdict block, committed blob
identity, and empty Dart/test/Windows content diff.

## Phase-1 validation results

- `py -3 tools/doctor.py`: `PASS` (`[OK] doctor passed`).
- `py -3 tools/validate_all.py`: unrestricted `PASS`, exit `0`, 314 tests,
  final `[OK] validate_all.py PASSED`. Exactly four warnings
  are the expected, pre-existing, non-blocking missing-optional-photo fixture
  warnings: the Pelle photo appears once during ZIP validation and once during
  imported-directory validation; the Board Canvas smoke photo does the same.
  The first restricted run reached the suite but normal ignored `.codex`
  materialization writes were permission-blocked; the identical unrestricted
  command supplied the green result.
- Stable-anchor closure: `PASS`; all selected anchors resolve exactly in the
  eight committed source/test targets: router `36`, shell source `36`, Overview
  source `34`, Board source `58`, shell test `32`, ProjectGate test `24`,
  Overview test `32`, and Board test `43` (`295` total, zero missing).
- Map concision: `PASS`; physical map lines are router `192`, shell source
  `183`, Overview source `160`, Board source `194`, shell test `176`,
  ProjectGate test `178`, Overview test `157`, and Board test `192`, all inside
  the Standard's preferred production/test ranges and below 300.
- Registry parity/status: `PASS`; 34 maps, 34 rows, eight review pairs, 26
  maintained pairs, zero orphan, zero unindexed, and zero status mismatch.
- Committed-input closure: `PASS`; all eight worktree Dart/test blobs equal the
  durable object ids published above.
- Git/freeze closure: `PASS`; exact 14-path material set, exactly three new
  paths, zero staged/unmerged paths, zero Dart/test or Windows substantive
  content paths, and both diff checks pass.
- Route/verdict/ledger closure: `PASS`; all three route-owner tops agree, the
  neutral ledger row occurs once at `REVIEW_REQUIRED`, and the one designated
  verdict block has one BEGIN/END pair with an empty interior.
- `SELF_REFERENCE_AUDIT`: `PASS`; current authored sections make no current-pass
  acceptance/staging claim, the ledger Description stays neutral, predecessor
  acceptance is explicitly attributed, and verdict enums are audit return
  templates rather than present results.

## TOOL_SKILL_CHECK

- Repo-local inventory owner: `docs/CODEX_TOOLING_POLICY.md`.
- Repo-local capability selected: `tracebench-prompt-authoring`, solely for the
  requested real-diff Claude handoff after validation; it does not authorize or
  widen map work.
- No dedicated repo-local Code Map maintenance skill exists.
- `tracebench-scope-lock` is not applicable because this pass does not reserve a
  future implementation; `tracebench-audit-reconciliation` is not applicable
  because no pushed artifact requires verdict reconciliation.
- Generic workflow capabilities used: plan execution and fresh verification.
- Repo helpers: Git, PowerShell, `rg`, `apply_patch`, `tools/doctor.py`, and
  `tools/validate_all.py`.
- External plugin/tool required: `NO`.
- Capability use does not widen the exact 14-path allowlist.

## MODEL_ROUTING_CHECK

- Result: `ESCALATED`.
- Codex performs bounded Lane A docs/map maintenance; Claude Code receives the
  independent exact-diff audit before any human staging decision.

## SELF_REFERENCE_AUDIT

- The artifact and ledger describe pass identity, committed inputs, performed
  map maintenance, route/boundaries, and time-invariant audit mechanics.
- Ledger Status is neutral `REVIEW_REQUIRED`; its Description claims no
  independent verdict or staging safety.
- The block below has exactly one BEGIN marker, one END marker, and an empty
  interior in Phase 1.
- Accepted status is attributed only to the committed implementation evidence,
  not to this map/pass audit.
- No touched prose claims this Phase-1 diff is accepted or safe to stage.

## Designated independent-audit verdict block

<!-- TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/app/router.dart.md
- docs/code_maps/lib/features/project/widgets/workbench_shell.dart.md
- docs/code_maps/lib/features/project/screens/project_overview_screen.dart.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/workbench_shell_test.dart.md
- docs/code_maps/test/widget/project_gate_test.dart.md
- docs/code_maps/test/widget/project_overview_screen_test.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES
BOUNDARY_RESULT: PASS
SELF_REFERENCE_AUDIT: PASS

<!-- TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
