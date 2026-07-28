# TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS

## PASS

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS`
- `Lane: A`
- `Mode: DOCS_SYNC`
- `Role: consolidated scope pass`
- `CODE_MAP_PREFLIGHT: REQUIRED`
- `CODE_MAP_DISPOSITION: NOT_APPLICABLE` for current docs-only source changes

## Human in-place amendment authority

The human product/scope owner explicitly authorized this same PASS_ID to absorb
the scope reservation that was previously routed to `NEEDS_USER_DECISION`.
This decision supersedes the former no-runtime-successor clause only inside the
existing nine-file docs/map allowlist.

No new amendment, scope, prerequisite, sync, closeout, or audit-of-audit
PASS_ID is created. The intended lifecycle is:

```text
current consolidated scope
-> implementation/build
-> one later unnamed lock/map-maintenance phase
```

The human decision supplies the explicit cross-file responsibility-zone
authorization recorded below. It creates no Dart/test write authority in this
current pass.

## Entry baseline and repository identity

- Repository root: `C:/Users/Kasutaja/Desktop/TraceBench`
- Remote: `https://github.com/Fuuduuu/TraceBench.git`
- Branch: `main`
- `HEAD`: `bef91f2c851032b8234db94fb27e47ae3212adf2`
- `origin/main`: `bef91f2c851032b8234db94fb27e47ae3212adf2`
- Subject: `docs: lock Home activation code-map prerequisite`
- Divergence command: `git rev-list --left-right --count HEAD...origin/main`
- Divergence result: `0 0`
- Entry cached-diff command: `git diff --cached --name-status`
- Entry cached-diff result: no paths
- Entry substantive-diff command: `git diff --name-status`
- Entry substantive-diff result: exactly the two frozen Wizard files listed
  below

## Exact current write allowlist

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/code_maps/CODE_MAP_INDEX.md`
6. `docs/code_maps/lib/app/app.dart.md`
7. `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`
8. `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`
9. `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS.md`

No tenth current-pass file is authorized.

## Accepted committed source identity

All map claims were derived from `git show HEAD:<path>`, never from the local
Wizard worktree.

| Source | Physical lines | `blob` identity command | `blob` object id |
| --- | ---: | --- | --- |
| `lib/app/app.dart` | 141 | `git rev-parse HEAD:lib/app/app.dart` | `4afeab1be7045926e54bb0b56a297c853cce4701` |
| `lib/features/home/screens/benchbeep_home_screen.dart` | 1,217 | `git rev-parse HEAD:lib/features/home/screens/benchbeep_home_screen.dart` | `0beed3164d66abda51214f60356b0ca4e6bf2567` |
| `test/widget/benchbeep_home_screen_test.dart` | 1,073 | `git rev-parse HEAD:test/widget/benchbeep_home_screen_test.dart` | `f4529e408a27a09b9db037583f0ebde15f597a34` |

These Git object IDs identify committed `blob` representations and are the
durable source anchors.

## CODE_MAP_PREFLIGHT

### `lib/app/app.dart`

- Index lookup at entry: absent
- Deterministic map at entry: absent
- Qualification:
  `AUTO — production file owns 5+ independently testable behaviors`
- Score cross-check: `9/12`
  (`0 + 2 + 1 + 2 + 2 + 2`)
- Current responsibility evidence: application providers, project acquisition,
  Home callback wiring, splash lifecycle, router lifecycle, and root rendering
- Current create-project callback: absent

### `lib/features/home/screens/benchbeep_home_screen.dart`

- Index lookup at entry: absent
- Deterministic map at entry: absent
- Qualification:
  `AUTO — production file owns 5+ independently testable behaviors`
- Score cross-check: `10/12`
  (`1 + 2 + 1 + 2 + 2 + 2`)
- Current responsibility evidence: callback contract, load-detail state,
  responsive shell, exit, launcher rail, mode interaction, project/load detail,
  secondary actions, identity, and hero/status presentation
- Current create-project callback: absent

### `test/widget/benchbeep_home_screen_test.dart`

- Index lookup at entry: absent
- Deterministic map at entry: absent
- Qualification: `SCORE 11/12`
  (`1 + 2 + 2 + 2 + 2 + 2`)
- Committed `testWidgets` count: 16
- Behavior families: identity/deferred actions, responsive layout,
  interaction styling, project acquisition/state, routing, and exit
- Current deferred-action assertion: present

`CODE_MAP_PREFLIGHT_RESULT: PASS`

## Created maps

- `docs/code_maps/lib/app/app.dart.md`
- `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`
- `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`

Each map initially records:

- correct deterministic `Source`;
- correct production/test `Type`;
- `Status: REVIEW_REQUIRED`;
- the qualification result above;
- this artifact as `Audit evidence`;
- stable symbols rather than maintained line numbers;
- actual call-path write classes;
- evidence classes, uncertainties, and non-authorization.

## Exact new code-map index rows

```text
| `lib/app/app.dart` | `docs/code_maps/lib/app/app.dart.md` | production | `REVIEW_REQUIRED` |
| `lib/features/home/screens/benchbeep_home_screen.dart` | `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md` | production | `REVIEW_REQUIRED` |
| `test/widget/benchbeep_home_screen_test.dart` | `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md` | test | `REVIEW_REQUIRED` |
```

Exactly those three rows are added; no pre-existing row changes status.

## Current committed behavior

The maps record the following accepted source truth:

1. `TraceBenchApp._buildLauncherHome` supplies load, open, workbench, and exit
   callbacks but no create-project callback.
2. `BenchBeepHomeScreen` declares no create-project callback field.
3. `_LauncherRail` renders
   `benchbeep_home_new_project_deferred` with `Tulekul`, `enabled: false`, and
   `onPressed: null`.
4. `_homeHarness` has no create-project callback parameter.
5. The primary Home test asserts the deferred key, three `Tulekul` labels, and
   a null tap for the new-project card.
6. `TraceBenchApp._openWorkbench({String initialLocation = '/project'})`
   already forwards a selected initial location into `buildTraceBenchRouter`.
7. `lib/app/router.dart` already defines the nested `/new-project` route.
8. No current accepted Home call path supplies `/new-project`.

The authorized activation below is future scope, not current map truth.

## Reserved implementation/build

- `PASS_ID: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS`
- `Lane: A`
- `Mode: FLUTTER_PASS`

Exact implementation write allowlist:

1. `lib/features/project/screens/new_project_wizard_screen.dart`
2. `test/widget/new_project_wizard_screen_test.dart`
3. `lib/app/app.dart`
4. `lib/features/home/screens/benchbeep_home_screen.dart`
5. `test/widget/benchbeep_home_screen_test.dart`

No sixth implementation file.

### Explicit human multi-zone authorization

The human authorizes those five files and their coordinated responsibility
zones solely for:

```text
BenchBeep Home
-> Loo projekt nullist
-> existing /new-project route
-> New Project Wizard foundation
```

The reserved implementation may:

- preserve and complete the existing two-file Wizard foundation;
- add an explicit create-new-project callback to `BenchBeepHomeScreen`;
- thread the callback through `_LauncherRail`;
- enable `Loo projekt nullist`;
- remove its `Tulekul` badge/state;
- call `_openWorkbench(initialLocation: '/new-project')` from
  `TraceBenchApp`; and
- update focused Home and Wizard tests for the complete flow.

It must preserve:

- the six-step Wizard shell;
- Step 1 widget-local draft behavior;
- forward/back draft retention;
- dirty-draft cancellation;
- mobile picker safety;
- `UI_LOCAL` / `ZERO_WRITE` behavior; and
- every unrelated Home action.

Inspect-only:

- `lib/app/router.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/shared/services/project_creator.dart`
- `lib/shared/theme/app_theme.dart`
- `pubspec.yaml`
- `pubspec.lock`

Excluded:

- any sixth implementation file;
- router or inspect-only-file edits;
- `ProjectCreator.createProject`;
- `projectStateProvider` assignment from the new Home action;
- final project creation;
- directory, file, event, fact, projection, or ZIP-output creation;
- schema, writer, materializer, asset, package, theme, tool, or `_incoming`
  changes; and
- canonical placement, coordinate, net, electrical, Confirm/write, or Project
  ZIP semantics.

The future implementation must return:

```text
CODE_MAP_DISPOSITION: UPDATE_REQUIRED
```

After accepted, audited, committed, and pushed implementation, exactly one
later unnamed lock/map-maintenance pass updates affected maps from accepted
committed source. That phase is not named or executed here.

No additional pre-build pass is required after this exact current scope is
independently accepted and pushed.

## Route

```text
Current: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS
Next: TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_IMPL_PASS
```

Implementation authority is conditional on independent acceptance and push of
the current nine-file scope.

## Frozen Wizard carryover

The two worktree files below remain outside the current write and future safe
staging set. They are inspect-only evidence and are not accepted source for the
three maps.

### Source

- Path:
  `lib/features/project/screens/new_project_wizard_screen.dart`
- Entry `blob` command:
  `git hash-object -- lib/features/project/screens/new_project_wizard_screen.dart`
- Entry `blob` object id:
  `66a4269b81d26ce2a1e4ef29ecd048aedd936eec`
- Entry local `worktree` command:
  `git hash-object --no-filters lib/features/project/screens/new_project_wizard_screen.dart`
- Entry local `worktree` object id:
  `66a4269b81d26ce2a1e4ef29ecd048aedd936eec`

### Test

- Path:
  `test/widget/new_project_wizard_screen_test.dart`
- Entry `blob` command:
  `git hash-object -- test/widget/new_project_wizard_screen_test.dart`
- Entry `blob` object id:
  `c78fe5b856cd6442d86adfc40e9494ceccd79a04`
- Entry local `worktree` command:
  `git hash-object --no-filters test/widget/new_project_wizard_screen_test.dart`
- Entry local `worktree` object id:
  `c78fe5b856cd6442d86adfc40e9494ceccd79a04`

`blob` values use the Git-filtered representation produced by
`git hash-object -- <path>`. `worktree` values are local observations of the
unfiltered bytes produced by `git hash-object --no-filters <path>` and are not
durable cross-clone anchors.

## Phase 1 map-body freeze anchors

For each map, read the local worktree file as UTF-8 without BOM, preserving
line endings, take the substring from the first character of
`## File purpose` through EOF, encode it as UTF-8 without BOM, and calculate
SHA-256. These local `worktree` values exclude mutable metadata headers.

| Map body | Local `worktree` SHA-256 |
| --- | --- |
| `docs/code_maps/lib/app/app.dart.md` | `a1a4e7cfe844a65a9f43432b463c004d3f0b43014b8a95923f91556f03c19f4d` |
| `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md` | `769d759902584721cd6a1046eff7e898e12cea4201533610cc7a94ffa68acc94` |
| `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md` | `7a5f84ec44e8d763ee1fe3f1840720cd8acac733705039911a77e1a665726c97` |

For each new registry row, split the raw row on literal `|`, replace segment
index `4` with exactly ` <MAP_STATUS_CELL> ` including one leading and one
trailing space, rejoin on literal `|`, and calculate SHA-256 of raw UTF-8
without BOM or a trailing newline:

| Source row | Masked-row SHA-256 |
| --- | --- |
| `lib/app/app.dart` | `14e6427105135ea75a26fbead51aa7412f1dcb8e99f00ee960941470be5e77b0` |
| `lib/features/home/screens/benchbeep_home_screen.dart` | `d994ed528322f6c90fcffe31dfd7f0eacb303cc53376a8ca8791fdf248ad507a` |
| `test/widget/benchbeep_home_screen_test.dart` | `8d71e1d37608c6c6262c5cff408bb799425e3f8c15d3588564eebf7602f32c0f` |

Only audit-authorized corrections may change map bodies before a clean map
audit. A clean promotion changes exactly the three map `Status` header lines
and three registry Status cells.

## Excluded current-pass surfaces

- all Dart production and test files;
- `lib/app/router.dart`;
- both frozen Wizard worktree files;
- `ProjectCreator`, loaders, persistence, schemas, writers, materializers,
  projections, events, facts, Project ZIP, assets, packages, theme, tooling,
  `_incoming`, and protected surfaces;
- staging, commit, push, stash mutation, reset, restore, clean, and deletion.

## TOOL_SKILL_CHECK

- Capability checked:
  `tracebench-scope-lock`, `tracebench-prompt-authoring`, repository Git/tools,
  and `tools/validate_all.py`
- Capability used:
  `tracebench-scope-lock`
- Why applicable:
  the explicit human in-place authority makes this immediate docs-only phase
  the reservation of one exact future implementation route, allowlist,
  boundaries, stops, and acceptance gate
- Audit-packet capability:
  `tracebench-prompt-authoring` applies to the real post-change map-to-code
  handoff
- External tool required: `NO`

## Validation evidence

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS_VALIDATION_EVIDENCE_BEGIN -->
- `git diff --check`: exit `0`; no whitespace errors. Git emitted only the
  existing LF-to-CRLF working-copy warnings.
- `git diff --cached --check`: exit `0`; no output.
- `py -3 tools\validate_all.py`: exit `1`; `302` tests ran and the suite
  reported `FAILED (errors=158)`. The failure class was environment permission
  denial: the restricted run could not write generated validation outputs
  under repo-local `.codex/` or create/write test artifacts under the OS
  temporary directory. The project-state and both sample-event validations
  completed with `[OK]` before the permission failures. An unsandboxed rerun
  was requested because this is the canonical validator, but the safety gate
  rejected that request; no green result is claimed and no workaround was
  attempted.
- Structural code-map checks: `PASS`; each map has every Standard section,
  covers its complete committed target, declares `REVIEW_REQUIRED`, and has
  exactly one matching `REVIEW_REQUIRED` registry row. No new row or map
  declares `MAINTAINED`.
- Route tuple check: `PASS`; `docs/CURRENT_STATE.md`,
  `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` agree on this current
  pass and the reserved implementation pass.
- Audit lifecycle check: `PASS`; the map-to-code and final-diff blocks are
  unique and whitespace-only, and the matching ledger row is unique.
- Source identity check: `PASS`; all three committed target blob IDs still
  match `HEAD`.
- Wizard carryover freeze check: `PASS`; both pre-existing Wizard files retain
  their baseline filtered and unfiltered Git object IDs.
- Scope check: `PASS`; the pass-owned set is exactly the nine authorized docs
  paths, the complete substantive set is those nine plus the two frozen Wizard
  files, and the index remains empty.
<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS_VALIDATION_EVIDENCE_END -->

## Map-to-code audit contract

The independent map audit compares all three complete map bodies and registry
rows against the committed source identities above. It checks qualification,
zones, symbols, state/data flow, dependencies, write classes, protected and
zero-write boundaries, tests/helpers, dangerous combinations, safe slices,
uncertainties, current-versus-future separation, and index identity.

The returned evidence must include:

```text
MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED_MAP_DRIFT
SAFE_FOR_SNIPER_USE: YES / NO
MAP_AUDIT_VERDICT: ACCEPT_AS_IS / NEEDS_SMALL_PATCH / REJECT
MAP_BODY_FREEZE_RESULT: PASS / FAIL
PROMOTION_AUTHORIZATION: YES / NO
PROMOTION_MAPS: exact map paths or NONE
PROMOTION_INDEX_ROWS: exact source rows or NONE
```

The map-to-code result is recorded only inside the following block:

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS_MAP_TO_CODE_AUDIT_BLOCK_BEGIN -->

### Returned independent map-to-code audit

```text
MAP_VERDICT: ACCEPT_WITH_NITS
SAFE_FOR_SNIPER_USE: YES
MAP_AUDIT_VERDICT: ACCEPT_AS_IS
MAP_BODY_FREEZE_RESULT: PASS
INDEX_ROW_FREEZE_RESULT: PASS
CURRENT_FUTURE_SEPARATION: PASS
SELF_REFERENCE_AUDIT: PASS
PROMOTION_AUTHORIZATION: YES
PHASE_2_RECORDING_AUTHORIZATION: YES
```

`PROMOTION_MAPS`:

- `docs/code_maps/lib/app/app.dart.md`
- `docs/code_maps/lib/features/home/screens/benchbeep_home_screen.dart.md`
- `docs/code_maps/test/widget/benchbeep_home_screen_test.dart.md`

`PROMOTION_INDEX_ROWS`:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

Returned non-blocking findings:

- `NIT-1`: The maps use compound forms such as `UI_LOCAL` / `ZERO_WRITE` and
  `ZERO_WRITE` / `PROJECTION_STATE`, while `CODE_MAP_STANDARD` defines only
  the single-class vocabulary. The call-path claims are correct and the
  meaning is unambiguous. No patch is required in this pass.
- `NIT-2`: Claude independently ran `py -3 tools\validate_all.py` in an
  unrestricted environment and returned `[OK] validate_all.py PASSED`,
  `EXIT=0`, with three expected missing-optional-photo warnings. This
  corroborates, rather than contradicts, Codex’s earlier sandbox-blocked
  validator result.

The Codex sandbox run remains recorded as environment-blocked and is not
retroactively described as green. Mechanical promotion changed only the three
map `Status` header lines and the three matching `CODE_MAP_INDEX.md` Status
cells authorized above. This returned map audit contains no final-diff or
`SAFE_FOR_STAGING` determination.

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS_MAP_TO_CODE_AUDIT_BLOCK_END -->

Ledger mirror: the `Status` cell of the matching
`TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS` row in
`docs/AUDIT_INDEX.md`.

## Final-diff verdict contract

After a clean map audit, any authorized correction, and mechanical promotion,
the final independent audit covers the complete nine-file scope diff. Its
canonical verdict, safety result, exact safe staging set, route/boundary
results, scope-role confirmation, and bounded final recording authorization
belong only inside:

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS_FINAL_DIFF_VERDICT_BLOCK_BEGIN -->

<!-- TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_CODE_MAP_PASS_FINAL_DIFF_VERDICT_BLOCK_END -->

Ledger mirror: the `Status` cell of the same matching row in
`docs/AUDIT_INDEX.md`.

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, and route-owner files were checked
- no touched file asserts this pass's own current staging or audit-pipeline
  position
- generic lifecycle policy and conditional future authority are distinguished
  from claims about the current pass
- `REVIEW_REQUIRED` describes map lifecycle state, not staging or audit
  acceptance
- no file claims this current scope is accepted, staged, committed, or pushed

`SELF_REFERENCE_AUDIT: PASS`
