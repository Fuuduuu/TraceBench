# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / implementation arm | active / drafted | Arm the narrow Board Canvas screen/test implementation allowlist after audit acceptance. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local panel controls | next | Implement UI-local size, rotation, marker draft, preview, safety copy, and inert/design-intent actions with no canonical writes. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / writer implementation arm | future candidate | Deferred by user decision until after the Add Component panel UI-local controls pass. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / writer + explicit Confirm path | future | Implement the writer and explicit Confirm/Salvesta hookup only inside a later armed allowlist. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Active pass note

- Implementation pass armed: `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`.
- Implementation allowlist:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Exact design handoff: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\Components\Lisa_Komponent_Panel_Codex_Handoff.html`.
- Handoff is `DESIGN_INPUT_ONLY`; `_incoming` remains provenance/design input only and must not be staged, copied, imported, or used as a runtime dependency.
- Detailed UI contract lives in `docs/audit/ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS.md` and spec section 2.8.
- Writer/Confirm contract remains preserved in `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS.md` and spec section 2.7.

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PROJECT_MEMORY_ORPHAN_RENDERER_WRITES_FRAGMENT_CLEANUP_PASS | CODEX / DOCS_HYGIENE | accepted/pushed/audited as `75361c23d526c06310e444687d3f3d063f980802` (`docs: remove project memory orphan fragment`) | Cleanup audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; removed the orphan `enderer writes: none.` fragment before implementation arming. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected UI-local Add Component panel | accepted/pushed/audited as `78157cfc5489ddd3276d8739e2fcb8222d24036d` (`docs: lock add component panel local draft controls`) | Scope-lock audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`; locks Board Canvas right-side `Lisa komponent` panel local draft controls from exact design handoff. |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | accepted/pushed as `c50add13f9bc45e73a30906b41bb378a7bd15013` (`docs: lock placement writer confirm contract`) | Locks future V2 placement writer and explicit Confirm/Salvesta contract; implementation is intentionally deferred by this Add Component panel route. |
| PLACEMENT_EDITOR_SHELL_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local editor shell | accepted/pushed/audited as `d779b0c294b5b0f28557d3e8d921fb4cd7970c91` (`feat: add placement editor draft shell`) | Board Canvas right panel now has a UI-local/session-only placement draft shell seeded from selected projection; local side/rotation/width/height controls; Cancel/Reset/Discard write nothing; no placement writer, no Confirm/Save/Edit placement write path, no canonical mutation. |
