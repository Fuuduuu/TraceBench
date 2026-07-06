# Pass Queue

## Current pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS`

## Next recommended pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status
This docs-only product scope lock records the Visual First component workflow direction and routes to an active-lock sync that must inspect live code before arming any implementation files.

Previous accepted closeout:
- `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ABORT_CLOSEOUT_PASS`
- Latest pushed commit verified live: `c072655 docs: close out aborted visual-first components workflow implementation`

## Product rule
VISUAL FIRST.

All normal component work must happen in the Board Canvas right-side menu/panel:
- measurement
- component creation
- component metadata editing
- visual placement

Old standalone Add/Edit/Measure-style pages are transitional debt. They must be removed or migrated through scoped passes, not duplicated in Board Canvas and not kept as the primary technician workflow.

Do not return to table/form-filling UX.

## Scope decisions
- Board Canvas right-side panel/menu is the primary component-work surface.
- Component creation belongs in the Board Canvas right-side panel/menu.
- Component metadata editing belongs in the Board Canvas right-side panel/menu.
- Visual placement remains Board Canvas-native.
- Measurement/right-panel workflow is accepted and must not be reworked in this scope.
- Old standalone Add/Edit/Measure-style pages are transitional debt and should be removed/migrated through scoped passes.
- Existing committed duplicate `Komponendid` hub/card UI is product debt and should be removed/replaced, not patched into another menu.
- No duplicate workflow menu.
- No route-out primary workflow.
- No table/form-filling regression.

## Canonical event split to preserve
- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Measurement clarification
The accepted measurement/right-panel workflow stays.

This scope does not change measurement implementation. Only duplicate `Komponendid` hub/card measurement affordance and old standalone measurement route/surface debt may be marked for future removal or migration after dependency verification.

## Phased migration strategy
Phase A:
- Remove or replace the committed duplicate Board Canvas `Komponendid` hub/card UI.
- Do not replace it with another duplicate workflow selector.
- Keep existing measurement/right-panel behavior intact.
- Keep placement controls intact.

Phase B:
- Move or land component identity creation in the Board Canvas right-side panel.
- Future implementation may use the `component_created` writer, but writer changes are not authorized by this scope lock.

Phase C:
- Move or land component metadata editing in the Board Canvas right-side panel.
- Future implementation may use the `component_updated` writer, but writer changes are not authorized by this scope lock.

Phase D:
- Retire, hide, or remove old standalone Add/Edit/Measure routes/pages only after dependency verification and after right-panel replacements are confirmed.
- No deletion is authorized by this docs-only pass.

## Expected first implementation slice candidate
The next active-lock sync should inspect live code and likely arm the smallest safe first slice:
- remove/replace duplicate Board Canvas `Komponendid` hub/card UI
- preserve current placement controls
- preserve accepted measurement/right-panel workflow
- avoid standalone route deletion unless live-code inspection proves it is safe and explicitly scopes it

## Future implementation boundaries
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
No implementation allowlist is armed by this pass.

The next pass must be `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS` and must inspect live code before arming exact files.

## Scope gate rules
- Route owners: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`.
- Audit/provenance owner: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
- Do not stage, commit, or push from implementation or docs-sync passes unless explicitly instructed.
- Never use `git add .`, `git add -A`, or `git commit -am`.
