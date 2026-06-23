# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`TRACEBENCH_OPERATIONAL_HANDOFF_COMPACTION_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| TRACEBENCH_OPERATIONAL_HANDOFF_COMPACTION_PASS | CODEX / DOCS_SYNC | current docs-only operational handoff compaction | Compact `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md` into current-route control-plane docs; preserve auditability through `AUDIT_INDEX`, `docs/audit`, `PASS_QUEUE_ARCHIVE`, and git history; no runtime/test/product behavior changes. |
| NEEDS_USER_DECISION | USER / ROUTE_DECISION | next route | Choose the next protected product/runtime/docs track after accepted BenchBeep Home launcher and Menu System work. |
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | CODEX / DOCS_PROTECTED_SCOPE_LOCK | future protected route option | Inline measurement-entry panel scope-lock; crosses from read-only UI into write-flow territory and requires dedicated protected-surface review. |
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS | CODEX / FLUTTER_NAV_POLISH | future route option | Route/navigation consolidation; keep `/project/measure-sheet` fallback/redirect and do not casually delete standalone Measure Sheet routing. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with layout, menu, Home, or write-flow work. |