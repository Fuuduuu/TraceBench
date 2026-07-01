# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Write allowlist | Notes |
| --- | --- | --- | --- | --- |
| BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected-surface event regime | active draft; route after Codex to `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS` | `docs/CURRENT_STATE.md`; `docs/PASS_QUEUE.md`; `docs/ACTIVE_SCOPE_LOCK.md`; `docs/AUDIT_INDEX.md`; `docs/TRUTH_INDEX.md`; `docs/PROJECT_MEMORY.md`; `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`; `docs/audit/BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS.md` | Locks future `component_visual_placement_confirmed` migration to V2/human envelope, records current V1 scaffold contradiction, preserves Board Canvas bodyOnly/read-only renderer, Add Component identity-only writer, visual-contact separation, and AI marker boundary. |
| BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / protected implementation arm | next | docs-only active-lock sync files, exact allowlist to be set by that pass | If this scope-lock is accepted, arm the future protected implementation allowlist for schema/validator/materializer/projection/writer tests only; do not implement during the sync. |

## Likely future protected implementation surfaces

| Surface | Reason |
| --- | --- |
| `schemas/events.schema.json` | Align `component_visual_placement_confirmed` with the V2 event envelope. |
| `schemas/known_facts.schema.json` | Keep projected placement shape compatible if migration affects projection contract. |
| `tools/validate_events_jsonl.py` | Accept and validate V2 human-authored placement events without V1 actor/envelope contradiction. |
| `tools/materialize_known_facts.py` | Materialize accepted V2 human-authored placement events and avoid silent drops. |
| V2 event-type owner(s) | Keep V2 event registry/allowlist coherent if a central owner is present. |
| Writer service / future Dart placement writer | Add a dedicated placement writer only after protected implementation scope is armed. |
| Focused validator/materializer/writer tests and samples | Prove V2 placement acceptance and projection behavior only when separately scoped. |

## Planned follow-up sequence

| Phase | Future pass family | Purpose | Implementation authorization |
| --- | --- | --- | --- |
| P2a | V2 placement event regime active-lock sync | Arm exact protected implementation allowlist after accepted scope-lock. | Docs only. |
| P2b | V2 placement event envelope/schema/materializer/validator implementation | Reconcile `component_visual_placement_confirmed` with V2/human regime before writer/UI implementation. | Protected implementation only after active-lock sync. |
| P3 | placement editor + writer scope-lock | Lock Board Canvas right-panel / ghost draft as the official UI-local placement editor and define writer boundaries. | Docs only. |
| P4 | placement editor implementation active-lock sync | Arm exact future UI/writer implementation allowlist after accepted scope-lock. | Docs only. |
| P5 | UI-local placement editor shell | Add or refine local draft UI without canonical writes. | Runtime/test only after active lock. |
| P6 | placement writer implementation | Add dedicated V2 placement writer service and tests. | Protected implementation after P2/P3/P4. |
| P7 | edit-placement flow | Scope and implement editing of confirmed visual placement separately. | Future protected scope. |
| P8 | visual-contact layout | Separate confirmed visual-contact event/projection/UI; not folded into placement. | Future protected scope. |
| P9 | AI marker conversion | Human-confirmed conversion of AI marker proposals through placement editor path. | Future protected scope. |

## Recent closeout context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / architecture decision | accepted/pushed as `1f0438a` (`docs: lock placement editor architecture decision`) | Records Add Component identity-only boundary, Board Canvas UI-local placement editor seed decision, V2/human placement-event regime direction, width/height size model, VectorFootprintLibrary vocabulary ownership, visual-contact separation, and AI marker conversion boundary. |
| BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_POST_AUDIT_PASS | CODEX / DOCS_CLOSEOUT / architecture decision | accepted/pushed as `b059278` (`docs: close out placement editor architecture decision`) | Records audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`, non-blocking nits, closed decisions, pushed scope-lock commit hash, active-lock release, and route return to `NEEDS_USER_DECISION`. |
| V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS | CODEX / FLUTTER_PASS / Board Canvas visual rendering | accepted/pushed as `02cd557` (`feat(board-canvas): render component footprints`) | Rendered recognizable component footprint bodies, enabled bodyOnly contact visibility, kept contacts/pads/legs off component image until future confirmed visual-contact layout, kept real pin selection in the right-side list, centered right-panel preview parity, removed old standalone M/M3 marker bubble, preserved no visual rotation and `renderer writes: none`. |
