# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

| PASS_ID | Lane/Type | Status | Purpose |
| --- | --- | --- | --- |
| PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected product + writer architecture | drafted / pending audit | Lock Board Canvas placement editor, dedicated placement writer, edit-placement, manual flow, AI marker boundary, and implementation sequence before implementation. |
| PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / future implementation arm | next recommended after accepted scope-lock | Arm exact UI-local Board Canvas placement editor shell allowlist; no writer and no canonical writes in sync. |
| PLACEMENT_EDITOR_SHELL_IMPL_PASS | CODEX / RUNTIME_IMPLEMENTATION / UI-local editor shell | future, not armed yet | Board Canvas placement editor shell only; UI-local draft state; no writer, no Confirm write path, no canonical event mutation. |
| PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected writer + Confirm path | future | Lock dedicated V2 placement writer service and explicit Confirm path before implementation. |
| EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / edit-placement flow | future | Reopen existing projected placement as draft, confirm via same writer, and preserve latest-wins projection semantics. |
| VISUAL_CONTACT_LAYOUT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / visual contacts | future | Confirmed visual contacts/pads/legs as separate event/projection, not folded into placement. |
| AI_MARKER_TO_PLACEMENT_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / AI marker conversion | future | Convert unconfirmed AI/photo marker proposals only through human-confirmed placement editor flow. |

## Locked implementation sequence

| Phase | Future pass family | Purpose | Implementation authorization |
| --- | --- | --- | --- |
| P1 | placement editor shell active-lock sync | Arm Board Canvas placement editor shell allowlist. | Docs only. |
| P1 implementation | UI-local placement editor shell | Board Canvas right-panel / ghost draft editor shell, in-memory draft only. | Runtime/test only after active lock. |
| P2 | placement writer + Confirm scope lock | Dedicated V2 placement writer service and explicit Confirm path. | Docs only before protected implementation. |
| P3 | edit-placement flow | Reopen confirmed placement, draft edits, re-confirm through same writer. | Future protected scope. |
| P4 | visual-contact layout | Confirmed visual contacts/pads/legs as separate canonical concept. | Future protected scope. |
| P5 | AI marker conversion | Unconfirmed AI marker candidate to human-confirmed placement. | Future protected scope. |

## Likely future allowlists

P1 editor shell:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- Optional new Board Canvas subfiles only if separately justified by active-lock sync.

P2 writer + Confirm:

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- Relevant writer tests if repo has a matching test location.
- Do not include materializer/validator unless a later audit proves they are needed.

P3 edit placement:

- Board Canvas/editor files.
- Widget tests.
- Writer reuse tests.

## Recent closeout context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / protected implementation arm | accepted/pushed as `39df320` (`docs: arm placement projection ordering implementation`) | Armed exact implementation allowlist `tools/materialize_known_facts.py` and `tests/test_materialize_known_facts.py`; no implementation in sync. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / materializer projection semantics | accepted/pushed as `386b52369a44053ac947aed344864a1b74e54df1` (`fix: order placement projection by event stream`) | Implementation audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; safe staging set `tools/materialize_known_facts.py` and `tests/test_materialize_known_facts.py`; stream-order latest-wins and placement invalidation retraction implemented. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_POST_AUDIT_PASS | CODEX / DOCS_CLOSEOUT / implementation post-audit | accepted/pushed as `05178a0be0523f780cf3b8c5a9157450fa40ad8c` (`docs: close out placement projection ordering`) | Completed docs-only closeout; route returned to `NEEDS_USER_DECISION` before this scope-lock. |
| TRACEBENCH_FILE_MAP_PASS | CODEX / DOCS_SYNC / file-map creation | accepted/pushed/audited as `dd0024450deb674dbb55d7ec71103f366f02a313` (`docs: add TraceBench file map`) | Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; route remained `NEEDS_USER_DECISION`. |
