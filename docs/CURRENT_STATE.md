# Current State

Current pass: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

The current pass is the accepted-lock Lane A docs-only repair for the inaccurate
archive disposition-owner wording in `docs/FILE_MAP.md`. It changes only that
owner-role cell plus the minimum route, index, and audit evidence required by
the active authority.

## Current authority

Only `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` is active. Its
exact write allowlist is:

- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS.md`

The repair remains active until independent Claude audit and exact human
commit/push. `NEEDS_USER_DECISION` is the non-executable next-route sentinel;
it is not active authority.

## Repair boundary

The archive remains the immutable historical ledger snapshot. Per-pass
disposition registers live in their corresponding `docs/audit/*.md` artifacts.
The archive, archive README, existing scope-lock artifact, all other audit
artifacts, the stale Board Canvas code-map anchor status, Project Sources,
skill-inventory findings, runtime, and protected semantics remain unchanged and
unarmed. No successor pass is reserved.
