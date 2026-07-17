# Active Scope Lock

## Route

Current: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Current write authority

This docs-only scope lock may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS.md`

No wildcard, optional expansion, skill implementation, tool/validator change,
runtime/test change, staging, commit, or push is authorized.

## Locked Variant C direction

The future architecture decision must define:

- core: `tracebench-prompt-authoring`;
- lifecycle: `tracebench-scope-lock`, `tracebench-code-map-lifecycle`,
  `tracebench-audit-reconciliation`, and `tracebench-docs-closeout`;
- specialized: `tracebench-flutter-widget-pass` and
  `tracebench-v2-event-boundary`; and
- mechanical guard: `tracebench-safe-staging`.

Canonical docs own truth, authority, routes, and semantic rules. Skills own
reusable judgment/workflow technique only. Tools and validators own mechanical
invariants. Code maps own descriptive responsibility/impact evidence. Each
prompt owns its pass-specific identity, baseline, allowlist, exclusions, and
delta. No skill may authorize or expand writes.

The five existing repo skills are preserved for inspection and default to
`formalize/rewrite` in the decision unless source evidence justifies
`preserve`, `split`, or `retire`. This lock does not decide implementation
content or modify any `SKILL.md`.

## Future decision authority

After this scope lock is independently audited, accepted, committed, and
pushed, `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS` may write exactly:

- `docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS.md`

No fourth file, wildcard, optional expansion, or skill edit is authorized.
The generic `docs/spec/**` ownership route already exists, so
`docs/FILE_MAP.md` remains unchanged. Stop rather than widen scope if a genuine
ownership conflict appears.

## Decision requirements and boundaries

The decision must cover purpose/non-goals, inventory/dispositions, Variant C,
canonical precedence/non-authorization, exact triggers, required YAML
frontmatter/content, composition, prompting and code-map relationships,
lifecycle boundaries, validator-owned checks, RED/GREEN pressure evidence,
narrow implementation batches, maintenance/deprecation/drift, and explicit
risks/non-decisions.

Skill paths remain `.agents/skills/<skill-name>/SKILL.md`; names use lowercase
letters, numbers, and hyphens; descriptions begin `Use when...`, contain only
triggering conditions, and do not summarize workflow. Skills must stay concise
and pointer-based, with no current commit, active route, or pass-specific
allowlist. Reusable supporting files require evidence that they are both
reusable and too heavy for `SKILL.md`.

Every new or materially rewritten skill later requires a meaningful RED/GREEN
pressure scenario before acceptance. The decision must split later work into
narrow batches rather than combine all eight skill changes.

## Preserved surfaces and stops

No Photo-to-Canvas architecture, skill implementation, `AGENTS.md`,
`PROMPTING_PROTOCOL.md`, `AUDIT_CONTRACT.md`, `FILE_MAP.md`, code-map Standard
or map, tool/validator, plugin/MCP, automatic loader, runtime, test, schema,
package, asset, `_incoming`, scratch, route behavior, writer, event, fact,
projection, Project ZIP, or protected-surface change is authorized.

Stop on `BLOCKED_BASELINE_MISMATCH`, `BLOCKED_DIRTY_STATE`,
`BLOCKED_ALLOWLIST_MISMATCH`, `BLOCKED_GOVERNANCE_CONFLICT`, or
`BLOCKED_SKILL_INVENTORY_MISMATCH`.
