# Pass Queue

## Current route

Current: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS`

## Current scope lock

The current Lane A docs-only pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS.md`

It reserves but does not perform the FILE_MAP ownership-wording repair.

## Conditional next pass

`TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` remains non-executable
until this exact scope-lock diff is independently accepted, committed and
pushed by the human, followed by a no-drift recheck. Its exact future allowlist
is:

- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS.md`

The future pass may correct only the inaccurate ownership wording and the
minimum truthful route/audit/index records. It must not touch the archive.
The Board Canvas code-map NIT remains deferred and unarmed.
