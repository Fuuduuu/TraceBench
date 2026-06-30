# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS`

## Next recommended pass

`TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_POST_AUDIT_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS | CODEX / DOCS_DRIFT_MINI_CLEANUP / cleanup_or_archive_planning | current docs-only compaction pass; RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW | Compacts docs/CURRENT_STATE.md and docs/PASS_QUEUE.md, moves completed active-queue history to docs/PASS_QUEUE_ARCHIVE.md, records evidence in docs/audit/TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_PASS.md, and keeps runtime/protected surfaces untouched. |
| TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT / cleanup_or_archive_planning | next recommended after read-only audit acceptance | Record audit verdict, validation, line-count outcome, archive-before-delete outcome, release the docs-hygiene active lock, and route back to NEEDS_USER_DECISION; docs-only. |