# TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS

Status: `PRE-AUDIT SNAPSHOT` — the seven-file docs-only repair diff is
unstaged and awaits independent Claude audit; no audit verdict or
staging-safety decision is claimed.

PASS_ID: `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS`

Lane: `B`

Mode: `DOCS_SYNC`

## Purpose

This governance/code-map repair resolves the known
`BLOCKED_CODE_MAP_REQUIRED` gate for
`lib/shared/services/project_creator.dart`. It creates the qualifying
production map at its deterministic path, adds exactly one registry row, and
records the minimum route, ledger, and audit evidence needed to make that map
discoverable.

This pass does not retry, implement, activate, or reserve New Project Wizard
V2. It changes no production, test, schema, tool, UI, router, event, writer,
Project ZIP, asset, `_incoming`, or design-input behavior.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: repo-local
  `tracebench-prompt-authoring`, `docs/code_maps/CODE_MAP_STANDARD.md`,
  `docs/code_maps/CODE_MAP_INDEX.md`, focused ProjectCreator tests, Git
  evidence commands, and `tools/validate_all.py`
- capability actually used: the prompt-authoring skill for the real
  post-change recovery handoff, the Code Map Standard for qualification and
  structure, focused source/test inspection for claims, and repository
  validators for the final evidence
- why applicable: the pass creates a maintained map for a qualifying Dart
  production owner and must hand a real seven-file governance diff to
  independent Claude audit
- external tool required: `YES` — independent Claude audit is required after
  the real diff; no external plugin or connection was used

The repo-local scope-lock skill is not applicable after the human corrected
the lifecycle classification: this is a recovery/code-map repair and reserves
no future implementation authority.

## CODE_MAP_PREFLIGHT

- target source: `lib/shared/services/project_creator.dart`
- target map before this repair:
  `docs/code_maps/lib/shared/services/project_creator.dart.md` absent
- index status before this repair: no ProjectCreator entry
- qualification:
  `AUTO — production file owns 5+ independently testable behaviors`
- changed production responsibility zone: none; this pass documents current
  baseline behavior and leaves the source and tests unchanged
- verified zones: request/result contract, dependency seams, ID generation,
  preflight, orchestration, skeleton/files, materializer, hydration, and
  failure cleanup
- inspect-only coupled surfaces: focused ProjectCreator tests, manifest model
  and schema, Python runner/materializer call boundary, event-store bootstrap,
  known-facts projection, and project-folder contract labels
- explicitly excluded: every Dart/test/schema/tool/UI/router/event/writer/
  Project ZIP implementation change and every Wizard V2 intention
- verified write classes: `ZERO_WRITE`, `NONCANONICAL_FILE`,
  `CANONICAL_EVENT` for empty event-store initialization,
  `PROJECTION_STATE` for materializer output, and their cleanup combination
- focused evidence: `test/unit/project_creator_test.dart`
- pre-repair outcome: `BLOCKED_CODE_MAP_REQUIRED`
- repair result: a current `MAINTAINED` map at the deterministic path; source
  disposition `REVIEWED_NO_CHANGE`

## Baseline evidence

The mandatory pre-edit gate matched:

- HEAD: `b4c5a007c1401764803fc2cad8b91de9e2c91b14`
- local `main`: `b4c5a007c1401764803fc2cad8b91de9e2c91b14`
- local `origin/main`: `b4c5a007c1401764803fc2cad8b91de9e2c91b14`
- live `refs/heads/main`:
  `b4c5a007c1401764803fc2cad8b91de9e2c91b14`
- subject: `docs: close out file map repair audit`
- parent: `81c2b7c0dcd14a3f10928ee952c83ea8afea383d`
- tracked diff: empty
- cached diff: empty
- all three route owners:
  `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- active or reserved allowlist: none
- deterministic target map: absent
- ProjectCreator registry entry: absent

The matching baseline route was the repository's empty, non-executable
sentinel. The explicit human continuation corrected the audit contract to
`recovery / evidence-recheck` and authorized this exact repair without any
future implementation reservation.

## BLOCKED_CODE_MAP_REQUIRED finding and qualification

The earlier Wizard V2 preflight stopped because the relevant ProjectCreator
production owner qualified for a maintained map but no map or registry entry
existed. That stop remains historical evidence; this pass repairs only its
missing-map cause.

The baseline source owns more than five independently testable
behaviors: project-ID generation, mobile gating, destination validation,
collision prevention, skeleton and manifest creation, materializer
orchestration, covered failure cleanup, created-project hydration, and typed
failure routing. It therefore qualifies automatically under
`docs/code_maps/CODE_MAP_STANDARD.md`.

## Exact map and index repair

The new production map:

- uses the deterministic path
  `docs/code_maps/lib/shared/services/project_creator.dart.md`;
- records `MAINTAINED`, automatic qualification, and `Audit evidence: none`;
- contains all thirteen Standard sections and nine responsibility zones;
- uses stable symbols rather than maintained line numbers;
- distinguishes verified current behavior from non-authorizing future seams;
- records empty event-store initialization without claiming any event append;
- records materializer-owned projection output without claiming Dart fact
  creation;
- records best-effort cleanup and the uncovered mid-skeleton lifecycle risk;
- claims no `project_name`, `ProjectDirectoryNamer`, Wizard V2 UI/router,
  board/component/placement write, or Project ZIP archive behavior.

`docs/code_maps/CODE_MAP_INDEX.md` gains exactly one ProjectCreator production
row between the existing Board Canvas production and test rows. Removing that
one inserted row reproduces the prior index bytes.

## Active authority

This pass may write exactly:

- `docs/code_maps/lib/shared/services/project_creator.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS.md`

No other file or directory is authorized.

## Route and audit gate

All three operational owners now record:

- Current: `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS`
- Next: `NEEDS_USER_DECISION`

The repair remains current pending independent Claude audit under
`recovery / evidence-recheck` and exact human commit/push.
`NEEDS_USER_DECISION` is a non-executable sentinel and grants no write
authority. No future implementation PASS_ID, implementation allowlist,
successor, or Wizard V2 activation is reserved.

## Preservation and excluded surfaces

The baseline ProjectCreator source, focused test, directly related manifest
model/schema, runtime, tools, UI, router, events, writers, Project ZIP behavior,
assets, specs, `_incoming`, design input, `docs/FILE_MAP.md`, all prior audit
artifacts, and known scratch remain outside the diff.

Existing `docs/AUDIT_INDEX.md` rows and existing
`docs/code_maps/CODE_MAP_INDEX.md` rows must remain byte-identical. The repair
creates exactly one PASS_ID row and one audit artifact. Nothing may be staged,
committed, pushed, pulled, fetched, reset, cleaned, or rebased by Codex.

## Fresh validation evidence

Fresh checks against the completed seven-file diff recorded:

- `py -3 tools\validate_all.py`: `PASS`; the required permission-enabled rerun
  completed all 302 discovered tests successfully. The initial sandboxed
  invocation could not create test outputs under `.codex` and the system temp
  directory; it reported permission errors rather than repository failures.
- `git diff --check`: `PASS`.
- `git diff --stat`, `git diff --numstat`, and
  `git diff --name-status`: exactly the five expected tracked modifications;
  the two authorized new untracked documents were checked separately.
- `git diff --cached --name-status`: empty.
- `git status --short --branch`: `main...origin/main`, with the five expected
  tracked modifications, two authorized new untracked documents, and the same
  pre-existing known-scratch roots observed at the pre-edit gate; no
  unexpected path appeared.
- exact changed-file union: the seven active-authority files only.
- structural map check: `PASS`; 229 physical lines, all thirteen Standard
  sections in order, nine responsibility zones, exact metadata, stable
  anchors, and no prohibited governance payload.
- route equality and exact seven-path authority across all three operational
  owners: `PASS`.
- `docs/AUDIT_INDEX.md` and `docs/code_maps/CODE_MAP_INDEX.md`
  byte-preservation reconstruction after deleting their single new rows:
  `PASS`.
- UTF-8, LF-only, no-BOM, final-newline, and trailing-whitespace checks for all
  seven files: `PASS`.
- baseline ProjectCreator source, focused test, manifest model/schema,
  materializer tool, runtime, test, schema, tool, and UI diff checks:
  unchanged.
- staged files: none.
- design ZIP: deliberately not read, extracted, or modified; no command in this
  repair targeted it, and its pre-existing `_incoming` scratch root showed no
  new status category.

## Audit state

This seven-file diff is unstaged and awaits independent Claude audit under
`recovery / evidence-recheck`. Codex issues no acceptance verdict and claims
no accepted, audited, committed, pushed, or Wizard V2 implementation state.
