# Pass Queue

## Current route

Current: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS`

## Current docs-only scope lock

This pass records the human-confirmed Variant C architecture, reconciles the
accepted Board Canvas test-map closeout, and reserves one separate docs-only
architecture decision. It does not create or edit skills, tools, validators,
the future spec, runtime, tests, or protected surfaces.

## Armed next pass

After this scope lock is independently audited, accepted, committed, and
pushed, the decision pass may write exactly:

- `docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS.md`

The decision pass must classify all five existing repo skills, define the
eight-skill catalogue and trigger/composition boundaries, keep canonical docs
authoritative, reserve mechanical checks for tools/validators, require
meaningful RED/GREEN evidence for every new or materially rewritten skill, and
decompose later skill implementation into narrow batches.

No active-lock sync follows this scope lock. No skill implementation,
Photo-to-Canvas work, automatic loader, plugin/MCP installation, tooling
change, or all-eight-skills implementation batch is queued.
