# TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS

## Pass identity and Phase-1 posture

- Project: TraceBench / BenchBeep
- PASS_ID: `TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS`
- Lane: `A`
- Mode: `DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1`
- Ledger Status: `REVIEW_REQUIRED`
- Manual smoke: `NOT_APPLICABLE`

This pass refreshes three existing maps and creates the first qualifying map
for the neutral project-acquisition owner strictly from committed Legacy Viewer
removal source/test. It changes no executable behavior and grants no successor
authority beyond the non-executable `NEEDS_USER_DECISION` sentinel.

## Verified committed baseline

- Worktree: `C:\dev\TraceBench`
- Repository: `Fuuduuu/TraceBench`
- Branch: `main`
- `HEAD`: `f43b2c0c72b29297e20cbe548678ff282a3a5195`
- local `origin/main`: `f43b2c0c72b29297e20cbe548678ff282a3a5195`
- divergence: `0 0`
- subject: `fix: remove legacy viewer fallback`
- parent: `f3a5af9c6f752ff54615af061f0ba523c7df29f1`

The entry substantive content diff, cached diff, untracked set, and unmerged
set returned no paths. Raw porcelain reported only the already-known
content-identical EOL/stat residue in three generated Windows plugin files.
This pass does not normalize or otherwise touch that residue.

## Exact Phase-1 material set -- 10

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/app.dart.md`
7. `docs/code_maps/lib/app/router.dart.md`
8. `docs/code_maps/lib/features/project/actions/project_acquisition_actions.dart.md`
9. `docs/code_maps/test/widget/project_gate_test.dart.md`
10. `docs/audit/TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS.md`

No eleventh path belongs to this pass. The acquisition-owner map and this
artifact are the only new paths.

## Committed implementation evidence

`git diff-tree --no-commit-id --name-status -r -M
f43b2c0c72b29297e20cbe548678ff282a3a5195` identifies the exact committed
implementation delta:

```text
M    lib/app/app.dart
M    lib/app/router.dart
R051 lib/features/project/screens/home_screen.dart
     lib/features/project/actions/project_acquisition_actions.dart
M    lib/features/project/widgets/project_gate.dart
M    test/integration/projection_stale_banner_end_to_end_test.dart
M    test/widget/benchbeep_home_screen_test.dart
M    test/widget/board_canvas_screen_test.dart
M    test/widget/edit_component_screen_test.dart
M    test/widget/project_gate_test.dart
M    test/widget/project_overview_screen_test.dart
```

The exact implementation material set is eleven repository paths because the
rename has one deleted source and one added destination. No other source/test
path is mapping input.

Durable committed object identities are the `blob` object ids returned by the
exact command template `git rev-parse f43b2c0c72b29297e20cbe548678ff282a3a5195:<repository-relative-path>`:

| Committed target | Git object id |
| --- | --- |
| `lib/app/app.dart` | `70bfd3076e7ac31c5c16742e9ae4c40d06da935c` |
| `lib/app/router.dart` | `3abdc465da47e01e16d7a3c3831faabfb7773579` |
| `lib/features/project/actions/project_acquisition_actions.dart` | `1848e42d131a56f09159fbd8abad479f4ca5fabf` |
| `lib/features/project/widgets/project_gate.dart` | `6338d473639e2d533d90f16465fcbe9761411017` |
| `test/widget/benchbeep_home_screen_test.dart` | `f91522f6cc33c68ae4d3ad8f3163ec7ac508703c` |
| `test/widget/board_canvas_screen_test.dart` | `a6526d63bbf83ea35c1152aa190a2a6fbd61b4ee` |
| `test/widget/edit_component_screen_test.dart` | `6de175bf04dd0a9cec0ca3b1998efcbfd1fd827c` |
| `test/widget/project_gate_test.dart` | `713784cd690e6c92797acdbb3b0775b5eef5d517` |
| `test/widget/project_overview_screen_test.dart` | `a51fc4263aeda3bf9bab6eeafc0bcff097f43883` |
| `test/integration/projection_stale_banner_end_to_end_test.dart` | `ebc9035302c104fc731e40d3847b4f108e96cf72` |

No working-tree runtime/test content is used as speculative mapping source.

## CODE_MAP_PREFLIGHT

### App production target

- Source: `lib/app/app.dart`
- Existing map/index entry state: `MAINTAINED`.
- Committed-source disposition: `UPDATE_REQUIRED`.
- Drift: `SYMBOL_DRIFT` for removed `routerProvider`; `STRUCTURE_DRIFT` and
  dependency drift for the neutral action owner; `FLOW_DRIFT` for delegated
  ZIP/directory handoff; root-construction drift for required `homeBuilder`.
- Preserved boundary: launcher/workbench state stays `UI_LOCAL`; bundled and
  Wizard assignments remain `PROJECTION_STATE`; persistent creation and
  Project ZIP ownership remain downstream.
- Phase-1 refreshed state: `REVIEW_REQUIRED`.

### Router production target

- Source: `lib/app/router.dart`
- Existing map/index entry state: `MAINTAINED`.
- Committed-source disposition: `UPDATE_REQUIRED`.
- Drift: `SYMBOL_DRIFT`, `FLOW_DRIFT`, dependency drift, and direct-caller
  `TEST_DRIFT` in the route-factory/root-Home zones.
- Preserved boundary: all routes, names, nesting, 15 real `ProjectGate`
  targets, two redirect aliases, Wizard default, errors, and
  `ZERO_WRITE`/`UI_LOCAL` ownership remain unchanged.
- Phase-1 refreshed state: `REVIEW_REQUIRED`.

### Project acquisition production target

- Source: `lib/features/project/actions/project_acquisition_actions.dart`
- Index/map lookup: no entry and no deterministic map at entry.
- Physical size: 120 lines -> `0`.
- Independent responsibilities: more than five distinct ZIP/directory
  behaviors -> `2`.
- Canonical/protected boundaries: one protected Project ZIP read boundary,
  plus explicit projection-state/navigation separation -> `1`.
- Regression surface: ZIP, directory, and ProjectGate recovery families ->
  `2`.
- Whole-file analysis tax: one current broad committed-source analysis -> `1`.
- Blast-radius ambiguity: app, gate, loader, provider, route, and two direct
  test owners require three or more adjacent zones -> `2`.
- Supporting worksheet: `SCORE 8/12`, with five non-size dimensions nonzero.
- Automatic qualification check: `YES`. The production file independently owns
  ZIP picker/cancel; byte-first load; path fallback/missing-path handling;
  state/callback/default-route success; typed and generic ZIP failures;
  directory picker/cancel; injected/default loader; directory success handoff;
  and typed/generic directory failures. This explicitly satisfies automatic
  rule 3 rather than assuming it.
- Canonical compact qualification:
  `AUTO — production file owns 5+ independently testable behaviors`.
- Entry lifecycle result: `BLOCKED_CODE_MAP_REQUIRED`.
- Phase-1 action: create the deterministic first map and matching index row at
  `REVIEW_REQUIRED`.

### ProjectGate test target

- Source: `test/widget/project_gate_test.dart`
- Existing map/index entry state: `MAINTAINED`.
- Physical size: 436 lines -> `0`.
- Independent responsibilities: four cohesive behavior families -> `1`.
- Canonical/protected boundaries: multiple route, provider, open-action, and
  writer boundaries -> `2`.
- Regression surface: three or more behavior families across 10 tests -> `2`.
- Whole-file analysis tax: one recent broad analysis -> `1`.
- Blast-radius ambiguity: adjacent harness, outcome, root, and route zones ->
  `1`.
- Qualification remains `SCORE 7/12`; five non-size dimensions are nonzero.
- Committed-source disposition: `UPDATE_REQUIRED`.
- Drift: `_buildCanonicalHome`, explicit `homeBuilder`,
  `BenchBeepHomeScreen`, and the two legacy Viewer absence assertions add
  stable root-contract anchors and linked router flow without changing the
  open/recovery/writer boundaries.
- Phase-1 refreshed state: `REVIEW_REQUIRED`.

### Rechecked committed implementation targets

- `test/widget/benchbeep_home_screen_test.dart`: `REVIEWED_NO_CHANGE`; only
  the action-owner import moved, while its 20-test mapped responsibilities,
  anchors, state flow, acquisition families, routes, and boundaries remain
  accurate.
- `test/widget/board_canvas_screen_test.dart`: `REVIEWED_NO_CHANGE`; exactly
  three router constructions add inert explicit roots, while the mapped 168-
  test inventory, helpers, route behavior, writers, freshness, and board-plane
  responsibilities remain accurate.
- `test/widget/edit_component_screen_test.dart`: `REVIEWED_NO_CHANGE`; one
  routed harness adds an inert root, with its 11-test mapped responsibilities
  unchanged.
- `test/widget/project_overview_screen_test.dart`: `REVIEWED_NO_CHANGE`; one
  routed harness adds an inert root, with its 23-test mapped route and
  zero-write responsibilities unchanged.
- `lib/features/project/widgets/project_gate.dart`: `NOT_APPLICABLE`; its 118
  lines still score `5/12`, the automatic five-behavior rule remains false,
  and its only committed change is the neutral action import path.
- `test/integration/projection_stale_banner_end_to_end_test.dart`:
  `NOT_APPLICABLE`; 76 lines, one compact cross-surface freshness family, and
  one inert explicit root builder do not meet a qualification rule.
- Deleted `lib/features/project/screens/home_screen.dart`: no map existed and
  the same-child deletion exclusion leaves no source to map or retire.

## Map refresh results

The app map now records:

1. app-wide project/beginner providers without the removed router provider;
2. direct bundled loading versus neutral ZIP/directory action delegation;
3. provider state assignment ownership at the direct/delegated boundaries;
4. the required canonical `_buildLauncherHome` router builder;
5. unchanged launcher, splash, Wizard handoff, router lifecycle, and disposal;
6. neutral acquisition actions as direct dependencies; and
7. preserved `UI_LOCAL`, `PROJECTION_STATE`, and `ZERO_WRITE` distinctions.

The router map now records:

1. required `homeBuilder` and direct `/` construction;
2. no `HomeScreen` import or implicit legacy root fallback;
3. unchanged optional Wizard builder/default;
4. unchanged 15 real gated targets and two aliases;
5. one production app caller plus the exact five direct caller test files;
6. canonical BenchBeep root evidence in the gate test; and
7. unchanged navigation-only ownership.

The ProjectGate test map now records:

1. `_buildCanonicalHome` and `BenchBeepHomeScreen` as the explicit root
   fixture;
2. required `homeBuilder` wiring in `_pumpRouter`;
3. Home recovery to `/` with both legacy Viewer strings absent;
4. unchanged 15-target inventory, four open outcomes, two aliases, provider
   handoff, visual tokens, and representative zero-write writer evidence; and
5. the unchanged 10-test qualification and responsibility family.

The new acquisition map records both public actions, exact picker/cancel/load
branches, byte-first/path-fallback ZIP flow, directory seams, state-before-
callback/default-route ordering, typed/generic failures, direct app/gate
callers, focused test owners, Project ZIP read-only boundary, and
`ZERO_WRITE`/`PROJECTION_STATE`/`UI_LOCAL` distinctions.

## Registry and lifecycle evidence

- Actual map files after Phase 1: `31`.
- Registry rows after Phase 1: `31`.
- Orphan maps: `0`.
- Unindexed map files: `0`.
- Phase-1 `REVIEW_REQUIRED` map headers: `4`.
- Phase-1 `REVIEW_REQUIRED` index cells: `4`.
- Unchanged `MAINTAINED` map/index pairs: `27`.
- Deleted legacy source map/index row: absent.
- Nonqualifying ProjectGate production and freshness integration maps/index
  rows: absent.

Only the app, router, and ProjectGate-test Status cells change and the new
acquisition row is added in `CODE_MAP_INDEX.md`. Every Source, Map file, Type,
and unrelated Status cell remains byte-identical to `HEAD`.

## Route result

The three route owners agree:

```text
Current: TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

The complete transition is:

```text
TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS
   [accepted and committed at f3a5af9]
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_IMPL_PASS
   [accepted and committed at f43b2c0]
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

Prior scope/implementation sections remain under historical,
non-authorizing headings; no completed history is deleted or reopened.

## Frozen-boundary evidence

This pass changes no Dart/test/runtime source, route implementation,
destination screen, acquisition behavior, `ProjectLoader`, Project ZIP,
picker/cancel/load/failure/provider/callback/navigation semantics, writer,
event/fact/evidence semantics, freshness behavior/copy/ownership, Board Canvas
board-plane/geometry behavior, launcher/splash/Wizard/shell/theme/responsive
behavior, unrelated map/index row, package, Windows/EOL residue, tool, schema,
asset, sample, F-03, or other product byte. Manual smoke is `NOT_APPLICABLE`
for descriptive maintenance.

## Bounded Phase-2 authority

A clean independent map/pass audit may authorize at most ten logical writes:

1. fill only the existing verdict-block interior below;
2. mechanically mirror that result in only this PASS_ID's existing
   `docs/AUDIT_INDEX.md` Status cell;
3. promote only the app map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
4. promote only the router map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
5. promote only the acquisition map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
6. promote only the ProjectGate-test map Status
   `REVIEW_REQUIRED` -> `MAINTAINED`;
7-10. promote only the four matching index Status cells.

Every map body, qualification, Source/Type/Audit-evidence field, route byte,
ledger Description, artifact exterior, unrelated index/ledger cell, and other
repository byte is frozen. The new acquisition map/index row means the index
remains part of the final material set after accepted promotions.

## Independent audit contract

Audit the complete Phase-1 diff except the empty designated block. For each of
the four review-target maps return:

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

Confirm the exact ten-path Phase-1/final material set, acquisition automatic
qualification plus supporting worksheet, all seven rechecked non-map-update
dispositions, 31/31 registry state, and ten-coordinate maximum for any
authorized Phase 2.

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

Also verify exact material scope, exactly two new paths, empty cached/unmerged
sets, 31/31 registry parity, exactly four `REVIEW_REQUIRED` map headers/index
cells, route-owner agreement, one empty verdict block, committed source/test
blob identity, and empty runtime/test/Windows content diff.

## Phase-1 validation results

- `py -3 tools/doctor.py`: `PASS` (`[OK] doctor passed`).
- `py -3 tools/validate_all.py`: `PASS`; 314 tests passed. Four warnings report
  the two expected missing optional sample-photo files during ZIP and directory
  validation. The first restricted run completed the 314-test suite but could
  not write the two normal ignored `.codex` materializations; the identical
  command passed after granting that narrow write permission.

## TOOL_SKILL_CHECK

- Repo-local inventory owner read: `docs/CODEX_TOOLING_POLICY.md`.
- Repo-local skills inspected: `tracebench-scope-lock`,
  `tracebench-prompt-authoring`, and `tracebench-audit-reconciliation`.
- Repo-local skill used: `tracebench-prompt-authoring`, only to compose the
  requested real-diff Claude audit handoff after this Phase-1 material existed.
  It did not select or widen any map, route, or write authority.
- `tracebench-scope-lock` and `tracebench-audit-reconciliation` are not
  applicable: this is neither a future-scope reservation nor a post-push audit
  reconciliation.
- Repo helpers used: Git, PowerShell, `rg`, `apply_patch`, `tools/doctor.py`,
  and `tools/validate_all.py`.
- External plugin/tool required: `NO`.
- Capability use does not widen the exact ten-path allowlist.

## SELF_REFERENCE_AUDIT

- The artifact and ledger describe pass identity, committed inputs, performed
  map maintenance, route/boundaries, and time-invariant audit mechanics.
- The ledger Status is neutral `REVIEW_REQUIRED`; its Description claims no
  independent verdict or staging safety.
- The block below has exactly one BEGIN marker, one END marker, and an empty
  interior in Phase 1.
- Accepted status is attributed only to the committed predecessor scope and
  implementation, not to this map/pass audit.
- No touched prose asserts this pass's audit-pipeline or staging position.

## Designated independent-audit verdict block

<!-- TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/app/app.dart.md
- docs/code_maps/lib/app/router.dart.md
- docs/code_maps/lib/features/project/actions/project_acquisition_actions.dart.md
- docs/code_maps/test/widget/project_gate_test.dart.md
- docs/audit/TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_LEGACY_VIEWER_REMOVAL_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
