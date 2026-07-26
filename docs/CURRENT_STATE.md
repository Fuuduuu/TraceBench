# Current State

Current pass: `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

The current Lane B docs-only pass resolves the known
`BLOCKED_CODE_MAP_REQUIRED` gate for
`lib/shared/services/project_creator.dart` by creating its maintained code map
and adding exactly one registry entry. It does not retry, activate, or reserve
New Project Wizard V2 implementation.

## Current authority

Only `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS` is active. Its exact
write allowlist is:

- `docs/code_maps/lib/shared/services/project_creator.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS.md`

The pass remains current until independent Claude audit and exact human
commit/push. `NEEDS_USER_DECISION` is the non-executable next-route sentinel
and grants no write authority.

## Boundary

The map and registry entry describe only verified current source and focused
test behavior. No Dart, schema, test, tool, UI, router, event, writer, Project
ZIP, asset, `_incoming`, or design-input file may change. No future
implementation allowlist or successor pass is reserved.
