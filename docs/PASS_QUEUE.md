# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT | accepted/pushed as `934a5a4` (`docs: record integrated measurement panel shell`) | Recorded accepted/pushed integrated measurement panel shell implementation `0d015c9`, released the prior implementation active lock, preserved no-write Board Canvas boundaries, and routed to `NEEDS_USER_DECISION`. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW | current docs-only protected UI scope-lock | Locks the next integrated Measure panel UX slice for local UI-only target selection and draft value/unit capture; does not implement runtime behavior and does not arm implementation directly. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | next after scope-lock acceptance | Future docs-only active-lock sync must name the implementation pass and exact runtime/test allowlist; it must preserve non-writing Board Canvas target-capture draft behavior unless a later separate writer scope explicitly authorizes Board Canvas write wiring. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with measurement panel, menu, Home, or write-flow work. |
