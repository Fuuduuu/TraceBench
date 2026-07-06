# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode

Docs-only product scope-lock.

## Implementation pass not armed

No implementation files are armed by this pass.

The next active-lock sync must inspect live code and decide the exact implementation allowlist before any runtime/test changes.

## Locked product intent

- Board Canvas is the primary technician-facing board/workbench surface.
- Component work should be contextual to the selected board/component where practical.
- A future Board Canvas `Komponendid` panel may coordinate identity, metadata, visual placement, and component-related measurement entry.
- Standalone Add Component and Edit Component remain transitional canonical writer flows until a V2 replacement exists.
- No route hiding, route deletion, screen deletion, writer merge, or writer semantics change is authorized by this pass.

## Canonical event boundaries to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Current flow map

- Project Overview routes to Add Component, Edit Component, Board Canvas, Measure Sheet, Board Graph, and projection/list views.
- Standalone Add Component owns component identity/existence creation through `component_created`.
- Standalone Edit Component owns component metadata update through `component_updated`.
- Board Canvas owns selected-component visual placement confirmation through `component_visual_placement_confirmed`.
- Measure Sheet owns measurement entry through `measurement_recorded`.
- Board Graph is advanced/debug projection inspection.

## Future implementation may later consider

- Board Canvas screen changes for a `Komponendid` right-panel/contextual workflow.
- Project Overview navigation/copy changes for routing component work toward Board Canvas.
- Add/Edit Component screen adapters or transitional route links.
- Measure Sheet links for component-related measurement starts.
- Related widget tests.

These surfaces are not armed in this scope-lock.

## Future implementation must not

- Change writer services unless separately armed.
- Change event schema.
- Change validator/materializer/tools.
- Change `events.jsonl` or `known_facts.json` semantics.
- Change Project Open From Directory behavior.
- Change rotation normalization.
- Change projection-stale policy.
- Change canonical bounds guard behavior.
- Change measurement writer behavior.
- Change Add/Edit Component writer behavior.
- Change Board Canvas placement writer behavior.
- Create component identity from visual placement.
- Create pins, contacts, pads, nets, traces, or electrical facts from visual marker drafts.
- Create AI-authored canonical facts.
- Hide routes.
- Delete screens.
- Merge writer semantics.

## Explicitly not armed

- `lib/`
- `test/`
- `tools/`
- `schemas/`
- `events.jsonl`
- `known_facts.json`
- `_incoming`

## Stop conditions for next pass

Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if future implementation requires files outside the active-lock allowlist set by the next sync pass.

Stop and report `BLOCKED_PRODUCT_DECISION` if implementation requires choosing between hub, integrated panel, phased hybrid, or not-pursued direction without a recorded decision.

## Staging

Do not stage, commit, or push.
