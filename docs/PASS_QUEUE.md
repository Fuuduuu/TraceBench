# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / protected implementation arm | in progress | Arms exact materializer/test implementation allowlist after accepted scope-lock audit; no implementation in this sync. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / materializer projection semantics | next | Implement deterministic stream-order latest-wins and `event_invalidated` placement retraction inside `tools/materialize_known_facts.py` with focused `tests/test_materialize_known_facts.py` coverage. |

## Planned follow-up sequence

| Phase | Future pass family | Purpose | Implementation authorization |
| --- | --- | --- | --- |
| P2 | placement projection ordering/invalidation implementation | Implement deterministic stream-order latest-wins and placement invalidation retraction. | Protected implementation now armed by active-lock sync. |
| P3 | placement editor + writer scope-lock | Lock Board Canvas right-panel / ghost draft as the official UI-local placement editor and define writer boundaries after projection semantics are resolved. | Docs only after user decision. |
| P4 | placement editor implementation active-lock sync | Arm exact future UI/writer implementation allowlist after accepted scope-lock. | Docs only. |
| P5 | UI-local placement editor shell | Add or refine local draft UI without canonical writes. | Runtime/test only after active lock. |
| P6 | placement writer implementation | Add dedicated V2 placement writer service and tests. | Protected implementation after explicit scope lock. |
| P7 | edit-placement flow | Scope and implement editing of confirmed visual placement separately. | Future protected scope. |
| P8 | visual-contact layout | Separate confirmed visual-contact event/projection/UI; not folded into placement. | Future protected scope. |
| P9 | AI marker conversion | Human-confirmed conversion of AI marker proposals through placement editor path. | Future protected scope. |

## Recent closeout context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected projection semantics | accepted/pushed/audited as `5cbf3b5174d062e716aa0c31d73420716fff7964` (`docs: lock placement projection ordering`) | Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; locks stream-order latest-wins and placement invalidation retraction before writer/UI work. |
| TRACEBENCH_FILE_MAP_PASS | CODEX / DOCS_SYNC / file-map creation | accepted/pushed/audited as `dd0024450deb674dbb55d7ec71103f366f02a313` (`docs: add TraceBench file map`) | Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; safe staging set recorded in `docs/AUDIT_INDEX.md`; route remained `NEEDS_USER_DECISION`. |
| BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / event regime + projection plumbing | accepted/pushed as `fa85231045c8dadc3543a914ca173829a3272c4d` (`feat: support V2 placement event regime`) | V2 validator accepts `component_visual_placement_confirmed`; V2 placement requires human/explicit confirmation and width+height; forbidden semantic fields are rejected; materializer projects V2 human-confirmed placements; latest-wins preserved; `schemas/events.schema.json` unchanged. |
| BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / architecture decision | accepted/pushed as `1f0438a` (`docs: lock placement editor architecture decision`) | Records Add Component identity-only boundary, Board Canvas UI-local placement editor seed decision, V2/human placement-event regime direction, width/height size model, VectorFootprintLibrary vocabulary ownership, future visual-contact separation, and AI marker conversion boundary. |
