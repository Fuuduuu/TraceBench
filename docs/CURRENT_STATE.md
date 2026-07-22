# Current State

Current pass: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS`

The current pass is a docs-only scope lock for one later audit-index archive
and compaction pass. The original lock was pushed as
`8e5f531be371442179e63588772dd0f40e0f3f17` (`docs: lock audit index archive
compaction`). This append-only amendment changes only the three route owners,
the existing audit-index row, and the existing scope-lock evidence artifact.

## Current authority

Only `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS` is active.
Its exact write allowlist is:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS.md`

The audit record and ledger row remain a `PRE-AUDIT SNAPSHOT`. This uncommitted
amendment claims no independent verdict and no staging-safety decision.

## Reserved next pass

`TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS` is reserved, not active. It
may begin only after this exact amendment diff is independently accepted,
committed and pushed by the human, followed by a no-drift recheck. Its exact
future write allowlist is:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/archive/AUDIT_INDEX_ARCHIVE.md`
- `docs/FILE_MAP.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`

The future pass must preserve the complete pre-compaction ledger, record both
pipe-line and true PASS_ID data-row counts, reconcile the supplied accepted
Board Outline closeout evidence, compact the active index, and then release all
three route owners to the non-executable `NEEDS_USER_DECISION` ->
`NEEDS_USER_DECISION` sentinel without a recursive closeout.

Source-package cleanup, repo-skill hardening, and code-map expansion remain
deferred and unarmed.
