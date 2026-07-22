# AUDIT_CONTRACT.md

Reusable TraceBench audit contracts for lean prompts. This file lets future audit prompts name a standard contract instead of pasting the full boundary list every time.

Repo docs remain canonical. Old chat memory, old uploaded snippets, and summary-only claims do not override the repository state.

## Common audit checks

Apply these checks to every contract unless the pass explicitly narrows them further.

- Scope compliance: changed files must stay inside the pass allowlist and outside every forbidden surface.
- Governance route consistency: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` must agree on current and next pass.
- No self-loop: current pass and next recommended pass must not be the same.
- AUDIT_INDEX row check: new audit artifacts must have a ledger row; folded route-review rows are allowed only when explicit and traceable.
- No completed pass reopened/pruned: prior audit history must not be deleted, rewritten, or marked active again unless a recovery pass explicitly authorizes it.
- Binding-source check: when a pass cites specs, schemas, tools, or audit files, the diff must remain compatible with those binding sources.
- Future allowlist / forbidden surfaces check: future implementation scopes must state exact allowed surfaces and forbidden surfaces.
- Validation/log sanity: claimed validation must match command output; expected non-blocking warnings should be classified explicitly.
- Artifact/docs hygiene: no generated artifacts, literal newline artifacts, tag/release mutations, or accidental runtime files unless scoped.
- Findings ranking: rank findings as `BLOCKER`, `HIGH`, `MEDIUM`, `LOW`, or `NIT`.
- Verdict and safety gate: return `AUDIT_VERDICT`, `SAFE_FOR_STAGING`, and the
  exact `SAFE_STAGING_SET` using the canonical packet shape below.
- Audit-packet handoff: apply the Prompting Protocol's post-change trigger; a
  paste-ready `CLAUDE_AUDIT_PACKET` accompanies an actual changed-file diff, not
  strategy, design, ordinary answers, new-chat context, or prompt drafting.
- Visual/manual-smoke gate: visual or product-surface packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`; Claude audit must not approve a known-wrong visual draft.
- Exact staging: accepted staging sets must list exact files; `git add .`, `git add -A`, and broad staging are forbidden.
- Capability preflight: verify `TOOL_SKILL_CHECK` exists, the reported
  capability was applicable, and its use did not widen the active allowlist.
- Conditional code-map preflight: for implementation, repair, diagnostic, QA,
  refactor, or review work targeting or materially depending on Dart
  production/test files, verify `CODE_MAP_PREFLIGHT` against
  `docs/code_maps/CODE_MAP_STANDARD.md`.
- Code-map evidence: verify the index lookup and map status; named zones and
  stable symbols against map and source; the diff against the declared zone and
  active allowlist; and that inspect-only and excluded zones stayed unchanged.
- Code-map impact: verify write class from actual call-path evidence, affected
  tests against the impact matrix, and exactly one justified disposition per
  relevant target. Block silent reliance on missing, stale, or conflicting maps
  and verify that no such map authorized work.
- Code-map lifecycle: verify `UPDATE_REQUIRED` routes to later docs-only map
  maintenance against accepted committed source, and multi-zone work had a new
  explicit human scope decision or stopped with `DECOMPOSE_REQUIRED`.

## Protected implementation activation gate

The scope-lock diff must already name the future implementation PASS_ID and its
exact runtime/test allowlist. Auditors verify that activation remains
conditional until independent acceptance and push of that exact lock. After
those gates, implementation may proceed without a routine active-lock-sync
pass. An older or deficient lock is amended; it is not routed through a new
sync-pass ceremony.

## Lane audit implications

`docs/PROMPTING_PROTOCOL.md` is the sole owner of Lane classification (`A` or
`B`) and Mode work classes. This contract consumes that classification:

- Lane A still requires independent Claude audit before routing onward.
- Even in Lane A, protected-surface checks in `docs/PROTECTED_SURFACES.md` and routing consistency checks in `docs/MODEL_ROUTING.md` remain mandatory.
- Lane A outputs should include explicit audit evidence handoff:
  - post-change Codex reports with a real diff include `CLAUDE_AUDIT_PACKET`;
  - For routine child passes, prefer batched audit evidence or commit-trailer notes.
  - Do not drop existing audit evidence or suppress previous findings.
- Do not create a new PASS_ID merely to copy a verdict. A docs closeout is
  exceptional and justified only by a real route, authority, or durable-risk
  transition; it must not spawn another routine closeout.

## Lane A evidence handoff requirement

- `CLAUDE_AUDIT_PACKET` is required when a Lane A changed-file diff is handed
  to independent audit.
- The packet should include: pass ID, lane, mode, expected diff, focus,
  validation/run commands, and safety gate.
- For routine bundle child passes, a combined milestone audit record is acceptable when risk and scope are unchanged.
- Evidence may not be overwritten as "closed" without explicitly recording the boundary change reason.

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
- Audit the actual diff, including untracked implementation files added with `git add -N` or explicit file upload.
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
- Confirm protected-surface work routes to scope lock first.
- Confirm no direct implementation route is selected for a protected write surface.

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

Use this single header/template when a changed-file diff is ready for
repo-local independent audit:

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
- Require `git add -N` or explicit file upload for untracked implementation files before diff audit.

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
