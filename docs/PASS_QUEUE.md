# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

- `docs/MEMORY_MAINTENANCE.md` owns the rule to compact `docs/CURRENT_STATE.md` when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in `docs/PASS_QUEUE_ARCHIVE.md` before removal when an archive update is scoped.
- Use `docs/AUDIT_INDEX.md`, `docs/audit/`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| NEEDS_USER_DECISION | ROUTE_DECISION | current | User selects the next pass. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / writer implementation arm | future candidate | Deferred until user chooses to arm the protected writer implementation allowlist. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / writer + explicit Confirm path | future | Implement the writer and explicit Confirm/Salvesta hookup only inside a later armed allowlist. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local Add Component panel controls | accepted/pushed/audited as `93452da3bddf554d7921b7df0e15bb183394f649` (`feat: add add component panel local draft controls`) | Board Canvas `Lisa komponent` right panel now has UI-local template, marker draft, size, rotation, preview, safety copy, and action controls; fixed-height / hidden-scroll panel layout hack removed; no writer, canonical write, events, known facts, schema, tool, materializer, validator, router, sample, or `_incoming` changes. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / implementation arm | pushed as `d0dbfcea033670b6d82175adda12638850955f31` (`docs: arm add component panel local draft controls`) | Armed the two-file Board Canvas screen/test implementation allowlist for the UI-local Add Component panel controls pass. |
| PROJECT_MEMORY_ORPHAN_RENDERER_WRITES_FRAGMENT_CLEANUP_PASS | CODEX / DOCS_HYGIENE | accepted/pushed/audited as `75361c23d526c06310e444687d3f3d063f980802` (`docs: remove project memory orphan fragment`) | Cleanup audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; removed the orphan `enderer writes: none.` fragment before implementation arming. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected UI-local Add Component panel | accepted/pushed/audited as `78157cfc5489ddd3276d8739e2fcb8222d24036d` (`docs: lock add component panel local draft controls`) | Scope-lock audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`; locks Board Canvas right-side `Lisa komponent` panel local draft controls from exact design handoff. |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | accepted/pushed as `c50add13f9bc45e73a30906b41bb378a7bd15013` (`docs: lock placement writer confirm contract`) | Locks future V2 placement writer and explicit Confirm/Salvesta contract; implementation remains deferred until user decision. |
| PLACEMENT_EDITOR_SHELL_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local editor shell | accepted/pushed/audited as `d779b0c294b5b0f28557d3e8d921fb4cd7970c91` (`feat: add placement editor draft shell`) | Board Canvas right panel has a UI-local/session-only placement draft shell; no placement writer, no Confirm/Save/Edit placement write path, and renderer/painter remains read-only. |
