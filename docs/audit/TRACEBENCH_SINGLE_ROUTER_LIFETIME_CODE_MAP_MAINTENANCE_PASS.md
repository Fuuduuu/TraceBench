# TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS

## Pass identity and Phase-1 posture

- Project: TraceBench / BenchBeep
- PASS_ID: `TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS`
- Lane: `A`
- Mode: `DOCS_AND_MAPS_ONLY / CODE_MAP_MAINTENANCE / PHASE_1`
- Ledger Status: `REVIEW_REQUIRED`
- Manual smoke: `NOT_APPLICABLE`

This pass refreshes the app and Home-test maps and creates the first qualifying
map for the expanded splash suite strictly from committed single-router
source/test. It changes no executable behavior and grants no successor
authority beyond the non-executable `NEEDS_USER_DECISION` sentinel.

## Verified committed baseline

- Worktree: `C:\dev\TraceBench`
- Repository: `Fuuduuu/TraceBench`
- Branch: `main`
- `HEAD`: `b5096c2790851bd32e215fd4f7660a71f6b7510e`
- local `origin/main`: `b5096c2790851bd32e215fd4f7660a71f6b7510e`
- divergence: `0 0`
- subject: `refactor: use single router lifetime`
- parent: `ab3c6877ad4a4d96754820162124bde1252ef84b`

The entry substantive content diff, cached diff, untracked set, and unmerged
set returned no paths. Raw porcelain reported only the already-known content-
identical EOL/stat residue in three generated Windows plugin files. This pass
does not normalize or otherwise touch that residue.

## Exact Phase-1 material set -- 9

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/app.dart.md`
7. `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
8. `docs/code_maps/test/widget/benchbeep_splash_screen_test.dart.md`
9. `docs/audit/TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS.md`

No tenth path belongs to this pass. The splash-test map and this artifact are
the only new paths.

## Committed implementation evidence

`git diff-tree --no-commit-id --name-status -r
b5096c2790851bd32e215fd4f7660a71f6b7510e` identifies the exact committed
implementation delta:

```text
M    lib/app/app.dart
M    test/widget/benchbeep_home_screen_test.dart
M    test/widget/benchbeep_splash_screen_test.dart
```

No other source/test path is a mapping input. The implementation adds 261
lines and removes 50 across those exact three files.

Durable committed object identities are the `blob` object ids returned by the
exact command template
`git rev-parse b5096c2790851bd32e215fd4f7660a71f6b7510e:<repository-relative-path>`:

| Committed target | Git object id |
| --- | --- |
| `lib/app/app.dart` | `fffdd586971c316b7668be0a506b8ce09cf990c0` |
| `test/widget/benchbeep_home_screen_test.dart` | `859b0fe039cb3db9381d20a2e1ba8a42c91db325` |
| `test/widget/benchbeep_splash_screen_test.dart` | `2c2ae628a7c5a2fbdb6b4e4a8deed5b08631bd3c` |
| `lib/app/router.dart` | `3abdc465da47e01e16d7a3c3831faabfb7773579` |
| `test/widget/new_project_wizard_screen_test.dart` | `6bc24bcdb81bfb7290aee156ca7844c5ab529940` |
| `test/widget/project_gate_test.dart` | `713784cd690e6c92797acdbb3b0775b5eef5d517` |

No working-tree runtime/test content is used as speculative mapping source.

## CODE_MAP_PREFLIGHT

### App production target

- Target: `lib/app/app.dart`.
- Index result at entry: mapped production target, `MAINTAINED`.
- Map path: `docs/code_maps/lib/app/app.dart.md`.
- Changed zones/stable symbols: `_showStartupIntro` becomes a `ValueNotifier`;
  `_router`, `initState`, `_buildLauncherShell`, `_openWorkbench`,
  `_buildWorkbenchRouter`, `dispose`, `build`, `MaterialApp.router`.
- Inspect-only coupled zones: `buildTraceBenchRouter`, launcher callbacks,
  splash completion, Wizard builder/handoff, acquisition actions, and both
  providers.
- Excluded zones: router topology, launcher/splash source, Wizard,
  ProjectGate, destinations, writers, Project ZIP, and domain semantics.
- Direct dependencies: Flutter lifecycle/notifiers, Riverpod, GoRouter,
  launcher/splash/Wizard screens, neutral acquisition actions, loader, theme,
  and window manager.
- Blast/evidence class: multi-zone lifetime and navigation flow with direct
  committed source plus Home/splash runtime/source tests.
- Write class: `UI_LOCAL` + `ZERO_WRITE`, with existing
  `PROJECTION_STATE` assignments preserved.
- Tests/helpers: Home suite, splash suite, Wizard suite, ProjectGate suite.
- Disposition: `UPDATE_REQUIRED`; refresh existing map at
  `REVIEW_REQUIRED`.

### BenchBeep Home test target

- Target: `test/widget/benchbeep_home_screen_test.dart`.
- Index result at entry: mapped test target, `MAINTAINED`, qualification
  `SCORE 11/12`.
- Map path:
  `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`.
- Changed zones/stable symbols: `new project action opens the existing Wizard
  route`, `successful Wizard creation hands app state off before explicit
  Canvas open`, `loaded project keeps direct board canvas handoff`,
  `projectStateProvider`, `beginnerModeProvider`, and `GoRouter.of` identity.
- Inspect-only coupled zones: app lifecycle, Wizard cancel/success, Canvas,
  canonical Home, acquisition actions, and file-picker/provider teardown.
- Excluded zones: production test behavior, acquisition contract, responsive
  breakpoints, exit semantics, Wizard source, and ProjectGate source.
- Direct dependencies: Flutter test, Riverpod, GoRouter, real app/launcher,
  Wizard/Canvas targets, creator result types, loaders, archive, and picker.
- Blast/evidence class: multi-family test suite; direct committed assertions
  cover router identity, two providers, route ordering, and retained existing
  families.
- Write class: test-local `UI_LOCAL` + observed `PROJECTION_STATE` +
  `ZERO_WRITE`; disposable fixtures remain `NONCANONICAL_FILE`.
- Tests/helpers: 20 `testWidgets`, `_FakeFilePicker`,
  `_waitForProjectState`, `_waitForLoadedProject`,
  `_createdWizardProjectState`, `_expectCanonicalBoardCanvas`.
- Disposition: `UPDATE_REQUIRED`; refresh existing map at
  `REVIEW_REQUIRED`.

### BenchBeep splash test target

- Target: `test/widget/benchbeep_splash_screen_test.dart`.
- Index/map result at entry: no row and no map.
- Physical size: 236 lines -> `0`.
- Independent responsibilities: identity, configured completion, normal app
  startup, early pointer-through/no replay, app lifecycle source guard, and
  splash presentation source guard -> `2`.
- Canonical/protected boundaries: one protected read-only router-lifecycle and
  presentation-only source boundary -> `1`.
- Regression surface: standalone component, app lifecycle/navigation, and
  architecture/presentation source-guard families -> `2`.
- Whole-file analysis tax: broad analysis in scope, implementation, and this
  maintenance pass -> `2`.
- Blast-radius ambiguity: splash, app lifecycle, launcher/Wizard navigation,
  and router source are three or more adjacent zones -> `2`.
- Supporting worksheet: `SCORE 9/12`, with five non-size dimensions nonzero.
- Automatic qualification check: no automatic trigger is required; the scored
  threshold qualifies the committed suite.
- Changed zones/stable symbols: `_matchCount`, four `testWidgets`, two source
  tests, exact 3200 ms threshold, `IgnorePointer`, one-router identity,
  pointer-through, Home return, cardinality/absence guards.
- Inspect-only coupled zones: `TraceBenchApp`, `BenchBeepSplashScreen`,
  `BenchBeepHomeScreen`, `NewProjectWizardScreen`, and router source.
- Excluded zones: runtime/test/source edits, provider-survival ownership,
  route topology, splash redesign, domain writers, and product workflow.
- Direct dependencies: Flutter test/Material, Riverpod, GoRouter, app,
  launcher/splash/Wizard types, and read-only `dart:io` source access.
- Blast/evidence class: runtime identity/timing/navigation plus bounded textual
  architecture and presentation guards.
- Write class: `UI_LOCAL` + `ZERO_WRITE` + protected read-only source access.
- Entry lifecycle result: `BLOCKED_CODE_MAP_REQUIRED`.
- Disposition: create the deterministic first map and matching index row at
  `REVIEW_REQUIRED`.

### Rechecked committed implementation targets

- `lib/app/router.dart`: existing maintained human-override map;
  `REVIEWED_NO_CHANGE`. The committed blob is unchanged. Required
  `homeBuilder`, `/`, `/new-project`, `/project`, 15 real `ProjectGate`
  targets, two aliases, names/nesting, Wizard fallback, and navigation-only
  ownership remain accurate.
- `test/widget/new_project_wizard_screen_test.dart`: existing maintained
  automatic map; `REVIEWED_NO_CHANGE`. The committed blob is unchanged. Its
  76-test cancel, exactly-once success, persistent Step 7, explicit route, and
  zero-write fixture responsibilities remain accurate.
- `test/widget/project_gate_test.dart`: existing maintained `SCORE 7/12` map;
  `REVIEWED_NO_CHANGE`. The committed blob is unchanged. Its 10-test canonical
  Home recovery, original-URI behavior, 15-target/two-alias inventory, open
  outcomes, provider handoff, visual treatment, and zero-write responsibilities
  remain accurate.

## Map refresh results

The app map records:

1. one `late final GoRouter` initialized once and disposed once;
2. one `MaterialApp.router` for launcher and workbench presentation;
3. canonical `/` through `_buildLauncherShell`;
4. `ValueNotifier`/`ValueListenableBuilder` intro state, 3200 ms overlay, and
   early-navigation completion latch;
5. `_openWorkbench` using `_router.go(initialLocation)` without replacement;
6. stable provider lifetime across Home/workbench navigation; and
7. unchanged acquisition, Wizard, projection, and zero-write boundaries.

The Home-test map records:

1. one router identity through canonical Home, Wizard, cancel, Canvas, Home,
   and re-entry;
2. loaded `ProjectState` identity and beginner-mode value survival;
3. provider assignment before the Wizard's explicit `/project` action;
4. retained 20-test launcher/acquisition/responsive/hover/legacy/exit scope;
   and
5. test-local versus projection-state versus noncanonical-fixture boundaries.

The new splash-test map records all six cases, the scored qualification,
standalone identity/timing, normal and early app lifecycles, pointer
transparency/no replay, runtime versus source evidence, exact architecture
cardinality guards, absence of a splash route, and presentation-only source
ownership.

## Registry and lifecycle evidence

- Actual map files after Phase 1: `32`.
- Registry rows after Phase 1: `32`.
- Orphan maps: `0`.
- Unindexed map files: `0`.
- Phase-1 `REVIEW_REQUIRED` map headers: `3`.
- Phase-1 `REVIEW_REQUIRED` index cells: `3`.
- Unchanged `MAINTAINED` map/index pairs: `29`.
- New splash map/index row: present once.

Only the app and Home-test Status cells change and the splash row is added in
`CODE_MAP_INDEX.md`. Every Source, Map file, Type, and unrelated Status cell
remains byte-identical to `HEAD`.

## Route result

The three route owners agree:

```text
Current: TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS
Next: NEEDS_USER_DECISION
```

The complete transition is:

```text
TRACEBENCH_SINGLE_ROUTER_LIFETIME_IMPL_PASS
   [committed at b5096c2]
-> TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS
-> NEEDS_USER_DECISION [non-executable]
```

Prior scope/implementation sections remain under historical,
non-authorizing headings; no completed history is deleted or reopened.

## Frozen-boundary evidence

This pass changes no Dart/test/runtime source, route topology or destination,
provider/acquisition/Wizard/ProjectGate behavior, launcher/splash source,
writer, event/fact/evidence semantics, freshness, Project ZIP, board-plane,
Workbench shell/theme, unrelated map/index row, package, Windows/EOL residue,
tool, schema, asset, sample, F-03, or other product byte. Manual smoke is
`NOT_APPLICABLE` for descriptive committed-source maintenance.

## Bounded Phase-2 authority

A clean independent map/pass audit may authorize at most eight logical writes:

1. fill only the existing verdict-block interior below;
2. mechanically mirror that result in only this PASS_ID's existing
   `docs/AUDIT_INDEX.md` Status cell;
3. promote only the app map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
4. promote only the Home-test map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
5. promote only the splash-test map Status `REVIEW_REQUIRED` -> `MAINTAINED`;
6-8. promote only the three matching index Status cells.

Every map body, qualification, Source/Type/Audit-evidence field, route byte,
ledger Description, artifact exterior, unrelated index/ledger cell, and other
repository byte is frozen. The new splash map/index row means the index remains
part of the final material set after accepted promotions.

## Independent audit contract

Audit the complete Phase-1 diff except the empty designated block. For each of
the three review-target maps return:

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

Confirm the exact nine-path material set, splash `SCORE 9/12` worksheet, all
three `REVIEWED_NO_CHANGE` dispositions, 32/32 registry state, and eight-
coordinate maximum for any authorized Phase 2.

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
sets, 32/32 registry parity, exactly three `REVIEW_REQUIRED` map headers/index
cells, route-owner agreement, one empty verdict block, committed source/test
blob identity, and empty runtime/test/Windows content diff.

## Phase-1 validation results

- `py -3 tools/doctor.py`: `PASS` (`[OK] doctor passed`).
- `py -3 tools/validate_all.py`: `PASS`; 314 tests passed. Four warnings are
  the expected missing optional sample-photo files during ZIP and directory
  validation. The first restricted run completed the same 314-test suite but
  could not write the two normal ignored `.codex` materializations; the
  identical command passed after granting only that required write permission.
- Stable-anchor closure: `PASS`; all 41 app-map, 30 Home-map, and 25 splash-map
  selected anchors resolve under each map's stated selection rule.
- Map concision: `PASS`; app `182`, Home test `177`, and splash test `166`
  physical map lines are within the Standard's preferred ranges.
- Registry parity/status: `PASS`; 32 maps, 32 rows, three review pairs, 29
  maintained pairs, zero orphan, zero unindexed, and zero header mismatches.
- Git/freeze closure: `PASS`; exactly nine substantive material paths, exactly
  two new paths, zero staged/unmerged paths, zero Dart/test or Windows content
  paths, all six committed blobs matched, and both diff checks passed.
- Route/verdict/ledger closure: `PASS`; three route-owner tops agree, the
  neutral ledger row exists once, and the one BEGIN/END verdict block has an
  empty interior.
- `SELF_REFERENCE_AUDIT`: `PASS`; no prohibited current lifecycle phrase or
  current acceptance/safety claim exists, and the one verdict enum is clearly
  the independent-audit return template.

## TOOL_SKILL_CHECK

- Repo-local inventory owner read: `docs/CODEX_TOOLING_POLICY.md`.
- Repo-local skills inspected: `tracebench-scope-lock`,
  `tracebench-prompt-authoring`, and `tracebench-audit-reconciliation`.
- Repo-local skill used: `tracebench-prompt-authoring`, only to compose the
  requested genuine post-change Claude audit handoff from named changed files,
  the real diff, and observed validation. It did not select or widen a map,
  route, or write authority.
- `tracebench-scope-lock` and `tracebench-audit-reconciliation` are not
  applicable: this is neither a future implementation reservation nor a
  post-push verdict reconciliation.
- Generic workflow skills used: planning within the fixed allowlist and fresh
  verification before completion.
- Repo helpers used: Git, PowerShell, `rg`, `apply_patch`, `tools/doctor.py`,
  and `tools/validate_all.py`.
- External plugin/tool required: `NO`.
- Capability use does not widen the exact nine-path allowlist.

## MODEL_ROUTING_CHECK

- Result: `ESCALATED`.
- Codex performs the bounded Lane A docs/maps maintenance; Claude Code receives
  the independent real-diff audit before any human exact staging decision.

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

<!-- TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/app/app.dart.md
- docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md
- docs/code_maps/test/widget/benchbeep_splash_screen_test.dart.md
- docs/audit/TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS_VERDICT_BLOCK_END -->
