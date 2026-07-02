# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_EDITOR_SHELL_IMPL_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / implementation arm | drafted / pending audit | Arms exact implementation allowlist for `PLACEMENT_EDITOR_SHELL_IMPL_PASS`; no implementation in this sync. |
| PLACEMENT_EDITOR_SHELL_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local editor shell | armed next | Board Canvas placement editor shell only; UI-local draft state; no writer, no Confirm write path, no canonical event mutation. |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | future | Lock dedicated V2 placement writer service and explicit Confirm path before implementation. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Armed implementation allowlist

`PLACEMENT_EDITOR_SHELL_IMPL_PASS` may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal

Implement the first UI-local Board Canvas placement editor shell.

The future implementation pass may evolve the existing Board Canvas right-panel / Add Component ghost/draft area into a clearer placement editor shell, expose UI-local controls for selected component context, board side, shape/template family, local position/drag if already represented, `rotation_deg`, `width`, `height`, optional template/visual family reference, and optional notes if low-risk.

The shell must label draft state as unsaved/session-only, provide Cancel/Reset/Discard behavior that writes nothing, preserve the read-only renderer/painter, and keep all draft state in memory only.

## Test requirements

- Board Canvas shell shows placement draft as unsaved/session-only.
- Draft changes do not write events or known facts.
- No Confirm/write affordance is present unless clearly disabled/inert.
- Cancel/Reset/Discard keeps renderer/canonical data unchanged.
- Existing Board Canvas renderer read-only tests continue to pass.
- Existing measurement/selection behavior remains intact.
- Per-side/contact draft controls, if visible, are explicitly UI-local and not confirmed contacts.

## Forbidden surfaces

- No new placement writer file.
- No component service writer edits.
- No Add Component writer edits.
- No Edit Component writer edits.
- No schema edits.
- No tools/materializer/validator edits.
- No router edits.
- No `events.jsonl` / `known_facts.json` semantic changes.
- No visual contact layout.
- No contacts/pads/legs rendering as confirmed.
- No AI marker implementation.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No broad docs cleanup.
- No implementation in this active-lock sync.

## Recent context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected product + writer architecture | accepted/pushed/audited as `0ebcf433608c9691440d43c8aa3d212c693454b4` (`docs: lock placement editor and writer contract`) | Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; locks editor/writer contract and routes to this active-lock sync. |
| PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_AUDIT_RECORD_SYNC_PASS | CODEX / DOCS_SYNC / audit-record sync | accepted/pushed as `c4f7f5687360b76f9000a7b50f7d7733c08cc193` (`docs: record placement editor contract audit`) | Records the already-received Claude audit verdict for the scope-lock so this active-lock gate can verify it from repo docs. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / materializer projection semantics | accepted/pushed as `386b52369a44053ac947aed344864a1b74e54df1` (`fix: order placement projection by event stream`) | Stream-order latest-wins and placement invalidation retraction implemented before editor/writer work. |
