# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

No active pass is armed. Next route requires user decision.

## Most recent closeout context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / architecture decision | accepted/pushed as `1f0438ad53bf7a1c4712079382819cc23d5593a2` (`docs: lock placement editor architecture decision`) | Records Add Component identity-only boundary, Board Canvas UI-local placement editor seed decision, V2/human placement-event regime direction, width/height size model, VectorFootprintLibrary vocabulary ownership, visual-contact separation, and AI marker conversion boundary. |
| BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_POST_AUDIT_PASS | CODEX / DOCS_CLOSEOUT / architecture decision | completed docs-only closeout; route set to `NEEDS_USER_DECISION` | Records audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`, non-blocking nits, closed decisions, pushed scope-lock commit hash, and active-lock release. |

## Planned follow-up sequence for later user decision

| Phase | Future pass family | Purpose | Implementation authorization |
| --- | --- | --- | --- |
| P2 | V2 placement event envelope/schema/materializer/validator alignment scope-lock | Protect and align `component_visual_placement_confirmed` with V2 event regime before writer/UI implementation. | Docs only; later protected implementation required. |
| P3 | placement editor + writer scope-lock | Lock Board Canvas right-panel / ghost draft as the official UI-local placement editor and define writer boundaries. | Docs only. |
| P4 | active-lock sync | Arm exact future implementation allowlist after accepted scope-lock. | Docs only. |
| P5 | UI-local placement editor shell | Add or refine local draft UI without canonical writes. | Runtime/test only after active lock. |
| P6 | placement writer implementation | Add dedicated V2 placement writer service and tests. | Protected implementation after P2/P3/P4. |
| P7 | edit-placement flow | Scope and implement editing of confirmed visual placement separately. | Future protected scope. |
| P8 | visual-contact layout | Separate confirmed visual-contact event/projection/UI; not folded into placement. | Future protected scope. |
| P9 | AI marker conversion | Human-confirmed conversion of AI marker proposals through placement editor path. | Future protected scope. |

## Recent Board Canvas footprint implementation context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS | CODEX / FLUTTER_PASS / Board Canvas visual rendering | accepted/pushed as `02cd557` (`feat(board-canvas): render component footprints`) | Rendered recognizable component footprint bodies, enabled bodyOnly contact visibility, kept contacts/pads/legs off component image until future confirmed visual-contact layout, kept real pin selection in the right-side list, centered right-panel preview parity, removed old standalone M/M3 marker bubble, preserved no visual rotation and `renderer writes: none`. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS | CODEX / DOCS_POST_AUDIT / Board Canvas visual rendering | accepted/pushed as `c2da8fd` (`docs: close out Board Canvas footprints`) | Records manual smoke `PASS`, audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`, non-blocking nits, validation, protected-surface boundaries, and releases the active lock. |
