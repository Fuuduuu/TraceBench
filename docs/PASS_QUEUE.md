# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ROUTE_ACTIVE_LOCK_SYNC | current docs-only active-lock sync | Record the user-selected `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`, arm its narrow future runtime/test allowlist, and do not implement Flutter/runtime/test changes in this sync pass. |
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS | CODEX / FLUTTER_NAV_POLISH | next armed implementation route | Narrow Workbench measurement navigation consolidation; preserve the standalone Measure Sheet route, `/project/measure-sheet` fallback/redirect, accepted Measure Sheet save behavior, Home/Menu/Add Component behavior, and protected-surface boundaries. |
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | CODEX / DOCS_PROTECTED_SCOPE_LOCK | future protected route option | Inline measurement-entry panel scope-lock; crosses from read-only UI into write-flow territory and requires dedicated protected-surface review. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with layout, menu, Home, or write-flow work. |
