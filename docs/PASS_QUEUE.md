# PASS_QUEUE

Last updated: 2026-07-06

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

No implementation pass is armed.

## Latest completed closeout

`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_POST_AUDIT_PASS`

Closeout records the pushed Visual First cleanup implementation:

`e598c9a9ae08dce44a1e0ae1666eb66a18292362 fix: remove duplicate board canvas component workflow hub`

The implementation removed the duplicate Board Canvas `Komponendid` hub/card UI from the Add Component / `Lisa` panel. It did not create a replacement duplicate workflow menu, did not route users to standalone pages, and did not touch writers, routes, schema, validator, materializer, tools, events, known_facts, `_incoming`, samples, or assets.

## Product direction

VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal component work.

Canonical write split remains:

- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. They must not be duplicated inside Board Canvas and must not remain the primary technician workflow once scoped replacements exist.

## Recommended candidate sequence

These are candidates only, not armed route state:

1. Board Canvas right-panel component creation flow.
2. Board Canvas right-panel component metadata editing flow.
3. Standalone Add/Edit route migration or removal after right-panel replacements exist.
4. Standalone Measure route cleanup after verifying accepted right-panel measurement behavior and dependencies.

## Scope gate rules

- One narrow pass at a time.
- Active implementation allowlists live in `docs/ACTIVE_SCOPE_LOCK.md`.
- Do not touch runtime/tests/docs outside the active pass allowlist.
- Do not stage, commit, or push from Codex unless explicitly requested.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
