# TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS

## Pass identity and Phase-1 posture

- Project: TraceBench / BenchBeep
- PASS_ID: `TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS`
- Lane: `A`
- Mode: `DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1`
- Ledger Status: `REVIEW_REQUIRED`
- Manual smoke: `NOT_APPLICABLE`

This pass refreshes two existing Code Maps strictly from accepted committed
Board Canvas source/test. It changes no executable behavior and grants no
successor authority beyond the non-executable `NEEDS_USER_DECISION` sentinel.

## Verified committed baseline

- Worktree: `C:\dev\TraceBench`
- Repository: `Fuuduuu/TraceBench`
- Branch: `main`
- `HEAD`: `f8336645e8207870edda8b57774f5ce5243fbd24`
- local `origin/main`: `f8336645e8207870edda8b57774f5ce5243fbd24`
- divergence: `0 0`
- subject: `feat: improve board canvas project navigation`
- parent: `7153f3ea668a1bb8538ada56d490752ff8aa7297`

The entry content diff, cached diff, untracked set, and unmerged set returned no
paths. Raw porcelain additionally reported the already-known stat/EOL residue
for `docs/code_maps/CODE_MAP_INDEX.md` and three generated Windows plugin
files; filtered worktree, index, and `HEAD` blobs were identical at entry.
This pass does not normalize or otherwise touch that residue.

## Exact Phase-1 material set -- 8

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
7. `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
8. `docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS.md`

No ninth path belongs to this pass. The artifact is the only new path.

## Accepted committed implementation evidence

`git diff-tree --no-commit-id --name-status -r
f8336645e8207870edda8b57774f5ce5243fbd24` returns exactly:

```text
M lib/features/board_canvas/screens/board_canvas_screen.dart
M test/widget/board_canvas_screen_test.dart
```

`git show --numstat --format=
f8336645e8207870edda8b57774f5ce5243fbd24` returns:

```text
36  1   lib/features/board_canvas/screens/board_canvas_screen.dart
224 87  test/widget/board_canvas_screen_test.dart
```

The durable committed mapping inputs are anchored by Git object identity:

| Committed source | Git object id | Reproduction command |
| --- | --- | --- |
| `lib/features/board_canvas/screens/board_canvas_screen.dart` | `53f27a2ea5ba616d5adc31bd95f3e06ecac04d07` | `git rev-parse f8336645e8207870edda8b57774f5ce5243fbd24:lib/features/board_canvas/screens/board_canvas_screen.dart` |
| `test/widget/board_canvas_screen_test.dart` | `089514963707bf527f2d5e3a1bddcc86f50dde68` | `git rev-parse f8336645e8207870edda8b57774f5ce5243fbd24:test/widget/board_canvas_screen_test.dart` |

No working-tree runtime/test content was used as a speculative source.

## CODE_MAP_PREFLIGHT

### Production target

- Source: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Existing deterministic map:
  `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
- Qualification:
  `AUTO — >5000 lines + 3+ responsibilities`
- Entry map/index state: `MAINTAINED`
- Accepted post-implementation disposition: `UPDATE_REQUIRED`
- Drift: `FLOW_DRIFT`, `SYMBOL_DRIFT`, `BOUNDARY_DRIFT`, and linked
  `TEST_DRIFT` in the Project-navigation responsibility.
- Phase-1 refreshed state: `REVIEW_REQUIRED`

### Test target

- Source: `test/widget/board_canvas_screen_test.dart`
- Existing deterministic map:
  `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
- Qualification:
  `AUTO — >3000 lines + 3+ test families`
- Committed test declarations: `168` (`158` `testWidgets`, `10` `test`),
  counted with anchored `rg` expressions over committed-equivalent source.
- Entry map/index state: `MAINTAINED`
- Accepted post-implementation disposition: `UPDATE_REQUIRED`
- Drift: helper/title `SYMBOL_DRIFT`, router/provider/filesystem
  `BOUNDARY_DRIFT`, navigation-family `TEST_DRIFT`, and linked `FLOW_DRIFT`.
- Phase-1 refreshed state: `REVIEW_REQUIRED`

The implementation combines the already human-authorized navigation zones
only. No new multi-zone decision is introduced by descriptive maintenance.

## Production map refresh result

The refreshed production map has 12 responsibility zones and records:

1. `_WorkbenchContextPanelMode _contextPanelMode` defaults to
   `projectNavigation`;
2. the Project hub is visible on initial supported `1000x800` and `1400x800`
   Workbench renders;
3. the exact ordered 12-action inventory is Home, Overview, Components,
   Measurements, Pins, Not Populated, Photos, Reference Images, Graph, Events,
   Known Facts, and Report;
4. the old seven retain relative order: Home, Photos, Reference Images,
   Graph, Events, Known Facts, Report;
5. the five additions and exact routes are Overview `/project/overview`,
   Components `/project/components`, Measurements `/project/measurements`,
   Pins `/project/pins`, and Not Populated `/project/not-populated`;
6. Add Component, Edit Component, and Measure Sheet remain outside the hub;
7. `Projekt` restores the hub after another panel and focus hide/restore
   preserves its selected state;
8. the new Overview action participates in the tested Canvas -> Overview ->
   Canvas round trip that settles on canonical `/project` through unchanged
   router/Overview owners; and
9. navigation remains `UI_LOCAL` + `ZERO_WRITE`, leaving all four writer call
   sites, provider state, events, freshness, and project files unchanged.

The refresh retains the existing selection, navigator, filter, measurement,
component create/edit, placement, Wizard gate/fit/render, inspector/evidence,
freshness, board-plane, geometry, and protected-boundary descriptions. The
former separate rail and Project-hub zones are combined into one coherent
zone, bringing the map from 13 to the Standard's maximum 12 zones. The
refreshed map is 206 physical lines.

## Test map refresh result

The refreshed test map has 12 responsibility zones and records:

- exact committed total `168` tests;
- `_projectHubDestinations` as the ordered expected key/label/path tuple set;
- `_projectHubActionKeys` as actual `ListView` key-order extraction;
- `_revealProjectHubAction` as the scroll-to-action helper;
- initial Project hub visibility at `1000x800` and `1400x800`;
- exact 12 unique keyed actions in order;
- explicit exclusion of Add Component, Edit Component, and Measure Sheet;
- all 12 route checks, including the five new named-route owners;
- `Projekt` panel restoration and focus hide/restore;
- production-router Canvas -> Overview -> Canvas canonical `/project`;
- all four fake-writer lists remaining empty; and
- provider identity, events, projection freshness, and temporary project
  contents remaining unchanged during navigation.

The refreshed map retains the existing fixture/harness, navigator/filter,
writer, Canvas/Wizard, painter/semantics, inspector/evidence, boundary, and
freshness families. It is 190 physical lines.

## Inspect-only route and Overview evidence

`lib/app/router.dart` remains the route owner. Its committed map is
`MAINTAINED`; canonical `/project`, `/project/overview`, and the compatibility
`/project/board-canvas` redirect remain unchanged.

`lib/features/project/screens/project_overview_screen.dart` and
`test/widget/project_overview_screen_test.dart` plus their maps remain
unchanged and `MAINTAINED`. The existing Overview action key
`overview-board-canvas-button` returns through the unchanged router contract.
Their disposition is `REVIEWED_NO_CHANGE`.

## Registry and lifecycle evidence

- Actual map files: `29`
- Registry rows: `29`
- Orphan maps: `0`
- Unindexed map files: `0`
- Phase-1 `REVIEW_REQUIRED` map headers: `2`
- Phase-1 `REVIEW_REQUIRED` index cells: `2`
- Unchanged `MAINTAINED` map/index pairs: `27`

Only the Board Canvas production/test Status cells move in
`docs/code_maps/CODE_MAP_INDEX.md`. Every Source, Map file, Type, and unrelated
Status cell remains byte-identical to `HEAD`.

## Route result

The three route owners agree:

```text
Current: TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

The complete transition is:

```text
TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_SCOPE_LOCK_PASS
   [accepted and committed at 7153f3e]
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_IMPL_PASS
   [accepted and committed at f833664]
-> TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

The prior scope section is retained beneath a historical, non-authorizing
heading; no completed history is deleted or reopened.

## Frozen-boundary evidence

This pass changes no Dart/test source, router, Project Overview, writer,
provider, event/fact/evidence semantics, F-01/F-05/F-16 board-plane behavior,
painter/hit/placement/geometry, freshness banner/copy/ownership/twelve-surface
contract, shell, project guard, `main.dart`, responsive minimum-size contract,
Project ZIP, package, Windows, tool, schema, asset, sample, F-03, or unrelated
map/index row. Manual smoke is `NOT_APPLICABLE` for descriptive maintenance.

## Bounded Phase-2 authority

A clean independent map/pass audit may authorize at most six logical writes:

1. fill only the existing verdict-block interior below;
2. mechanically mirror that result in only this PASS_ID's existing
   `docs/AUDIT_INDEX.md` Status cell;
3. promote only the production map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
4. promote only the test map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
5. promote only the production matching index Status cell; and
6. promote only the test matching index Status cell.

Every map body, qualification, Source/Type/Audit-evidence field, route byte,
ledger Description, artifact exterior, and unrelated byte is frozen. If both
map/index pairs are accepted and promoted, `CODE_MAP_INDEX.md` returns to
byte-content parity with `HEAD`; the Phase-1 material set remains eight, while
the final net Git staging set would contain seven paths and exclude that
net-zero index file. The independent auditor must state the applicable set
explicitly rather than treating a reported path count as authority.

## Independent audit contract

Audit the complete Phase-1 diff except the empty designated block. For each
map return:

```text
MAP_VERDICT: ACCEPT_AS_IS | ACCEPT_WITH_NITS | BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES | NO
MAP_STATUS_PROMOTION_REQUIRED: YES | NO
```

Then return the pass result:

```text
AUDIT_VERDICT: ACCEPT_AS_IS | NEEDS_SMALL_PATCH | REJECT
SAFE_FOR_STAGING: YES | NO
SAFE_STAGING_SET: exact paths or NONE
PHASE_2_RECORDING_AUTHORIZATION: YES | NO
```

Confirm the exact eight-path Phase-1 reviewed set. If both maps are accepted,
also confirm whether the authorized promotions make the index net-zero and
whether the final seven-path net staging set excludes
`docs/code_maps/CODE_MAP_INDEX.md`.

## Phase-1 validation contract

Run and report:

```text
py -3 tools\doctor.py
py -3 tools\validate_all.py
git diff --check
git diff --cached --check
```

Also verify exact material scope, empty cached/unmerged sets, the sole
authorized new artifact, 29/29 registry parity, exactly two
`REVIEW_REQUIRED` map headers/index cells, and committed source/test blob
identity.

## Phase-1 validation results

- `py -3 tools\doctor.py`: `PASS` — `[OK] doctor passed`.
- `py -3 tools\validate_all.py`: `PASS` — `314/314` unit tests and final
  `[OK] validate_all.py PASSED`; four expected optional-photo warnings were
  emitted across ZIP/directory validation for the two sample projects.
- The first sandbox-constrained validator invocation could not write its
  normal ignored `.codex/known_facts*.json` outputs and reported only those
  two `PermissionError` materialization failures while all 314 tests passed.
  The same command was rerun with permission for those repository-local
  ignored outputs and passed. `.gitignore` owns `.codex/`; no content path was
  added to the pass material set.
- `git diff --check`: `PASS`.
- `git diff --cached --check`: `PASS`.
- Phase-1 content set: `PASS` — seven tracked paths plus the sole authorized
  new artifact equal the exact eight-path allowlist.
- `git diff --cached --name-status`: no paths.
- `git diff --name-only --diff-filter=U`: no paths.
- `git diff -- windows/`: no content.
- Registry: `PASS` — 29 actual maps, 29 index rows, zero orphan, zero
  unindexed; exactly two map headers and two index cells are
  `REVIEW_REQUIRED`.
- Route: `PASS` — all three owners name this pass as Current and
  `NEEDS_USER_DECISION` as Next.
- Verdict block: `PASS` — exactly one marker pair and an empty interior.
- Committed source/test freeze: `PASS` —
  `git hash-object lib/features/board_canvas/screens/board_canvas_screen.dart`
  and `git hash-object test/widget/board_canvas_screen_test.dart` return
  `53f27a2ea5ba616d5adc31bd95f3e06ecac04d07` and
  `089514963707bf527f2d5e3a1bddcc86f50dde68`; both match the committed `blob`
  object identities above.

## TOOL_SKILL_CHECK

- Repo-local skills inspected through `docs/CODEX_TOOLING_POLICY.md`:
  `tracebench-scope-lock`, `tracebench-prompt-authoring`, and
  `tracebench-audit-reconciliation`.
- Repo-local skill used: `none applicable`. This is execution of an already
  supplied exact map-maintenance pass, not future implementation reservation,
  prompt authoring, or post-push artifact reconciliation.
- General capabilities used: `executing-plans` for bounded sequencing and
  `verification-before-completion` for fresh evidence before completion.
- Repo helpers used: Git, PowerShell, `rg`, `apply_patch`,
  `tools/doctor.py`, and `tools/validate_all.py`.
- External plugin/tool requirement: `NO`.
- Capability use does not widen the exact eight-path allowlist.

## SELF_REFERENCE_AUDIT

- The artifact and ledger describe pass identity, committed inputs, performed
  map refreshes, route/boundaries, and time-invariant audit mechanics.
- The ledger Status is neutral `REVIEW_REQUIRED`; its Description claims no
  independent verdict or staging safety.
- The block below has exactly one BEGIN marker, one END marker, and an empty
  interior in Phase 1.
- Accepted status is attributed only to the committed predecessor scope and
  implementation, not to this map/pass audit.
- No touched prose asserts this pass's audit-pipeline or staging position.

## Designated independent-audit verdict block

<!-- TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md
- docs/code_maps/test/widget/board_canvas_screen_test.dart.md
- docs/audit/TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS.md

CODE_MAP_INDEX_NET_ZERO_AFTER_PROMOTION: YES

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
