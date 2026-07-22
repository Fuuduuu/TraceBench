# Pass Queue

## Current route

Current: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS`

## Current pass

The current docs-only scope lock may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS.md`

It creates no archive and makes no historical disposition. Its audit entry is
a `PRE-AUDIT SNAPSHOT` with no verdict or staging-safety claim.

## Conditional next pass

`TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS` is the sole reserved next
pass. It remains non-executable until this amendment is independently audited
and accepted, the human commits and pushes the exact accepted five-file set,
and a fresh no-drift recheck confirms the accepted commit at local and live
`main`.

When those gates are satisfied, the next pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/archive/AUDIT_INDEX_ARCHIVE.md`
- `docs/FILE_MAP.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`

After successful archive, evidence disposition, and compaction, that pass must
set all three route owners to `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
Those matching values are a non-executable sentinel, not a pass self-loop; no
recursive closeout or audit-of-audit pass is permitted.

The future pass must recompute its live starting ledger inventory, separately
record pipe-line count and true PASS_ID data-row count after excluding the
markdown header and separator, and reconcile the supplied accepted/pushed/
audited Board Outline closeout evidence before releasing the route.

No source-package cleanup, repo-skill hardening, code-map expansion, runtime,
schema, tool, test, Dart, Flutter, or protected-surface pass is queued or
armed.
