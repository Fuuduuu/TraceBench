# Active Scope Lock

## Current pass

`TRACEBENCH_CODEX_SKILLS_AND_MCP_POLICY_PASS`

## Type

`CODEX / DOCS_AND_AGENT_SKILLS_PASS`

## Lane

`CODEX / DOCS_AND_AGENT_SKILLS_PASS`

## Mode

Repo-local docs/agent-skills pass that writes:

- `AGENTS.md`
- `.agents/skills/tracebench-*`
- `docs/CODEX_TOOLING_POLICY.md`

No runtime/tooling install or dependency changes are allowed in this pass.

## Next recommended pass

`TRACEBENCH_CODEX_SKILLS_AND_MCP_POLICY_POST_AUDIT_PASS`

## Write allowlist for this pass

- `AGENTS.md`
- `.agents/skills/tracebench-scope-lock/SKILL.md`
- `.agents/skills/tracebench-docs-closeout/SKILL.md`
- `.agents/skills/tracebench-safe-staging/SKILL.md`
- `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
- `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/TRACEBENCH_CODEX_SKILLS_AND_MCP_POLICY_PASS.md`

## Forbidden surfaces

- `lib/**`, `test/**`, and runtime implementation paths.
- `schemas/`, `validator/`, `materializer/`, writer-service runtime files.
- `Project ZIP`, `Board Canvas` write/edit runtime, `Reference Images` runtime.
- `AI/OCR/CV`, `Activity Timeline`, `Measure Momentum`.
- `Photo Markup`, `Repair Map`, `Visual Trace Shape Assist`.
- `samples/`, generated artifacts, platform folders, tags/releases.
- plugin dependency updates, MCP/plugin enablement, or external installs in this pass.

## Route lock

Current: `TRACEBENCH_CODEX_SKILLS_AND_MCP_POLICY_PASS`
Next: `TRACEBENCH_CODEX_SKILLS_AND_MCP_POLICY_POST_AUDIT_PASS`
