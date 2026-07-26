# Pass Queue

## Current route

Current: `TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS`
Next: `NEEDS_USER_DECISION`

## Current docs-only repair

The current Lane B repair may write exactly:

- `docs/code_maps/lib/shared/services/project_creator.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_PROJECT_CREATOR_CODE_MAP_REPAIR_PASS.md`

It resolves only the missing maintained-map gate for
`lib/shared/services/project_creator.dart`, adds exactly one registry entry,
and records the minimum truthful route, ledger, and audit evidence.

## Conditional next state

The repair remains current pending independent Claude audit and exact human
commit/push. `NEEDS_USER_DECISION` remains a non-executable sentinel. No
future allowlist, Wizard V2 implementation pass, successor authority, or other
code-map work is queued or reserved.
