# Active Scope Lock

## Route

Current: `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS`
Next: `NEEDS_USER_DECISION`

## Active authority

Only `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS` is active. This Lane B
docs-only pass may write exactly:

- `docs/code_maps/lib/shared/services/project_creator.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS.md`

It may create the maintained map for
`lib/shared/services/project_creator.dart`, add exactly one corresponding
`docs/code_maps/CODE_MAP_INDEX.md` entry, and update only the minimum route,
ledger, and audit evidence required by this pass.

The map must be grounded in current committed source and focused tests. It is
descriptive and non-authorizing; source, tests, canonical owners,
`docs/POHIKIRI.md`, and this lock outrank it.

The pass must not edit Dart, schema, tests, tools, UI, router, events, writers,
Project ZIP behavior, assets, `_incoming`, the design ZIP, `docs/FILE_MAP.md`,
or any prior audit artifact. It must not retry, activate, or reserve New
Project Wizard V2 implementation.

## Audit and release gate

The exact seven-file diff remains active until independent Claude audit under
`recovery / evidence-recheck` and exact human commit/push.
`NEEDS_USER_DECISION` grants no write authority. No future implementation
allowlist or successor pass is reserved.
