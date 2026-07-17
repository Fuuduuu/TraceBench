# TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only architecture scope lock
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- Current: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS`

This pass locks the human-confirmed Variant C repo-skills architecture for a
separate docs-only decision. It does not create or edit a skill, architecture
spec, tool, validator, runtime file, test, map, package, asset, or protected
surface.

## Tool and skill preflight

`TOOL_SKILL_CHECK`:

- Relevant skill/tool/helper found: repo-local
  `.agents/skills/tracebench-scope-lock/SKILL.md`, `androbuss-pass-runner`,
  generic `skill-creator` and `writing-skills` methodology, Git, `rg`,
  PowerShell, and `tools/validate_all.py`.
- Capability actually used: `tracebench-scope-lock` supplies the narrowest
  repo-local docs-only lock workflow; `androbuss-pass-runner` supplies exact
  gate/allowlist discipline; the authoring guidance was used only to inspect
  frontmatter, trigger, concision, progressive-disclosure, and RED/GREEN
  expectations. No skill-authoring workflow or skill write authority was
  activated.
- Why applicable: this pass reserves one architecture decision, reconciles one
  accepted prior closeout, and must preserve exact write and non-authorization
  boundaries while evaluating the current skill inventory.
- External tool required: `NO`.

The generic skill helper includes a mechanical `quick_validate.py`, but no
skill is changed or validated in this pass and no dependency installation is
authorized or required. No plugin, MCP, download, or external service was
used.

## Code-map preflight

`CODE_MAP_PREFLIGHT: NOT_APPLICABLE` because the changed files are operational
and audit-governance Markdown only and the pass does not target or materially
depend on Dart production/test files.

Supporting gate evidence confirms the separate Board Canvas production and
test map rows remain `MAINTAINED`; neither map, its source, nor its index is
changed or used as write authority.

## Verified baseline and gate

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == 061ec7a0ce195e4d0560832631a25e55e3a0c1c2`
- Subject: `docs: close out board canvas test code map`
- Direct parent: `041d3a710ac3f35092532d831ffc04eb57e38ebc`
- Initial route: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- Tracked diff before editing: empty.
- Cached diff before editing: empty.
- `git diff --check` before editing: PASS.
- Board Canvas production and test maps: both `MAINTAINED`.
- Other armed pass: none.
- Known untracked scratch was present and remained outside scope.

Commit `061ec7a0ce195e4d0560832631a25e55e3a0c1c2` contains exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_POST_AUDIT_PASS.md`

The human selected this architecture scope lock from the no-active-pass route.
No charter, route, inventory, ownership, or protected-surface conflict was
found.

## Prior closeout reconciliation

`BOARD_CANVAS_SCREEN_TEST_CODE_MAP_POST_AUDIT_PASS` is accepted, pushed, and
audited at:

- commit: `061ec7a0ce195e4d0560832631a25e55e3a0c1c2`;
- subject: `docs: close out board canvas test code map`;
- Claude: `AUDIT_VERDICT: ACCEPT_AS_IS`;
- Claude: `SAFE_FOR_STAGING: YES`;
- blockers: none; and
- nits: none.

Only that row's pending status is reconciled in `docs/AUDIT_INDEX.md`; its
descriptive column remains unchanged. The historical closeout artifact is
outside this allowlist and remains unchanged.

## Human-confirmed Variant C architecture

The future decision must define exactly this catalogue:

| Layer | Skill |
| --- | --- |
| Core | `tracebench-prompt-authoring` |
| Lifecycle | `tracebench-scope-lock` |
| Lifecycle | `tracebench-code-map-lifecycle` |
| Lifecycle | `tracebench-audit-reconciliation` |
| Lifecycle | `tracebench-docs-closeout` |
| Specialized | `tracebench-flutter-widget-pass` |
| Specialized | `tracebench-v2-event-boundary` |
| Mechanical guard | `tracebench-safe-staging` |

No Photo-to-Canvas skill is included. The catalogue defines decision targets,
not permission to create or edit any skill in either this scope lock or the
future decision pass.

## Foundational ownership and precedence

| Owner | Exclusive responsibility |
| --- | --- |
| Canonical repo docs | Product truth, governance authority, current route, semantic rules, and protected boundaries. |
| Skills | Reusable judgment and workflow technique, expressed as concise pointers to canonical owners. |
| Tools and validators | Mechanical invariants that are deterministic and repeatedly valuable. |
| Code maps | Descriptive source responsibility, dependency, impact, boundary, and test evidence only. |
| Each pass prompt | Its own PASS_ID, baseline, exact allowlist, exclusions, pass-specific delta, stops, and validation. |

Source, tests, canonical owners, `docs/POHIKIRI.md`, and active authority outrank
skills and code maps. No skill may authorize a write, add a file to an
allowlist, open a protected surface, arm a pass, or override a prompt's exact
scope.

## Existing skill inventory and default dispositions

The repository contains exactly five `tracebench-*` skill directories and no
supporting files beneath them. All five use valid lowercase-hyphen directory
names, are concise at 22–42 lines / 113–145 words, and lack YAML frontmatter.

| Existing skill | Evidence requiring decision | Default disposition |
| --- | --- | --- |
| `tracebench-scope-lock` | Useful lifecycle seed and body trigger, but no discovery frontmatter; required reads/output predate the exact default-five, `TOOL_SKILL_CHECK`, conditional code-map, and audit-packet contracts. | `formalize/rewrite` |
| `tracebench-docs-closeout` | Useful route-ledger role, but no discovery frontmatter; overlaps staging and says to run an explicit staging command even when a pass forbids staging. | `formalize/rewrite` |
| `tracebench-safe-staging` | Valuable guard role, but no discovery frontmatter or explicit authorization trigger; mixes judgment with duplicated mechanical scratch/command checks. | `formalize/rewrite` |
| `tracebench-flutter-widget-pass` | Valid specialized role, but no discovery frontmatter; omits current default reads, tool/code-map preflight, TDD/debug composition, and manual-visual audit gate. | `formalize/rewrite` |
| `tracebench-v2-event-boundary` | Valid protected-boundary role, but no discovery frontmatter; restates canonical semantic rules rather than primarily routing to canonical owners. | `formalize/rewrite` |

No current evidence supports `preserve` as-is, `split`, or `retire`. The future
decision must still evaluate and record one of `preserve`,
`formalize/rewrite`, `split`, or `retire` for each existing skill rather than
treating this default as implementation authority.

Three Variant C roles do not currently exist:

- `tracebench-prompt-authoring`;
- `tracebench-code-map-lifecycle`; and
- `tracebench-audit-reconciliation`.

They remain decision subjects only. This pass creates no directory or file.

## Current gaps the decision must resolve

The future decision must resolve:

- missing formal YAML frontmatter and loader-visible discovery metadata;
- trigger-description quality and exact skill boundaries;
- overlap with canonical governance and semantic owners;
- stale or conflicting workflow wording;
- ordered and conditional composition between multiple skills;
- appropriate skill length and reference/supporting-file strategy;
- meaningful RED/GREEN pressure-scenario evidence;
- mechanical checks that should later migrate to tools/validators;
- lifecycle, review, deprecation, and drift triggers; and
- migration without widening the five-file default read set.

The current skills are already concise, so length alone does not justify a
split or supporting references. Reusable supporting material needs separate
evidence.

## Exact future decision allowlist

After this scope lock is independently audited, accepted, committed, and
pushed, `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS` may write exactly:

- `docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS.md`

No fourth file, wildcard, optional expansion, or skill edit is authorized.
`docs/FILE_MAP.md` already assigns generic ownership to `docs/spec/**`; if a
genuine ownership conflict appears, the decision pass must stop rather than
expand its allowlist.

## Locked decision-spec content

The future architecture spec must define:

1. purpose and non-goals;
2. existing skill inventory and one disposition per existing skill;
3. accepted Variant C architecture;
4. canonical precedence and non-authorization;
5. the exact eight-skill catalogue and trigger boundaries;
6. required `SKILL.md` frontmatter and content contract;
7. cross-skill composition matrix;
8. prompt-authoring relationship to `PROMPTING_PROTOCOL.md`;
9. code-map relationship to `CODE_MAP_STANDARD.md`;
10. scope-lock, audit-reconciliation, and closeout lifecycle boundaries;
11. mechanical checks reserved for validators/tools;
12. RED/GREEN pressure-test method and evidence location;
13. decomposition into narrow future implementation passes;
14. maintenance, review, deprecation, and drift triggers; and
15. risks, uncertainties, and explicit non-decisions.

The spec must remain descriptive and decision-bearing. It cannot itself
authorize any later skill, tool, validator, runtime, test, or protected write.

## Locked skill format direction

The decision must evaluate and lock:

- path: `.agents/skills/<skill-name>/SKILL.md`;
- YAML frontmatter containing `name` and `description`;
- lowercase letters, numbers, and hyphens for names;
- `description` begins with `Use when...`;
- `description` contains triggering conditions only and does not summarize the
  workflow;
- the body is concise and points to canonical owners rather than copying them;
- no current commit hash, active route, or pass-specific allowlist appears in
  a skill; and
- supporting files exist only when genuinely reusable and too heavy for
  `SKILL.md`.

The stricter trigger-only description is the human-locked TraceBench contract.
Generic authoring guidance is method input, not authority to weaken it.

## Locked RED/GREEN pressure-test direction

For every new or materially rewritten skill, a later implementation pass must:

1. establish baseline failure without the new/revised skill;
2. record the exact agent rationalization or missed guard;
3. add the minimum skill guidance;
4. rerun the same scenario with the skill;
5. verify compliance; and
6. record evidence in that implementation-pass audit artifact.

At least one meaningful scenario is required per new or materially rewritten
skill before acceptance. No permanent test harness is authorized until
repeated value is demonstrated. Historical use alone is not RED/GREEN proof.

## Locked implementation decomposition

The future decision must propose narrow batches. The expected direction is:

- A — core route authoring: `tracebench-prompt-authoring`,
  `tracebench-scope-lock`, and `tracebench-audit-reconciliation`;
- B — closure and staging safety: `tracebench-docs-closeout` and
  `tracebench-safe-staging`;
- C — code-map lifecycle: `tracebench-code-map-lifecycle`; and
- D — specialized execution: `tracebench-flutter-widget-pass` and
  `tracebench-v2-event-boundary`.

The decision may refine these batches, but it may not combine all eight skill
changes into one implementation diff without explicit human approval.

## Preserved surfaces and non-goals

This scope lock and the future decision exclude:

- Photo-to-Canvas skill or architecture changes;
- any skill creation, edit, move, split, or retirement;
- `AGENTS.md`, `PROMPTING_PROTOCOL.md`, `AUDIT_CONTRACT.md`, `FILE_MAP.md`,
  `CODE_MAP_STANDARD.md`, and `docs/code_maps/**` changes;
- automatic skill loading, linting, validation, hooks, CI, or generators;
- plugin/MCP installation, external downloads, or dependency changes;
- tools, validators, Dart/runtime, tests, schemas, packages, assets,
  `_incoming`, and scratch;
- routes, writers, events, facts, projections, Project ZIP, canonical or
  protected semantics; and
- active-lock sync or implementation authority.

Known scratch remains untouched and outside every staging set.

## Route and model ownership

After this scope lock:

- Current: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS`

No active-lock sync is required because the future decision is Lane A,
docs-only, and has no skill/runtime/tool authority.

`MODEL_ROUTING_CHECK result: PASS` — Codex drafts this narrow repo-local scope
lock, Claude Code performs the independent read-only audit, ChatGPT/GPT Pro
owns architecture/risk review, and the human owns exact staging, commit, push,
and any later scope expansion.

## Exact current write set

This pass writes exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS.md`

Nothing is staged, committed, or pushed.

## Validation record

- `python tools/validate_all.py`: PASS — 285 tests. The initial sandboxed run
  was permission-blocked on repo `.codex` outputs and Windows temporary
  directories; the required host-permission rerun completed with 285/285
  tests passing.
- `git diff --check`: PASS.
- Changed-file scope: PASS — exactly the four modified operational/audit docs
  plus this one new audit artifact.
- `git diff --cached --name-status`: empty.
- `HEAD == origin/main ==
  061ec7a0ce195e4d0560832631a25e55e3a0c1c2`: PASS and unchanged.
- Route owners agree on
  `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS`.
- Future decision allowlist: exactly three files; no future decision row or
  active-lock sync was added.
- Prior closeout reconciliation: PASS — only its index status changed; the
  descriptive column is byte-identical to `HEAD`.
- `AUDIT_INDEX.md` new scope row count: one; glued `||` rows: none.
- Existing skill inventory: exactly five; all pre-edit SHA-256 hashes remain
  unchanged; no skill/supporting file was created or edited.
- Board Canvas production/test maps and index rows remain `MAINTAINED` and
  unchanged.
- Future architecture spec and future decision audit artifact: absent.
- Forbidden tracked diff: empty; no skill, spec, policy owner, map, runtime,
  test, tool, schema, package, asset, or `_incoming` change.
- Known untracked scratch set: unchanged and unstaged.
- Nothing was staged, committed, or pushed.

This artifact remains `DRAFTED / PENDING CLAUDE AUDIT` and claims no staging
permission.
