# AUDIT_CONTRACT.md

Reusable TraceBench audit contracts for lean prompts. This file lets future audit prompts name a standard contract instead of pasting the full boundary list every time.

Repo docs remain canonical. Old chat memory, old uploaded snippets, and summary-only claims do not override the repository state.

## Common audit checks

Risk-based applicability: ordinary low-risk UI/docs uses one independent diff
review recorded in thread/PR/review output, then exact human commit. A new audit
artifact, ledger row, formal packet or separate verdict-recording/closeout pass
is not mandatory. Formal protected/human-requested artifacts use the recording
contract below. Existing historical records are not rewritten by this policy.

- Check the explicit compact/protected task boundary, exact changed material
  and preservation of unrelated work. A new product priority is not write authority.
- Verify canonical/data protection: writers, events, evidence, Session guards,
  materialization, migrations, user files and ZIP compatibility. Escalate real
  ambiguity; do not classify data changes as cosmetic.
- Verify current route owners agree without a self-loop. Prior evidence stays
  historical; completed passes are not reopened by implication.
- If an audit artifact is explicitly created/updated, preserve its ledger link,
  markers, prior verdicts and bounded recording contract. No mandatory new row
  or artifact is inferred for an ordinary task that uses review-output evidence.
- Do not invent acceptance/pushed state or assert an artifact's own staging/
  audit-pipeline position. Git reports staging. Generic recording policy and
  frozen historical snapshots are distinct from current-pass claims.
- Published hash/byte attestations name blob/worktree representation and the
  exact command under the attestation rules below.
- Compare actual source/tests with the changed claims; inspect named dependency
  hops only. Use maps where useful, and review material source/map drift together
  in the same authorized diff. No automatic standalone maintenance audit.
- Confirm actual validation output, classify existing warnings, and require
  human visual acceptance for changed product surfaces where applicable.
- Rank findings BLOCKER/HIGH/MEDIUM/LOW/NIT. Address material fixes in the same
  bounded review cycle, not an automatic new documentation programme.
- Only the human stages/commits/pushes exact accepted files; broad staging and
  destructive cleanup are forbidden.

Formal packets still use the canonical shape below. A packet describes an
actual diff, not a preparation answer. CLAUDE_SNIPER_PACKET is an optional
read envelope for complex reviews, not a second required audit schema.
Tool/Code Map preflight detail follows risk and PROMPTING_PROTOCOL, not a
blanket reporting obligation for every minor presentation edit.

## Verdict-recording gate: audit -> record verdict -> stage

This gate applies when a protected contract or explicit human request uses a
formal artifact and ledger. It is not the default for ordinary UI/docs work.

1. Prepare the real diff and, when that contract requires it, one empty named
   verdict block and neutral ledger row.
2. Independent review returns the verdict, safety result and exact file set;
   it may expressly authorize only the bounded mechanical recording.
3. Copy that result into the designated block and ledger Status, preserving
   Description/history and proving no bytes outside authorized coordinates move.
4. The human commits the exact accepted material. Mechanical recording may be
   the tail of the same task; no new PASS_ID, separate recording project or
   second audit is needed if the authorized content alone changes.

Explicit existing Phase 1/Phase 2 contracts retain their exact coordinates.
Other material edits need review of that changed diff, not invented acceptance.

The first validated use of the no-self-referential-lifecycle rule was
`TRACEBENCH_AUDIT_EVIDENCE_RECONCILIATION`: its mechanical
`SELF_REFERENCE_AUDIT` passed, and it required no follow-up evidence repair.

### Prospective adoption and historical snapshots

The verdict-recording and no-self-referential-lifecycle rules apply to every
artifact or ledger row created or updated by
`TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS` or a later pass.

The grandfathered set is defined by a counting method, not by a remembered
total. A record is grandfathered when its ledger `Status` cell contains the
literal `PRE-AUDIT SNAPSHOT`.

Counting method: split each pipe-prefixed table row on `|`, so field 2 is
`PASS_ID`, field 3 is `File`, and field 4 is `Status`; match the literal only
in field 4. A mention inside a `Description` cell is not a record, and a
line-scoped match that ignores the field boundary overcounts.

Applying that method at `9644e62ef9e8f81d00a3d38cff3e0606b2b93a73` returns six
records. In `docs/AUDIT_INDEX.md`:

- `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS`
- `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
- `BENCHBEEP_ROUTE_SENTINEL_RELEASE_PASS`
- `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_POST_AUDIT_PASS`

In `docs/archive/AUDIT_INDEX_ARCHIVE.md`:

- `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS`
- `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_POST_AUDIT_PASS`

The four active records are the same four rows previously described as
unreconciled. They are one population, not two. The two archived records remain
historical evidence and need no further decision.

Whether an independent audit actually ran for each active record is
undetermined in the repository; a commit or push is not evidence that it did.
Determining it needs evidence the repository does not hold, so those four rows
are owned by the non-executable `NEEDS_USER_DECISION` sentinel until an
explicit human route decision assigns them to a named executable pass. They are
not assigned to any lock that does not exist.

Two further active rows assert an unresolved audit position without carrying
the `PRE-AUDIT SNAPSHOT` label, so the method above excludes them while the
same open question applies:

- `TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_ABORT_CLOSEOUT_PASS`
- `BOARD_CANVAS_SCREEN_CODE_MAP_POST_AUDIT_PASS`

They share the `NEEDS_USER_DECISION` owner. Neither row is rewritten, because
choosing replacement wording would require inferring whether an audit ran.

The superseded total `13` was published without a recorded derivation and is
not reproducible from any committed ledger state. The artifact and ledger row
that carry it are frozen history and are not rewritten; the divergence is
registered by `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`.

## Published hash and byte-length attestations

A hash or byte length is meaningless without the byte representation it
measured. This repository checks out text with CRLF and stores it with LF, so
the same tracked file has two different valid hashes at the same time.

Every published hash or byte-length attestation must name its representation
using exactly one of:

- `blob` — the bytes Git stores, read with `git cat-file blob <rev>:<path>`;
- `worktree` — the bytes on disk after checkout filters have run.

`blob` is the required representation for any value presented as durable,
immutable, or reproducible, because it is identical in every clone regardless
of platform or checkout settings. A `worktree` value may be published only as a
local observation, and never as the anchor a future verifier is told to
reproduce.

Prefer the Git object id from `git rev-parse <rev>:<path>` as the primary
anchor for a preserved snapshot. It proves object identity directly, needs no
external hashing tool, and stays stable across normalization that does not
change stored bytes.

An attestation must also record the exact command that produced it, so the
claim is re-runnable rather than merely asserted.

When a hash is published inside a Markdown table cell, write it as a single
backtick-delimited token with exactly one space between the value and each
surrounding pipe, and never break the value across lines. A value split by a
line break or padded unevenly cannot be extracted mechanically, which is the
condition that lets an unverifiable value survive review.

## Protected implementation activation gate

This gate applies when a separate protected scope-lock artifact is required
for a new/changed protected contract or explicitly requested by the human.
Reusing an unchanged accepted contract still needs explicit protected task
bounds, regression tests and independent review, without automatically adding
another preparatory docs programme.

The scope-lock diff must already name the future implementation PASS_ID and its
exact runtime/test allowlist. Auditors verify that activation remains
conditional until independent acceptance and push of that exact lock. After
those gates, implementation may proceed without a routine active-lock-sync
pass. An older or deficient lock is amended; it is not routed through a new
sync-pass ceremony.

## Lane audit implications

PROMPTING_PROTOCOL owns risk classification. Ordinary Lane A changes use one
independent actual-diff review; review-output/thread/PR evidence is sufficient.
Protected Lane B keeps explicit scope, relevant regression/recovery evidence
and independent review. Do not weaken data or evidence boundaries in either lane.

No standalone map maintenance, audit-recording or closeout pass is mandatory
for minor UI work. Keep meaningful current pointers in the bounded task when
needed; do not spawn a pass merely to copy a verdict.

## Lane A evidence handoff requirement

Provide exact changed material, actual checks and any acceptance limits to the
independent reviewer. A lean review summary is sufficient; the canonical formal
packet below remains available when explicitly requested or risk warrants it.
Do not fabricate an artifact/ledger just to satisfy an optional template.

## Compact `CLAUDE_AUDIT_PACKET` for clean audits

- For clean passes where no blockers are found, audit may be returned as compact packet form instead of full prose.
- Required packet fields:
  - `AUDIT_VERDICT` (`ACCEPT_AS_IS` only for shorthand path).
  - `SAFE_FOR_STAGING` (`YES` / `NO`).
  - `EXPECTED_DIFF`.
  - `CURRENT_ROUTE` / `NEXT_ROUTE`.
  - `BOUNDARY_RESULT` and protected-surface confirmation.
  - `VALIDATION_RESULTS` (commands and pass/fail).
  - `STAGED` state (`NO`) and exact safe staging set if accepted.
- No full evidence details are required only when:
  - `AUDIT_VERDICT` is `ACCEPT_AS_IS`
  - `SAFE_FOR_STAGING` is `YES`
  - no blockers
  - no route/hash mismatch
  - no unexpected changed files.
- If shorthand is used, packet must still explicitly confirm `no false accepted/pushed` claim for the current uncommitted pass.

## Accepted shorthand gate

The user may reply with only `Accepted` only when Claude returned `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and the exact safe staging set matches expected changed files.

The user must paste relevant audit details when Claude returns or mentions `ACCEPT_WITH_NITS`, `BLOCKED`, `SAFE_FOR_STAGING: NO`, route/hash mismatch, unexpected files, protected-surface concern, staging-set mismatch, or unclear/conditional acceptance.

## Contract: scope-lock-post-audit

Use after a docs-only scope lock is drafted and needs independent audit before
exact human staging and push.

Checks:

- Apply all common audit checks.
- Confirm the scope lock is docs-only unless it explicitly scopes a later implementation pass.
- Confirm future implementation allowlist is narrow, concrete, and auditable.
- Confirm forbidden surfaces include protected product and evidence surfaces relevant to the pass.
- Confirm binding sources are named and compatible with the proposed future work.
- Confirm validation commands for the future implementation are exact enough to run.
- Confirm the lock already names the future implementation PASS_ID and exact
  allowlist, with activation conditional on acceptance and push.

Verdict options: `ACCEPT_AS_IS`, `NEEDS_SMALL_PATCH`, `REJECT`.

Return: findings plus canonical `AUDIT_VERDICT`, `SAFE_FOR_STAGING`, and
`SAFE_STAGING_SET` fields.

## Contract: implementation-post-audit

Use after code, tests, tools, schema, validator, materializer, or runtime implementation work.

Checks:

- Apply all common audit checks.
- Audit the actual diff and explicitly read the named untracked files; no staging or intent-to-add is required for a local read-only review.
- Confirm implementation creates only the scoped behavior and no adjacent product behavior.
- Confirm event/evidence semantics remain compatible with binding specs and protected-surface rules.
- Confirm validation output covers focused tests and broader baseline tests required by the scope.
- Confirm no direct writes bypass accepted writer/service boundaries when such boundaries exist.
- Confirm idempotency, failure handling, and local UI projection behavior when scoped.
- Confirm analyzer/lint residuals are either fixed or classified as known baseline/deferred issues.
- For applicable Dart production/test work, apply the common conditional
  code-map checks before accepting the implementation diff.

Verdict options: `ACCEPT_AS_IS`, `NEEDS_SMALL_PATCH`, `REJECT`.

Return: findings plus canonical `AUDIT_VERDICT`, `SAFE_FOR_STAGING`, and
`SAFE_STAGING_SET` fields.

## Contract: exceptional docs-closeout

Use only when an accepted and pushed pass causes a real route, authority, or
durable-risk transition that cannot truthfully wait for the next product pass.
Do not use it merely to copy a verdict.

Checks:

- Apply all common audit checks.
- Confirm the closed pass was implemented or captured, post-audited, accepted, committed, and pushed when the closeout says so.
- Confirm post-audit verdict and safety gate are recorded accurately.
- Confirm validation state is recorded without inventing unreported results.
- Confirm current route is the closeout pass and next route is the accepted next pass.
- Confirm no implementation behavior, tags, release objects, generated artifacts, or forbidden surfaces changed.
- Confirm completed pass history stays completed and no audit artifact is pruned.
- Confirm the update reuses existing evidence identity where applicable and
  does not create another routine closeout or audit-of-audit loop.

Verdict options: `PASS`, `NEEDS_PATCH`, `BLOCK`.

Return: closeout summary and findings plus canonical `AUDIT_VERDICT`,
`SAFE_FOR_STAGING`, and `SAFE_STAGING_SET` fields.

## Contract: route-review

Use when choosing the next pass without implementation.

Checks:

- Apply all common audit checks.
- Confirm no files changed unless the route review is explicitly docs-sync.
- Confirm route decision is based on current repo docs and accepted audit state.
- Confirm blocked or deferred work remains deferred unless the pass explicitly promotes it.
- Confirm new/changed protected contracts route through the formal scope gate.
- Confirm reuse of accepted protected contracts has explicit task bounds, tests and independent review.

Verdict options: `PASS`, `PASS_WITH_NITS`, `NEEDS_ROUTE_FIX`, `BLOCK`.

Return: route decision and useful alternatives plus canonical `AUDIT_VERDICT`,
`SAFE_FOR_STAGING`, and `SAFE_STAGING_SET` fields.

## Contract: recovery / evidence-recheck

Use for small governance repairs, missing audit artifacts, stale route pointers, or rechecking evidence after an audit finding.

Checks:

- Apply all common audit checks.
- Confirm the recovery does not rewrite or erase prior history.
- Confirm the repair is the minimum change that restores traceability.
- Confirm current and next routing are not polluted by stale pass IDs.
- Confirm any recovered evidence is explicitly labeled as recovered, folded, or user-provided context.
- Confirm no implementation work enters a docs-only recovery pass.

Verdict options: `PASS`, `NEEDS_PATCH`, `BLOCK`.

Return: recovery summary and remaining risk plus canonical `AUDIT_VERDICT`,
`SAFE_FOR_STAGING`, and `SAFE_STAGING_SET` fields.

## Canonical `CLAUDE_AUDIT_PACKET` input shape

When a formal packet is requested, use this single header/template for the
actual changed-file diff. Ordinary review may use the lean summary above:

```text
CLAUDE_AUDIT_PACKET

PASS_ID: <id>
LANE: <A | B>
MODE: AUDIT_ONLY
APPLY STANDARD AUDIT CONTRACT: <contract name>

EXPECTED_DIFF:
<exact changed-file set>

DO NOT edit, create, stage, commit, push, reset, or clean.

FOCUS:
<1-3 pass-specific risks>

VALIDATION:
<commands and observed results>

RETURN:
AUDIT_VERDICT: <contract verdict>
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET: <exact files or NONE>
```

## Lean-read rules for auditors

- Read the diff first.
- Read full files only when the diff requires it.
- Check governance with focused current/next route reads or greps when full-file reads are not necessary.
- Do not paste stable boundary lists into every prompt when the repo docs already own them.
- Treat repo docs as source of truth.
- Treat old chat memory and old uploads as non-canonical unless captured in repo docs.
- Treat summary-only evidence as insufficient for protected implementation audits.
- Explicitly read named untracked files alongside the tracked diff. If repo access is unavailable, require their exact file content; do not stage merely to make them visible.

## When full prompts are still required

Use a full prompt instead of a lean prompt when:

- new protected architecture is introduced;
- a new canonical event type is introduced;
- validator, materializer, writer, schema, or Project ZIP contract behavior changes;
- AI/OCR/CV, Photo Markup, or Repair Map architecture opens;
- an audit found blockers and exact patch instructions are needed;
- the helper lacks repo access and needs full context.

## Examples

### Scope-lock post-audit

```text
PASS_ID: V2_EDIT_COMPONENT_SCOPE_LOCK_PASS
LANE: B
MODE: AUDIT_ONLY
APPLY STANDARD AUDIT CONTRACT: scope-lock-post-audit
EXPECTED_DIFF: <exact governance files>
DO NOT edit, create, stage, commit, push, reset, or clean.
FOCUS: identity update boundaries; writer adapter expectations; no direct Edit implementation.
VALIDATION: <commands and observed results>
RETURN: AUDIT_VERDICT + SAFE_FOR_STAGING + exact SAFE_STAGING_SET
```

### Implementation post-audit

```text
PASS_ID: V2_EDIT_COMPONENT_IMPL_PASS
LANE: B
MODE: AUDIT_ONLY
APPLY STANDARD AUDIT CONTRACT: implementation-post-audit
EXPECTED_DIFF: <exact implementation files>
DO NOT edit, create, stage, commit, push, reset, or clean.
FOCUS: event type constraints; idempotent local projection; no unscoped writes.
VALIDATION: <commands and observed results>
RETURN: AUDIT_VERDICT + SAFE_FOR_STAGING + exact SAFE_STAGING_SET
```

### Docs closeout

```text
PASS_ID: V2_EDIT_COMPONENT_CLOSEOUT_PASS
LANE: A
MODE: AUDIT_ONLY
APPLY STANDARD AUDIT CONTRACT: exceptional docs-closeout
EXPECTED_DIFF: <exact meaningful route/authority transition files>
DO NOT edit, create, stage, commit, push, reset, or clean.
FOCUS: closeout accuracy; route consistency; no forbidden surface changes.
VALIDATION: <commands and observed results>
RETURN: AUDIT_VERDICT + SAFE_FOR_STAGING + exact SAFE_STAGING_SET
```

### Evidence recheck

```text
PASS_ID: V2_EDIT_COMPONENT_EVIDENCE_RECHECK_PASS
LANE: A
MODE: AUDIT_ONLY
APPLY STANDARD AUDIT CONTRACT: recovery / evidence-recheck
EXPECTED_DIFF: <exact recovery files>
DO NOT edit, create, stage, commit, push, reset, or clean.
FOCUS: cited finding validity; binding-source conflict; minimum recovery path.
VALIDATION: <commands and observed results>
RETURN: AUDIT_VERDICT + SAFE_FOR_STAGING + exact SAFE_STAGING_SET
```
