# Current State

Current pass: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS`

The current pass is a Lane A docs-only scope lock for one later correction to
the inaccurate archive disposition-owner wording in `docs/FILE_MAP.md`. It
does not perform that repair.

## Current authority

Only `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS` is active. Its
exact write allowlist is:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS.md`

## Reserved repair

`TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` is reserved, not active. It
may begin only after this exact scope lock is independently accepted, committed
and pushed by the human, followed by a no-drift recheck.

Its exact future write allowlist is:

- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS.md`

The archive remains the immutable historical ledger snapshot. Per-pass
disposition registers live in their corresponding `docs/audit/*.md` artifacts.
The stale Board Canvas code-map anchor status remains deferred and unarmed.
