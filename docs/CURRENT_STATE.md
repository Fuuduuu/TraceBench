# CURRENT_STATE

Last updated: 2026-07-06

## Current route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Latest closeout

`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_POST_AUDIT_PASS`

This docs-only closeout records the pushed `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS` implementation and releases the active implementation lock.

Recorded implementation commit:

`e598c9a9ae08dce44a1e0ae1666eb66a18292362 fix: remove duplicate board canvas component workflow hub`

## Visual First product rule

VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal technician component work.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. They are not the primary technician workflow, must not be duplicated inside Board Canvas, and must be migrated or removed through separately scoped passes.

The accepted measurement/right-panel workflow remains accepted and is not reworked by this closeout.

## Canonical write split

- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Closeout summary

The pushed implementation removed the duplicate Board Canvas `Komponendid` hub/card UI from the Add Component / `Lisa` panel and removed unused hub-card code.

The implementation did not create a replacement duplicate workflow menu. It preserved existing placement controls, selected-placement prefill, required-label guard, canonical-bounds guard, projection-stale success copy, and the `Salvesta` placement-confirmation path.

No router, standalone Add/Edit/Measure page, writer, schema, validator, materializer, tools, events, known_facts, `_incoming`, sample, or asset files were changed.

## Recommended next candidates

No pass is armed. Candidate directions only:

1. Board Canvas right-panel component creation flow, scoped separately.
2. Board Canvas right-panel component metadata editing flow, scoped separately.
3. Standalone Add/Edit route migration or removal after right-panel replacements exist.
4. Standalone Measure route cleanup only after verifying accepted right-panel measurement behavior and dependencies.

## Standing boundaries

- Do not create duplicate Board Canvas menus for old standalone workflows.
- Do not route technicians out of Board Canvas as the primary component workflow.
- Do not regress to table/form-filling UX.
- Do not change writer/schema/materializer/validator/projection/project ZIP/fact/event semantics unless separately scoped.
- Do not create identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions from visual placement UI.
