# TraceBench Repo Skills Architecture

Status: repo-local architecture decision. This document defines the skill
system; it does not implement a skill, tool, validator, loader, route, or
write authority.

## 1. Purpose, authority, and non-goals

This specification owns the TraceBench repo-skill catalogue, trigger
boundaries, composition model, portability model, and lifecycle expectations.
It keeps reusable judgment in skills without moving canonical truth or
pass-specific authority out of their existing owners.

This specification does not:

- create, edit, load, or retire a skill;
- authorize a pass, file, route, protected surface, stage, commit, or push;
- replace `AGENTS.md`, `docs/POHIKIRI.md`, operational route owners, semantic
  owners, source, tests, or exact pass prompts;
- change `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, or
  `docs/code_maps/CODE_MAP_STANDARD.md`;
- add automatic linting, hooks, CI, generators, or a permanent test harness;
  or
- classify, compact, or delete an existing Markdown owner.

All `tracebench-*` skills remain repo-local under `.agents/skills/**`. Any
generic or personal extraction requires a separate human decision and pass.

## 2. Foundational ownership

| Owner | Responsibility |
| --- | --- |
| Canonical repo docs | Product truth, governance authority, current route, semantic rules, and protected boundaries. |
| Skills | Reusable judgment and workflow technique, expressed as concise pointers to canonical owners. |
| Tools and validators | Deterministic mechanical invariants with repeated value. |
| Code maps | Descriptive source responsibilities, dependencies, impact evidence, write classes, and tests. |
| Each exact pass prompt | Its PASS_ID, baseline, exact allowlist, exclusions, stops, pass-specific delta, and validation. |
| Accepted committed source | Implementation reality for its scoped surface. |
| Tests | Executable behavior evidence; tests do not replace source or canonical semantic owners. |

Skills and code maps are non-authorizing. They cannot create or widen write
authority, arm a route, weaken a stop, open a protected surface, or override
the exact prompt and active lock.

## 3. Variant C catalogue and trigger boundaries

The catalogue contains exactly eight roles. A layer is organizational; it is
not an instruction to load every skill in that layer.

| Layer | Skill | Trigger boundary | Exclusion boundary |
| --- | --- | --- | --- |
| Core | `tracebench-prompt-authoring` | Use when drafting or materially revising a TraceBench pass prompt, handoff, or Claude audit packet. | Does not execute the pass or replace canonical prompt owners. |
| Lifecycle | `tracebench-scope-lock` | Use when a docs-only pass reserves a future pass route, exact allowlist, boundaries, and stops. | Not audit reconciliation, active-lock sync, implementation, or closeout merely because a PASS_ID contains `SCOPE_LOCK_PASS`. |
| Lifecycle | `tracebench-code-map-lifecycle` | Use when qualifying, creating, auditing, finalizing, drift-reviewing, updating, or retiring a code map. | Not ordinary mapped-file work whose reviewed disposition is `REVIEWED_NO_CHANGE`; maps never authorize source writes. |
| Lifecycle | `tracebench-audit-reconciliation` | Use when recording an already-returned independent verdict and pushed-commit evidence while route and authority remain unchanged. | Does not perform the audit, change route, release a lock, or close an implementation. |
| Lifecycle | `tracebench-docs-closeout` | Use when an accepted and pushed pass must update operational route/lock/ledger owners and preserve durable outcome evidence. | Not evidence-only reconciliation and never staging authority. |
| Specialized | `tracebench-flutter-widget-pass` | Use when implementing, repairing, diagnosing, or validating a narrow TraceBench Flutter/Dart UI or widget pass under active authority. | Not docs-only work or an unscoped event, schema, writer, or protected change. |
| Specialized | `tracebench-v2-event-boundary` | Use when a pass targets or materially affects V2 events, canonical writers, validators, materializers, known-facts projection, or canonical event semantics. | Not a demonstrably zero-write UI-only pass; protected authority remains mandatory. |
| Mechanical guard | `tracebench-safe-staging` | Use when verifying or performing an explicitly authorized exact-file staging operation after an accepted independent audit. | Does not grant staging permission, infer files, stage scratch, commit, or replace the accepted safe staging set. |

Trigger matching uses the requested work and live authority, not PASS_ID
substring matching alone. If no trigger applies, no skill is required merely
to fill the catalogue.

## 4. Existing inventory and dispositions

The current repository has five `tracebench-*` directories, each containing
only one concise `SKILL.md`. None has YAML frontmatter. Each is retained until
a separately scoped implementation batch proves and audits its replacement.

| Existing skill | Disposition | Evidence |
| --- | --- | --- |
| `tracebench-scope-lock` | `formalize/rewrite` | The useful lifecycle seed lacks discovery frontmatter, uses substring-only triggering, and carries stale read/output details instead of current canonical pointers. |
| `tracebench-docs-closeout` | `formalize/rewrite` | It lacks discovery frontmatter and conflates closeout with staging even when staging has not been authorized. |
| `tracebench-safe-staging` | `formalize/rewrite` | It lacks discovery frontmatter and duplicates mechanical scratch and command rules owned by repo guidance and Git checks. |
| `tracebench-flutter-widget-pass` | `formalize/rewrite` | It lacks discovery frontmatter, conditional code-map routing, current debugging/TDD composition, and the manual visual audit gate. |
| `tracebench-v2-event-boundary` | `formalize/rewrite` | It lacks discovery frontmatter and copies canonical semantic rules instead of primarily routing to their owners. |

There is no current evidence for `preserve`, `split`, or `retire`. The three
other catalogue roles do not exist and remain future implementation subjects.

## 5. Skill format contract

Every future repo skill uses:

- path `.agents/skills/<skill-name>/SKILL.md`;
- a directory and `name` containing lowercase letters, numbers, and hyphens
  only;
- YAML frontmatter with required `name` and `description` fields;
- a `name` that matches its directory;
- a third-person `description` beginning `Use when...` and containing trigger
  conditions only, not a workflow summary;
- a concise, pointer-based body that owns technique rather than copied truth;
- no current commit, active route, PASS_ID, or pass-specific allowlist; and
- supporting files only after evidence shows the material is reusable and too
  heavy to remain concise inline.

Canonical rule lists are referenced by owner and read when triggered. They are
not copied into a skill as a competing truth source.

## 6. Precedence and non-authorization

Precedence is resolved by conflict type rather than by choosing whichever
source is most permissive:

- authority and route conflicts resolve to `docs/POHIKIRI.md`, `AGENTS.md`,
  verified live Git state, the operational route owners, and
  `ACTIVE_SCOPE_LOCK.md`; an exact prompt may narrow that authority but never
  widen it;
- semantic conflicts resolve to the exact canonical document, spec, schema,
  and accepted runtime owner for that surface;
- implementation-fact conflicts resolve to accepted committed source and
  tests, which outrank descriptive code maps;
- skills remain below those owners and supply technique only; and
- tools and validators supply mechanical evidence but cannot decide semantic
  truth, authorize work, or select a more permissive owner.

Any unresolved disagreement stops the pass. A skill must never resolve a
conflict by silently broadening the prompt, allowlist, route, or validation.

## 7. Composition order and conflict resolution

Composition is conditional and narrow:

1. `tracebench-prompt-authoring` applies only while authoring or materially
   revising the pass handoff.
2. If a lifecycle trigger applies, select at most one primary lifecycle phase:
   scope lock, audit reconciliation, or docs closeout.
3. Apply `tracebench-code-map-lifecycle` only when the conditional code-map
   preflight finds lifecycle work such as qualification, drift, audit, or
   maintenance.
4. Apply a specialized execution skill only when its target trigger is met.
5. Apply `tracebench-safe-staging` last, only after an independent accepted
   audit and explicit human staging authority.

Conflict rules:

- scope lock, audit reconciliation, and closeout remain distinct phases; a
  pass combining their route-changing duties must decompose;
- code-map work never authorizes mapped source or test changes;
- the V2 boundary may strengthen a Flutter pass but never supplies protected
  write authority; without that authority the pass stops or decomposes;
- safe staging never inherits permission from closeout or from a skill name;
  it consumes only the exact accepted set supplied by the audit and human;
- a more specific skill may refine technique, but cannot weaken a broader
  canonical rule or stop; and
- unresolved overlap or independent responsibility zones produce a stop and
  a new human scope decision rather than an improvised merged workflow.

## 8. Relationship to the Prompting Protocol

`docs/PROMPTING_PROTOCOL.md` remains the canonical owner of required prompt
fields, lane selection, tool/skill and conditional code-map preflights, compact
versus full prompt form, audit packets, stop clauses, and exact staging rules.

`tracebench-prompt-authoring` may teach how to discover and apply that contract
without bloating a pass. It must point to the protocol, model routing, audit
contract, live route owners, and exact task-specific owners. It does not copy
stable blocks, decide the route, or make a prompt self-authorizing.

## 9. Relationship to the Code Map Standard

`docs/code_maps/CODE_MAP_STANDARD.md` owns map qualification, deterministic
paths, status, evidence and write classes, drift, lifecycle, audit, SNIPER
integration, dispositions, and stop outcomes. `CODE_MAP_INDEX.md` lists only
actual maps.

`tracebench-code-map-lifecycle` teaches when and how to apply those owners. It
does not require a map for every Dart file, turn `REVIEWED_NO_CHANGE` into an
edit, update a map from unfinished work, or authorize source, test, refactor,
or protected-surface changes.

## 10. Lifecycle boundaries

| Phase | Owns | Must not own |
| --- | --- | --- |
| Scope lock | Reserve a future exact route, allowlist, exclusions, stops, and acceptance contract. | Implementation, audit verdict, staging, or closeout. |
| Audit reconciliation | Record an already-returned verdict and pushed commit evidence with route and authority unchanged. | Performing the audit, releasing the lock, implementation, or route mutation. |
| Docs closeout | Record an accepted/pushed outcome, reconcile durable route evidence, release the completed lock, and record the next state already authorized by the exact prompt or human route decision. | Staging, implementation, route selection, or rewriting historical evidence. |

Active-lock sync remains a pass contract governed by canonical operational
docs. It is not folded into a skill simply because it is another lifecycle
step.

## 11. Tools, validators, and judgment boundary

Future tools or validators may own deterministic checks only after a separate
pass demonstrates repeated value. Eligible checks include:

- YAML parseability and required frontmatter fields;
- name/directory equality and lowercase-hyphen syntax;
- description prefix, file existence, duplicate names, and exact file counts;
- exact changed/staged set, forbidden-path detection, and `git diff --check`;
- route tuple equality and missing or dangling pointers; and
- mechanical stable-symbol presence checks that do not replace map-to-code
  audit, semantic drift judgment, or `MAINTAINED` status finalization.

Skills retain judgment about whether a trigger semantically applies, whether
a description is truly trigger-only, whether a pressure scenario is
meaningful, whether guidance should decompose, whether supporting files have
proven reuse, and whether canonical boundaries conflict.

This decision reserves those mechanical categories; it implements no tool,
validator, automatic loader, hook, or CI rule.

## 12. RED/GREEN pressure-scenario contract

Every new or materially rewritten skill requires its own evidence cycle:

1. Run a meaningful baseline pressure scenario without the proposed skill.
2. Record the exact failure, omission, or rationalization.
3. Add the minimum guidance that addresses that demonstrated failure.
4. Rerun the identical scenario with the proposed skill available.
5. Demonstrate compliance and record any remaining loophole or uncertainty.
6. Preserve the RED and GREEN evidence in that implementation pass's audit
   artifact before independent acceptance.

A scenario that already passes does not prove the skill is necessary. More
scenarios are required when the first one does not exercise the trigger or
pressure. No permanent harness is authorized until repeated reuse proves that
its mechanical value outweighs maintenance cost.

## 13. Narrow implementation batches

Later implementation remains decomposed into these batches:

| Batch | Purpose | Skills |
| --- | --- | --- |
| A | Core route authoring | `tracebench-prompt-authoring`, `tracebench-scope-lock`, `tracebench-audit-reconciliation` |
| B | Closure and staging safety | `tracebench-docs-closeout`, `tracebench-safe-staging` |
| C | Code-map lifecycle | `tracebench-code-map-lifecycle` |
| D | Specialized execution | `tracebench-flutter-widget-pass`, `tracebench-v2-event-boundary` |

Each batch requires its own exact scope and audit. Each skill inside a batch
still needs individual RED/GREEN evidence. No later pass may edit all eight
skills together without a new explicit human decision.

## 14. Portability model

| Skill | Classification | Extraction candidate | Required project bindings |
| --- | --- | --- | --- |
| `tracebench-prompt-authoring` | `PROJECT_ADAPTER` | `YES` | `AGENTS.md`, Prompting Protocol, Model Routing, Pass Lifecycle, and live route/lock owners. |
| `tracebench-scope-lock` | `PROJECT_ADAPTER` | `YES` | Default five owners, Audit Contract, relevant protected owners, and route ledger. |
| `tracebench-code-map-lifecycle` | `PROJECT_ADAPTER` | `YES` | Code Map Standard, index, applicable map/source/test, Prompting Protocol, and active lock. |
| `tracebench-audit-reconciliation` | `PROJECT_ADAPTER` | `YES` | Audit Contract, Audit Index, one exact artifact, Git evidence, and read-only route owners. |
| `tracebench-docs-closeout` | `PROJECT_ADAPTER` | `YES` | Current State, Pass Queue, Active Scope Lock, Audit Index, exact audit evidence, and Pass Lifecycle. |
| `tracebench-safe-staging` | `PROJECT_ADAPTER` | `YES` | `AGENTS.md` Git/scratch rules, active allowlist, accepted audit set, explicit human authority, and live Git state. |
| `tracebench-flutter-widget-pass` | `TECHNOLOGY_SPECIFIC` | `YES` | Flutter/Dart toolchain, active lock, code-map preflight, focused tests, UI workflow, protected boundaries, and manual-smoke gate. |
| `tracebench-v2-event-boundary` | `PROJECT_ONLY` | `NO` | Charter, Truth Index, Protected Surfaces, and exact schema/writer/validator/materializer/projection owners. |

`GENERIC_CORE` is a valid future classification but describes no current
repo-local catalogue entry. Extraction candidate `YES` records only a possible
future generic core; it is not permission to extract, publish, or install one.

## 15. Maintenance, drift, deprecation, and retirement

Review a skill when its trigger no longer selects the intended work, a
canonical pointer moves, the Prompting Protocol or Code Map Standard changes,
repeated agents bypass a boundary, deterministic checks move into tooling, or
pressure scenarios reveal new rationalizations.

Prefer the smallest rewrite that restores the trigger and technique. A skill
becomes a deprecation candidate when its trigger is no longer recurring, its
judgment is fully absorbed by a better-scoped skill, or only mechanical checks
remain. Retirement requires a separate exact-file pass, updated pointers, no
lost authority, preserved audit history, and proof that no supported workflow
still depends on it.

## 16. Future Markdown compaction model

Future docs work may assign exactly one disposition:

- `KEEP_CANONICAL` — retain the file as the authoritative owner;
- `COMPACT_AND_REPOINT` — keep a concise owner or pointer after detailed
  content has a better accepted owner; or
- `RETIRE_AND_DELETE` — remove a superseded non-audit file only through a
  dedicated exact-file pass.

Deletion is allowed only after the replacement owner is implemented and
audited, every pointer is updated, no canonical authority is lost, audit
history remains intact, no `FILE_MAP`/index/read-order reference dangles, and
a dedicated docs-compaction pass authorizes the exact files.

This architecture decision assigns no current Markdown disposition and
deletes nothing.

## 17. Risks, uncertainties, and explicit non-decisions

Risks to control in later batches:

- lifecycle triggers can overlap unless their route-changing duties stay
  distinct;
- copied canonical rules can drift inside concise-looking skills;
- mechanical checklists can displace judgment instead of moving to tools; and
- premature generic extraction can fragment repo-local authority.

Implementation must verify actual loader discovery and YAML behavior. Exact
generic-core interfaces, word limits, supporting-file layouts, permanent
pressure harnesses, and validator implementations remain undecided until
evidence justifies them.

This decision does not authorize a Photo-to-Canvas skill, generic/personal
skill, plugin or MCP, external download, dependency, automatic loader,
Markdown compaction, route change, runtime/test/map/schema/tool change, or any
writer, event, fact, projection, Project ZIP, or protected semantic change.
