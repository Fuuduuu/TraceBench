# BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS

## Mode
Docs-only product scope.

## Result
Locked the Visual First component workflow direction and defined a phased migration/removal strategy.

This pass does not implement runtime behavior, edit tests, hide routes, delete screens, or arm implementation files.

## Baseline verification
Verified before editing:
- `git status --short --branch`: `## main...origin/main`; tracked/cached diff clean, known untracked scratch only.
- `git log --oneline --decorate -10`: latest commit `c072655 docs: close out aborted visual-first components workflow implementation` on `main`, aligned with `origin/main`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.
- Route docs showed `NEEDS_USER_DECISION -> NEEDS_USER_DECISION`.
- `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ABORT_CLOSEOUT_PASS` was pushed/recorded.

## Read-only surface findings
Read-only inspection found:
- Board Canvas still contains the committed `Komponendid` hub/card UI from the earlier accepted hub pass.
- Project Overview and tests still expose standalone Add Component, Edit Component, and measurement routes/actions as legacy/transitional surfaces.
- Standalone Add Component writes `component_created`.
- Standalone Edit Component writes `component_updated`.
- Board Canvas placement save writes `component_visual_placement_confirmed` through the accepted explicit save flow.
- Measurement/right-panel behavior is already accepted and should not be reworked by the first cleanup slice.

## Visual First product rule recorded
VISUAL FIRST.

All normal component work must happen in the Board Canvas right-side menu/panel:
- measurement
- component creation
- component metadata editing
- visual placement

Old standalone Add/Edit/Measure-style pages must be removed or migrated through scoped passes. They must not be duplicated in Board Canvas and must not remain the primary technician workflow.

Do not return to table/form-filling UX.

## Scope decisions recorded
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

## Canonical split preserved
- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Measurement clarification
The accepted measurement/right-panel workflow stays.

This scope does not change measurement implementation. Only duplicate `Komponendid` hub/card measurement affordance and old standalone measurement route/surface debt may be marked for future removal or migration after dependency verification.

## Migration strategy recorded
Phase A:
- Remove or replace the committed duplicate Board Canvas `Komponendid` hub/card UI.
- Do not replace it with another duplicate workflow selector.
- Keep existing measurement/right-panel behavior intact.
- Keep placement controls intact.

Phase B:
- Move or land component identity creation in the Board Canvas right-side panel.
- This may later use the `component_created` writer, but writer changes are not authorized by this pass.

Phase C:
- Move or land component metadata editing in the Board Canvas right-side panel.
- This may later use the `component_updated` writer, but writer changes are not authorized by this pass.

Phase D:
- Retire, hide, or remove old standalone Add/Edit/Measure routes/pages only after dependency verification and after right-panel replacements are confirmed.
- No deletion is authorized by this docs-only pass unless a future implementation scope explicitly arms it.

## Expected first implementation slice candidate
Likely first implementation candidate for the next active-lock sync to evaluate:
- remove/replace duplicate Board Canvas `Komponendid` hub/card UI
- preserve current placement controls
- preserve accepted measurement/right-panel workflow
- no standalone route deletion yet unless active-lock sync proves it is safe and explicitly scopes it

## Hard boundaries recorded
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

## Route state after scope lock
Current: `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS`

Next: `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Implementation allowlist
None armed.

The next pass must inspect live code and arm the smallest safe first implementation slice.

## Changed files
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/audit/BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS.md`

## Boundary confirmation
Docs-only. No runtime, tests, router, writer services, schema, tools, materializer, validator, events.jsonl, known_facts.json, sample, asset, or `_incoming` files changed.

No files were staged, committed, or pushed.

## Audit status
DRAFTED / PENDING CLAUDE AUDIT
