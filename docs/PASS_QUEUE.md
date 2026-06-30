# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

No active or near-future implementation/docs pass is selected. The route is parked at `NEEDS_USER_DECISION`.

## Recent closeout context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS | CODEX / DOCS_DRIFT_MINI_CLEANUP / cleanup_or_archive_planning | accepted/pushed as `9f7e5ec` (`docs: compact current state and pass queue`) | Compacted docs/CURRENT_STATE.md to 49 lines and docs/PASS_QUEUE.md to 32 lines; moved 59 completed queue rows byte-verbatim into docs/PASS_QUEUE_ARCHIVE.md; no runtime/protected/canonical changes. |
| TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT / cleanup_or_archive_planning | docs-only closeout drafted; route after closeout `NEEDS_USER_DECISION` | Records audit acceptance, validation, archive-before-delete outcome, and releases the docs-hygiene lock. |
