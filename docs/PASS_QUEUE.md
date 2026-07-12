# Pass Queue

## Current route

Current: `TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_CODE_MAP_STANDARD_BOOTSTRAP_PASS`

## Current docs-only scope lock

`TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS` locks the code-map framework direction, task-specific loading, non-authorization boundaries, independent production/test qualification, committed-state and symbol-anchor rules, and the exact two-file bootstrap allowlist.

Current write set:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS.md`

## Armed bootstrap

`TRACEBENCH_CODE_MAP_STANDARD_BOOTSTRAP_PASS` may create exactly:

- `docs/code_maps/CODE_MAP_STANDARD.md`
- `docs/code_maps/CODE_MAP_INDEX.md`

The bootstrap defines the standard and an actual-map-only index. It must not create a production map, test map, Board Canvas map, tool, linter, refactor, or `docs/FILE_MAP.md` change. The first production map requires a later separate pass.

Detailed requirements: `docs/ACTIVE_SCOPE_LOCK.md` and `docs/audit/TRACEBENCH_CODE_MAP_STANDARD_SCOPE_LOCK_PASS.md`.

Do not stage, commit, or push from this scope-lock pass.
