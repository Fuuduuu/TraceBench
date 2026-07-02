# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected UI-local Add Component panel | active / drafted | Lock the Board Canvas right-side `Lisa komponent` panel local draft controls from the exact design handoff before implementation. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / implementation arm | next | Arm the narrow Board Canvas screen/test implementation allowlist after audit acceptance. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local panel controls | future | Implement UI-local size, rotation, marker draft, preview, safety copy, and inert/design-intent actions with no canonical writes. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / writer implementation arm | future candidate | Deferred by user decision until after the Add Component panel UI-local controls pass. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / writer + explicit Confirm path | future | Implement the writer and explicit Confirm/Salvesta hookup only inside a later armed allowlist. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Active pass note

- Exact design handoff: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\Components\Lisa_Komponent_Panel_Codex_Handoff.html`.
- Handoff is `DESIGN_INPUT_ONLY`; `_incoming` remains provenance/design input only and must not be staged.
- Detailed UI contract lives in `docs/audit/ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS.md` and spec section 2.8.
- Writer/Confirm contract remains preserved in `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS.md` and spec section 2.7.

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | accepted/pushed as `c50add13f9bc45e73a30906b41bb378a7bd15013` (`docs: lock placement writer confirm contract`) | Locks future V2 placement writer and explicit Confirm/Salvesta contract; implementation is intentionally deferred by this Add Component panel route pivot. |
| PLACEMENT_EDITOR_SHELL_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local editor shell | accepted/pushed/audited as `d779b0c294b5b0f28557d3e8d921fb4cd7970c91` (`feat: add placement editor draft shell`) | Board Canvas right panel now has a UI-local/session-only placement draft shell seeded from selected projection; local side/rotation/width/height controls; Cancel/Reset/Discard write nothing; no placement writer, no Confirm/Save/Edit placement write path, no canonical mutation. |
| PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / implementation arm | accepted/pushed as `657a269f7ea0a949bde80f35007477576e3b38a6` (`docs: arm placement editor shell implementation`) | Armed exact implementation allowlist for `PLACEMENT_EDITOR_SHELL_IMPL_PASS`; no implementation in the sync. |
| PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected product + writer architecture | accepted/pushed/audited as `0ebcf433608c9691440d43c8aa3d212c693454b4` (`docs: lock placement editor and writer contract`) | Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; locks editor/writer contract and routes to the implementation-arm sequence. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / materializer projection semantics | accepted/pushed as `386b52369a44053ac947aed344864a1b74e54df1` (`fix: order placement projection by event stream`) | Stream-order latest-wins and placement invalidation retraction implemented before editor/writer work. |
