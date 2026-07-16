# TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_POST_AUDIT_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only governance closeout
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Current after closeout: `NEEDS_USER_DECISION`
- Next after closeout: `NEEDS_USER_DECISION`

This pass records and closes the accepted code-map prompting integration chain.
It changes operational/audit Markdown only, releases the docs-only amendment
authority, and arms no follow-up work.

## Baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == f5c34dc776ec1380c13c47053b0ff535e25ad1fa`
- Subject: `docs: integrate code maps into prompting governance`
- Verified parent: `7dd21a13f77f6e663d8e04de968043c67b3ec5be`
- Initial tracked diff: empty.
- Initial cached diff: empty.
- Initial `git diff --check`: PASS.
- Only known untracked scratch/design files were present; they remain outside
  scope and untouched.

The amendment commit is the direct successor of the scope-audit reconciliation
and contains exactly the accepted five-owner set. The live queue and scope
artifact explicitly route the accepted amendment to this closeout without an
active-lock sync, so no governance conflict was found.

## Tool, skill, and code-map preflight

`TOOL_SKILL_CHECK`:

- Relevant skill/tool/helper found: YES — repo-local
  `.agents/skills/tracebench-docs-closeout/SKILL.md`,
  `androbuss-pass-runner`, `verification-before-completion`, Git scope/commit
  checks, focused ledger assertions, and `tools/validate_all.py`.
- Capability actually used: the repo-local closeout workflow as the narrowest
  owner, with pass-runner gate enforcement and fresh completion verification.
- Why applicable: this pass must reconcile one accepted chain into exactly
  four operational/audit-index documents plus one new closeout artifact,
  synchronize three route owners, preserve forbidden surfaces, and verify the
  final unstaged diff.
- External tool required: NO.

`CODE_MAP_PREFLIGHT`: `NOT_APPLICABLE` — this closeout targets operational and
audit Markdown and neither targets nor materially depends on Dart
production/test files.

## Accepted chain

### Scope lock

- Commit: `5a9098016efe057b8e64145117dd79778a2a5f69`
- Subject: `docs: lock code map prompting integration`
- Parent: `20b76d291fa1898da0fd4cadc0e6002b6bc9ddb8`
- Claude: `AUDIT_VERDICT: ACCEPT_AS_IS`
- Claude: `SAFE_FOR_STAGING: YES`
- Blockers: none.
- Nits: none.

The existing scope-lock audit row and reconciliation evidence remain
preserved.

### Scope-audit reconciliation

- Commit: `7dd21a13f77f6e663d8e04de968043c67b3ec5be`
- Subject: `docs: record code map prompting scope audit`
- Parent: `5a9098016efe057b8e64145117dd79778a2a5f69`
- Exact set: `docs/AUDIT_INDEX.md` and
  `docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS.md`.

### Governance amendment

- Commit: `f5c34dc776ec1380c13c47053b0ff535e25ad1fa`
- Subject: `docs: integrate code maps into prompting governance`
- Parent: `7dd21a13f77f6e663d8e04de968043c67b3ec5be`
- Claude: `AUDIT_VERDICT: ACCEPT_AS_IS`
- Claude: `SAFE_FOR_STAGING: YES`
- Blockers: none.
- Nits: none.

Exact accepted amendment set:

- `AGENTS.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/FILE_MAP.md`
- `docs/code_maps/CODE_MAP_STANDARD.md`

Git commit evidence confirms this exact set and no sixth file.

## Closed governance outcome

### Mandatory capability preflight

Every Codex `PASS_ID` prompt and final report now carries
`TOOL_SKILL_CHECK`. The narrowest applicable repo-local capability is used;
`none applicable` remains valid with evidence. External-tool reporting is
descriptive only, and capability selection never expands write authority.

### Conditional Dart code-map preflight

Implementation, repair, diagnostic, QA, refactor, or review work targeting or
materially depending on Dart production/test files now carries
`CODE_MAP_PREFLIGHT`. It records target/index/map/qualification evidence,
changed responsibility zones and stable symbols, inspect-only and excluded
zones, dependencies, blast radius with evidence classes, write class,
tests/helpers, and one map disposition. Read-only work may record
`changed responsibility zone: none` with inspected zones/symbols.

Exactly one disposition applies per relevant target:

- `REVIEWED_NO_CHANGE`
- `UPDATE_REQUIRED`
- `NOT_APPLICABLE`

Exact stop outcomes are:

- `BLOCKED_CODE_MAP_REQUIRED`
- `BLOCKED_CODE_MAP_STALE`
- `BLOCKED_CODE_MAP_CONFLICT`
- `BLOCKED_ALLOWLIST_MISMATCH`
- `DECOMPOSE_REQUIRED`

### Layered ownership

- `docs/code_maps/CODE_MAP_STANDARD.md` remains the sole detailed owner of map
  qualification, lifecycle, structure, evidence/write classes, drift,
  maintenance, SNIPER use, and map audit.
- `docs/PROMPTING_PROTOCOL.md` owns prompt/report fields and hooks.
- `AGENTS.md` owns agent routing and stop behavior.
- `docs/AUDIT_CONTRACT.md` owns independent checks.
- `docs/FILE_MAP.md` owns documentation loading and ownership routing.

### Non-authorization and loading

Maps narrow investigation only. They never authorize writes, add allowlist
files, override source/tests/canonical owners/`docs/POHIKIRI.md`/active
authority, or turn speculation and extraction seams into scope.

The default read set remains exactly five files. `CODE_MAP_STANDARD.md`,
`CODE_MAP_INDEX.md`, and source-specific maps remain task-specific and
on-demand; only an applicable maintained map supplies exact zones and impact.

### Maintenance policy

Pre-existing missing, stale, unverifiable, or conflicting required maps block
before work. `UPDATE_REQUIRED` records expected drift from proposed or accepted
source work and routes later docs-only maintenance against accepted committed
source. Unfinished local work never updates a maintained map.

## Preserved surfaces

- `docs/code_maps/CODE_MAP_INDEX.md`: unchanged.
- Existing source-specific map: unchanged.
- `docs/code_maps/CODE_MAP_STANDARD.md`: unchanged by this closeout.
- No new code map.
- No Dart/runtime/test/schema/tool/package/asset or `_incoming` change.
- No product, writer, event, fact, projection, route, or protected behavior.
- No default-read expansion.
- No automatic generator, linter, CI, hook, or watcher.
- Known scratch remains untouched.

## Route and authority release

After this closeout:

- Current: `NEEDS_USER_DECISION`
- Next: `NEEDS_USER_DECISION`

The docs-only amendment authority is released. No new code map, Board Canvas
test-file map, measurement file-lock hardening, overview retirement, runtime
implementation, active-lock sync, or protected-surface pass is armed. Any
future work requires a new human decision and an exact allowlist.

## Exact closeout write set

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_POST_AUDIT_PASS.md`

Nothing is staged, committed, or pushed.

## Validation record

- `python tools/validate_all.py`: PASS — 285 tests, `OK`.
- `git diff --check`: PASS; informational LF-to-CRLF warnings only.
- Exact closeout allowlist: PASS — four tracked operational/index edits plus
  the one new untracked closeout artifact.
- `git diff --cached --name-status`: PASS — empty.
- `git status --short --branch`: PASS — only the exact closeout set plus known
  pre-existing untracked scratch/design files.
- Amendment commit exact five-owner set: PASS.
- Default read set remains exactly five files: PASS.
- `docs/AUDIT_INDEX.md` no-glued-`||` check: PASS.
- Forbidden-path diff: PASS — empty.
- Route synchronization: PASS — all three route owners record
  `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- `HEAD == origin/main`: PASS — unchanged at
  `f5c34dc776ec1380c13c47053b0ff535e25ad1fa`.

## Audit state

This closeout remains `DRAFTED / PENDING CLAUDE AUDIT`. It records accepted
prior audit evidence but does not claim that the current five-file closeout is
safe for staging. Claude Code must independently audit the exact unstaged diff.
