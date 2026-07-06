# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS

## Next recommended pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS

## Route status

Active-lock sync for the Board Canvas `Komponendid` hub action-gateway implementation.

This pass is docs-only. It arms the future implementation allowlist and records the live-code decision that the next implementation can stay within Board Canvas and its widget test.

## Scope gate rules

- One narrow pass at a time.
- Repo docs and verified git state outrank prompt handoff text.
- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` must agree before implementation.
- Protected surfaces require a dedicated scope-lock before implementation.
- Do not stage, commit, or push unless the user explicitly asks.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Board Canvas Komponendid workflow actions active-lock sync

Live-code findings:

- Board Canvas already contains the read-only `Komponendid` hub in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Board Canvas already owns the `Lisa` / `Salvesta` visual placement panel and selected-component placement save flow.
- Existing Project Overview actions route to Add Component, Edit Component, Board Canvas, and Measure Sheet.
- Existing router/project navigation exposes Add Component, Edit Component, Measure Sheet, and Board Canvas routes.
- Existing widget coverage for Board Canvas already includes the `Komponendid` hub and placement-save boundaries; implementation-specific tests belong in `test/widget/board_canvas_screen_test.dart`.

Implementation-shape decision:

- Navigation-only gateway, plus existing in-panel placement action.
- Not an integrated writer merge.
- Not blocked by product decision.

Exact implementation allowlist armed for `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS`:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Implementation boundaries:

- No writer services.
- No Add Component screen edits.
- No Edit Component screen edits.
- No Measure Sheet screen edits.
- No Project Overview edits.
- No router edits.
- No schema/tool/materializer/validator edits.
- No events.jsonl / known_facts.json semantic changes.
- No route hiding/deletion.
- No `_incoming`, samples, or assets edits.

## Planned follow-up sequence

1. `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS` - current docs-only active-lock sync.
2. `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS` - implement the small Board Canvas action-gateway behavior inside the armed allowlist.
3. `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_POST_AUDIT_PASS` - close out after audit and push.

## Recent accepted context

| Pass | Status | Notes |
|---|---|---|
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS` | pushed / pending audit record | Scope-lock for action-gateway direction, pushed as `72a6049 docs: lock board canvas components workflow actions scope`. |
| `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_POST_AUDIT_PASS` | closed | Selected placement context/prefill closed out and route released. |
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_POST_AUDIT_PASS` | closed | Read-only `Komponendid` hub added and recorded. |
| `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_POST_AUDIT_PASS` | closed | Standalone Add/Edit flow labels clarified as identity/metadata flows. |

## Current-state maintenance trigger

Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together when the route changes.

Update `docs/AUDIT_INDEX.md` and create a focused `docs/audit/*.md` artifact for each route-changing pass.