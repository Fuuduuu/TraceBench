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
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

No active pass is armed. Route is `NEEDS_USER_DECISION`.

## Recent Board Canvas footprint implementation context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / Board Canvas visual rendering | accepted/pushed as `8fad35d` (`docs: lock Board Canvas real component footprints`) | Locked future Board Canvas visual-only real-looking component footprint rendering scope; design source input-only; no runtime/test/protected changes. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_ROUTE_SYNC_PASS | CODEX / DOCS_ROUTE_SYNC / Board Canvas visual rendering | accepted/pushed as `32e89f5` (`docs: sync Board Canvas footprint route`) | Advanced route from scope-lock current to active-lock-sync current so implementation could be armed; no runtime/test implementation. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / Board Canvas visual rendering | repaired docs-only active-lock sync; `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW` | Recorded route-sync hash `32e89f5a1771b67474899d0c77433a98678df043`, armed exact implementation allowlist, and routed to implementation. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS | CODEX / FLUTTER_PASS / Board Canvas visual rendering | accepted/pushed as `02cd557` (`feat(board-canvas): render component footprints`) | Rendered recognizable component footprint bodies, enabled bodyOnly contact visibility, kept contacts/pads/legs off component image until future confirmed visual-contact layout, kept real pin selection in the right-side list, centered right-panel preview parity, removed old standalone M/M3 marker bubble, preserved no visual rotation and `renderer writes: none`. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT / Board Canvas visual rendering | completed closeout; route set to `NEEDS_USER_DECISION`; `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW` | Records manual smoke `PASS`, audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`, non-blocking nits, validation, protected-surface boundaries, and releases the active lock. |
