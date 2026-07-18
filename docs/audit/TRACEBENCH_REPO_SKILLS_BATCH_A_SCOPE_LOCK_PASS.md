# TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Form: compact
- Mode: docs-only scope lock; no implementation
- Status: accepted/pushed/audited as
  `043f1f6ec90622fe7c0629a3c46fed2f1355ca8f`
  (`docs: lock repo skills batch A scope`); Claude audit `ACCEPT_AS_IS` /
  `SAFE_FOR_STAGING: YES`; blockers none; one deferred non-blocking
  `docs/PASS_QUEUE.md` paragraph-spacing nit
- Current: `TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS`

This pass makes the human-selected Batch A the active governed route and locks
its future contracts and sequence. It creates or edits no skill, performs no
pressure evaluation, and grants no implementation, staging, commit, or push
authority.

## Tool and skill check

`TOOL_SKILL_CHECK`:

- Relevant skill/tool/helper found: current repo-local
  `.agents/skills/tracebench-scope-lock/SKILL.md`,
  `androbuss-pass-runner`, `writing-skills`, its required TDD and subagent
  testing guidance, Git, `rg`, PowerShell, and `tools/validate_all.py`.
- Capability actually used: the compatible gate, route-consistency,
  one-pass-narrowness, and exact-allowlist technique from the current scope-lock
  skill; pass-runner gate discipline; skill-writing/TDD methodology only to
  define the future per-skill RED/GREEN contract; and local mechanical
  verification.
- Why applicable: this pass reserves one architecture-approved docs-to-sync-to-
  implementation sequence for three repo-local skills while leaving every
  implementation surface unarmed.
- External tool required: `NO`.

The current `tracebench-scope-lock` skill is known by the accepted architecture
to need `formalize/rewrite`: it lacks discovery frontmatter, has an over-broad
substring trigger, and carries stale copied details. Higher canonical owners
therefore control. Its compatible gate and narrowness technique applies here
because the requested work is semantically a scope lock; its stale or
conflicting details are not followed and do not widen this pass. No unresolved
governance conflict remains, and this pass does not repair the skill.

`writing-skills` and TDD guidance do not authorize a skill edit in this pass.
They only sharpen the future evidence order already required by the accepted
architecture.

## Model-routing check

`MODEL_ROUTING_CHECK result: PASS` — Lane A routes this bounded docs-only lock
through Codex, then independent Claude Code audit before any exact staging.
The human remains the staging, commit, and push owner. No GPT escalation,
external plugin, download, or installation is required because no protected or
ambiguous product behavior is opened.

## Code-map preflight

`CODE_MAP_PREFLIGHT: NOT_APPLICABLE` — this pass changes governance Markdown
only and neither targets nor materially depends on Dart production or test
files. No map is loaded as authority and SNIPER is not used.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main ==
  214cc91bf1595c9463e1ef7796c697d0a40bc536`
- Subject: `docs: record repo skills architecture closeout audit`
- Direct parent: `a22ac3c75db15d6d0f8df2095f4bc4ddff99af26`
- Initial tracked diff: empty.
- Initial cached diff: empty.
- Initial `git diff --check`: PASS.
- Initial route in all three operational owners:
  `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.

Commit `214cc91bf1595c9463e1ef7796c697d0a40bc536` contains exactly:

- `docs/AUDIT_INDEX.md`; and
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_POST_AUDIT_PASS.md`.

The known untracked snapshot contained 94 files and 43,936,062 bytes. A sorted
path/length/content SHA-256 manifest calculated from
`git ls-files --others --exclude-standard` was:

`bfedaf16cf4751953d11df0860078ccb9a9ff95bd259d15ef05c4a5af2314e24`.

The short-status untracked-path snapshot SHA-256 was:

`45110780824e53357a05b4f3d2df7b68c81a0b00738e3657d26e4112b2a0a6ce`.

Scratch remains outside scope and must match those snapshots after the pass.

## Accepted architecture evidence

The durable decision owner is
`docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md` at accepted decision commit
`9d6ec175ee9a4327b1683ca101ddb36b0acb48ec`
(`docs: define repo skills architecture`). Claude accepted that decision
`ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; blockers none; nits none.

The architecture closeout is pushed at
`a22ac3c75db15d6d0f8df2095f4bc4ddff99af26`, and its evidence-only audit
reconciliation is pushed at the current baseline
`214cc91bf1595c9463e1ef7796c697d0a40bc536`. This scope lock does not perform,
repeat, reopen, or rewrite that completed reconciliation.

The accepted architecture groups Batch A exactly as prompt authoring, scope
locking, and audit reconciliation. It requires one genuine RED/GREEN cycle per
new or materially rewritten skill and keeps skills descriptive,
pointer-based, and non-authorizing.

## Verified skill inventory

Exactly five implemented repo-local skills existed at gate, each containing
exactly one `SKILL.md`:

| Skill | Accepted disposition | SHA-256 at gate |
| --- | --- | --- |
| `tracebench-docs-closeout` | `formalize/rewrite` | `04e827eba8a0a16458ac0330f45bc054d8d53166d095cd562d3b1e9f89e11cbd` |
| `tracebench-flutter-widget-pass` | `formalize/rewrite` | `a0976e29f450766964991675a9a772b9a898e35e7579c33d9597a69aac30e3a0` |
| `tracebench-safe-staging` | `formalize/rewrite` | `8940eb4068b03b77a1695dbbc49b62cbeb60991d0943d3ce01f4ed0089722356` |
| `tracebench-scope-lock` | `formalize/rewrite` | `ea05d4757f08f96ba93353e96b8f26a7131d70cd454f87a95190288461174c12` |
| `tracebench-v2-event-boundary` | `formalize/rewrite` | `9b4ca4be0fbeee2726258e4b7f1ee3160661b63d85b62d4708eddde7f5a52fb3` |

Exactly these catalogue roles were absent:

- `tracebench-prompt-authoring`;
- `tracebench-code-map-lifecycle`; and
- `tracebench-audit-reconciliation`.

The two new Batch A directories and this scope-lock artifact were absent at
gate. Neither the future sync nor implementation pass had an `AUDIT_INDEX`
row.

## Exact current write authority

This docs-only scope lock writes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS.md`

No sixth path, wildcard, skill, implementation, stage, commit, or push is
authorized.

## Locked Batch A membership

Batch A is exactly:

- `tracebench-prompt-authoring` — new;
- `tracebench-scope-lock` — `formalize/rewrite`; and
- `tracebench-audit-reconciliation` — new.

`tracebench-code-map-lifecycle` remains the only missing catalogue role after
successful future Batch A implementation. Batch B, C, and D remain separately
scoped architecture batches and are not armed here.

## Canonical ownership and non-authorization

- Canonical repo docs own product truth, route, authority, semantics, and
  protected boundaries.
- Each exact prompt owns its PASS_ID, baseline, allowlist, exclusions, stops,
  pass-specific delta, and validation only within live canonical authority.
- Skills own reusable judgment and workflow technique only.
- A skill cannot create or widen a route, allowlist, write, stage, protected
  surface, implementation, commit, or push authority.
- Code maps remain descriptive and non-authorizing.
- Tools may later own only separately proven deterministic checks.
- Any unresolved owner or independent responsibility-zone conflict stops or
  decomposes instead of being merged by convenience.

## Shared future skill format

Every Batch A skill must use:

- `.agents/skills/<skill-name>/SKILL.md`;
- YAML frontmatter with required `name` and `description`;
- a directory and `name` that match exactly and use lowercase letters,
  numbers, and hyphens only;
- a third-person `description` beginning `Use when...` and containing trigger
  conditions only, never workflow summary;
- a concise, pointer-based body that owns technique rather than copied truth;
- references to canonical owners rather than duplicated rule lists;
- no current hash, active route, PASS_ID, or pass-specific allowlist;
- no supporting file without separately demonstrated reuse and authority; and
- no generic or personal extraction in Batch A.

## Future `tracebench-prompt-authoring` contract

Trigger: drafting or materially revising a TraceBench pass prompt, handoff, or
Claude audit packet.

It must:

- read the live canonical route and authority owners;
- follow `docs/PROMPTING_PROTOCOL.md` and route model roles through
  `docs/MODEL_ROUTING.md`;
- select compact or full form through canonical rules;
- include `TOOL_SKILL_CHECK`;
- include conditional `CODE_MAP_PREFLIGHT` when applicable;
- distinguish write, read, inspect-only, excluded, staging, and scratch
  surfaces;
- preserve the exact baseline, allowlist, stops, validation, and audit packet;
  and
- stop rather than invent authority.

It must not:

- execute or authorize a pass;
- replace canonical governance; or
- treat SNIPER as a general prompt profile.

## Future `tracebench-scope-lock` contract

Trigger: reserving a future exact route, allowlist, boundaries, and stops.

It must:

- verify live route and baseline;
- distinguish current scope-lock authority from reserved future authority;
- detect independent responsibility zones;
- decompose conflicting lifecycle phases or independent zones;
- reserve active-lock sync only when required by the exact selected sequence;
  and
- preserve non-authorization.

It must not:

- use substring-only triggering;
- combine reconciliation, sync, implementation, or closeout;
- implement, stage, commit, or push; or
- encode active-lock sync as a universal skill rule.

## Future `tracebench-audit-reconciliation` contract

Trigger: an independent verdict has returned and the audited pass is pushed,
while its existing artifact/index still records pending state and route and
authority stay unchanged.

It must:

- point to `docs/AUDIT_CONTRACT.md`, `docs/AUDIT_INDEX.md`, one exact existing
  artifact, live Git evidence, and read-only route owners;
- retain the same PASS_ID and existing artifact;
- verify commit, subject, parent, and exact committed set;
- preserve original draft-time evidence;
- change only exact authorized ledger/artifact surfaces;
- preserve the `AUDIT_INDEX` descriptive text byte-identically;
- append superseding audit and push evidence; and
- keep route and authority unchanged.

It must not:

- create a new artifact;
- mutate route or release a lock;
- perform closeout or implementation; or
- stage, commit, or push.

## Reserved RED/GREEN pressure evidence

This scope lock records no RED or GREEN result. The future implementation must
process the three skills serially. It may not create or edit a candidate skill
until that skill's genuine RED baseline has run and demonstrated a meaningful
failure, omission, or unsafe rationalization. It may not move to the next skill
until the current skill's GREEN and any required REFACTOR rerun are recorded.

For new skills, RED runs before the skill exists. For the
`tracebench-scope-lock` rewrite, RED uses the current committed skill at the
gate hash above as the baseline; it must not manufacture an artificially
skill-free state.

Each skill requires one real paired evaluation:

1. Run a fresh-context, read-only baseline evaluator with the candidate absent
   or, for the rewrite, at its committed baseline.
2. Record the exact scenario prompt, choices, omissions, failures, and unsafe
   rationalizations verbatim in
   `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS.md`.
3. Write only the minimum candidate guidance addressing the demonstrated RED.
4. Run a second fresh-context, read-only evaluator with the same task prompt,
   model, reasoning level, and repo fixture; only normal candidate-skill
   availability may differ.
5. Prove that ordinary repo-local discovery caused the evaluator to find and
   read the candidate. Do not inject, summarize, or quote its workflow into the
   scenario prompt.
6. Record demonstrated compliance and any new rationalization verbatim. Apply
   the minimum refactor and repeat the identical GREEN scenario when needed.

Fresh-context subagents or another supported genuine evaluation capability are
acceptable. Because agents share the working tree, RED and GREEN evaluations
must be serialized and response-only; evaluators may not edit, stage, commit,
push, or mutate live route, index, artifact, or scratch state. Synthetic
fixtures must stay inside the prompt and implementation artifact evidence; no
permanent harness or supporting file is authorized.

Each discipline scenario combines at least three genuine pressures such as
time, authority, sunk cost, convenience, or social pressure. If a no-guidance
RED control complies already, strengthen the scenario and rerun it before
writing the skill. If no meaningful failure can be produced, stop rather than
claim necessity. If GREEN fails, minimally refactor and rerun the identical
scenario or stop; never infer or fabricate compliance.

If genuine evaluation is unavailable during implementation, stop with
`BLOCKED_PRESSURE_TEST_CAPABILITY`. If this contract cannot be preserved, stop
with `BLOCKED_PRESSURE_TEST_CONTRACT_GAP`.

### Locked scenario themes

- Prompt authoring: ask the evaluator to draft or materially revise a compact
  TraceBench pass prompt and Claude packet for a small Dart request while no
  active write authority exists, a maintained map and scratch are present, and
  deadline, authority, and convenience pressure encourage direct execution,
  broad staging, or skipped map/scratch guards.
- Scope lock: present a conflicting live route or independent docs/runtime
  responsibility zones while deadline, authority, and sunk-cost pressure
  encourage combining planning, reconciliation, sync, and implementation.
- Audit reconciliation: use a response-only synthetic already-pushed pass with
  a returned verdict but pending artifact/index while deadline, authority, and
  convenience pressure encourage a new artifact, route mutation, historical
  rewrite, or closeout conflation.

## Reserved future active-lock sync

`TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS` is selected as the
next pass only after this scope lock is independently audited, accepted,
committed, pushed, and reconciled. Its reserved write allowlist is exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Its sole purpose is to make `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS` current
and synchronize that pass's exact allowlist and boundaries. It creates or edits
no skill. This is the selected pass sequence, not a universal rule owned by a
skill.

## Reserved future implementation

`TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS` remains unarmed. Its reserved future
write allowlist is exactly:

- `.agents/skills/tracebench-prompt-authoring/SKILL.md`
- `.agents/skills/tracebench-scope-lock/SKILL.md`
- `.agents/skills/tracebench-audit-reconciliation/SKILL.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS.md`

No sixth path, wildcard, other skill, owner, fixture, harness, or helper file is
reserved.

## Reserved tooling-policy delta

Only after successful future Batch A implementation may
`docs/CODEX_TOOLING_POLICY.md` record:

- implemented repo-local skill count: seven;
- `tracebench-code-map-lifecycle` as the only missing catalogue role; and
- external tooling still default-off.

The policy must remain compact and point to, rather than duplicate, the full
architecture spec.

## Preserved surfaces and exclusions

This pass leaves unchanged:

- all five existing `.agents/skills/**` files and their recorded hashes;
- both missing Batch A skill directories;
- `docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`;
- `docs/CODEX_TOOLING_POLICY.md`;
- `AGENTS.md`, `PROMPTING_PROTOCOL.md`, `AUDIT_CONTRACT.md`,
  `MODEL_ROUTING.md`, `PROTECTED_SURFACES.md`, and `FILE_MAP.md`;
- Code Map Standard, index, and every map;
- every historical audit artifact, including the accepted architecture
  decision and closeout chain;
- `lib/**`, `test/**`, `tools/**`, `schemas/**`, packages, assets,
  `_incoming`, and scratch; and
- routes, writers, events, facts, projections, Project ZIP, and every protected
  semantic surface.

No pressure test, skill edit, generic/personal extraction, Markdown compaction,
Photo-to-Canvas work, Batch B/C/D work, runtime, test, tool, validator, loader,
hook, CI, dependency, map, or protected change is performed or armed.

## Route and authority distinction

After this draft:

- Current: `TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS`

Only the exact five-file current docs allowlist is active. The next-pass route
records selected sequencing; it does not activate the sync or implementation
allowlists. The sync and implementation targets remain conditional
reservations until their required independent evidence and route transitions
exist.

## Audit-index and artifact record

This pass adds exactly one `DRAFTED / PENDING CLAUDE AUDIT` row for
`TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS` and creates this one matching
artifact. It adds no sync or implementation row, changes no pre-existing row,
and claims no accepted, staged, committed, or pushed status.

## Stop conditions

Stop on:

- `BLOCKED_BASELINE_MISMATCH`;
- `BLOCKED_DIRTY_STATE`;
- `BLOCKED_ALLOWLIST_MISMATCH`;
- `BLOCKED_GOVERNANCE_CONFLICT` for an unresolved higher-owner conflict;
- `BLOCKED_SKILL_INVENTORY_MISMATCH`;
- `BLOCKED_PRESSURE_TEST_CONTRACT_GAP`; or
- `DECOMPOSE_REQUIRED`.

Future implementation additionally stops with
`BLOCKED_PRESSURE_TEST_CAPABILITY` if genuine evaluation is unavailable.

## Validation record

- `python tools/validate_all.py`: PASS on the required unrestricted rerun;
  285 tests ran, zero failures, exit 0. The first managed-sandbox attempt was
  blocked only by permission errors writing repo `.codex` outputs and Windows
  temporary directories; it produced 148 environment-caused errors before the
  unchanged command was rerun successfully outside the sandbox.
- `git diff --check`: PASS, with working-copy LF-to-CRLF notices only.
- Final task set: exactly the four modified operational/index files plus this
  one untracked audit artifact, matching the five-file current allowlist.
- `git diff --cached --name-status`: empty.
- All three route owners agree on
  `TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- `AUDIT_INDEX.md`: exactly one new scope-lock row, no sync or implementation
  row, no duplicate or glued row, and all 745 pre-existing rows unchanged.
- All five existing `SKILL.md` hashes match their gate values; both missing
  Batch A skill directories remain absent.
- The architecture spec, tooling policy, prompt/audit/model/file owners, Code
  Map Standard/maps, historical audit artifacts, runtime, tests, tools,
  schemas, packages, assets, `_incoming`, and protected surfaces have no
  tracked diff.
- The known 94-file, 43,936,062-byte scratch manifest and short-status snapshot
  match their gate hashes after excluding this allowed new audit artifact.
- `HEAD == origin/main ==
  214cc91bf1595c9463e1ef7796c697d0a40bc536`; HEAD is unchanged.
- No pressure test or fabricated RED/GREEN evidence exists.
- Nothing is staged, committed, or pushed.

This artifact remains `DRAFTED / PENDING CLAUDE AUDIT`; the validation record
grants no staging, commit, or push permission.

## Claude scope-lock audit reconciliation

The original draft-time body above, including its pending statements, remains
unchanged as historical pre-audit evidence. Those statements are superseded
only by the top Status metadata and this appended reconciliation.

- Audit verdict: `ACCEPT_AS_IS`.
- Safe for staging: `YES`.
- Blockers: none.
- Nit: one non-blocking cosmetic note in `docs/PASS_QUEUE.md`: the “Unarmed
  implementation target” reservation pointer and following exclusion list
  render as one paragraph because no blank line separates them.
- Nit disposition: deferred; it changes no governance, route, allowlist, or
  authority meaning and is not fixed in this reconciliation.
- Claude verified all fifteen scope-lock checklist items.
- Claude did not rerun `tools/validate_all.py` because it writes into
  `.codex/`; Claude edited, staged, committed, and pushed nothing.
- The existing 285/285 draft-time validation remains unchanged historical
  evidence by construction.
- Pushed commit:
  `043f1f6ec90622fe7c0629a3c46fed2f1355ca8f`.
- Subject: `docs: lock repo skills batch A scope`.
- Verified direct parent:
  `214cc91bf1595c9463e1ef7796c697d0a40bc536`.
- Exact committed set:
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS.md`
- Original accepted safe staging set:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS.md`
- Reconciliation gate:
  `HEAD == origin/main == 043f1f6ec90622fe7c0629a3c46fed2f1355ca8f`.
- Tracked diff before reconciliation: empty.
- Cached diff before reconciliation: empty.
- The known 94-file, 43,936,062-byte scratch snapshot remains preserved and
  unstaged.
- Route remains:
  `TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Current authority remains the existing five-file docs-only scope lock; this
  two-file reconciliation neither activates the reserved sync nor arms the
  unarmed implementation target.

No closeout, sync, implementation, skill creation, lock release, staging,
commit, or push is performed here.
