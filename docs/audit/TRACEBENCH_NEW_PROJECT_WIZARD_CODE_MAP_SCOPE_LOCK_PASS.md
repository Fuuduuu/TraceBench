# TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS

Status: `PRE-AUDIT SNAPSHOT` — this five-file docs-only scope-lock diff is
unstaged and awaits independent Claude audit; no audit verdict or
staging-safety decision is claimed.

PASS_ID: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`

Lane: `A`

Mode: `DOCS_SYNC`

Profile: `SCOPE_LOCK / DOCS_ONLY`

## Purpose

Reserve one narrow future pass to create the two missing descriptive code maps
that block safe New Project Wizard scope qualification. This pass creates no
map or index row, changes no Dart responsibility zone, defines no Wizard V2
product behavior, and reserves no implementation authority.

Future PASS_ID: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`

## TOOL_SKILL_CHECK

- relevant capability found: repo-local `tracebench-scope-lock`,
  `docs/code_maps/CODE_MAP_STANDARD.md`, Git source/index evidence, and
  `tools/validate_all.py`
- capability used: exact future-route and allowlist reservation, independent
  source/test qualification, responsibility-zone inspection, and repository
  validation
- why applicable: two qualifying Dart targets lack their deterministic maps
  and index entries, so implementation qualification must remain blocked until
  a separately audited docs-only map pass creates them
- external tool required: `NO` — no plugin, connection, installation, GitHub
  tool, or external capability is required to execute this scope lock

Independent Claude review remains a later repository workflow gate; it is not
an external capability invoked by Codex during this pass.

## MODEL_ROUTING_CHECK

`PASS` — Lane A docs work routes from Codex to independent Claude Code audit,
then to exact human staging, commit, and push if accepted.

## Verified baseline

The pre-edit gate matched:

- branch: `main`
- HEAD, local `main`, local `origin/main`, and live `refs/heads/main`:
  `d8d983f104bb66bec39e182ffcba1dd552005348`
- subject: `docs: release BenchBeep route sentinel`
- parent: `c16d17b7567ea6b23f347bffeec9dd84b2eaf3a3`
- tracked diff: empty
- cached diff: empty
- starting Current: `NEEDS_USER_DECISION`
- starting Next: `NEEDS_USER_DECISION`
- active, future, reserved, executable, or Wizard implementation allowlist:
  none
- this PASS_ID, ledger row, and artifact: absent

## CODE_MAP_PREFLIGHT

### Production target

- target:
  `lib/features/project/screens/new_project_wizard_screen.dart`
- deterministic map:
  `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `CODE_MAP_INDEX` lookup: no row
- deterministic map path: absent
- committed source: 199 physical lines; blob
  `bb7c02e2eb1a1e31892ea1fa5c020701cde56fe4`
- qualification: `AUTO — production file owns 5+ independently testable
  behaviors`
- direct behavior evidence: platform/mobile gating, folder selection and
  cancellation, destination prerequisite, optional-field request forwarding,
  transient submit state, success state/navigation, typed failure routing,
  sanitized failure presentation, and cancel navigation
- changed responsibility zone: none
- inspected stable anchors: `NewProjectWizardScreen`,
  `_NewProjectWizardScreenState`, `_isMobile`, `_pickFolder`,
  `_createProject`, `_isSubmitting`, and `build`
- write class for this pass: inspect-only; no Dart write
- implementation qualification result: `BLOCKED_CODE_MAP_REQUIRED` until the
  future map pass completes

### Test target

- target: `test/widget/new_project_wizard_screen_test.dart`
- deterministic map:
  `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `CODE_MAP_INDEX` lookup: no row
- deterministic map path: absent
- committed source: 265 physical lines; blob
  `cbd66ba8ceb957d61caced285b6204b191e3688d`
- qualification: `SCORE 6/12`
- score: physical size `0`; independent responsibilities `2`;
  canonical/protected read-only boundary `1`; regression surface `2`;
  whole-file analysis tax `0`; blast-radius ambiguity `1`
- inspected stable anchors: `_TestPlatformInfo`, `_FakeProjectCreator`,
  `_FakeDirectoryPicker`, `_inlineProjectState`, `_buildWizardApp`, and the
  five focused `testWidgets` cases
- changed responsibility zone: none
- write class for this pass: inspect-only; no test write
- implementation qualification result: `BLOCKED_CODE_MAP_REQUIRED` until the
  future map pass completes

Both source targets remain byte-identical and inspect-only. This scope lock
records the map requirement without creating or updating either map.

## Exact future allowlist

After independent acceptance and push of this scope lock,
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` may write exactly:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

No fifth file is authorized.

## Future pass contract

The future pass must:

- describe accepted committed source only;
- follow the `CODE_MAP_STANDARD` template;
- use stable symbol anchors and never maintained line numbers;
- create exactly two map files and exactly two index rows;
- keep both maps descriptive and non-authorizing;
- leave both Dart targets and all runtime/test behavior unchanged;
- begin both map files and index rows as `REVIEW_REQUIRED`;
- obtain independent Claude map-to-code audit before any `MAINTAINED`
  promotion; and
- obtain a final Claude diff audit before staging.

If qualification, source, tests, required files, or product boundaries differ
from this lock, stop instead of broadening the future allowlist.

## Route after this pass

All three operational route owners record:

- Current: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`

The future pass remains conditional until this exact scope-lock diff is
independently accepted and pushed.

## Excluded surfaces

No Wizard V2 implementation, project-name, directory, collision, persistence,
event, outline, component, placement, router, writer, schema, tool, runtime,
UI, asset, ZIP, Project Source, handoff, or design-input authority is created.
No code map or index row is created by this scope lock.

## Exact scope-lock diff

This pass changes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS.md`

Nothing is staged, committed, pushed, pulled, fetched, reset, cleaned, or
rebased by Codex.

## Fresh validation evidence

- `py -3 tools\validate_all.py`: `PASS` (`302` tests, `OK`; only the
  repository's existing optional-photo warnings were reported)
- `git diff --check`: `PASS`
- changed-file boundary: exactly four modified governance files plus this one
  new audit artifact; no other tracked file changed
- cached/staged diff: empty
- route equality: all three operational owners record the corrected
  `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` tuple
- future allowlist: exactly the four paths recorded above
- map/index boundary: both deterministic maps and both index rows remain
  absent; `docs/code_maps/CODE_MAP_INDEX.md` is unchanged
- inspect-only blobs: production
  `bb7c02e2eb1a1e31892ea1fa5c020701cde56fe4`; test
  `cbd66ba8ceb957d61caced285b6204b191e3688d`
- ledger preservation: exactly one new row for this PASS_ID, with no removed
  or modified prior row
- file hygiene: all five changed files are valid UTF-8, LF-only, BOM-free,
  newline-terminated, and clean under `git diff --check`
- known scratch inventory: retained and unstaged with no unexpected path drift
- Git no-drift recheck: HEAD, local `main`, local `origin/main`, and live
  `refs/heads/main` remain
  `d8d983f104bb66bec39e182ffcba1dd552005348`

## Audit state

This scope-lock diff remains PRE-AUDIT and awaits independent Claude audit
under `scope-lock-post-audit`. Codex issues no acceptance verdict and claims no
accepted, staging-safe, committed, pushed, or active future-map authority.
