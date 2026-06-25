# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT | accepted/pushed as `934a5a4` (`docs: record integrated measurement panel shell`) | Recorded accepted/pushed integrated measurement panel shell implementation `0d015c9`, released the prior implementation active lock, preserved no-write Board Canvas boundaries, and routed to `NEEDS_USER_DECISION`. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW | accepted/pushed as `375adbe` (`docs: lock measurement target capture scope`) | Locked the next integrated Measure panel UX slice for local UI-only target selection and draft value/unit capture; did not implement runtime behavior and routed to active-lock sync before implementation. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | current docs-only active-lock sync | Arms the future target-capture implementation pass with an exact narrow Board Canvas runtime/test allowlist; does not implement runtime behavior and does not mark implementation accepted/pushed. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS | CODEX / FLUTTER_UI_PROTECTED_IMPLEMENTATION | next armed implementation after sync acceptance | Future implementation may add only local UI-only target row selection, pin/leg selection, draft value/unit state, validation hints, and Canvas focus/highlight/preview in the files listed by `docs/ACTIVE_SCOPE_LOCK.md`; no Board Canvas canonical write/save behavior, writer wiring, or protected data-surface change is authorized. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with measurement panel, menu, Home, or write-flow work. |
