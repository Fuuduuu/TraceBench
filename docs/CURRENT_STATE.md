# Current State

Current pass: `NEEDS_USER_DECISION`
Next recommended pass: `NEEDS_USER_DECISION`

## Charter and accepted baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop
authority.

The code-map prompting governance amendment is accepted, pushed, and audited
as `f5c34dc776ec1380c13c47053b0ff535e25ad1fa`
(`docs: integrate code maps into prompting governance`). Claude returned
`ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`; blockers none; nits none. Its exact
accepted set was `AGENTS.md`, `docs/PROMPTING_PROTOCOL.md`,
`docs/AUDIT_CONTRACT.md`, `docs/FILE_MAP.md`, and
`docs/code_maps/CODE_MAP_STANDARD.md`.

Accepted chain:

- scope lock `5a9098016efe057b8e64145117dd79778a2a5f69`;
- scope-audit reconciliation `7dd21a13f77f6e663d8e04de968043c67b3ec5be`;
- governance amendment `f5c34dc776ec1380c13c47053b0ff535e25ad1fa`.

## Closed governance outcome

TraceBench governance now requires mandatory `TOOL_SKILL_CHECK` for every
Codex `PASS_ID` prompt and final report, plus conditional `CODE_MAP_PREFLIGHT`
for work targeting or materially depending on Dart production/test files.
Applicable preflights report map/index/qualification evidence, changed or
inspect-only zones, dependencies, blast radius, write class, tests/helpers,
and exactly one disposition: `REVIEWED_NO_CHANGE`, `UPDATE_REQUIRED`, or
`NOT_APPLICABLE`.

The exact code-map stop outcomes are `BLOCKED_CODE_MAP_REQUIRED`,
`BLOCKED_CODE_MAP_STALE`, `BLOCKED_CODE_MAP_CONFLICT`,
`BLOCKED_ALLOWLIST_MISMATCH`, and `DECOMPOSE_REQUIRED`. Detailed map lifecycle
ownership remains in `CODE_MAP_STANDARD.md`; prompt hooks, agent routing,
independent audit, and loading rules remain in their respective accepted
owners.

Maps remain descriptive and non-authorizing. The default read set remains
exactly five files; the standard, index, and applicable maintained maps remain
on-demand. No map/index, runtime, test, schema, tool, package, asset, route, or
protected product behavior changed.

The docs-only amendment authority is released and no follow-up pass is armed.

Closeout evidence:
`docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_POST_AUDIT_PASS.md`.
