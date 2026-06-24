# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW | accepted/pushed as `6711c6b` (`docs: lock integrated measurement panel scope`) | Locked future visual-first integrated measurement panel direction and protected boundaries only; did not implement runtime UI, save/write behavior, or protected data semantics. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | current docs-only active-lock sync | Arms the future implementation pass with an exact narrow Board Canvas runtime/test allowlist near write-flow boundaries; does not implement runtime behavior and does not mark implementation accepted/pushed. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS | CODEX / FLUTTER_UI_PROTECTED_IMPLEMENTATION | next armed implementation after sync acceptance | Future narrow implementation may add only a visual-first right-side non-writing measurement panel shell/local UI state in the files listed by `docs/ACTIVE_SCOPE_LOCK.md`; save/value/unit controls are inert or local UI-only placeholders, Measure Sheet remains the only functional save path, manual smoke is required before Claude audit, and unscoped writer/schema/materializer/projection/event/fact changes remain forbidden. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with measurement panel, menu, Home, or write-flow work. |
