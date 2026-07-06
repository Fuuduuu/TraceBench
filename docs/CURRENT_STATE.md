# Current State

## Current pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS`

## Next recommended pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status
Docs-only product scope lock for the Board Canvas Visual First component workflow direction.

Baseline verified from live git/docs:
- Latest pushed closeout commit: `c072655 docs: close out aborted visual-first components workflow implementation`
- Prior route before this scope lock: `NEEDS_USER_DECISION -> NEEDS_USER_DECISION`
- Main is aligned with `origin/main`.
- Tracked diff and cached diff were clean before this scope lock.
- `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ABORT_CLOSEOUT_PASS` is pushed/recorded.

This pass does not implement runtime UI, hide routes, delete screens, edit tests, or arm implementation files.

## Product rule locked
VISUAL FIRST.

All normal component work should happen in the Board Canvas right-side menu/panel:
- measurement
- component creation
- component metadata editing
- visual placement

Old standalone Add/Edit/Measure-style pages are transitional debt. They must be removed or migrated through separately scoped passes, not duplicated in Board Canvas and not kept as the primary technician workflow.

Do not return to table/form-filling UX.

## Scope decisions
1. Board Canvas right-side panel/menu is the primary component-work surface.
2. Component creation belongs in the Board Canvas right-side panel/menu.
3. Component metadata editing belongs in the Board Canvas right-side panel/menu.
4. Visual placement remains Board Canvas-native.
5. Measurement/right-panel workflow is accepted and must not be reworked in this scope.
6. Old standalone Add/Edit/Measure-style pages are transitional debt and should be removed/migrated through scoped passes.
7. Existing committed duplicate `Komponendid` hub/card UI is product debt and should be removed/replaced, not patched into another menu.
8. No duplicate workflow menu.
9. No route-out primary workflow.
10. No table/form-filling regression.

## Canonical event split to preserve
- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Measurement clarification
The accepted measurement/right-panel workflow stays.

This scope does not change measurement implementation. Only duplicate `Komponendid` hub/card measurement affordance and old standalone measurement route/surface debt may be marked for future removal or migration after dependency verification.

## Phased migration strategy
Phase A: remove or replace the committed duplicate Board Canvas `Komponendid` hub/card UI. Do not replace it with another duplicate workflow selector. Keep existing measurement/right-panel behavior and placement controls intact.

Phase B: move or land component identity creation in the Board Canvas right-side panel. A future pass may use the `component_created` writer, but writer changes are not authorized by this scope lock.

Phase C: move or land component metadata editing in the Board Canvas right-side panel. A future pass may use the `component_updated` writer, but writer changes are not authorized by this scope lock.

Phase D: retire, hide, or remove old standalone Add/Edit/Measure routes/pages only after dependency verification and after right-panel replacements are confirmed. No deletion is authorized by this docs-only pass.

## Expected first implementation slice candidate
Likely first implementation candidate for the next active-lock sync to evaluate:
- remove/replace duplicate Board Canvas `Komponendid` hub/card UI
- preserve current placement controls
- preserve accepted measurement/right-panel workflow
- do not delete standalone routes yet unless the active-lock sync proves it is safe and explicitly scopes it

## Boundaries
Future implementation must not:
- rebuild old standalone forms inside Board Canvas
- create a second workflow menu duplicating old pages
- route technicians out of Board Canvas as primary workflow
- change measurement implementation in the first cleanup slice
- change writer services unless separately scoped
- change event schema
- change validator/materializer/tools
- mutate `known_facts.json` directly from Flutter
- touch `events.jsonl` or `known_facts.json` as sample truth
- create identity from visual placement
- create pins/contacts/pads/nets/traces/electrical facts from visual drafts
- create AI-authored canonical facts
- implement startup intro or use `_incoming` design handoffs

## Implementation allowlist
None armed in this pass.
