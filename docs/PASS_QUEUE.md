# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / Board Canvas visual rendering | current docs-only active-lock sync | Arm the exact future runtime/test implementation allowlist for `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`; must not implement rendering during the sync pass. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS | CODEX / FLUTTER_PASS / Board Canvas visual rendering | next recommended after active-lock sync acceptance | Replace marker-only Board Canvas placement visuals with real-looking component footprint renderers using existing placement/projection data only; preserve selection, inspector, measurement summary, pan/zoom/fit/reset, read-only/no-write language, and confirmed-status semantics. |

## Recent route-sync context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / Board Canvas visual rendering | accepted/pushed as `8fad35d` (`docs: lock Board Canvas real component footprints`) | Locked the future Board Canvas visual-only real-looking component footprint rendering scope; design source is input-only; no runtime/test/protected changes. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_ROUTE_SYNC_PASS | CODEX / DOCS_ROUTE_SYNC / Board Canvas visual rendering | current tiny route pointer sync; RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW | Advances route from scope-lock current to active-lock-sync current so implementation can be armed in the next pass; no runtime/test implementation. |
