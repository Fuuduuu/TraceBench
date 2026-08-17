# Audit Artifact — Legacy Viewer Removal Scope Lock

- PASS_ID: `TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS`
- Lane: `B`
- Mode: `SCOPE_LOCK / DOCS_ONLY / PHASE_1`
- Baseline: `e513ab5d4192883e04e5880e698ef068479b8e05`
- Status: `REVIEW_REQUIRED`
- Manual smoke for this docs-only scope: `NOT_APPLICABLE`
- Manual smoke for the reserved implementation: `REQUIRED_BEFORE_IMPLEMENTATION_AUDIT`

## Purpose

This artifact records one human-selected product-surface scope: remove the
implicit legacy `TraceBench Viewer` / `HomeScreen` fallback while preserving
all useful project acquisition behavior. It reserves exact future authority
without changing runtime behavior and must be audited as a five-file docs-only
scope rather than as the implementation.

## Verified entry state

Read-only prewrite commands established:

- repository root `C:/dev/TraceBench` and remote
  `https://github.com/Fuuduuu/TraceBench.git`;
- branch `main`;
- `HEAD`, local `origin/main`, and live remote `origin/main` all equal
  `e513ab5d4192883e04e5880e698ef068479b8e05`;
- divergence `0 0`;
- commit subject `docs: refresh shared project gate code maps`;
- tracked content diff and cached diff empty;
- untracked and unmerged sets empty; and
- live route
  `TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS -> NEEDS_USER_DECISION`.

Raw Git status retains the three known generated-Windows EOL/stat entries, but
`git diff --name-status` and `git diff --quiet` establish that their content is
unchanged. This pass does not normalize them.

## Exact Phase-1 material set -- 5

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS.md`

No sixth path is authorized. Phase 1 may update only the three live route-owner
tops, add one neutral `REVIEW_REQUIRED` ledger row, and create this one artifact
with one named empty verdict block. It may not edit implementation, tests,
maps/index, packages, platforms, tools, schemas, assets, or samples.

## Route reconciliation

The three route owners must agree:

```text
Current: TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS
Next: TRACEBENCH_LEGACY_VIEWER_REMOVAL_IMPL_PASS
```

The deeper route is:

```text
TRACEBENCH_SHARED_PROJECT_GATE_CODE_MAP_MAINTENANCE_PASS
   [committed at e513ab5]
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS
-> TRACEBENCH_LEGACY_VIEWER_REMOVAL_IMPL_PASS
   [activates only after independent scope acceptance, bounded verdict
    recording, and human exact scope commit/push]
-> [human manual smoke]
-> [independent implementation audit]
-> [human exact implementation staging/commit/push]
-> [separately scoped committed-source LOCK/map maintenance as required]
-> NEEDS_USER_DECISION
```

Retained earlier route sections are historical and non-authorizing.

## Exact reserved implementation child

```text
PASS_ID: TRACEBENCH_LEGACY_VIEWER_REMOVAL_IMPL_PASS
Lane: B
Mode: FLUTTER_PASS / LEGACY_SURFACE_REMOVAL / ACQUISITION_PRESERVATION
Write class: ZERO_WRITE + UI_LOCAL + PROJECTION_STATE
```

The exact future implementation allowlist is:

1. `lib/app/app.dart`
2. `lib/app/router.dart`
3. `lib/features/project/actions/project_acquisition_actions.dart`
4. `lib/features/project/screens/home_screen.dart`
5. `lib/features/project/widgets/project_gate.dart`
6. `test/widget/benchbeep_home_screen_test.dart`
7. `test/widget/board_canvas_screen_test.dart`
8. `test/widget/edit_component_screen_test.dart`
9. `test/widget/project_gate_test.dart`
10. `test/widget/project_overview_screen_test.dart`
11. `test/integration/projection_stale_banner_end_to_end_test.dart`

No twelfth implementation path is reserved. The acquisition-actions path is
the only authorized new file and `home_screen.dart` is the only authorized
deletion. Any additional required path stops with
`BLOCKED_ALLOWLIST_MISMATCH`.

## Complete direct-caller inventory

Exact repo-wide searches for the five governed symbols established:

| Symbol | Production occurrences | Direct test occurrences | Child disposition |
|---|---|---|---|
| `buildTraceBenchRouter` | factory in `router.dart`; unused `routerProvider` and retained `_buildWorkbenchRouter` caller in `app.dart` | Board Canvas at three sites; Edit at one; ProjectGate at one; Overview at one; freshness integration at one | remove unused caller; make root builder required; update all five caller test files |
| `ProjectZipImportAction` | definition/self-use in `home_screen.dart`; real app consumer | behavior exercised through BenchBeep launcher tests | relocate definition; repoint app and test import |
| `ProjectDirectoryOpenAction` | definition/self-use in `home_screen.dart`; app and ProjectGate consumers | two direct action cases in BenchBeep launcher test; indirect ProjectGate outcome family | relocate definition; repoint app, gate, and test import |
| `HomeScreen` | definition and router fallback | ProjectGate Home expectation | delete source/fallback; expect canonical `BenchBeepHomeScreen` |
| `routerProvider` | one declaration in `app.dart` | none | delete |

`benchbeep_splash_screen_test.dart` reads router source solely to exclude a
`/splash` route. It has no governed-symbol occurrence, requires no source-shape
change, and remains an inspect-only regression. No other caller or test is
guessed into the allowlist.

## Locked implementation outcome

The child must:

1. move both acquisition action classes from `home_screen.dart` into
   `lib/features/project/actions/project_acquisition_actions.dart` with their
   public signatures and behavior unchanged;
2. repoint `app.dart`, `project_gate.dart`, and direct action tests;
3. remove unused `routerProvider` only;
4. make `homeBuilder` required in `buildTraceBenchRouter`;
5. remove the router's `HomeScreen` import and implicit fallback;
6. require every real caller/harness to provide an explicit root builder;
7. preserve `_buildLauncherHome` as the production canonical `/` owner;
8. make ProjectGate Home recovery prove `BenchBeepHomeScreen` at `/`; and
9. delete `home_screen.dart` after exact-symbol closure is empty.

The moved action bodies are a responsibility relocation, not a redesign.
Only import and file-location changes required by that relocation are allowed.

## Acquisition behavior freeze

Preserve exactly:

- ZIP selection using one custom `.zip` file with bytes requested;
- cancellation before loader/provider/navigation activity;
- byte-backed ZIP loading before path fallback;
- missing-path handling through the existing typed exception;
- typed and generic ZIP failure presentation;
- directory picker title, cancellation, and injected/default loader behavior;
- typed and generic directory failure presentation;
- provider assignment only after successful load;
- caller-owned `onImported` and `onOpened` callbacks, with existing default
  `/project` navigation only when the matching callback is absent;
- ProjectGate's non-null callback, stable original URI, recovery/child
  lifecycle, copy, tokens, and deterministic picker/loader seams;
- bundled sample behavior;
- New Project Wizard builder, creation, provider handoff, and explicit success
  navigation; and
- every route name/path/nesting/destination plus both compatibility redirects.

`ProjectLoader`, archive parsing, manifest/events/known-facts semantics, Project
ZIP self-containment, materialization, and every persistent/canonical boundary
remain with their current owners. The child changes no canonical event, fact,
evidence, writer, schema, or Project ZIP behavior.

## Exact test contract

| Test target | Authorized change | Frozen evidence |
|---|---|---|
| `benchbeep_home_screen_test.dart` | acquisition-owner import only | all 20 tests, launcher identity, legacy absence, sample/folder/ZIP, Wizard, provider handoff, responsive, exit |
| `project_gate_test.dart` | explicit canonical root builder and canonical Home widget expectation | 10 tests, all 15 gated targets, both aliases, URI/provider/open outcomes, zero writer requests |
| `board_canvas_screen_test.dart` | explicit root builder at exactly three direct router sites | 168 declarations, exact destination inventory, round trip, writers, freshness, board/painter/geometry behavior |
| `edit_component_screen_test.dart` | explicit root builder in `_pumpEditComponentScreenRouter` only | 11 tests and every edit/writer/freshness boundary |
| `project_overview_screen_test.dart` | explicit root builder in `_pumpProjectOverview` only | 23 tests and every Overview/route/zero-write behavior |
| `projection_stale_banner_end_to_end_test.dart` | explicit root builder in its one router construction | one exact twelve-surface loop and forbidden-action assertions |

Inspect-only regressions are
`test/widget/benchbeep_splash_screen_test.dart` and
`test/widget/new_project_wizard_screen_test.dart`. No new test file is
authorized.

## Code Map preflight and lifecycle

The live registry contains 30 maps and 30 rows, all `MAINTAINED`.

| Target | Live lookup and qualification | Changed/inspect-only zones and dependencies | Write class | Disposition and later obligation |
|---|---|---|---|---|
| `lib/app/app.dart` | maintained app map | change providers, acquisition dependency, router transition; inspect Wizard/splash/root lifecycle | `UI_LOCAL + PROJECTION_STATE` | `UPDATE_REQUIRED` |
| `lib/app/router.dart` | maintained router map | change route-factory and root-Home zones; inspect Wizard/project tree/redirects/error | `ZERO_WRITE + UI_LOCAL` | `UPDATE_REQUIRED` |
| new acquisition-actions source | absent because target does not exist | relocate exact ZIP/directory action zones; inspect loader, picker, app/gate callers | `PROJECTION_STATE` plus read-only filesystem boundary | entry `NOT_APPLICABLE`; expected committed `AUTO — 5+ independently testable behaviors`, then first map required |
| `home_screen.dart` | no map; same-child deletion exclusion | relocate only the two action zones; delete legacy UI zone | preserved imported boundaries | `NOT_APPLICABLE`; no map for deleted source |
| `project_gate.dart` | no map; accepted `SCORE 5/12` | import dependency only; all recovery behavior inspect-only | `ZERO_WRITE + PROJECTION_STATE` | `NOT_APPLICABLE` |
| BenchBeep launcher test | maintained `SCORE 11/12` map | import owner only; all mapped families unchanged | test-local plus observed projection | `REVIEWED_NO_CHANGE` |
| ProjectGate test | maintained `SCORE 7/12` map | Home expectation and router harness; all other zones inspect-only | `UI_LOCAL + ZERO_WRITE`, observed projection | `UPDATE_REQUIRED` |
| Board Canvas test | maintained automatic map | three router-harness call sites only | test setup `ZERO_WRITE` | `REVIEWED_NO_CHANGE` if 168-test responsibilities remain exact |
| Edit test | maintained `SCORE 7/12` map | one router harness only | test setup `ZERO_WRITE` | `REVIEWED_NO_CHANGE` |
| Overview test | maintained `SCORE 7/12` map | one router harness only | test setup `ZERO_WRITE` | `REVIEWED_NO_CHANGE` |
| freshness integration | no map; `SCORE 3/12` | one router harness; all twelve warning targets inspect-only | test setup `ZERO_WRITE` | `NOT_APPLICABLE` |

No Code Map or index edit is authorized now or in the child. Following accepted
implementation commit, a separate docs/maps pass must refresh the app, router,
and ProjectGate-test maps and create the first acquisition-owner map/index row.
Every reviewed-no-change target is rechecked against the final committed diff.

## Frozen boundaries

Byte/behavior-freeze:

- single-lifetime-router conversion, launcher/workbench root switching,
  `_showLauncher`, splash, router disposal, Workbench shell, theme/tokens,
  responsive minimum size, `main.dart`, and window-manager behavior;
- Project Overview and every project destination screen;
- Add/Edit/Measure consolidation and every writer call;
- both compatibility aliases and all route definitions except removal of the
  implicit legacy root fallback;
- capability tiers and Diagnostics/Advanced behavior;
- screen-local null defenses;
- ProjectLoader, ProjectCreator, ProjectExporter, materializer, schemas,
  writers, event/fact/evidence meaning, freshness, Board Canvas, F-01/F-03/
  F-05/F-16, board plane, geometry, painters, and hit testing;
- every map/index byte, package, Windows/EOL residue, tool, schema, asset,
  sample, generated file, dependency, and nonallowlisted repository byte.

## Future implementation validation

The child must run fresh:

```text
dart format --output=none --set-exit-if-changed \
  lib/app/app.dart \
  lib/app/router.dart \
  lib/features/project/actions/project_acquisition_actions.dart \
  lib/features/project/widgets/project_gate.dart \
  test/widget/benchbeep_home_screen_test.dart \
  test/widget/board_canvas_screen_test.dart \
  test/widget/edit_component_screen_test.dart \
  test/widget/project_gate_test.dart \
  test/widget/project_overview_screen_test.dart \
  test/integration/projection_stale_banner_end_to_end_test.dart

flutter test test/widget/benchbeep_home_screen_test.dart
flutter test test/widget/project_gate_test.dart
flutter test test/widget/board_canvas_screen_test.dart
flutter test test/widget/edit_component_screen_test.dart
flutter test test/widget/project_overview_screen_test.dart
flutter test test/integration/projection_stale_banner_end_to_end_test.dart
flutter test test/widget/benchbeep_splash_screen_test.dart
flutter test test/widget/new_project_wizard_screen_test.dart

flutter analyze --no-pub
py -3 tools/doctor.py
py -3 tools/validate_all.py
flutter test

rg -n "\\bHomeScreen\\b|TraceBench Viewer|Read-only Project ZIP Viewer" lib
rg -n "\\brouterProvider\\b" lib test
rg -n "\\bProjectZipImportAction\\b|\\bProjectDirectoryOpenAction\\b" lib test
rg -n "\\bbuildTraceBenchRouter\\b" lib test

git diff --check
git diff --cached --check
git diff --name-status
git diff --cached --name-status
git status --short --branch
```

The first two searches return no matches. The action search returns only the
new definitions and exact app/gate/direct-test consumers. The router search
returns only the factory, retained explicit app caller, and five direct caller
test files. Acceptance requires exactly eleven content paths, one new file,
one deletion, no other untracked/unmerged/staged path, no new analyzer finding
beyond the committed baseline, and no map/index/Windows content diff.

## Required human manual smoke

After automated validation and before implementation audit, smoke at a
supported desktop size, preferably `1000x800`:

1. cold start shows unchanged splash then canonical BenchBeep launcher only;
2. no legacy Viewer title/copy is reachable;
3. bundled sample and Continue reach `/project`;
4. ZIP cancel, success, and invalid outcomes retain their existing behavior;
5. directory cancel, success, and invalid outcomes retain existing behavior;
6. null `/project/known-facts` retains gate URI and Home renders BenchBeep;
7. valid-folder recovery reveals `/project/known-facts` without `/project`
   navigation; and
8. New Project Wizard opens and retains its explicit success transition.

## Scope activation, Phase 2, and stops

The reserved child activates only after independent scope acceptance, explicit
authorization for bounded recording, Phase 2 confined to this artifact's
verdict interior and this PASS_ID's ledger Status cell, and human exact scope
staging/commit/push. The product-surface implementation requires its own fresh
validation, human smoke, and independent audit marked `USE ONLY AFTER MANUAL
SMOKE PASS` before human exact staging/commit/push.

Stop on baseline or route mismatch, a twelfth implementation path, a second
product outcome, action-body semantic drift, any Project ZIP/loader/picker/
failure/provider/navigation change, an excluded cleanup, stale/conflicting
applicable map, validation failure, nonallowlisted content, Phase-2 execution,
or any stage, commit, push, stash, reset, clean, or Windows normalization.

## Phase-1 validation contract

Before independent scope audit, prove:

- exact five-path content set and no sixth path;
- empty cached and unmerged sets;
- no untracked path outside this exact material set;
- all three route owners agree on Current and Next;
- one matching neutral `REVIEW_REQUIRED` ledger row;
- exactly one verdict marker pair with whitespace-only interior;
- source, test, map/index, and Windows content diffs empty;
- `py -3 tools/doctor.py` passes;
- `py -3 tools/validate_all.py` passes;
- `git diff --check` passes; and
- `git diff --cached --check` passes.

## Completed Phase-1 validation evidence

- `py -3 tools/doctor.py`: `PASS` (`[OK] doctor passed`)
- `py -3 tools/validate_all.py`: `PASS` (`314` tests, final
  `[OK] validate_all.py PASSED`); the successful run used only the validator's
  required repository-local `.codex` output permission
- `git diff --check`: `PASS` (only the preserved Windows/EOL warnings)
- `git diff --cached --check`: `PASS`
- Phase-1 content set: exactly the five authorized paths; no sixth path
- cached and unmerged sets: empty
- route owners: matching Current and Next tuples
- ledger: one matching neutral `REVIEW_REQUIRED` row
- verdict block: one marker pair with whitespace-only interior
- source, test, map/index, and Windows content diffs: empty

## TOOL_SKILL_CHECK

- Relevant repo skill: `tracebench-scope-lock`
- Capability used: exact current/future authority, route, allowlist,
  lifecycle, boundary, validation, and stop authoring
- Repo helpers used: Git, `rg`, `tools/doctor.py`, and
  `tools/validate_all.py`
- External plugin/tool required: `NO`

The skill constrained the scope to one future child and did not expand either
allowlist.

## SELF_REFERENCE_AUDIT

- The ledger Status is neutral `REVIEW_REQUIRED`.
- The verdict interior is empty.
- No touched artifact, ledger, or route owner asserts an audit verdict or
  staging-safety result for this scope.
- Conditional activation gates are time-invariant authority rules rather than
  transient pipeline claims.
- Historical route sections are explicitly non-authorizing.

## Independent audit focus

Audit the exact five-file docs scope, complete eleven-path child and caller
closure, required canonical root builder, action relocation with byte/behavior
freeze, Home deletion, acquisition/ProjectGate/route preservation, Code Map
qualification and lifecycle, manual-smoke placement, excluded architecture,
and implementation validation contract.

<!-- TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:

- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_LEGACY_VIEWER_REMOVAL_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
