# TRACEBENCH_AGENT_ORIENTATION_PASS

Status: `PRE-AUDIT SNAPSHOT` — the exact nine-file Lane A docs-sync diff is
unstaged and awaits independent Claude audit; no verdict, staging safety, safe
staging set, commit, or push is claimed.

PASS_ID: `TRACEBENCH_AGENT_ORIENTATION_PASS`

Lane: `A`

Mode: `DOCS_SYNC`

## Purpose

Make the established five-file TraceBench protocol reachable through two
compact, non-authorizing entry points:

- auto-loaded `CLAUDE.md` for Claude Code
- pasteable `docs/PROJECT_MINI_MAP.md` for an assistant without repo access

This pass changes discoverability and current governance routing only. It does
not change the five-file default set, product behavior, implementation, or any
protected surface.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: the three loader-qualified repo-local
  skills at `.agents/skills/**`, with inventory owned by
  `docs/CODEX_TOOLING_POLICY.md`; `tracebench-prompt-authoring` applies to the
  post-change audit handoff, and `tracebench-code-map-lifecycle` does not exist
- capability actually used: `tracebench-prompt-authoring` for the real
  post-change Claude packet, plus direct allowlist-bound documentation edits,
  repository governance owners, Git evidence, and `tools/validate_all.py`
- why applicable: no repo-local skill owns an immediate orientation/docs-sync
  pass; `tracebench-scope-lock` is not applicable because this pass reserves no
  future route or successor, while `tracebench-prompt-authoring` applies only
  to the real post-change Claude audit handoff
- external tool required: `NO`

## CODE_MAP_PREFLIGHT

`not applicable`. No Dart production or test file is targeted or materially
depended on. Both maintained Wizard maps and `docs/code_maps/CODE_MAP_INDEX.md`
remain untouched.

## Authority basis

The explicit human route decision selected this pass from the non-executable
`NEEDS_USER_DECISION` sentinel.

The repo-local precedent in
`docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS.md`
records under `## MODEL_ROUTING_CHECK` that the lifecycle enters a scope node
from a human route/backlog decision and no prior allowlist can self-authorize
the successor. That same entry condition applies here.

The verified baseline is:

- HEAD, local `main`, local `origin/main`, and live `refs/heads/main`:
  `3e7ba9e97b5b45af158b8d7922915065d7677273`
- subject: `docs: reconcile New Project Wizard code map audit evidence`
- parent: `3e5edad0956c852584543bc643ca7306caee9e8e`
- baseline commit set: exactly the existing Wizard artifact and its ledger row
- normalized tracked and cached diffs: empty

## Spent Wizard authority

The existing Wizard artifact records:

1. independent map-to-code audit complete
2. both map and index states promoted to `MAINTAINED`
3. final eight-file diff audit `ACCEPT_AS_IS` with
   `SAFE_FOR_STAGING: YES`
4. exact staging, commit, and push complete at
   `3e5edad0956c852584543bc643ca7306caee9e8e`

That superseding evidence was reconciled and pushed at the baseline
`3e7ba9e97b5b45af158b8d7922915065d7677273`. This pass records in the active
lock that the former eight-file authority is spent and grants no later writes.
It creates no closeout, route-release, ceremony, or pointer-reset pass.

## Exact nine-file boundary

This pass changes exactly:

- `CLAUDE.md`
- `docs/PROJECT_MINI_MAP.md`
- `AGENTS.md`
- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AGENT_ORIENTATION_PASS.md`

No other file is authorized.

## Orientation content

`CLAUDE.md` is 11 physical lines. It contains only one repo-identity line, the
instruction to read `AGENTS.md` and its exact five-file default set, the
live-only never-infer-state rule, and a pointer to `AGENTS.md` Git discipline.
It copies no routing table, protected-surface list, scratch list, or default-set
contents.

`docs/PROJECT_MINI_MAP.md` is 56 physical lines. It removes the stale Mermaid
diagram and provides:

- the exact five-file default set
- the live-only state rule for route, PASS_ID, allowlist, HEAD, divergence,
  staging, validation, and test counts
- the full `docs/MEMORY_REGISTRY.yml` conflict order
- compact task-specific routing
- the existing AI/OCR/fault-probability/source-search fast stop

## Pointer and ownership changes

`AGENTS.md` now names both orientation files without adding them to the default
read set. Its capability preflight names `.agents/skills/**` and
`docs/CODEX_TOOLING_POLICY.md` as inventory owner.

`docs/FILE_MAP.md` receives exactly three ownership rows:

- `CLAUDE.md`
- `docs/PROJECT_MINI_MAP.md`
- `.agents/skills/**`

No other ownership or loading row changes.

## Route and current authority

All three operational owners now read:

- Current: `TRACEBENCH_AGENT_ORIENTATION_PASS`
- Next: `NEEDS_USER_DECISION`

The active lock contains the exact nine-file current allowlist. The next
sentinel is non-executable, reserves no successor, and requires a later explicit
human decision.

## Scope restraint

This pass deliberately does not repair:

- the remaining stale pre-audit and Board Canvas ledger rows
- the unindexed Board Canvas and audit-index compaction artifacts
- the other unrouted documents owned by the routing/docs-hygiene locks

It changes no Dart, test, schema, tool, asset, ZIP, runtime, `_incoming`,
`.agents/skills/**`, product behavior, implementation authority, or protected
surface.

## Fresh validation evidence

- `py -3 tools\validate_all.py`: environment limitation, exit `1`. The runner
  discovered and ran all `302` tests in `18.464s`, then reported `158` errors
  dominated by sandbox `PermissionError` failures while writing repo-local
  `.codex/*.json` fixtures and operating-system temporary paths. This result
  supplies no repository or test-suite verdict and is not reported as a pass.
- User-supplied real-host parent reference for accepted baseline `3e7ba9e`:
  exit `0`, `302` tests, `[OK] validate_all.py PASSED`, verified six times.
  This is historical parent evidence supplied by the human, not current Codex
  validation of this nine-file diff.
- `git diff --check`: pass.
- `git diff --cached --check`: pass; the index is empty.
- Focused structural verification: pass. The content boundary is exactly the
  nine allowlisted files; `CLAUDE.md` is `11` physical lines;
  `docs/PROJECT_MINI_MAP.md` is `56` physical lines and reproduces the exact
  five-file default set plus all `23` conflict-order entries; `docs/FILE_MAP.md`
  adds exactly three ownership rows; `docs/AUDIT_INDEX.md` adds exactly one
  ledger row; the three route owners agree; and no runtime, test, tool, schema,
  asset, or `_incoming` content changed.

## Audit state

Independent Claude audit has not run on this orientation diff. This pass stops
unstaged and uses `docs/AUDIT_CONTRACT.md` `recovery / evidence-recheck` for its
post-change audit packet.

## Superseding audit evidence reconciliation — 2026-07-27

Reconciliation PASS_ID:
`TRACEBENCH_AUDIT_EVIDENCE_RECONCILIATION`

Lane: `A`

Mode: `DOCS_SYNC / AUDIT_RECONCILIATION`

This labelled section preserves the complete draft-time body above as temporal
evidence and supersedes only its former current-state conclusions with the
returned audit and pushed Git evidence below. It creates no sibling artifact,
rewrites no historical body, and changes neither route nor authority.

### TOOL_SKILL_CHECK

- relevant skill/tool/helper found:
  `tracebench-audit-reconciliation`, Git object evidence, and
  `tools/validate_all.py`
- capability actually used: the repo-local reconciliation sequence, exact
  byte-slice hashing, focused table-cell reconstruction, and Git verification
- why applicable: the independently audited orientation pass is pushed while
  its existing artifact, ledger cell, and two route-owner statements retain
  draft-time audit/staging claims
- external tool required: `NO`

### CODE_MAP_PREFLIGHT

`not applicable`. No Dart production or test file is targeted or materially
depended on; every code map and `docs/code_maps/CODE_MAP_INDEX.md` remains
unchanged.

### Returned orientation audit

The human supplied these exact results from the independent audit of the
complete nine-file orientation diff:

```text
AUDIT_VERDICT: PASS
SAFE_FOR_STAGING: YES
SAFE_STAGING_SET:
- CLAUDE.md
- docs/PROJECT_MINI_MAP.md
- AGENTS.md
- docs/FILE_MAP.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_AGENT_ORIENTATION_PASS.md
FINDINGS:
- LOW — docs/PROJECT_MINI_MAP.md reproduces 33 of its 56 lines from two
  canonical owners (23-entry conflict order from docs/MEMORY_REGISTRY.yml,
  plus the task-routing table). It matches the registry exactly today, but no
  sync obligation is recorded anywhere, creating an untracked drift surface.
  Mitigated by the card's own line 2. Deferred to the routing lock, which owns
  docs/MEMORY_REGISTRY.yml.
```

### Independent post-push evidence recheck

The independent evidence recheck of
`3e7ba9e97b5b45af158b8d7922915065d7677273..d9fd44684e8b15239aadd16b8e348e358258cf3c`
records:

- commit: `d9fd44684e8b15239aadd16b8e348e358258cf3c`
- parent: `3e7ba9e97b5b45af158b8d7922915065d7677273`
- subject: `docs: add agent orientation entry points`
- committed stat: 9 files, 380 insertions, 234 deletions
- committed set: identical to the returned nine-file safe staging set
- `docs/FILE_MAP.md`: exactly `+3/-0`
- `docs/AUDIT_INDEX.md`: exactly `+1/-0`
- `docs/PROJECT_MINI_MAP.md`: 56 physical lines
- forbidden implementation/input/skill surfaces touched: none
- all three route owners:
  `TRACEBENCH_AGENT_ORIENTATION_PASS` -> `NEEDS_USER_DECISION`

### Push completion and role deviation

Git and human-supplied session evidence record that Claude Code performed the
independent audit and then staged, committed, and pushed under explicit human
delegation. The staging command named exactly the nine accepted files:

```text
git add CLAUDE.md docs/PROJECT_MINI_MAP.md AGENTS.md docs/FILE_MAP.md docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/TRACEBENCH_AGENT_ORIENTATION_PASS.md
```

No `git add .` or `git add -A` was used. This is the second recorded occurrence
of Claude Code combining the auditor and executor roles under explicit human
delegation; the Wizard code-map gate was the first. It is a deviation from the
default role separation in `AGENTS.md` and `docs/MODEL_ROUTING.md`, not a
precedent or a change to those owners.

### Byte-preservation proofs

All hashes below use SHA-256 over the stated raw UTF-8 byte slice, without BOM
or newline normalization.

- This artifact's original lines 3-5: hash the bytes beginning with `Status:`
  and ending with `claimed.`, including the two internal LF bytes and excluding
  the following LF. Length `197` bytes; SHA-256
  `22029f485ea11ca4b7eff5abf1df0ae68c11dfed72350e1f38c42c59f823266a`.
- Wizard artifact preserved prefix: in the `d9fd446` blob, hash every byte from
  offset `0` up to but excluding the first byte of `The current two-file
  reconciliation is unstaged, uncommitted, unpushed, and`; in the edited file,
  use the same range ending immediately before `The two-file reconciliation
  was independently audited`. Length `20723` bytes; both SHA-256
  `3a326fa0803890d664f7d2e22e271be9c035450973e36a28a949effe760cf466`.
- Wizard artifact preserved suffix: in the `d9fd446` blob, hash every byte
  immediately after the period in `not yet independently audited.` through
  EOF; in the edited file, use the range immediately after the period following
  commit `3e7ba9e97b5b45af158b8d7922915065d7677273` through EOF. Length `182`
  bytes; both SHA-256
  `6f1b03c4557ae85a004e96449e24d63f746e3f6f105bf234c83a1fce8e39b0ef`.
- Ledger description algorithm: split the unique Markdown row on literal `|`
  bytes and hash the fifth segment, including its leading and trailing spaces
  but excluding delimiter pipes and the line ending.
- Orientation description: `552` bytes; before/after SHA-256
  `2028cd3293ef885bba6a0fa6397b0223c59c368c0a1811b96ce13c487a3b1b99`.
- Wizard description: `449` bytes; before/after SHA-256
  `1321ce92099eae265f72daf5734799c41d92b029b7cf0e62d8ab08918259aab3`.

### Superseded claims and route

- The original orientation Status and `## Audit state` remain byte-preserved
  draft-time evidence and are superseded by the returned audit and pushed
  commit evidence above.
- The Wizard reconciliation sentence now records its returned `PASS` /
  `SAFE_FOR_STAGING: YES` result and pushed commit rather than its former
  draft-time pipeline position.
- Only the two affected `docs/AUDIT_INDEX.md` Status cells carry later audit
  and pushed-commit evidence; both Description cells remain byte-identical.
- `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md` replace only their obsolete
  orientation audit/staging claims with the verified pushed state.
- Current remains `TRACEBENCH_AGENT_ORIENTATION_PASS`; Next remains
  `NEEDS_USER_DECISION`.
- `docs/ACTIVE_SCOPE_LOCK.md` remains byte-identical at SHA-256
  `393aed6c9da3802eeaa7e2f9b249a386578cd79f917273478993545ecc12c4c2`.

### Exact reconciliation boundary

The content delta is limited to:

- `docs/audit/TRACEBENCH_AGENT_ORIENTATION_PASS.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`

No sibling artifact, new ledger row, other audit row, active-lock content,
code map, Dart, test, schema, tool, asset, ZIP, runtime, `_incoming`, or
protected-surface content is changed.
