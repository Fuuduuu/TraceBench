# ACTIVE_SCOPE_LOCK

Last updated: 2026-07-06

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock state

No active implementation lock is armed.

The `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS` implementation lock has been released by `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_POST_AUDIT_PASS`.

Recorded implementation commit:

`e598c9a9ae08dce44a1e0ae1666eb66a18292362 fix: remove duplicate board canvas component workflow hub`

## Released implementation allowlist

The prior active implementation allowlist is no longer armed:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Visual First rule retained

VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal component work.

Canonical write split remains:

- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. They must not be duplicated inside Board Canvas and must not be used as the primary technician workflow after scoped replacements exist.

## Standing forbidden surfaces without a new lock

- No runtime edits.
- No test edits.
- No router edits.
- No Add/Edit/Measure page edits.
- No writer/schema/tool/materializer/validator edits.
- No events.jsonl / known_facts.json semantic changes.
- No `_incoming` edits or staging.
- No duplicate Board Canvas workflow hub/menu for old standalone flows.
- No table/form-filling UX regression.
