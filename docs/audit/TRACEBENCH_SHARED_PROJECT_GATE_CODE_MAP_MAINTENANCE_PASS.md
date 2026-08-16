# TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS

## Pass identity and Phase-1 posture

- Project: TraceBench / BenchBeep
- PASS_ID: `TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS`
- Lane: `A`
- Mode: `DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1`
- Ledger Status: `REVIEW_REQUIRED`
- Manual smoke: `NOT_APPLICABLE`

This pass refreshes one existing router Code Map and creates one qualifying
test map strictly from committed Shared Project Gate source/test. It changes no
executable behavior and grants no successor authority beyond the
non-executable `NEEDS_USER_DECISION` sentinel.

## Verified committed baseline

- Worktree: `C:\dev\TraceBench`
- Repository: `Fuuduuu/TraceBench`
- Branch: `main`
- `HEAD`: `a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba`
- local `origin/main`: `a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba`
- divergence: `0 0`
- subject: `feat: add shared project gate`
- parent: `2b2db684ec9205cbdf003938c59f2d0d16ca33a8`

The entry substantive content diff, cached diff, untracked set, and unmerged
set returned no paths. Raw porcelain additionally reported the already-known
stat/EOL residue for `docs/code_maps/CODE_MAP_INDEX.md` and three generated
Windows plugin files; filtered worktree, index, and `HEAD` content was
identical at entry. This pass does not normalize that residue.

## Exact Phase-1 material set -- 8

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/router.dart.md`
7. `docs/code_maps/test/widget/project_gate_test.dart.md`
8. `docs/audit/TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS.md`

No ninth path belongs to this pass. The test map and this artifact are the only
new paths.

## Committed implementation evidence

`git diff-tree --no-commit-id --name-status -r
a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba` returns exactly:

```text
M lib/app/router.dart
A lib/features/project/widgets/project_gate.dart
M test/widget/board_canvas_screen_test.dart
A test/widget/project_gate_test.dart
```

`git show --numstat --format=
a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba` returns:

```text
46  15  lib/app/router.dart
118 0   lib/features/project/widgets/project_gate.dart
8   2   test/widget/board_canvas_screen_test.dart
418 0   test/widget/project_gate_test.dart
```

The durable mapping inputs are anchored by Git object identity:

| Committed target | Git object id | Reproduction command |
| --- | --- | --- |
| `lib/app/router.dart` | `a41bef1a71fc7117102c2c33bd4391f29825a2e3` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:lib/app/router.dart` |
| `lib/features/project/widgets/project_gate.dart` | `90069c07d9f1ea3d3a77d19504e288c96ce245f8` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:lib/features/project/widgets/project_gate.dart` |
| `test/widget/project_gate_test.dart` | `4678aef65c04783932d7804ec8919464747afa2d` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:test/widget/project_gate_test.dart` |
| `test/widget/board_canvas_screen_test.dart` | `4b5c959208f08c476c217bf8961925386fe70b12` | `git rev-parse a8e0fe7ab2ee07581674fd53ea99cbdd5ba612ba:test/widget/board_canvas_screen_test.dart` |

No working-tree runtime/test content is used as a speculative mapping source.

## CODE_MAP_PREFLIGHT

### Router production target

- Source: `lib/app/router.dart`
- Existing map: `docs/code_maps/lib/app/router.dart.md`
- Qualification: retained human override for cross-router creation handoff and
  durable impact analysis.
- Entry map/index state: `MAINTAINED`
- Committed-source disposition: `UPDATE_REQUIRED`
- Drift: `SYMBOL_DRIFT`, `FLOW_DRIFT`, dependency and linked `TEST_DRIFT` in
  the project-child construction zone; no router write-boundary drift.
- Phase-1 refreshed state: `REVIEW_REQUIRED`

### ProjectGate production target

- Source: `lib/features/project/widgets/project_gate.dart`
- Index/map lookup: no entry and no deterministic map.
- Physical size: 118 lines -> `0`.
- Independent responsibilities: three cohesive responsibilities -> `1`.
- Canonical/protected boundaries: one project-state/open-action boundary ->
  `1`.
- Regression surface: one compact focused family -> `1`.
- Whole-file analysis tax: one recent broad analysis -> `1`.
- Blast-radius ambiguity: one to two adjacent zones -> `1`.
- Qualification result: `SCORE 5/12`; at least two non-size dimensions are
  nonzero, but the total is below six.
- Automatic qualification check: `NO`. The file owns loaded/null selection,
  recovery presentation/actions, and delegation through two deterministic
  seams. The 15-target inventory belongs to the router; picker cancel, typed
  and generic failure presentation, and provider assignment belong to the
  reused `ProjectDirectoryOpenAction`. Those delegated outcomes are not five
  independently owned production behaviors.
- Disposition: `NOT_APPLICABLE`; no map or index row is created.

### ProjectGate test target

- Source: `test/widget/project_gate_test.dart`
- Index/map lookup: no entry and no deterministic map at entry.
- Physical size: 418 lines -> `0`.
- Independent responsibilities: four families -> `1`.
- Canonical/protected boundaries: multiple route, provider, open-action, and
  writer boundaries -> `2`.
- Regression surface: three or more behavior families across 10 tests -> `2`.
- Whole-file analysis tax: one recent broad analysis -> `1`.
- Blast-radius ambiguity: adjacent harness/outcome/route zones -> `1`.
- Qualification: `SCORE 7/12`; five non-size dimensions are nonzero.
- Entry lifecycle result: `BLOCKED_CODE_MAP_REQUIRED`.
- Phase-1 action: create the deterministic first map at `REVIEW_REQUIRED` and
  add its matching index row at `REVIEW_REQUIRED`.

### Board Canvas test target

- Source: `test/widget/board_canvas_screen_test.dart`
- Existing map/index state: `MAINTAINED`.
- Committed change: only the two reserved canonical/alias route fixtures move
  from null state to explicit loaded state.
- Map review: stable anchors, harness ownership, route responsibilities,
  state/data flow, write boundaries, test count, and linked families remain
  accurate.
- Disposition: `REVIEWED_NO_CHANGE`; map and index row are byte-frozen.

## Router map refresh result

The refreshed router map records:

1. one `ProjectGate(child: ...)` wrapper around exactly 15 real project
   targets;
2. unchanged canonical `/project` and all nested route paths/names;
3. unchanged redirect-only `/project/measurements/new` and
   `/project/board-canvas` aliases outside the gate;
4. `ProjectGate` as a direct outbound wrapper dependency;
5. state/open/recovery ownership remaining downstream from the router;
6. router construction, gated builders, redirects, and error rendering
   remaining `ZERO_WRITE` or `UI_LOCAL` only; and
7. `test/widget/project_gate_test.dart` as the focused route/gate evidence
   owner alongside existing router harnesses.

The existing human-approved qualification remains unchanged. The refreshed
map is kept within the Standard's zone and concision limits.

## First ProjectGate test map result

The new test map records:

- the exact 15-entry `_projectDestinations` route/type inventory;
- `_loadedProject`, `_RouterSession`, and `_pumpRouter` fixture/harness flow;
- injected directory-picker and project-loader seams;
- `_RecordingAddComponentWriter.requests` as the representative zero-write
  observation;
- exact recovery copy plus active `BenchBeepVisualTokens` surface/panel/rule
  treatment;
- null and preloaded child lifecycle;
- cancel, typed failure, generic failure, and success outcomes;
- success provider assignment without original-URI replacement;
- Home and both unchanged aliases;
- all 15 real gated destinations; and
- `UI_LOCAL`, `PROJECTION_STATE`, `ZERO_WRITE`, exercised filesystem-read,
  and canonical-writer boundary distinctions.

The map contains eight responsibility zones and stays within the Standard's
test-map concision range.

## Registry and lifecycle evidence

- Actual map files after Phase 1: `30`
- Registry rows after Phase 1: `30`
- Orphan maps: `0`
- Unindexed map files: `0`
- Phase-1 `REVIEW_REQUIRED` map headers: `2`
- Phase-1 `REVIEW_REQUIRED` index cells: `2`
- Unchanged `MAINTAINED` map/index pairs: `28`
- `project_gate.dart` production map/index row: absent by qualification.

Only the router Status cell changes and the gate-test row is added in
`docs/code_maps/CODE_MAP_INDEX.md`. Every existing Source, Map file, Type, and
unrelated Status cell remains byte-identical to `HEAD`.

## Route result

The three route owners agree:

```text
Current: TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

The complete transition is:

```text
TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS
   [accepted and committed at 2b2db68]
-> TRACEBENCH_SHARED_PROJECT_GATE_IMPL_PASS
   [committed at a8e0fe7]
-> TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

The prior scope sections remain under historical, non-authorizing headings;
no completed history is deleted or reopened.

## Frozen-boundary evidence

This pass changes no Dart/test/runtime source, Board Canvas test map, unrelated
map/index row, route definition, destination screen, writer, provider,
event/fact/evidence semantics, Project ZIP, freshness behavior/copy/ownership,
F-01/F-05/F-16 board-plane behavior, painter/hit/placement/geometry, shell,
responsive envelope, package, Windows, tool, schema, asset, sample, F-03, or
other product byte. Manual smoke is `NOT_APPLICABLE` for descriptive
maintenance.

## Bounded Phase-2 authority

A clean independent map/pass audit may authorize at most six logical writes:

1. fill only the existing verdict-block interior below;
2. mechanically mirror that result in only this PASS_ID's existing
   `docs/AUDIT_INDEX.md` Status cell;
3. promote only the router map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
4. promote only the gate-test map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
5. promote only the router matching index Status cell; and
6. promote only the gate-test matching index Status cell.

Every map body, qualification, Source/Type/Audit-evidence field, route byte,
ledger Description, artifact exterior, unrelated index/ledger cell, and other
repository byte is frozen. The new gate-test row means the index remains part
of the final material set after any accepted status promotions.

## Independent audit contract

Audit the complete Phase-1 diff except the empty designated block. For each
map return:

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

Confirm the exact eight-path Phase-1 and final material set, the production
gate non-qualification, the gate-test `SCORE 7/12`, the Board Canvas
`REVIEWED_NO_CHANGE` result, and the six-coordinate maximum for any authorized
Phase 2.

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
sets, 30/30 registry parity, exactly two `REVIEW_REQUIRED` map headers/index
cells, route-owner agreement, one empty verdict block, committed
implementation blob identity, and empty runtime/test/Windows content diff.

## Phase-1 validation results

- `py -3 tools/doctor.py`: `PASS` — `[OK] doctor passed`.
- `py -3 tools/validate_all.py`: `PASS` — `314/314` unit tests and final
  `[OK] validate_all.py PASSED`; four expected optional-photo warnings were
  emitted across ZIP/directory validation for the two sample projects.
- The first sandbox-constrained validator invocation could not write its two
  normal ignored `.codex/known_facts*.json` outputs. All 314 unit tests passed
  in that invocation; the validator reported only the two resulting
  materialization failures. The identical command was rerun with permission
  for those repository-local ignored outputs and passed. No content path was
  added to the pass material set.
- `git diff --check`: `PASS`.
- `git diff --cached --check`: `PASS`.
- Phase-1 content set: `PASS` — six tracked paths plus exactly the two
  authorized new paths equal the eight-path allowlist.
- `git diff --cached --name-status`: no paths.
- `git diff --name-only --diff-filter=U`: no paths.
- Runtime/test and `windows/**` content diffs: empty.
- Registry: `PASS` — 30 actual maps, 30 index rows, zero orphan, zero
  unindexed; exactly two map headers and two index cells are
  `REVIEW_REQUIRED`, and the other 28 pairs are `MAINTAINED`.
- Route: `PASS` — all three owners name this pass as Current and
  `NEEDS_USER_DECISION` as Next.
- Verdict block: `PASS` — exactly one marker pair and an empty interior.
- Committed implementation freeze: `PASS` —
  `git diff --exit-code -- lib test` returned no content difference, while the
  four committed `blob` object ids remain the tabled durable anchors above.
- Board Canvas test map freeze: `PASS` — filtered worktree object id
  `9a720f97ffac1891ed07beec50abbd3a7c1c1905`, produced by
  `git hash-object --path=docs/code_maps/test/widget/board_canvas_screen_test.dart.md docs/code_maps/test/widget/board_canvas_screen_test.dart.md`, equals the
  `HEAD` blob produced by
  `git rev-parse HEAD:docs/code_maps/test/widget/board_canvas_screen_test.dart.md`.

## TOOL_SKILL_CHECK

- Repo-local inventory owner read: `docs/CODEX_TOOLING_POLICY.md`.
- Repo-local skills inspected: `tracebench-scope-lock`,
  `tracebench-prompt-authoring`, and `tracebench-audit-reconciliation`.
- Repo-local skill used: `none applicable`. This is execution of an already
  supplied committed-source map-maintenance pass, not future-scope
  reservation, prompt authoring, or post-push audit reconciliation.
- Repo helpers used: Git, PowerShell, `rg`, `apply_patch`, `tools/doctor.py`,
  and `tools/validate_all.py`.
- External plugin/tool required: `NO`.
- Capability use does not widen the exact eight-path allowlist.

## SELF_REFERENCE_AUDIT

- The artifact and ledger describe pass identity, committed inputs, performed
  map maintenance, route/boundaries, and time-invariant audit mechanics.
- The ledger Status is neutral `REVIEW_REQUIRED`; its Description claims no
  independent verdict or staging safety.
- The block below has exactly one BEGIN marker, one END marker, and an empty
  interior in Phase 1.
- Accepted status is attributed only to the committed predecessor scope, not
  to this map/pass audit or to undocumented implementation-audit evidence.
- No touched prose asserts this pass's audit-pipeline or staging position.

## Designated independent-audit verdict block

<!-- TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

Router map:

MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

ProjectGate test map:

MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: YES

Board Canvas test map:

MAP_VERDICT: ACCEPT_AS_IS
SAFE_FOR_SNIPER_USE: YES
MAP_STATUS_PROMOTION_REQUIRED: NO

Pass:

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/app/router.dart.md
- docs/code_maps/test/widget/project_gate_test.dart.md
- docs/audit/TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
