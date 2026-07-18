# TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Form: compact
- Mode: docs-only active-lock sync; no implementation
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Route at gate: `TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Route after sync: `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS` ->
  `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_POST_AUDIT_PASS`

This pass synchronizes accepted Batch A authority into the operational route.
It creates or edits no skill, policy, implementation artifact, evaluator
harness, pressure evidence, stage, commit, or push.

## Tool and skill check

`TOOL_SKILL_CHECK`:

- Relevant capability found: `androbuss-pass-runner`, Git, `rg`, PowerShell,
  and `tools/validate_all.py`; no repo-local lifecycle skill owns active-lock
  sync.
- Capability used: pass-runner gate and exact-allowlist discipline plus local
  mechanical validation.
- Applicability: the accepted architecture keeps active-lock sync as a
  canonical pass contract. The stale substring trigger in
  `tracebench-scope-lock` does not apply from PASS_ID ancestry;
  `tracebench-docs-closeout`, `tracebench-safe-staging`, Flutter, and V2 skills
  are not triggered. `tracebench-prompt-authoring` and
  `tracebench-audit-reconciliation` do not yet exist.
- External tool required: `NO`.

No capability expands this exact five-file docs authority.

## Model routing and code-map checks

`MODEL_ROUTING_CHECK result: PASS` — Lane A routes this docs-only sync through
Codex, then independent Claude Code audit before exact human staging. No GPT,
design, research, plugin, download, or installation route is required.

`CODE_MAP_PREFLIGHT: NOT_APPLICABLE` — governance Markdown only; no Dart
source or test dependency exists.

## Verified baseline and accepted scope chain

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main ==
  e1126bd3062a0c471750c39d7dbc675f6a8ddb97`
- Subject: `docs: record repo skills batch A scope audit`
- Direct parent: `043f1f6ec90622fe7c0629a3c46fed2f1355ca8f`
- Initial tracked diff: empty.
- Initial cached diff: empty.
- Initial `git diff --check`: PASS.

Commit `e1126bd3062a0c471750c39d7dbc675f6a8ddb97` contains exactly:

- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS.md`

The accepted scope lock is
`043f1f6ec90622fe7c0629a3c46fed2f1355ca8f`
(`docs: lock repo skills batch A scope`), with direct parent
`214cc91bf1595c9463e1ef7796c697d0a40bc536` and exact committed set:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS.md`

Claude returned `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; blockers none; one
deferred non-blocking `docs/PASS_QUEUE.md` paragraph-spacing nit. The scope
row and existing artifact are reconciled at the current baseline.

## Exact sync write authority

This sync writes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

No sixth path or wildcard is authorized.

## Route and activated implementation authority

After this sync is independently audited, accepted, exactly committed, and
pushed, the operational route is:

- Current: `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS`
- Next: `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_POST_AUDIT_PASS`

The next PASS_ID records lifecycle sequencing only and authorizes no future
file. The implementation pass may then write exactly:

- `.agents/skills/tracebench-prompt-authoring/SKILL.md`
- `.agents/skills/tracebench-scope-lock/SKILL.md`
- `.agents/skills/tracebench-audit-reconciliation/SKILL.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS.md`

No optional file, fixture, harness, helper, supporting file, sixth path, or
wildcard is active.

## Inherited Batch A contract and stops

The architecture spec remains the decision owner. The active lock incorporates
the accepted Batch A contract; detailed evidence is recorded in the accepted
scope-lock artifact. Batch A contains only new `tracebench-prompt-authoring`,
`tracebench-scope-lock` as `formalize/rewrite`, and new
`tracebench-audit-reconciliation`.

All three use YAML `name` and trigger-only third-person `description`, matching
lowercase-hyphen directory/name, concise pointer-based bodies, and strict
non-authorization. Implementation requires genuine serialized per-skill
RED/GREEN evidence. RED precedes each new skill; the scope-lock rewrite RED
uses its committed baseline skill. GREEN must preserve the same task, model,
reasoning, and fixture while ordinary skill discovery is demonstrated. No
workflow injection, permanent harness, supporting file, or fabricated evidence
is allowed.

Stop with `BLOCKED_PRESSURE_TEST_CAPABILITY` if genuine evaluation is
unavailable and `BLOCKED_PRESSURE_TEST_CONTRACT_GAP` if the paired contract
cannot be preserved. Generic/personal extraction remains excluded and
external tooling remains default-off.

## Inspect-only and excluded surfaces

Canonical charter, route, audit/index, prompt/model/audit/lifecycle, protected,
architecture, accepted scope, and sync owners are inspect-only during
implementation. All non-allowlisted existing skills are inspect-only.

Batch B/C/D, `tracebench-code-map-lifecycle`, other skills or docs,
generic/personal extraction, Markdown compaction, Photo-to-Canvas,
`lib/**`, `test/**`, `tools/**`, validators, schemas, packages, assets,
`_incoming`, code maps, runtime, writers, events, facts, projections, Project
ZIP, and protected semantics remain excluded.

Known scratch remains preserved and unstaged. Neither this sync nor the future
implementation gains staging, commit, or push authority from this artifact.

## PASS_QUEUE nit disposition

The deferred spacing nit was not an independent cleanup goal. The mandatory
semantic replacement of the old “unarmed implementation” state with active
implementation state naturally superseded the joined paragraph; no additional
cosmetic-only hunk was created.

## Audit-index record

This pass adds exactly one `DRAFTED / PENDING CLAUDE AUDIT` row for its own
PASS_ID. It adds no implementation row and preserves every previous index line
byte-identically.

## Validation record

- `python tools/validate_all.py`: PASS on the required unchanged rerun outside
  the managed sandbox; 285 tests ran, zero failures, exit 0. The first sandbox
  attempt produced 148 environment-only permission errors while writing repo
  `.codex` outputs and Windows temporary files.
- `git diff --check`: PASS, with working-copy LF-to-CRLF notices only.
- Final task set: exactly the four modified route/index files plus this one new
  audit artifact, matching the five-file sync authority.
- `git diff --cached --name-status`: empty.
- All three route owners agree on
  `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS` ->
  `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_POST_AUDIT_PASS`.
- The exact five-file sync and implementation allowlists match between
  `docs/ACTIVE_SCOPE_LOCK.md` and this artifact.
- `docs/AUDIT_INDEX.md`: one exact insertion; the prompt-defined non-separator
  row count changed 746 -> 747 and the physical line count changed 763 -> 764.
  There is one anchored sync row, zero anchored implementation rows, no glued
  row, and every prior line is byte-identical.
- The accepted scope-lock row and artifact remain unchanged.
- All five existing skill hashes remain unchanged; both new skill directories
  and the implementation artifact remain absent.
- `docs/CODEX_TOOLING_POLICY.md` and the architecture spec remain unchanged.
- No RED/GREEN or implementation result is claimed or fabricated.
- The known 94-file, 43,936,062-byte scratch snapshot remains unchanged after
  excluding this authorized new artifact.
- `HEAD == origin/main ==
  e1126bd3062a0c471750c39d7dbc675f6a8ddb97`; HEAD is unchanged.
- Nothing is staged, committed, or pushed.

This artifact remains `DRAFTED / PENDING CLAUDE AUDIT`; validation grants no
implementation, staging, commit, or push permission.
