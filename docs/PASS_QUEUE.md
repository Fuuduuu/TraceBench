# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW | current docs-only protected scope-lock | Lock future visual-first integrated measurement panel direction and protected boundaries only; do not implement runtime UI, save/write behavior, or protected data semantics. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ROUTE_ACTIVE_LOCK_SYNC | next docs-only active-lock decision | May arm a future implementation pass only after this scope-lock is accepted/pushed; must define the exact runtime/test allowlist and must not implement runtime behavior. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS | CODEX / FLUTTER_UI_PROTECTED_IMPLEMENTATION | future protected implementation, not armed | Future narrow implementation may add a visual-first right-side measurement panel only after active-lock sync; must preserve Measure Sheet compatibility, use manual smoke before Claude audit, and avoid unscoped writer/schema/materializer/projection/event/fact changes. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with measurement panel, menu, Home, or write-flow work. |
