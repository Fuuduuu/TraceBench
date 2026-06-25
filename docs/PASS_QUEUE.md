# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS`

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
| V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_POLISH | accepted/pushed as `42c3594` (`docs: lock measurement panel visual density scope`) | Locked the next narrow non-writing integrated Measure panel polish slice for visual density, spacing, measured-value row readability, compact controls, quiet Advanced behavior, secondary Continue in Measure Sheet styling, and compact From -> To context; did not arm runtime implementation. |
| V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | accepted/pushed as `6b919fa` (`docs: arm measurement panel visual density implementation`) | Armed `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS` with exact allowlist `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`; no runtime/test implementation in the sync pass and no implementation accepted/pushed hash claim. |
| V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS | CODEX / FLUTTER_UI_PROTECTED_IMPLEMENTATION | accepted/pushed as `8b140d6` (`feat(board-canvas): polish measurement panel density`) | Manual smoke evidence supplied by user: `all passed`. Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; polished integrated Measure panel visual density, compacted header and copy, improved measured-value row readability, compacted value/unit controls, made Continue in Measure Sheet secondary, kept From -> To display/provenance-only, preserved quiet Advanced details, and did not add Board Canvas save/write behavior. |
| V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT_CLOSEOUT | accepted/pushed as `a80fb7d` (`docs: record measurement panel visual density`) | Records accepted/pushed implementation `8b140d6`, supplied manual-smoke evidence, Claude acceptance, exact implementation files, design-reference-only HTML usage, releases the implementation active lock, and routes to `NEEDS_USER_DECISION`; no runtime/test/protected edits in closeout. |
| V2_BOARD_CANVAS_APP_VISUAL_POLISH_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_POLISH | accepted/pushed as `3ff38fe` (`docs: lock Board Canvas app visual polish scope`) | Locks a future narrow Board Canvas/app visual-language polish slice using inspected Board Canvas HTML as design input only; no runtime/test implementation, no write/canonical semantics, no `_incoming` runtime dependency, and route after acceptance to active-lock sync. |
| V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT | current docs-only active-lock sync | Arms `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS` with exact Board Canvas runtime/test allowlist; no runtime/test implementation in the sync pass and no implementation accepted/pushed hash claim. |
| V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS | CODEX / FLUTTER_UI_PROTECTED_IMPLEMENTATION | next recommended after active-lock sync acceptance | Future product/UI implementation may polish only existing Board Canvas/app visual language inside the exact allowlist; manual smoke is required before Claude audit and no Board Canvas save/write behavior is authorized. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later route | Optional theme scope only; do not mix with measurement panel, menu, Home, or write-flow work. |
