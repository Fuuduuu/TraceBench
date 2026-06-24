# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT | current docs-only closeout | Record accepted/pushed `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` at `4a7ac96`, release the implementation lock, and route to `NEEDS_USER_DECISION`. |
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS | CODEX / FLUTTER_NAV_POLISH | accepted/pushed as `4a7ac96` (`feat(board-canvas): consolidate measurement navigation`) | Implementation accepted after manual smoke PASS and Claude `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; Board Canvas measurement entry reaches the accepted Measure Sheet route and Back returns to Board Canvas; `/project/measure-sheet`, Project Overview measurement entry, Measure Sheet save behavior, Home/Menu/Add Component behavior, and protected boundaries remain preserved. |
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ROUTE_ACTIVE_LOCK_SYNC | accepted/pushed as `8c27bae` (`docs: arm measurement navigation consolidation`) | Armed the narrow measurement navigation implementation allowlist; superseded by accepted implementation and this closeout. |
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | CODEX / DOCS_PROTECTED_SCOPE_LOCK | future protected route option, not armed | Future visual-first integrated/right-side measurement panel scope-lock; crosses into write-flow and protected workflow territory and must not be implemented without a separate protected scope-lock. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with layout, menu, Home, or write-flow work. |
