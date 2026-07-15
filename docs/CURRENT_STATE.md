# Current State

Current pass: `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS`

## Charter and accepted baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop
authority.

Baseline `20b76d291fa1898da0fd4cadc0e6002b6bc9ddb8`
(`docs: close out board canvas project navigation hub`) is accepted, pushed,
and audited. Claude returned `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, blockers
none, and nits none for that closeout.

## Active docs-only objective

This pass locks one later Lane A docs-only amendment that integrates mandatory
tool/skill preflight and task-specific Dart code-map preflight into prompting,
agent routing, audit checks, and documentation loading.

The layered owner model is fixed:

- `docs/code_maps/CODE_MAP_STANDARD.md` owns map qualification, structure,
  evidence/write classes, SNIPER use, drift, maintenance, and map audit.
- `docs/PROMPTING_PROTOCOL.md` owns mandatory prompt fields and compact hooks.
- `AGENTS.md` owns task-specific agent routing and stop behavior.
- `docs/AUDIT_CONTRACT.md` owns independent audit checks.
- `docs/FILE_MAP.md` owns documentation loading and ownership routing.

No governance amendment is made in this scope-lock pass. The later amendment
may write exactly those five owner documents. It may not edit
`CODE_MAP_INDEX.md`, any existing map, runtime, tests, schemas, tools, packages,
assets, `_incoming`, or route/audit docs.

No active-lock sync is required or authorized. After this scope lock is
accepted and pushed, the route proceeds directly to
`TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_PASS`.

Scope-lock evidence:
`docs/audit/TRACEBENCH_CODE_MAP_PROMPTING_INTEGRATION_SCOPE_LOCK_PASS.md`.
