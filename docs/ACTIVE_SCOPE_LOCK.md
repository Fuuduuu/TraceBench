# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS`

## Mode

Docs-only active-lock sync.

## Purpose

Arm the exact implementation allowlist for the Board Canvas `Komponendid` hub action-gateway implementation.

## Current pass write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation shape decision

Navigation-only gateway with existing in-panel placement action.

Future implementation may make the existing Board Canvas `Komponendid` hub rows actionable as follows:

- `Loo komponent`: navigate to the existing standalone Add Component identity route.
- `Muuda andmeid`: navigate to the existing standalone Edit Component metadata route.
- `Paiguta`: open or focus the existing Board Canvas `Lisa` / `Salvesta` visual placement workflow.
- `Mõõda komponenti`: navigate to the existing Measure Sheet route as route-only behavior.

This is not an integrated writer panel and not a writer merge.

## Must preserve

- `component_created` remains component identity/existence creation.
- `component_updated` remains component metadata update.
- `component_visual_placement_confirmed` remains visual placement confirmation.
- `measurement_recorded` remains measurement write.
- Existing standalone Add/Edit routes remain available.
- Existing Measure Sheet route remains available.
- Existing Board Canvas placement save guards remain intact.
- Board Canvas renderer/painter read-only boundary remains intact.
- Existing writer contracts remain unchanged.
- Existing routes remain available.

## Forbidden surfaces for implementation

- No writer service edits.
- No Add Component screen edits.
- No Edit Component screen edits.
- No Measure Sheet screen edits.
- No Project Overview edits.
- No router edits.
- No schema/tool/materializer/validator edits.
- No events.jsonl / known_facts.json edits or semantic changes.
- No Project Open From Directory changes.
- No rotation normalization changes.
- No samples/assets edits.
- No `_incoming` edits or staging.
- No route hiding or deletion.
- No screen deletion.
- No writer semantic merge.
- No component identity creation from placement.
- No pins/contacts/pads/nets/traces/electrical facts from marker drafts.
- No AI-authored canonical facts.

## Future test expectations

The implementation pass should add/update focused Board Canvas widget tests proving:

- `Komponendid` hub actions/links are clear.
- Identity creation, metadata edit, placement confirmation, and measurement remain labeled distinctly.
- Navigation-only actions target existing routes when implemented.
- Non-clickable/future rows are not misleadingly interactive.
- Board Canvas placement save behavior remains unchanged.
- No writer/event/schema behavior changes are introduced.
- No route hiding/deletion occurred.
- Renderer/painter remains read-only.