# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW | accepted/pushed as `6711c6b` (`docs: lock integrated measurement panel scope`) | Locked future visual-first integrated measurement panel direction and protected boundaries only; did not implement runtime UI, save/write behavior, or protected data semantics. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | accepted/pushed as `710b87d` (`docs: arm integrated measurement panel implementation`) | Armed `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` with the exact Board Canvas runtime/test allowlist and non-writing shell boundary; did not implement runtime behavior. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS | CODEX / FLUTTER_UI_PROTECTED_IMPLEMENTATION | accepted/pushed as `0d015c9` (`feat(board-canvas): add integrated measurement panel shell`) | Manual smoke PASS and Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; added the Board Canvas right-side integrated Measure panel shell, kept Canvas visible, made measured values primary, kept quick capture inert/local only, preserved standalone Measure Sheet route compatibility, and did not add Board Canvas save/write behavior. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT | current docs-only closeout | Records accepted/pushed implementation `0d015c9`, releases the implementation active lock, preserves no-write boundaries, and routes after acceptance to `NEEDS_USER_DECISION`; no runtime/test/protected edits in closeout. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with measurement panel, menu, Home, or write-flow work. |
