# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / Board Canvas visual rendering | current docs-only scope lock; RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW | Locks future replacement of marker-only Board Canvas placement visuals with real-looking component footprint renderers. Uses existing placement/projection data only; preserves selection, inspector, measurement summary, pan/zoom/fit, and read-only behavior; forbids runtime/test edits in this pass. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / Board Canvas visual rendering | next recommended | Arm the exact future runtime/test implementation allowlist after this scope lock is audited and accepted. Must not implement rendering during the sync pass. |

## Recent closeout context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| TRACEBENCH_DOCS_DRIFT_CURRENT_STATE_AND_QUEUE_COMPACTION_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT / cleanup_or_archive_planning | accepted/pushed as `b0ebd36` (`docs: close out docs compaction`) | Released docs-hygiene lock and returned route to `NEEDS_USER_DECISION` before this Board Canvas scope lock was opened. |
