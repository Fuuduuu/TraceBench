# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md` when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in `docs/AUDIT_INDEX.md`, `docs/audit/*.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history, not in this active queue.

## Current pass

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

## Current-state maintenance trigger pointer

- `docs/MEMORY_MAINTENANCE.md` owns the rule to compact `docs/CURRENT_STATE.md` when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in `docs/PASS_QUEUE_ARCHIVE.md` before removal when an archive update is scoped.
- Use `docs/AUDIT_INDEX.md`, `docs/audit/`, `docs/PASS_QUEUE_ARCHIVE.md`, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / writer implementation arm | active / drafted | Arm the protected placement writer and explicit Confirm/Salvesta implementation allowlist after user route decision. |
| PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / writer + explicit Confirm path | next | Implement the V2 human placement writer and explicit Board Canvas Confirm/Salvesta hookup only inside the armed allowlist. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Active pass note

- Implementation pass armed: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`.
- Implementation allowlist:
  - `lib/features/components/services/v2_placement_writer.dart`
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/unit/v2_placement_writer_test.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Writer/Confirm contract lives in `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS.md` and spec section 2.7.
- `Salvesta` may become wired only in the next implementation pass, not in this docs-only sync.

## Implementation boundaries

Future implementation must preserve:

- explicit human Confirm only
- writer emits only `component_visual_placement_confirmed`
- no component identity creation
- no pin/contact/pad/net/electrical facts
- no measurements, visual contact layout, AI-authored canonical facts, or repair conclusions
- Board Canvas renderer/painter remains read-only
- draft interactions remain UI-local/no-write until explicit Confirm

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_POST_AUDIT_PASS | CODEX / DOCS_SYNC_CLOSEOUT | accepted/pushed as `ed45dbcf` (`docs: close out add component panel local draft controls`) | Closed out the UI-local Add Component panel controls implementation, released the active implementation lock, and returned route to `NEEDS_USER_DECISION`. |
| ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local Add Component panel controls | accepted/pushed/audited as `93452da3bddf554d7921b7df0e15bb183394f649` (`feat: add add component panel local draft controls`) | Board Canvas `Lisa komponent` right panel now has UI-local template, marker draft, size, rotation, preview, safety copy, and action controls; fixed-height / hidden-scroll panel layout hack removed; no writer, canonical write, events, known facts, schema, tool, materializer, validator, router, sample, or `_incoming` changes. |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | accepted/pushed as `c50add13f9bc45e73a30906b41bb378a7bd15013` (`docs: lock placement writer confirm contract`) | Locks future V2 placement writer and explicit Confirm/Salvesta contract; implementation is now routed through this active-lock sync. |
| PLACEMENT_EDITOR_SHELL_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local editor shell | accepted/pushed/audited as `d779b0c294b5b0f28557d3e8d921fb4cd7970c91` (`feat: add placement editor draft shell`) | Board Canvas right panel has a UI-local/session-only placement draft shell; no placement writer, no Confirm/Save/Edit placement write path, and renderer/painter remains read-only. |
