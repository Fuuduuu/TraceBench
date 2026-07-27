# TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS

Status: `MAP AUDIT RECORDED / FINAL DIFF AUDIT PENDING` — the human-supplied
independent map-to-code audit permits Phase 2; both Wizard maps and both index
rows are `MAINTAINED`, while `SAFE_FOR_STAGING: NO`, final diff audit, exact
safe staging set, human staging, commit, and push all remain open.

PASS_ID: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`

Lane: `A`

Mode: `DOCS_ONLY / CODE_MAP`

Phase: `2 of 2`

## Purpose

Phase 1 activated the reserved New Project Wizard code-map pass under the
amended eight-file lock, verified both descriptive map bodies against accepted
committed source, and stopped at `REVIEW_REQUIRED`. Phase 2 records the
human-supplied independent map audit, promotes both maps and both index rows to
`MAINTAINED` without changing either audited body, and stops for final
independent diff audit. This pass defines no Wizard V2 behavior, changes no
runtime or test source, and grants no implementation authority.

## TOOL_SKILL_CHECK

- relevant capability found: no dedicated repo-local code-map skill, helper,
  fixture, or generation tool exists; `tracebench-code-map-lifecycle` does not
  exist, as recorded by `docs/CODEX_TOOLING_POLICY.md`
- capability used: `docs/code_maps/CODE_MAP_STANDARD.md`, committed
  production/test source, Git object evidence, map/index validation rules, and
  `tools/validate_all.py`
- why applicable: this is code-map lifecycle work for two independently
  qualifying Dart targets, and the Standard is the canonical lifecycle owner
- external tool required: `NO`

## Verified baseline

The pre-edit gate matched:

- checkout: normal `main` checkout, not a submodule or linked worktree
- HEAD, local `main`, local `origin/main`, and live
  `refs/heads/main`:
  `480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`
- subject: `docs: amend New Project Wizard code-map scope lock`
- parent: `363d86bf81266a6205fff2f0f07d9a302077065c`
- normalized tracked content diff: exactly
  `docs/code_maps/CODE_MAP_INDEX.md`
- cached/staged diff: empty
- pre-edit Current:
  `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
- pre-edit Next: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`
- active write allowlist: exactly the amended eight files changed by this pass
- Wizard implementation authority: none
- uncommitted map/index lifecycle state: `MAINTAINED` with no audit authority;
  corrected by this pass to `REVIEW_REQUIRED`
- known scratch inventory: the pre-existing untracked set was retained and
  unstaged; its volatile path count is intentionally not durable artifact truth

The pushed amendment satisfies the reserved pass's activation condition. No
uploaded, handoff, Project Source, design ZIP, or external evidence was used
to describe the target code.

## CODE_MAP_PREFLIGHT

### Production map

- target source:
  `lib/features/project/screens/new_project_wizard_screen.dart`
- target map:
  `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- index status: audited at `REVIEW_REQUIRED`; promoted to `MAINTAINED` in
  Phase 2
- qualification:
  `AUTO — 5+ independently testable behaviors`
- changed responsibility zone: none; only descriptive lifecycle/route/audit
  documentation changes
- inspect-only coupled zones: the focused Wizard widget test, the maintained
  `ProjectCreator` map, `projectStateProvider`, and the router destination
- direct dependencies: `dart:io` Platform display utility, Flutter Material,
  Flutter Riverpod, GoRouter, `file_picker`, `app.dart` project state,
  `ProjectCreator`, and `PlatformInfo`
- evidence classes: `[D]` for committed source and focused-test behavior,
  `[P]` only for maintained `ProjectCreator` downstream boundaries, and `[S]`
  only for explicitly labeled future extraction seams
- write class: local form/picker/navigation paths are `ZERO_WRITE` or
  `UI_LOCAL`; the creator call crosses
  `CANONICAL_EVENT` + `NONCANONICAL_FILE` + `PROJECTION_STATE` boundaries
  owned behind `ProjectCreator`, while this screen owns none of those writes
- affected tests: all five focused tests in
  `test/widget/new_project_wizard_screen_test.dart`
- disposition: `REVIEWED_NO_CHANGE`

### Test map

- target source: `test/widget/new_project_wizard_screen_test.dart`
- target map:
  `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- index status: audited at `REVIEW_REQUIRED`; promoted to `MAINTAINED` in
  Phase 2
- qualification:
  `SCORE 6/12 — multi-family UI regression surface with protected-state fixtures`
- changed responsibility zone: none; only descriptive lifecycle/route/audit
  documentation changes
- inspect-only coupled zones: the production Wizard screen, creator/picker
  injection seams, project-state projection, and success-route widgets
- direct dependencies: Flutter test, Flutter Material, Flutter Riverpod,
  GoRouter, `file_picker`, platform info, the production Wizard,
  `ProjectCreator`, the app router, project-state fixture models, Board Canvas,
  and the stale-projection banner
- evidence classes: `[D]` for committed test/source assertions and `[S]` only
  for explicitly labeled future extraction seams
- write class: fake creator and picker behavior is `ZERO_WRITE`; widget
  interaction and process-global picker replacement are test-local
  `UI_LOCAL`/`ZERO_WRITE`; successful provider replacement exercises
  `PROJECTION_STATE` without real persistence
- affected tests/helpers: `_TestPlatformInfo`, `_FakeProjectCreator`,
  `_FakeDirectoryPicker`, `_inlineProjectState`, `_buildWizardApp`, and all
  five focused `testWidgets`
- disposition: `REVIEWED_NO_CHANGE`

## Source verification

### Production target

- committed source: 199 physical lines; blob
  `bb7c02e2eb1a1e31892ea1fa5c020701cde56fe4`
- stable anchors resolved in committed source:
  `projectCreatorProvider`, `NewProjectWizardScreen`,
  `_NewProjectWizardScreenState`, `_isMobile`, `_pickFolder`,
  `_createProject`, `_showMessage`, `dispose`, and `build`
- behavior branches checked directly: platform gating, directory picking and
  cancellation, selected-parent prerequisite, optional-field request
  forwarding, submit locking, success state/navigation, typed failure routing,
  sanitized failure presentation, and cancel navigation
- cross-file anchors checked: the focused test keys and seams,
  `ProjectCreator.createProject`, `projectStateProvider`, Board Canvas, and the
  stale-projection banner
- negative claims checked: this file contains no direct filesystem write,
  materializer, event-store, schema, Project ZIP, fact, placement, or
  projection-file implementation
- map length: 194 physical lines

### Test target

- committed source: 265 physical lines; blob
  `cbd66ba8ceb957d61caced285b6204b191e3688d`
- stable anchors resolved in committed source:
  `_TestPlatformInfo`, `_FakeProjectCreator`, `_FakeDirectoryPicker`,
  `_inlineProjectState`, `_buildWizardApp`, `main`, and all five exact
  `testWidgets` descriptions
- cross-file anchors checked: production Wizard widget keys, Board Canvas,
  the stale-projection banner, creator request/result types, and provider
  overrides
- negative claims checked: the suite uses fake creator/picker seams and
  performs no real project-directory, event-store, materializer,
  projection-file, Project ZIP, fact, or placement write
- map length: 181 physical lines

Both map bodies follow the standard section order, use stable symbol anchors
instead of maintained line numbers, remain descriptive and non-authorizing,
and contain no commit ID, PASS_ID, route state, verdict, staging set, or
allowlist.

## Exact eight-file boundary

This pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

Relative to committed baseline, the code-map index receives exactly two new
rows, one for each deterministic map, both now at `MAINTAINED`. The audit index
receives exactly one new row for this pass; Phase 2 updates only that
uncommitted row and modifies no other audit-index row.

## Map state and audit gates

Gate 1 is satisfied by the human-supplied independent map-to-code audit
recorded below. Gate 2 is satisfied inside this same PASS_ID: both map headers
and both index rows read `MAINTAINED`, and both map headers cite this artifact
as `Audit evidence`.

Gates 3 and 4 remain open. A final independent Claude audit of the complete
eight-file diff is required before any exact human staging. `MAINTAINED` is
only code-map lifecycle status; it is not final pass acceptance or staging
permission.

## Supplied independent map-to-code audit

The human supplied these exact read-only Claude results for the Phase 1 maps
at committed source baseline
`480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`:

- `PRODUCTION_MAP_RESULT: ACCEPT_WITH_NITS`
- `TEST_MAP_RESULT: ACCEPT_AS_IS`
- `MAP_VERDICT: ACCEPT_WITH_NITS`
- `SAFE_FOR_SNIPER_USE: YES`
- `PHASE_2_ALLOWED: YES`
- `BOUNDARY_RESULT: PASS`
- `SAFE_FOR_STAGING: NO`
- `SAFE_STAGING_SET: NONE`

Claude verified both map bodies claim-by-claim against committed source,
including responsibility zones, data flow, dependencies, write classes,
zero-write claims, test names, negative claims, and uncertainty claims. These
results authorize only the Phase 2 metadata promotion. They do not supply a
final diff verdict, pass acceptance, staging permission, commit, or push.

## Supplied findings and dispositions

The supplied audit reported one `LOW` and four `NIT` findings. None blocks the
authorized metadata promotion:

- `LOW` — the test map's `SCORE 6/12` is not independently reproducible from
  the compact map alone. At 265 physical source lines and five focused tests,
  physical size scores `0`, so all six qualification points come from
  non-size dimensions. Deferred to a future map-maintenance pass; not armed.
- `NIT` — `REVIEWED_NO_CHANGE` stretches disposition vocabulary designed for
  work against an existing map, while this pass authored both maps.
  `NOT_APPLICABLE` would be invalid and the Standard defines no authorship
  disposition. Deferred as a Standard-vocabulary observation; no pass armed.
- `NIT` — the production map names `PlatformInfo` without noting that its
  owner is `lib/shared/services/python_runner.dart`. Deferred to a future
  map-maintenance pass; the audited map body remains frozen and no pass is
  armed.
- `NIT` — the production map's
  `_createProject` -> `ProjectCreator.createProject` boundary row has no
  evidence-class tag; the call path is `[D]` and downstream write classes are
  `[P]`. Deferred to a future map-maintenance pass; the audited map body
  remains frozen and no pass is armed.
- `NIT` — the Phase 1 artifact pinned a volatile untracked-path count.
  Addressed in this authorized Phase 2 artifact rewrite by retaining only the
  durable statement that baseline scratch stayed unstaged.

## Audited map body freeze proof

Only each map's `Status` and `Audit evidence` header lines changed. Line counts
are unchanged, and SHA-256 fingerprints computed after masking those two
header values are identical before and after promotion:

- production map: 194 -> 194 lines; masked SHA-256
  `d28b09b82b3ccc62ec60b5542a2f24eb898d70fe9006e6ae1f24bda935d3d3aa`
  before and after; full SHA-256
  `60fdda59ec86b5627f15d4ab41aa520eaebbd29c13d694298410abad0c7c21a9`
  ->
  `ed99b7ff400724b12cde745347ce56bbc2315eb3450a23528f1f13cb10b0f6ea`
- test map: 181 -> 181 lines; masked SHA-256
  `9ed870b79929d04a425b2feb3b1e13d7d854d411d037b822a125adb409764628`
  before and after; full SHA-256
  `2e30dc818a3a7ff02e55205b75dce722374d9a781af9e70596cbe585ebb32a31`
  ->
  `1e8ee7fe88cb49b4d59ff723352c417a79c537966bd7984267b3f56b607fbcfe`

## Route change

All three route owners advance coherently:

- old: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`
- new: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` ->
  `NEEDS_USER_DECISION`

`NEEDS_USER_DECISION` is a non-executable sentinel, not a reserved successor.
It is the truthful Next value because Phase 2 remains inside the current
PASS_ID and the active lock forbids a closeout, route-release, ceremony, or
pointer-reset pass.

## Preserved governance and product boundaries

- both mapped Dart files and every other runtime/test file are inspect-only
- schemas, tools, assets, UI implementation, ZIP files, Project Sources,
  handoffs, design inputs, `_incoming`, and all docs outside the exact eight
  remain unchanged
- no project-name, directory, collision, persistence, event, outline,
  component, placement, router, writer, fact, or Wizard V2 behavior is
  defined, reserved, or implemented
- the supplied map verdict and `MAINTAINED` promotion are recorded, but no
  final diff verdict, pass acceptance, safe staging set, completion, staging,
  commit, or push is claimed
- nothing is staged, committed, pushed, pulled, reset, cleaned, or rebased by
  Codex

## Phase 1 validation evidence

- `py -3 tools\validate_all.py`: `environment limitation` — exit `1`; the
  sandbox denied writes to repository `.codex/known_facts*.json` outputs and
  Windows OS temporary directories with `PermissionError`; discovery reached
  all 302 tests (`Ran 302 tests in 20.553s`) but this run supplies no
  repository/test verdict
- human-provided local reference: the same validator passes this commit in the
  real local worktree with exit `0`, 302 tests, and
  `[OK] validate_all.py PASSED`; this reference is not relabeled as Codex-run
  validation
- `git diff --check`: `PASS` (only Git line-ending conversion warnings)
- `git diff --cached --check`: `PASS`
- exact changed-file boundary: `PASS` — five normalized tracked documentation
  diffs plus exactly the three allowlisted untracked map/audit files
- cached/staged diff: empty
- route coherence: `PASS` — all three owners read this pass ->
  `NEEDS_USER_DECISION`
- map/index status: `PASS` — both map headers and both index rows read
  `REVIEW_REQUIRED`; both map headers read `Audit evidence: none`
- source preservation: production blob
  `bb7c02e2eb1a1e31892ea1fa5c020701cde56fe4`; test blob
  `cbd66ba8ceb957d61caced285b6204b191e3688d`
- untracked inventory: the baseline scratch set remained present and
  unstaged; its volatile count is not durable artifact truth
- Git no-drift recheck: HEAD, local `main`, and local `origin/main` remain
  `480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`; the live remote ref was verified
  at the pre-edit gate

## Phase 2 validation evidence

- `py -3 tools\validate_all.py`: `environment limitation` — exit `1`; the
  sandbox again denied repository `.codex/known_facts*.json` and Windows OS
  temporary-directory writes; discovery reached all 302 tests
  (`Ran 302 tests in 20.265s`) and emitted 474 `PermissionError` lines, so this
  run supplies no repository/test verdict
- human-provided local reference: the same validator passes this commit on the
  real host with exit `0`, 302 tests, and `[OK] validate_all.py PASSED`,
  verified four times; this is not relabeled as Codex-run validation
- `git diff --check`: `PASS` (only Git line-ending conversion warnings)
- `git diff --cached --check`: `PASS`
- exact eight-file boundary: `PASS` — five normalized tracked documentation
  diffs plus exactly the three allowlisted untracked map/audit files
- map-body freeze proof: `PASS` — both masked SHA-256 values and both line
  counts remain identical before and after the authorized header promotion
- route coherence: `PASS` — all three owners remain this pass ->
  `NEEDS_USER_DECISION`
- source preservation: production blob
  `bb7c02e2eb1a1e31892ea1fa5c020701cde56fe4`; test blob
  `cbd66ba8ceb957d61caced285b6204b191e3688d`
- cached/staged diff: empty
- scratch preservation: the baseline untracked set remains unstaged; its
  volatile count is intentionally omitted from durable artifact truth
- Git no-drift recheck: HEAD, local `main`, and local `origin/main` remain
  `480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`; the live remote ref matched at
  the Phase 2 gate

## Audit state

Gate 2 is recorded and both maps are `MAINTAINED`. This pass now stops for
gate 3, the final independent Claude audit of the complete eight-file diff.
Codex claims no final acceptance, staging safety, safe staging set, committed,
pushed, complete, or implementation-ready state.

## Superseding audit reconciliation — 2026-07-27

Reconciliation PASS_ID:
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_AUDIT_RECONCILIATION`

Mode: `DOCS_SYNC / AUDIT_RECONCILIATION`

This append-only section records later human-supplied audit/session evidence
and Git-verifiable commit evidence. It preserves the complete draft-time body
above as temporal history while superseding its former current-state claims.
It performs no new map audit, changes no map or index-map content, and does not
change the current/next route or active authority.

### Superseded claims

- Original lines 3-6 remain the accurate pre-gate-3 status, but no longer
  describe the pushed pass after the returned gate-3 verdict and gate 4.
- The original `Gates 3 and 4 remain open` statement remains preserved as the
  pre-audit handoff state; both gates are now evidenced below.
- The original gate-1 `SAFE_FOR_STAGING: NO` result remains accurate for that
  earlier map-to-code audit, but is superseded as the final pass safety state
  by the later gate-3 `SAFE_FOR_STAGING: YES` result.
- The original final `## Audit state` remains the pre-gate-3 stop record; it is
  superseded by this reconciliation without deletion or rewriting.

### Returned gate-3 result

The human supplied the following result from Claude Code's final independent
audit of the complete eight-file Phase 2 diff:

```text
AUDIT_VERDICT: ACCEPT_AS_IS
MAP_BODY_FREEZE_RESULT: PASS
RECORDED_MAP_AUDIT_RESULT: PASS
LEDGER_RESULT: PASS
ROUTE_RESULT: PASS
BOUNDARY_RESULT: PASS
NO_FALSE_ACCEPTED_OR_PUSHED_CLAIM: YES
SAFE_FOR_STAGING: YES
SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md
- docs/code_maps/CODE_MAP_INDEX.md
- docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md
- docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md
```

The audit raised one `NIT`: the masked SHA-256 values published in the Phase 2
report were not independently reproducible because the masking algorithm was
unspecified. The auditor instead verified the map-body freeze by content
comparison against the Phase 1 audited bodies.

### Gate-4 completion and role deviation

Git evidence verifies gate 4 completed as:

- commit:
  `3e5edad0956c852584543bc643ca7306caee9e8e`
- parent:
  `480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`
- subject: `docs: add New Project Wizard code maps`
- committed set: exactly the eight files in the gate-3 safe staging set
- commit stat: 8 files, 830 insertions, 71 deletions
- pushed state: local `main`, local `origin/main`, and live
  `refs/heads/main` all resolve to `3e5edad0956c852584543bc643ca7306caee9e8e`

`docs/ACTIVE_SCOPE_LOCK.md` required exact human staging followed by commit and
push, and `AGENTS.md` assigns those operations to the human by default. The
human-supplied session record states that Claude Code performed the gate-3
audit and then performed all three gate-4 operations under explicit human
delegation, using this exact-file form:

```text
git add docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md docs/code_maps/CODE_MAP_INDEX.md docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md
```

No `git add .` or `git add -A` was used. Combining the independent auditor and
executor roles was an explicitly human-authorized deviation from the default
role separation; it is recorded as a deviation, not presented as
compliant-by-default or as a general precedent.

### Reconciliation boundary and current state

This reconciliation changes only this existing artifact and this pass's
`docs/AUDIT_INDEX.md` status cell. It leaves
`docs/ACTIVE_SCOPE_LOCK.md`, `docs/CURRENT_STATE.md`, and
`docs/PASS_QUEUE.md` unchanged. Marking the eight-file authority as spent would
change active authority and exceeds the selected reconciliation skill, which
requires route and authority to remain unchanged.

The current two-file reconciliation is unstaged, uncommitted, unpushed, and
not yet independently audited. It does not inherit the prior pass's acceptance
or safe staging set; its own exact two-file diff requires the independent
audit requested by the accompanying `CLAUDE_AUDIT_PACKET`.
