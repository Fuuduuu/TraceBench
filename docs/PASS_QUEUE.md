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

No pass is currently armed. Route is at `NEEDS_USER_DECISION`.

## Recommended next candidate

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / local folder open path | candidate / not armed | Scope the missing open-from-local-folder UI path needed for full placement writer manual smoke. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_POST_AUDIT_PASS | CODEX / DOCS_SYNC_CLOSEOUT | drafted closeout | Records pushed implementation commits `e0af793e1b140eec7c498d9a73e8a65f29020b33` and `8db8c23669421f4d7c4a71cfce716dc1f9dd06a7`, Claude final audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`, manual smoke `PASS_WITH_ENVIRONMENT_LIMITATION`, safe implementation set, known nits, and route reset to `NEEDS_USER_DECISION`. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / writer + explicit Confirm path | accepted/pushed/audited | Base implementation `e0af793e1b140eec7c498d9a73e8a65f29020b33` (`feat: confirm component visual placement`) plus follow-up `8db8c23669421f4d7c4a71cfce716dc1f9dd06a7` (`fix: align placement confirm flow with canvas selection`); writer emits only `component_visual_placement_confirmed`, `Salvesta` confirms selected existing component visual placement, dropdown drift removed, renderer remains read-only. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / writer implementation arm | accepted/pushed | Armed the protected implementation allowlist for `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` as commit `597a6dcb65cf3264c45c4ff0e93c9e98eb02d775` (`docs: arm placement writer confirm implementation`). |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_POST_AUDIT_PASS | CODEX / DOCS_SYNC_CLOSEOUT | accepted/pushed as `ed45dbcf` (`docs: close out add component panel local draft controls`) | Closed out the UI-local Add Component panel controls implementation, released the active implementation lock, and returned route to `NEEDS_USER_DECISION`. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local Add Component panel controls | accepted/pushed/audited as `93452da3bddf554d7921b7df0e15bb183394f649` (`feat: add add component panel local draft controls`) | Board Canvas `Lisa komponent` right panel now has UI-local template, marker draft, size, rotation, preview, safety copy, and action controls; fixed-height / hidden-scroll panel layout hack removed; no writer, canonical write, events, known facts, schema, tool, materializer, validator, router, sample, or `_incoming` changes. |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | accepted/pushed as `c50add13f9bc45e73a30906b41bb378a7bd15013` (`docs: lock placement writer confirm contract`) | Locked V2 placement writer and explicit Confirm/Salvesta contract; implementation now closed out. |
