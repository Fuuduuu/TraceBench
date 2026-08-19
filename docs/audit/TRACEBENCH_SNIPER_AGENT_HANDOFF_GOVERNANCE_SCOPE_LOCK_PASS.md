# TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS

Status: `REVIEW_REQUIRED`

## Pass identity

```text
PASS_ID: TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS
Lane: A
Mode: SCOPE_LOCK / DOCS_ONLY / PHASE_1
Baseline: 496bae2eb3aed7de8f2b47cc5e4a352cc30707fc
```

This artifact reserves one exact two-file governance child. This Phase 1
solves only the missing live PASS_ID/write authority reported by the
independent audit of a pre-existing foreign draft. It does not edit, accept,
ratify, stage, or discard that draft and does not implement the future child.

## Live baseline and route evidence

Read-only Git verification established:

- repository: `C:\dev\TraceBench`;
- branch: `main`;
- `HEAD == origin/main ==
  496bae2eb3aed7de8f2b47cc5e4a352cc30707fc`;
- parent: `b5096c2790851bd32e215fd4f7660a71f6b7510e`;
- subject: `docs: refresh single router lifetime code maps`;
- divergence: `0 0`;
- cached paths: `0`; and
- unmerged paths: `0`.

The committed predecessor
`TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS` is accepted at
that baseline and routes to the non-executable `NEEDS_USER_DECISION` sentinel.
The human's explicit selection replaces only that sentinel with this scope and
its one conditional child:

```text
TRACEBENCH_SINGLE_ROUTER_LIFETIME_CODE_MAP_MAINTENANCE_PASS
   [accepted and committed at 496bae2]
-> TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS
-> TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_IMPL_PASS
   [conditional on accepted/pushed scope]
-> NEEDS_USER_DECISION [non-executable]
```

No previous allowlist is inherited.

## Exact Phase-1 material set

This scope may author exactly:

1. `docs/ACTIVE_SCOPE_LOCK.md`
2. `docs/CURRENT_STATE.md`
3. `docs/PASS_QUEUE.md`
4. `docs/AUDIT_INDEX.md`
5. `docs/audit/TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS.md`

No sixth path is authorized. The allowed operations are limited to reconciling
the three route-owner tops, adding one neutral `REVIEW_REQUIRED` ledger row,
and creating this artifact with one named empty verdict block.

## Foreign-draft freeze

At entry, the only substantive working-tree diff was an unauthorized
governance draft in:

1. `AGENTS.md`
2. `docs/PROMPTING_PROTOCOL.md`

Both files are foreign to the five-path scope material set and remain
read-only. The following attestation measures the exact working-tree file
bytes, not Git blobs, normalized text, or rendered characters.

Hash command:

```powershell
Get-FileHash -Algorithm SHA256 -LiteralPath <path>
```

Length command:

```powershell
[System.IO.File]::ReadAllBytes(
  (Resolve-Path -LiteralPath <path>)
).Length
```

| Frozen foreign path | Entry SHA-256 over exact file bytes | Entry byte length |
| --- | --- | ---: |
| `AGENTS.md` | `8263DF1EF48995B83A70319CB1CB4A1CA633A121E3E6E6372252EBDAEB1A0821` | 7638 |
| `docs/PROMPTING_PROTOCOL.md` | `FA0EA721B0193A20F53365C95A5F0FF6256683935E92AFC8507E1190446E1B03` | 23285 |

The same commands must return the same values after all scope writes and
validation. The total substantive worktree may therefore contain seven paths:
the two unchanged foreign paths plus the exact five authored scope paths.
Only the latter five are this pass's material and possible later staging set.

Known `windows/flutter/generated_plugin_registrant.cc`,
`windows/flutter/generated_plugin_registrant.h`, and
`windows/flutter/generated_plugins.cmake` EOL/stat residue has no substantive
content diff and remains untouched.

## Independent draft-audit disposition

The supplied independent audit found:

1. `MEDIUM`: `AGENTS.md` can imply that `CLAUDE_SNIPER_PACKET` replaces the
   binding `CLAUDE_AUDIT_PACKET`.
2. `MEDIUM`: `AGENTS.md` makes map-first unconditional, conflicting with the
   Audit Contract's exact-diff-first audit execution rule.
3. `MEDIUM`: the two-file draft had no live PASS_ID/write authority.
4. `LOW/NIT`: tool-skill and optional-photo-warning wording.

This scope resolves item 3 only. The future child must resolve items 1 and 2.
Item 4 is nonblocking and explicitly excluded. No current draft wording is
accepted merely because it is quoted, hashed, or reserved for later work.

## Reserved child and exact future allowlist

```text
PASS_ID: TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_IMPL_PASS
Lane: A
Mode: DOCS_ONLY / AGENT_WORKFLOW
```

The child's exact write allowlist is:

1. `AGENTS.md`
2. `docs/PROMPTING_PROTOCOL.md`

No third child path, new file, deletion, rename, move, map, map-index, audit
contract, charter, runtime, test, package, asset, schema, tool, generated, or
platform write is reserved. The child activates only after:

1. independent audit accepts this exact five-path scope;
2. the returned verdict explicitly authorizes the bounded recording below;
3. that verdict is recorded in only the two designated logical coordinates;
4. the freeze proof confirms no other byte moved; and
5. the human stages, commits, and pushes exactly the accepted five scope paths.

The existing foreign draft may then be reused as input, but its content must be
judged and corrected under the child rather than treated as pre-accepted.

## Locked child outcome — AGENTS.md

The child must leave `AGENTS.md` with all of these invariants:

1. Repository identity uses `C:\dev\TraceBench`.
2. The five mandatory owner files remain full reads in their existing order.
3. The default bounded-pass sequence is:
   mandatory five -> task-specific map or canonical owner -> exact diff and
   exact symbol/responsibility zones.
4. Handoff construction and audit execution are explicit, distinct phases:
   Codex uses map-first responsibility bounding when constructing the handoff;
   Claude begins audit execution with the exact diff as primary evidence under
   `docs/AUDIT_CONTRACT.md`.
5. `CLAUDE_SNIPER_PACKET` accompanies the binding
   `CLAUDE_AUDIT_PACKET`. It never replaces, competes with, or acts as a second
   canonical audit header.
6. Independent Claude audit means independently verify, not rediscover.
7. Large whole-file or broad repository/architecture reads are not the
   default. Expansion requires a named failed anchor, stale/conflicting map,
   unresolved exact caller/symbol closure, material-set mismatch,
   evidence/validation conflict, or concrete potential blocker/finding.
8. Expansion proceeds one dependency hop at a time with the reason stated.
9. SNIPER discipline cannot widen an active allowlist or outrank
   `docs/POHIKIRI.md`, `docs/ACTIVE_SCOPE_LOCK.md`, source/tests,
   `docs/AUDIT_CONTRACT.md`, or
   `docs/code_maps/CODE_MAP_STANDARD.md`.

The text must stay compact and must not add another mandatory default-read
document or parallel workflow layer.

## Locked child outcome — PROMPTING_PROTOCOL.md

The child must leave `docs/PROMPTING_PROTOCOL.md` with these invariants:

1. `docs/AUDIT_CONTRACT.md` remains the sole audit-contract owner and sole
   owner of the canonical `CLAUDE_AUDIT_PACKET` header, verdict fields, and
   recording sequence.
2. `CLAUDE_SNIPER_PACKET` is only a compact, non-verdict optimization payload
   accompanying the required canonical packet. It is not a new gate, schema
   owner, audit header, verdict format, or authority source.
3. The compact payload defines:
   - `AUDIT_MODE: SNIPER / VERIFY_NOT_REDISCOVER`;
   - `AUTHORITY`;
   - `EXACT_MATERIAL_SET`;
   - `READ`;
   - `DO_NOT_READ_BY_DEFAULT`;
   - `VERIFY_INDEPENDENTLY`;
   - `EXACT_SYMBOL_ZONES`;
   - `DIRECT_COMMANDS`;
   - `EXPAND_ONLY_IF`;
   - `EXPANSION_RULE`; and
   - `RETURN`.
4. Handoff construction is map-first responsibility bounding.
5. Audit execution is exact-diff-first primary evidence.
6. Expansion is one dependency hop at a time with a stated reason and only
   after a named contradiction, failure, mismatch, conflict, or concrete
   potential blocker.
7. The payload cannot widen authority, replace the canonical packet, or
   outrank canonical repository owners.

Compact frozen-area information may be conveyed inside the optimization
payload, but it must not become a competing mandatory document, verdict
schema, or new authority layer.

## Exact child validation and acceptance

The child must:

- run formatting/whitespace checks on the exact two docs as applicable;
- run `py -3 tools/doctor.py` and `py -3 tools/validate_all.py`;
- run `git diff --check` and `git diff --cached --check`;
- prove its exact material set is only `AGENTS.md` and
  `docs/PROMPTING_PROTOCOL.md`;
- prove cached and unmerged sets are empty and the three route owners still
  point to the child during execution;
- prove `docs/AUDIT_CONTRACT.md`,
  `docs/code_maps/CODE_MAP_STANDARD.md`, `docs/POHIKIRI.md`, runtime, tests,
  maps/index, Windows substantive content, and every other frozen path are
  unchanged;
- prove the canonical packet relationship and map-first versus
  exact-diff-first distinction through exact text anchors; and
- receive independent Claude audit before any exact human staging.

Manual smoke is `NOT_APPLICABLE`. The child returns the route to
`NEEDS_USER_DECISION` and does not reserve a cleanup, reconciliation, or
additional process pass.

## Inspect-only owners and frozen boundaries

Task-specific governance review used:

- `docs/AUDIT_CONTRACT.md` for the canonical packet, diff-first auditor rule,
  verdict recording, and `scope-lock-post-audit` contract;
- `docs/PROMPTING_PROTOCOL.md` as frozen foreign input and future owner of the
  optimization payload;
- `docs/MODEL_ROUTING.md` for Codex -> Claude -> human Lane A ownership;
- `docs/PASS_LIFECYCLE.md` for conditional child activation; and
- `docs/CODEX_TOOLING_POLICY.md` for the three-skill inventory and
  external-tool default-off policy.

All are inspect-only in this Phase 1. `docs/AUDIT_CONTRACT.md` and
`docs/code_maps/CODE_MAP_STANDARD.md` remain byte-frozen in the child.
`docs/POHIKIRI.md` remains canonical. Runtime, tests, code maps/index,
implementation architecture, product IA, writers, events, facts, evidence,
freshness, Project ZIP, protected semantics, packages, assets, schemas, tools,
generated files, Windows content, `_incoming`, and scratch remain frozen.

`CODE_MAP_PREFLIGHT: NOT_APPLICABLE` because this pass and its reserved child
change only governance Markdown and do not target or materially depend on Dart
production/test files.

## Phase-1 validation contract

Run:

```text
py -3 tools/doctor.py
py -3 tools/validate_all.py
git diff --check
git diff --cached --check
git diff --name-status
git status --short --branch
```

Also prove:

- exactly five authored scope paths relative to the captured two-path foreign
  pre-state;
- exactly seven total substantive worktree paths: two unchanged foreign paths
  plus those five scope paths;
- unchanged foreign SHA-256 values and byte lengths;
- empty cached and unmerged sets;
- empty substantive diffs for `lib`, `test`, `docs/code_maps`, and `windows`;
- matching Current/Next tuples across the three route owners;
- one unique neutral `REVIEW_REQUIRED` ledger row;
- exactly one marker pair with a whitespace-only interior;
- manual smoke `NOT_APPLICABLE`; and
- no false audit, acceptance, safety, staging, commit, or push claim for this
  scope.

## Bounded Phase-2 recording authority

An independent `scope-lock-post-audit` result may authorize exactly two logical
coordinates:

1. the whitespace-only interior of the uniquely marked verdict block at the
   end of this artifact;
2. the Status cell of this PASS_ID's existing row in
   `docs/AUDIT_INDEX.md`.

Only the returned `AUDIT_VERDICT`, `SAFE_FOR_STAGING`, exact
`SAFE_STAGING_SET`, and `PHASE_2_RECORDING_AUTHORIZATION` may be copied into
those coordinates. The expected accepted staging set is the exact five Phase-1
paths above and excludes both frozen foreign draft paths.

Every artifact-exterior byte, ledger Description byte, route-owner byte,
foreign draft byte, and other repository byte is frozen during Phase 2.

## Stop conditions

Stop if:

- either foreign hash or byte length changes during this scope;
- a sixth scope path or third child path is needed;
- the child requires `docs/AUDIT_CONTRACT.md`, the Code Map Standard,
  `docs/POHIKIRI.md`, or another authority to change;
- the canonical packet relationship or diff-first execution rule cannot be
  preserved;
- the route cannot reconcile cleanly from the committed sentinel;
- runtime, test, map/index, Windows, product, or protected content changes;
- validation or the empty-verdict/neutral-ledger proof fails; or
- any stage, commit, push, reset, restore, stash, clean, discard, delete, or
  normalization action occurs.

## TOOL_SKILL_CHECK

- Relevant capability found: loader-qualified `tracebench-scope-lock` and
  `tracebench-prompt-authoring`; Git, `rg`, `tools/doctor.py`, and
  `tools/validate_all.py`.
- Capability used: `tracebench-scope-lock` for exact current/future authority,
  allowlists, lifecycle, boundaries, validation, and stops; prompt authoring
  only for the genuine post-change Claude audit handoff.
- Why applicable: the immediate executable work is a docs-only reservation of
  one exact future governance child and produces a real five-path diff for
  independent audit.
- External tool required: `NO`.

`tracebench-audit-reconciliation` is not applicable because no pushed audit
artifact is being reconciled. No skill or helper expanded either allowlist.

## MODEL_ROUTING_CHECK

`MODEL_ROUTING_CHECK result: PASS`. Lane A ownership is Codex for this bounded
scope, Claude Code for independent `scope-lock-post-audit` verification, and
the human for any authorized verdict recording decision plus exact staging,
commit, and push.

## SELF_REFERENCE_AUDIT

- This artifact and its ledger row use neutral `REVIEW_REQUIRED` status.
- The designated verdict-block interior is empty.
- No touched artifact, ledger row, or route owner records an audit verdict,
  staging-safety result, or acceptance for this scope.
- Child activation is conditional and time-invariant.
- The accepted predecessor is identified by committed Git and ledger evidence;
  this scope is not described as accepted, staged, committed, or pushed.
- Entry Git and foreign-byte observations are labelled as entry evidence.
- Historical route sections are explicitly non-authorizing.

## Independent audit focus

Apply `scope-lock-post-audit` from `docs/AUDIT_CONTRACT.md` to the exact five
scope paths. Verify the live baseline and route, the captured two-file foreign
freeze, the five-versus-seven material distinction, the one-child/two-path
reservation, the exact packet relationship and construction/execution
distinction, the excluded low/NIT findings, canonical owner precedence,
validation evidence, empty verdict block, neutral ledger row, and the bounded
two-coordinate recording authority.

<!-- TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS_VERDICT_BLOCK_BEGIN -->

AUDIT_VERDICT: ACCEPT_AS_IS
SAFE_FOR_STAGING: YES

SAFE_STAGING_SET:
- docs/ACTIVE_SCOPE_LOCK.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS.md

PHASE_2_RECORDING_AUTHORIZATION: YES

<!-- TRACEBENCH_SNIPER_AGENT_HANDOFF_GOVERNANCE_SCOPE_LOCK_PASS_VERDICT_BLOCK_END -->
