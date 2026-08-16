# Audit Artifact — Shared Project Gate Scope Lock

- PASS_ID: `TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS`
- Lane: `A`
- Mode: `SCOPE_LOCK / DOCS_ONLY / PHASE_1`
- Baseline: `8fd9b2ad7d720d4fc10d533f2da00241513e8e38`
- Status: `REVIEW_REQUIRED`
- Manual smoke for this docs-only scope: `NOT_APPLICABLE`
- Manual smoke for the reserved implementation: `REQUIRED_BEFORE_IMPLEMENTATION_AUDIT`

## Purpose

This artifact records the human-selected scope for one shared project-state
recovery gate. It reserves exact future implementation authority without
changing runtime behavior. It must be audited as a five-file docs-only scope,
not as the implementation itself.

## Verified entry state

Prewrite reconnaissance was read-only and established:

- repository `Fuuduuu/TraceBench` on branch `main`;
- `HEAD == origin/main == 8fd9b2ad7d720d4fc10d533f2da00241513e8e38`;
- divergence `0 0`;
- tracked content diff empty;
- cached diff empty;
- untracked set empty;
- unmerged set empty; and
- committed route
  `TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS -> NEEDS_USER_DECISION`.

Known content-identical Windows/EOL stat residue is not material and is not
normalized by this pass.

Commit `8fd9b2ad7d720d4fc10d533f2da00241513e8e38`, subject
`docs: refresh board canvas navigation code maps`, preserves the accepted
Board Canvas navigation implementation mapping. The human selected the Shared
Project Gate from the non-executable sentinel.

## Exact Phase-1 material set -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS.md`

No sixth path is authorized. Phase 1 may update the three route owners, add
one neutral `REVIEW_REQUIRED` ledger row, and create this one artifact with one
named empty verdict block. It may not implement the gate or edit a test, map,
index, platform, package, tool, schema, asset, or sample.

## Route reconciliation

The three operational route owners must agree exactly:

```text
Current: TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS
Next: TRACEBENCH_SHARED_PROJECT_GATE_IMPL_PASS
```

The deeper route is:

```text
TRACEBENCH_BOARD_CANVAS_NAVIGATION_CONTRACT_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 8fd9b2a]
-> TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS
-> TRACEBENCH_SHARED_PROJECT_GATE_IMPL_PASS
   [activates only after independent scope acceptance, bounded verdict
    recording, and human exact scope commit/push]
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped committed-source router Code Map maintenance]
-> NEEDS_USER_DECISION
```

Retained earlier route sections are historical and non-authorizing. They do
not override the live route above.

## Exact reserved implementation child

```text
PASS_ID: TRACEBENCH_SHARED_PROJECT_GATE_IMPL_PASS
Lane: A
Mode: FLUTTER_PASS / SHARED_PROJECT_GATE / ROUTE_STABLE_RECOVERY
Write class: UI_LOCAL + PROJECTION_STATE
```

The exact future implementation allowlist is:

1. `lib/features/project/widgets/project_gate.dart`
2. `lib/app/router.dart`
3. `test/widget/project_gate_test.dart`
4. `test/widget/board_canvas_screen_test.dart`

No fifth implementation path is reserved. Any discovered need for a fifth
path stops the child and returns to scope authority.

## Exact gated route inventory

One shared gate must protect exactly these 15 real targets:

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

The redirect routes are not independently gated and must not be altered:

- `/project/measurements/new` continues to redirect to
  `/project/measure-sheet`; and
- `/project/board-canvas` continues to redirect to canonical `/project`.

`/project` remains Board Canvas, `/project/overview` remains Project Overview,
and every path, name, nesting relationship, and redirect remains unchanged.
The child may not add a `ShellRoute`, global `GoRouter` redirect, or route
reparenting.

## Shared Project Gate ownership

`lib/features/project/widgets/project_gate.dart` owns the shared
`ConsumerWidget`. It watches `projectStateProvider` and receives its child from
the router. A non-null project returns the child unchanged. A null project:

- remains on the exact requested URI;
- does not router-redirect;
- does not mount the guarded child; and
- shows one shared recovery view.

The recovery copy is exact:

```text
Title: Projekt pole avatud
Supporting text: Selle vaate kasutamiseks ava TraceBenchi projekt.
Primary action: Ava projekt
Secondary action: Tagasi avalehele
```

Optional gate-local deterministic seams for `directoryPicker` and
`projectLoader` are permitted only when the focused tests require them.
Production defaults must delegate unchanged to
`ProjectDirectoryOpenAction.openDirectory(...)`. Project-loading ownership
must not move into `lib/app/router.dart`.

## Project-open and route-stability contract

`Ava projekt` must reuse
`ProjectDirectoryOpenAction.openDirectory(...)`; no second loader or duplicate
project-opening path is permitted. Route stability uses the existing non-null
`onOpened` callback behavior while the action implementation and public
behavior remain frozen.

The exact outcome table is:

| Outcome | Provider state | Requested URI | Recovery/child result |
|---|---|---|---|
| Cancel | remains null | unchanged | recovery remains; loader is not invoked |
| Typed load failure | remains null | unchanged | recovery remains; existing typed feedback remains |
| Generic failure | remains null | unchanged | recovery remains; existing generic feedback remains |
| Success | assigned loaded project | unchanged | gate rebuild exposes the real child |

Success must not navigate to `/project`. The original requested URI remains
canonical evidence of the user's destination. `Tagasi avalehele` alone uses
`context.go('/')`.

## Focused test contract

The new owner `test/widget/project_gate_test.dart` must prove:

1. exact recovery title, supporting text, and both actions;
2. requested-URI stability with null project;
3. guarded child absence while null;
4. immediate child rendering with existing project state;
5. cancel retains URI/recovery and does not invoke the loader;
6. typed failure retains URI/recovery/null state and existing feedback;
7. generic failure retains URI/recovery/null state and existing feedback;
8. success assigns state, keeps the exact original URI, and shows the child;
9. Home resolves to `/`;
10. table-driven coverage for all 15 real gated routes;
11. `/project/board-canvas` canonicalizes to `/project`;
12. `/project/measurements/new` redirects to `/project/measure-sheet`;
13. representative read-only and write-capable routes are gated; and
14. recovery and child reveal issue zero writer requests.

`test/widget/board_canvas_screen_test.dart` may change only the two route tests
that currently expect `BoardCanvasScreen` to mount with null project state.
Those two fixtures receive loaded project state. The direct Board Canvas
screen-local no-project test remains byte-identical.

The following regression owners are inspect-only:

- `test/widget/benchbeep_home_screen_test.dart`;
- `test/widget/project_overview_screen_test.dart`;
- `test/widget/edit_component_screen_test.dart`; and
- `test/integration/projection_stale_banner_end_to_end_test.dart`.

## Zero-write and semantic boundary

The gate is recovery UI around existing provider/loading behavior. Recovery,
route canonicalization, and child reveal must not issue event, fact, evidence,
component, measurement, or Board Canvas writer requests. The child may not
change F-01/F-05/F-16 behavior, board-plane semantics, Project ZIP semantics,
projection freshness, or any other canonical data contract.

## Frozen boundaries

Byte-freeze:

- `lib/app/app.dart` and the two-shell launcher/workbench architecture;
- `lib/features/project/screens/home_screen.dart`;
- `ProjectDirectoryOpenAction` implementation and public behavior;
- `ProjectLoader` and all ZIP-loading semantics;
- all 15 destination screen sources and every existing screen-local
  null-project defense;
- every existing route path, name, nesting relationship, and redirect;
- Board Canvas writers, geometry, painters, interactions, and
  F-01/F-05/F-16 behavior;
- component and measurement writers;
- projection-freshness contract, copy, and ownership;
- Project Overview source/test and Project Wizard;
- responsive envelope and `main.dart`;
- every Code Map and `docs/code_maps/CODE_MAP_INDEX.md`;
- packages, tools, schemas, assets, samples, Windows, and F-03; and
- every other nonallowlisted repository byte.

Implementation stops if it appears to require `home_screen.dart`, `app.dart`,
any destination screen source, any writer, `ProjectLoader`, any map/index file,
or any fifth implementation path.

## Code Map preflight and lifecycle

Read-only preflight at the committed baseline established:

- `lib/app/router.dart` has a present `MAINTAINED` map and becomes
  `UPDATE_REQUIRED` after accepted implementation;
- new `project_gate.dart` does not yet exist and must be requalified from
  accepted committed source, with expected disposition `NOT_QUALIFIED`;
- new `project_gate_test.dart` does not yet exist and must be requalified from
  accepted committed source, with expected disposition `NOT_QUALIFIED`;
- `test/widget/board_canvas_screen_test.dart` has a present `MAINTAINED` map
  and is `REVIEWED_NO_CHANGE` only if the child remains exactly the two
  reserved fixture corrections; and
- no map edit is allowed in either this scope or the implementation child.

Required router-map maintenance occurs later in a separate committed-source
docs/maps pass. If the Board Canvas test change exceeds the two fixture
corrections, stop and re-evaluate its map disposition.

## Required manual smoke

Manual smoke is required after implementation validation and before the
independent implementation audit. At one supported desktop size, preferably
`1000x800`, prove:

1. null `/project/known-facts` shows exact recovery and unchanged URI;
2. canceling `Ava projekt` leaves recovery and URI unchanged;
3. an invalid folder retains existing error feedback and unchanged URI;
4. a valid project reveals Known Facts without navigation to `/project`;
5. the null-to-success boundary at `/project/components/add` produces no
   writer activity before explicit submission;
6. `Tagasi avalehele` reaches `/`; and
7. with null state, `/project/board-canvas` canonicalizes to `/project` and
   `/project/measurements/new` redirects to `/project/measure-sheet`, with
   Project Gate recovery visible at both targets.

## Future implementation validation contract

The child must run fresh:

```text
dart format --output=none --set-exit-if-changed \
  lib/app/router.dart \
  lib/features/project/widgets/project_gate.dart \
  test/widget/project_gate_test.dart \
  test/widget/board_canvas_screen_test.dart

flutter test test/widget/project_gate_test.dart
flutter test test/widget/board_canvas_screen_test.dart
flutter test test/widget/benchbeep_home_screen_test.dart
flutter test test/widget/project_overview_screen_test.dart
flutter test test/widget/edit_component_screen_test.dart
flutter test test/integration/projection_stale_banner_end_to_end_test.dart

flutter analyze --no-pub
py -3 tools\doctor.py
py -3 tools\validate_all.py
flutter test

git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

Expected child acceptance evidence is exactly four substantive paths, empty
staged and unmerged sets, exactly the two authorized new files untracked, and
an analyzer baseline of exactly three infos / zero warnings / zero errors.
There must be no protected, map/index, or Windows content diff.

## Scope activation and audit model

The reserved child becomes executable only after:

1. independent audit accepts this exact five-file scope;
2. the auditor explicitly authorizes bounded Phase-2 recording;
3. Phase 2 changes only this artifact's designated verdict-block interior and
   this PASS_ID's ledger Status cell; and
4. the human stages, commits, and pushes exactly the accepted scope set.

Phase 2 may not change route prose, the reservation, artifact exterior, ledger
Description, or any other byte. The implementation requires its own fresh
validation, human manual smoke, and independent audit before human exact
staging, commit, and push.

## Phase-1 validation contract

Before independent scope audit, fresh evidence must establish:

- baseline remains exact at `8fd9b2ad7d720d4fc10d533f2da00241513e8e38`;
- content diff is exactly the five authorized docs paths and no sixth path;
- the staged and unmerged sets are empty and no nonallowlisted untracked path
  exists;
- all three route owners agree on Current and Next;
- the ledger has exactly one neutral `REVIEW_REQUIRED` row for this PASS_ID;
- this artifact has exactly one named verdict block with empty interior;
- source, tests, maps/index, and Windows have no content diff;
- `py -3 tools\doctor.py` passes;
- `py -3 tools\validate_all.py` passes;
- `git diff --check` passes; and
- `git diff --cached --check` passes.

## Completed Phase-1 validation evidence

- Baseline: `PASS` — branch `main`, `HEAD == origin/main ==
  8fd9b2ad7d720d4fc10d533f2da00241513e8e38`, divergence `0 0`.
- Content set: `PASS` — exactly the four modified route/ledger documents plus
  this authorized new artifact; no sixth content path.
- Git state: `PASS` — cached and unmerged sets empty; no untracked path exists
  outside the exact authorized five-path content set.
- Route agreement: `PASS` — all three route-owner tops name the exact Current
  and Next tuple.
- Ledger: `PASS` — exactly one matching row with neutral
  `REVIEW_REQUIRED` Status.
- Verdict block: `PASS` — exactly one BEGIN marker, one END marker, and a
  whitespace-only interior.
- Frozen content: `PASS` — source, tests, Code Maps/index, and Windows have no
  content diff. Known content-identical Windows/EOL stat residue is preserved
  without normalization.
- `py -3 tools\doctor.py`: `PASS` — `[OK] doctor passed`.
- `py -3 tools\validate_all.py`: `PASS` — `314` discovered unit tests passed
  and the validator ended `[OK] validate_all.py PASSED` after receiving its
  required repository-local output permission.
- `git diff --check`: `PASS`.
- `git diff --cached --check`: `PASS`.

## TOOL_SKILL_CHECK

- Result: `PASS`
- Repo skill: `tracebench-scope-lock`
- Capability: route/allowlist/lifecycle/stop-boundary authoring
- External plugin/tool required: `NO`
- Prewrite reconnaissance: read-only; no blocker found

The repo-local skill constrained the live-route reconciliation, exact current
and future allowlists, activation gates, neutral ledger record, empty verdict
block, stop conditions, and independent-audit handoff. It did not expand either
allowlist.

## SELF_REFERENCE_AUDIT

- Result: `PASS`
- The ledger Status is neutral `REVIEW_REQUIRED`.
- The verdict-block interior is empty.
- No touched file asserts an audit verdict or staging safety for this scope.
- Conditional activation gates are time-invariant authority rules, not a claim
  about transient staging, commit, or audit position.
- Historical route text is explicitly non-authorizing.

## Independent audit focus

The auditor must assess:

- exact five-path docs-only scope;
- exact four-path implementation reservation;
- complete 15-target gate coverage and both redirect exclusions;
- route topology and original-URI preservation;
- exact recovery copy and loader reuse semantics;
- focused and inspect-only test boundaries;
- zero-write and frozen boundaries;
- manual-smoke placement;
- Code Map lifecycle; and
- the complete implementation validation contract.

<!-- TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_SHARED_PROJECT_GATE_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
