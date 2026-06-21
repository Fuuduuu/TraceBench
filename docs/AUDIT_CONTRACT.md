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
- Verdict and safety gate: return one verdict option and `safe_to_commit` or `safe_for_commit_push` as `YES` or `NO`.

## Two-lane policy

- Lane A pass families (docs-only sync, docs locks, scoped polish, QA hardening in accepted behavior, no protected behavior activation) use lean contract prompts by default.
- Lane B pass families (schema/validator/materializer/writer, event/facts, Project ZIP, renderer writes, AI/OCR/CV, route ambiguity, Confirm/write/persistence commits, canonical semantics changes) require full contract detail and a complete decision trail.
- Lane A still requires independent Claude audit before routing onward.
- Even in Lane A, protected-surface checks in `docs/PROTECTED_SURFACES.md` and routing consistency checks in `docs/MODEL_ROUTING.md` remain mandatory.
- Lane A outputs should include explicit audit evidence handoff:
  - Codex reports must include `CLAUDE_AUDIT_PACKET`.
  - For routine child passes, prefer batched audit evidence or commit-trailer notes.
  - Do not drop existing audit evidence or suppress previous findings.
- Do not add redundant post-audit passes unless they capture meaningful state, boundary decisions, or protected/high-risk risk transitions.

## Lane A evidence handoff requirement

- `CLAUDE_AUDIT_PACKET` is required in Lane A closeout/lock/audit summary handoff to keep evidence continuity.
- The packet should include: pass ID, lane/type, expected diff, focus, validation/run commands, and safety gate.
- For routine bundle child passes, a combined milestone audit record is acceptable when risk and scope are unchanged.
- Evidence may not be overwritten as "closed" without explicitly recording the boundary change reason.

## Compact `CLAUDE_AUDIT_PACKET` for clean Lane A docs-only passes

- For clean Lane A docs-only passes where no blockers are found, audit may be returned as compact packet form instead of full prose.
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

## Contract: scope-lock-post-audit

Use after a docs-only scope lock is drafted and needs independent audit before closeout.

Checks:

- Apply all common audit checks.
- Confirm the scope lock is docs-only unless it explicitly scopes a later implementation pass.
- Confirm future implementation allowlist is narrow, concrete, and auditable.
- Confirm forbidden surfaces include protected product and evidence surfaces relevant to the pass.
- Confirm binding sources are named and compatible with the proposed future work.
- Confirm validation commands for the future implementation are exact enough to run.
- Confirm the next route is the post-audit or closeout path, not direct implementation unless already accepted.

Verdict options: `ACCEPT_AS_IS`, `NEEDS_SMALL_PATCH`, `REJECT`.

Return: findings, verdict, `safe_to_commit: YES/NO`.

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

Verdict options: `ACCEPT_AS_IS`, `NEEDS_SMALL_PATCH`, `REJECT`.

Return: findings, verdict, `safe_to_commit: YES/NO`.

## Contract: docs-closeout

Use to close out accepted and pushed passes.

Checks:

- Apply all common audit checks.
- Confirm the closed pass was implemented or captured, post-audited, accepted, committed, and pushed when the closeout says so.
- Confirm post-audit verdict and safety gate are recorded accurately.
- Confirm validation state is recorded without inventing unreported results.
- Confirm current route is the closeout pass and next route is the accepted next pass.
- Confirm no implementation behavior, tags, release objects, generated artifacts, or forbidden surfaces changed.
- Confirm completed pass history stays completed and no audit artifact is pruned.

Verdict options: `PASS`, `NEEDS_PATCH`, `BLOCK`.

Return: closeout summary, findings, verdict, `safe_for_commit_push: YES/NO`.

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

Return: route decision, alternatives considered if useful, verdict, `safe_to_commit` or `safe_for_commit_push` as applicable.

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

Return: recovery summary, remaining risk if any, verdict, `safe_to_commit` or `safe_for_commit_push` as applicable.

## Lean prompt format

Use this standard prompt shape when a repo-local audit contract is enough:

```text
PASS_ID: <id>

TYPE:
scope-lock | implementation | docs-closeout | route-review | recovery | evidence-recheck

LANE:
<model/helper lane>

CODEX:
<short summary: verdict, changed files, validation, route>

FOCUS:
<1-3 pass-specific risks>

APPLY STANDARD AUDIT CONTRACT: <contract name>
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
PASS_ID: V2_EDIT_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS
TYPE: scope-lock-post-audit
LANE: CLAUDE_CODE_OPUS / AUDIT_ONLY
CODEX: Scope lock drafted; changed governance docs only; validate_all PASS; next route closeout.
FOCUS: identity update boundaries; writer adapter expectations; no direct Edit implementation.
APPLY STANDARD AUDIT CONTRACT: scope-lock-post-audit
```

### Implementation post-audit

```text
PASS_ID: V2_EDIT_COMPONENT_POST_AUDIT_PASS
TYPE: implementation-post-audit
LANE: CLAUDE_CODE_OPUS / AUDIT_ONLY
CODEX: Implementation changed scoped UI/service/tests; focused tests PASS; full suite PASS; validate_all PASS.
FOCUS: event type constraints; idempotent local projection; no unscoped writes.
APPLY STANDARD AUDIT CONTRACT: implementation-post-audit
```

### Docs closeout

```text
PASS_ID: V2_EDIT_COMPONENT_CLOSEOUT_PASS
TYPE: docs-closeout
LANE: CODEX / DOCS_SYNC_CLOSEOUT
CODEX: Accepted implementation pushed; post-audit ACCEPT_AS_IS; route next to selected scope lock.
FOCUS: closeout accuracy; route consistency; no forbidden surface changes.
APPLY STANDARD AUDIT CONTRACT: docs-closeout
```

### Evidence recheck

```text
PASS_ID: V2_EDIT_COMPONENT_EVIDENCE_RECHECK_PASS
TYPE: evidence-recheck
LANE: CODEX / RECOVERY
CODEX: Recheck post-audit concern against current diff and binding specs; no implementation unless explicitly scoped.
FOCUS: cited finding validity; binding-source conflict; minimum recovery path.
APPLY STANDARD AUDIT CONTRACT: recovery / evidence-recheck
```
