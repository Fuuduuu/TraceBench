# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current-state maintenance trigger pointer

Canonical owner: `docs/MEMORY_MAINTENANCE.md`. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT | accepted/pushed as `934a5a4` (`docs: record integrated measurement panel shell`) | Recorded accepted/pushed integrated measurement panel shell implementation `0d015c9`, released the prior implementation active lock, preserved no-write Board Canvas boundaries, and routed to `NEEDS_USER_DECISION`. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW | accepted/pushed as `375adbe` (`docs: lock measurement target capture scope`) | Locked the next integrated Measure panel UX slice for local UI-only target selection and draft value/unit capture; did not implement runtime behavior and routed to active-lock sync before implementation. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | accepted/pushed as `ff271db` (`docs: arm measurement target capture implementation`) | Armed `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS` with exact Board Canvas runtime/test allowlist and non-writing target-capture boundaries; did not implement runtime behavior. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS | CODEX / FLUTTER_UI_PROTECTED_IMPLEMENTATION | accepted/pushed as `80c9bff` (`feat(board-canvas): add measurement target capture`) | Manual smoke before Claude audit: user-reported `PASS_WITH_NITS` after UI parity/micro-polish review; remaining nits were visual polish only and did not affect non-writing boundaries. Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; added local UI-only target selection, inline draft value/unit controls, component visual before measured values, separate From -> To display/provenance context, preserved Continue in Measure Sheet compatibility, and did not add Board Canvas save/write behavior. |
| V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT | accepted/pushed as `d39db25` (`docs: record measurement target capture`) | Recorded accepted/pushed implementation `80c9bff`, released the implementation active lock, preserved no-write boundaries, and routed to `NEEDS_USER_DECISION`; no runtime/test/protected edits in closeout. |
| V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_POLISH | current docs-only scope-lock | Locks the next narrow non-writing integrated Measure panel polish slice for visual density, spacing, measured-value row readability, compact controls, quiet Advanced behavior, secondary Continue in Measure Sheet styling, and compact From -> To context; does not arm runtime implementation. |
| V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | next after scope-lock acceptance | Should arm `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS` only after this scope-lock is accepted/pushed, with exact expected allowlist `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`; no runtime/test implementation in the sync pass. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with measurement panel, menu, Home, or write-flow work. |
