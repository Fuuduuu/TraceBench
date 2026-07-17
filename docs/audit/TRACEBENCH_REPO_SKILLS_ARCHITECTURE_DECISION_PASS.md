# TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only architecture decision
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Route observed, not changed:
  `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS`

This pass records the human-locked Variant C repo-skills architecture. It
implements no skill, tool, validator, loader, route, runtime behavior, test,
map, schema, or protected write.

## Tool and skill preflight

`TOOL_SKILL_CHECK`:

- Relevant capability found: repo-local `tracebench-scope-lock`,
  `androbuss-pass-runner`, generic brainstorming, writing-skills and TDD
  methodology, Git, `rg`, PowerShell, and `tools/validate_all.py`.
- Capability actually used: `androbuss-pass-runner` enforced the hard gate and
  exact allowlist; the repo scope guidance and canonical audit/prompt owners
  established authority; brainstorming checked the already human-approved
  design for boundaries; writing-skills/TDD supplied trigger-only discovery,
  concision, and RED/GREEN pressure methodology.
- Why applicable: the pass turns an accepted scope decision into a durable
  skill-system architecture without implementing the eight skills.
- External tool required: `NO`.

The user had already selected and fully specified Variant C. Therefore the
generic brainstorming method was used as a design self-review, not to reopen
the decision, create a second spec, request another approval, or commit. The
user's exact path and no-commit instructions control this pass.

## Code-map preflight

`CODE_MAP_PREFLIGHT: NOT_APPLICABLE` — the pass changes architecture/tooling
Markdown only and neither targets nor materially depends on Dart production or
test files. Code maps remain descriptive and unchanged.

## Baseline and accepted scope chain

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Gate: `HEAD == origin/main ==
  0d0987c91e35e7b8d54cb21e8eaefabcb8cbb58f`.
- Baseline subject: `docs: record repo skills architecture scope audit`.
- Scope-lock commit:
  `86c93679cd6ff5ab2844b5c3df0b4da1fcaf05e5`
  (`docs: lock repo skills architecture decision`).
- Reconciliation commit:
  `0d0987c91e35e7b8d54cb21e8eaefabcb8cbb58f`.
- Scope-lock Claude audit: `ACCEPT_AS_IS` /
  `SAFE_FOR_STAGING: YES`; blockers none; nits none.
- Initial tracked diff: empty.
- Initial cached diff: empty.
- Future architecture spec and this decision artifact were absent at gate.
- Known untracked scratch remained outside scope.

Commit `0d0987c91e35e7b8d54cb21e8eaefabcb8cbb58f` is the direct successor of the
scope lock and contains exactly the two audit-reconciliation files recorded by
the accepted chain.

## Exact write authority

This pass writes exactly:

- `docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS.md`

No fourth file, wildcard, staging, commit, or push is authorized.

## Inventory evidence and dispositions

The repository contained exactly five `tracebench-*` directories at gate.
Each contained one `SKILL.md`, no supporting file, and no YAML frontmatter.

| Existing skill | Disposition | Draft evidence |
| --- | --- | --- |
| `tracebench-scope-lock` | `formalize/rewrite` | Useful lifecycle seed, but substring-only triggering and stale copied read/output details. |
| `tracebench-docs-closeout` | `formalize/rewrite` | Useful closeout seed, but it conflates closeout with staging. |
| `tracebench-safe-staging` | `formalize/rewrite` | Valuable guard, but it lacks discovery metadata and copies mechanical scratch/check lists. |
| `tracebench-flutter-widget-pass` | `formalize/rewrite` | Valid specialization, but it lacks current code-map, TDD/debug, and manual-smoke routing. |
| `tracebench-v2-event-boundary` | `formalize/rewrite` | Valid protected role, but it copies canonical semantics instead of pointing to owners. |

No evidence supported `preserve`, `split`, or `retire`. The following roles did
not exist and were decision targets only: prompt authoring, code-map lifecycle,
and audit reconciliation.

Pre-edit SHA-256 evidence:

- `tracebench-docs-closeout`:
  `04e827eba8a0a16458ac0330f45bc054d8d53166d095cd562d3b1e9f89e11cbd`
- `tracebench-flutter-widget-pass`:
  `a0976e29f450766964991675a9a772b9a898e35e7579c33d9597a69aac30e3a0`
- `tracebench-safe-staging`:
  `8940eb4068b03b77a1695dbbc49b62cbeb60991d0943d3ce01f4ed0089722356`
- `tracebench-scope-lock`:
  `ea05d4757f08f96ba93353e96b8f26a7131d70cd454f87a95190288461174c12`
- `tracebench-v2-event-boundary`:
  `9b4ca4be0fbeee2726258e4b7f1ee3160661b63d85b62d4708eddde7f5a52fb3`

## Locked architecture decisions

The durable decision owner is
`docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`. It locks:

- canonical docs for truth, routes, authority, semantics, and protected
  boundaries;
- skills for reusable judgment and workflow technique only;
- deterministic tools/validators for proven mechanical invariants;
- code maps for descriptive source responsibility and impact evidence;
- each prompt for its exact identity, scope, stops, delta, and validation;
- exact trigger boundaries and trigger-only discovery descriptions;
- ordered, conditional composition rather than loading all skills;
- lifecycle separation between scope lock, audit reconciliation, and closeout;
- non-authorization at every skill and map boundary; and
- narrow implementation batches with per-skill RED/GREEN evidence.

### Exact Variant C catalogue

| Layer | Catalogue entries |
| --- | --- |
| Core | `tracebench-prompt-authoring` |
| Lifecycle | `tracebench-scope-lock`, `tracebench-code-map-lifecycle`, `tracebench-audit-reconciliation`, `tracebench-docs-closeout` |
| Specialized | `tracebench-flutter-widget-pass`, `tracebench-v2-event-boundary` |
| Mechanical guard | `tracebench-safe-staging` |

The policy points to the spec, records this exact catalogue, preserves
local-only/default-off external tooling, and does not duplicate the full
architecture.

### Trigger boundaries

| Skill | Locked trigger | Locked exclusion |
| --- | --- | --- |
| `tracebench-prompt-authoring` | Draft or materially revise a TraceBench pass prompt, handoff, or Claude packet. | Does not execute or authorize the pass. |
| `tracebench-scope-lock` | Reserve future exact route, allowlist, boundaries, and stops. | Not substring-only matching, reconciliation, sync, implementation, or closeout. |
| `tracebench-code-map-lifecycle` | Qualify, create, audit, finalize, review drift, update, or retire a map. | Not ordinary `REVIEWED_NO_CHANGE` source work and never source authority. |
| `tracebench-audit-reconciliation` | Record an already-returned verdict and pushed evidence without route change. | Does not perform audit, release lock, or close implementation. |
| `tracebench-docs-closeout` | Close an accepted/pushed pass through operational route and durable evidence owners. | Not evidence-only reconciliation or staging. |
| `tracebench-flutter-widget-pass` | Execute, repair, diagnose, or verify scoped Flutter/Dart UI/widget work. | Not docs-only or unscoped protected behavior. |
| `tracebench-v2-event-boundary` | Target or materially affect V2 event/writer/validator/materializer/projection semantics. | Not demonstrably zero-write UI; never supplies protected authority. |
| `tracebench-safe-staging` | Verify or perform explicitly authorized exact-file staging after accepted audit. | Does not grant permission, infer files, stage scratch, or commit. |

## Format and composition decisions

Future skills use `.agents/skills/<skill-name>/SKILL.md`, lowercase
letters/numbers/hyphens, and YAML `name` plus `description`. Descriptions begin
`Use when...`, contain trigger conditions only, and do not summarize workflow.
Bodies remain concise and pointer-based, with no commit, active route, PASS_ID,
or pass-specific allowlist. Supporting files need proven reuse and excessive
inline weight.

Composition order is canonical gate -> compatible prompt authority -> at most
one primary lifecycle phase when a lifecycle trigger applies -> conditional
code-map lifecycle -> applicable specialized execution -> safe staging last.
Safe staging requires both an accepted independent audit and explicit human
authority. Scope lock, audit reconciliation, and closeout do not absorb one
another. Any unresolved authority or independent-zone conflict stops or
decomposes.

## Portability decision

| Skill | Class | Extraction candidate | Required TraceBench binding summary |
| --- | --- | --- | --- |
| `tracebench-prompt-authoring` | `PROJECT_ADAPTER` | `YES` | Prompt, model, lifecycle, and route owners. |
| `tracebench-scope-lock` | `PROJECT_ADAPTER` | `YES` | Default five, audit, protected, and route owners. |
| `tracebench-code-map-lifecycle` | `PROJECT_ADAPTER` | `YES` | Code Map Standard/index/map/source/test and active authority. |
| `tracebench-audit-reconciliation` | `PROJECT_ADAPTER` | `YES` | Audit contract/index/artifact, Git evidence, and route owners. |
| `tracebench-docs-closeout` | `PROJECT_ADAPTER` | `YES` | Operational route/lock owners, audit evidence, and lifecycle. |
| `tracebench-safe-staging` | `PROJECT_ADAPTER` | `YES` | Git/scratch rules, active allowlist, accepted exact set, and human authority. |
| `tracebench-flutter-widget-pass` | `TECHNOLOGY_SPECIFIC` | `YES` | Flutter/Dart, maps, tests, UI/protected owners, and visual gate. |
| `tracebench-v2-event-boundary` | `PROJECT_ONLY` | `NO` | Charter, truth/protected owners, and exact V2 implementation owners. |

All remain repo-local. Extraction candidate `YES` is a future option, not
permission. A generic or personal skill requires a separate decision and pass.

## Validator and RED/GREEN boundaries

The decision reserves only deterministic checks for future tools/validators:
frontmatter parsing, naming syntax/equality, required fields, prefix/file/count
checks, exact diff/staging sets, forbidden paths, route tuple equality,
dangling pointers, and mechanical stable-symbol presence checks. Presence
checks cannot replace map-to-code audit, semantic drift judgment, or
`MAINTAINED` status finalization. This pass implements none.

Semantic trigger selection, pressure-scenario quality, decomposition,
supporting-file reuse, canonical conflict, and portability remain judgment.

Every new or materially rewritten skill later requires a baseline scenario
without the skill, recorded failure/rationalization, minimum guidance, the
identical scenario rerun with the skill, demonstrated compliance, and RED/GREEN
evidence in that implementation pass's audit artifact. No permanent harness is
authorized until repeated value is demonstrated.

## Narrow implementation batches

| Batch | Skills |
| --- | --- |
| A — core route authoring | `tracebench-prompt-authoring`, `tracebench-scope-lock`, `tracebench-audit-reconciliation` |
| B — closure and staging safety | `tracebench-docs-closeout`, `tracebench-safe-staging` |
| C — code-map lifecycle | `tracebench-code-map-lifecycle` |
| D — specialized execution | `tracebench-flutter-widget-pass`, `tracebench-v2-event-boundary` |

The batches cover all eight roles once. No all-eight implementation pass is
authorized.

## Markdown compaction and lifecycle decisions

Future Markdown dispositions are `KEEP_CANONICAL`, `COMPACT_AND_REPOINT`, and
`RETIRE_AND_DELETE`. Deletion requires an implemented and audited replacement,
updated pointers, preserved canonical authority, preserved audit history, no
dangling `FILE_MAP`/index/read-order reference, and a dedicated exact-file
docs-compaction pass.

This pass classifies or deletes no Markdown. Skill drift, deprecation, and
retirement likewise require evidence and separate exact authority.

## Risks, uncertainties, and non-decisions

Recorded risks are overlapping lifecycle triggers, duplicated canonical truth,
mechanical checklists displacing judgment, and premature generic extraction.
Actual loader/YAML discovery behavior must be verified during later skill
implementation. Exact generic interfaces, permanent harnesses, validator
implementation, word limits, and supporting-file layouts remain open until
evidence justifies them.

`docs/AUDIT_CONTRACT.md` still contains some legacy `safe_to_commit` /
`safe_for_commit_push` vocabulary alongside the current compact
`SAFE_FOR_STAGING` contract. This is a non-blocking, out-of-scope owner
normalization question; this pass preserves that file and uses the verdict
format required by the active prompt.

No Photo-to-Canvas decision, plugin/MCP, dependency, external download,
automatic loader, tool, validator, skill implementation, route change,
Markdown compaction, or protected product/semantic behavior is decided here.

## Unchanged surfaces

- all `.agents/skills/**` files and their five baseline hashes;
- `AGENTS.md`, the five operational owners, `AUDIT_INDEX.md`, `FILE_MAP.md`,
  Prompting Protocol, Audit Contract, Model Routing, and Pass Lifecycle;
- Code Map Standard, index, and all maps;
- `lib/**`, `test/**`, `tools/**`, `schemas/**`, packages, assets,
  `_incoming`, and scratch;
- runtime routes, writers, events, facts, projections, Project ZIP, and every
  protected surface; and
- all Photo-to-Canvas decisions.

The route remains the accepted scope-lock -> decision-pass route. No
`AUDIT_INDEX.md` row is added in this pass.

## Validation record

- `py -3.13 tools/validate_all.py`: unavailable — the Windows launcher reports
  `No suitable Python runtime found`; Python 3.13 is not installed and this
  pass performed no install or download.
- `python --version`: `Python 3.12.10`.
- Fallback `python tools/validate_all.py`: PASS — 285/285 tests.
- `git diff --check`: PASS.
- Worktree scope: PASS — `git diff --name-status` contains only the modified
  tooling policy, while `git status --short` also identifies exactly the two
  allowed new spec/audit files; together the set is exactly three files.
- `git diff --cached --name-status`: empty.
- Catalogue count: PASS — in spec section 3 each of the eight roles appears
  exactly once.
- Disposition count: PASS — in spec section 4 each of the five existing skills
  appears exactly once and `formalize/rewrite` appears five times.
- Batch count: PASS — in spec section 13 batches A–D cover each of the eight
  roles exactly once.
- Portability count: PASS — in spec section 14 each role appears exactly once
  with a nonempty project binding, the locked classification, and extraction
  value.
- Policy catalogue count: PASS — each of the eight Variant C roles appears
  exactly once in the policy's compact catalogue.
- Route owners, `AUDIT_INDEX.md`, `FILE_MAP.md`, Prompting Protocol, Audit
  Contract, Code Map Standard/maps, and all `.agents/skills/**`: unchanged.
- Existing skill inventory: exactly five files; all post-edit SHA-256 hashes
  match the recorded pre-edit values.
- Markdown deletions: none; no architecture-adjacent owner was removed.
- Forbidden tracked diff: empty; no runtime, test, tool, schema, map, package,
  asset, `_incoming`, or scratch change.
- `HEAD == origin/main ==
  0d0987c91e35e7b8d54cb21e8eaefabcb8cbb58f`: unchanged.
- Nothing staged, committed, or pushed.

This artifact remains `DRAFTED / PENDING CLAUDE AUDIT` and claims no staging
permission.
