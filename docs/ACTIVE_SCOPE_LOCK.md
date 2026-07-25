# Active Scope Lock

## Route

Current: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS`

## Active authority

Only `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS` is active. This
Lane A docs-only pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS.md`

It must not edit `docs/FILE_MAP.md`, the archive, the archive README, any
pre-existing audit artifact, or the stale Board Canvas code-map anchor.

## Reserved future authority

`TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` is reserved but not active.
After independent acceptance and exact human commit/push of this scope lock,
plus a no-drift recheck, it may write exactly:

- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS.md`

The repair is docs-only and Lane A. It may change only the inaccurate wording
that calls the archive the disposition owner and the minimum truthful
route/audit/index records required by live governance.

`docs/archive/AUDIT_INDEX_ARCHIVE.md` remains the immutable historical ledger
snapshot. Per-pass disposition registers live in the corresponding
`docs/audit/*.md` artifacts. The repair must not edit the archive itself.

The Board Canvas code-map NIT, source-package cleanup, repo-skill hardening,
code-map expansion, runtime, schema, tool, test, Dart, Flutter, package, asset,
Project ZIP, `_incoming`, and protected-semantic work remain deferred and
unarmed.
