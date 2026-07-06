# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS`

## Next recommended pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only product scope-lock is active for selected-placement visual draft prefill behavior.

No implementation files are armed by this pass. The next active-lock sync must inspect live code and arm the exact implementation allowlist if this direction is accepted.

## Latest accepted baseline

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_POST_AUDIT_PASS` closed out pushed implementation commit `2d08eb6464c4a0edf6eef886accfcc5836a4f912` (`feat: add board canvas components workflow hub`).

Recorded baseline behavior:

- Board Canvas Add Component / `Lisa` panel includes a read-only `Komponendid` hub card.
- Board Canvas `Salvesta` remains visual placement confirmation for an existing selected component.
- Existing `Salvesta` behavior, placement writer invocation, required-label guard, canonical-bounds guard, rotation normalization, and projection-stale behavior remain unchanged.
- Board Canvas renderer/painter remains read-only.

## Scope-lock question

When a technician selects a component/placement on the Board Canvas and opens `Lisa` / Add Component, the selected placement context should carry into the right-panel visual placement draft/editor instead of feeling like a blank template-only flow.

This pass locks product intent only; it does not implement runtime behavior.

## Locked product intent

- Board Canvas visual placement work is for existing selected components.
- Selection context should not be lost when opening the placement/draft panel.
- Existing placement data may seed local draft fields where safe.
- Draft seeding is UI-local and writes nothing.
- `Salvesta` remains the only canonical placement write trigger.
- No component identity is created from visual placement.
- No pins, contacts, pads, nets, traces, or electrical facts are created from visual placement drafts.
- Standalone Add/Edit Component identity/metadata flows remain separate.

## Boundary confirmation

- Docs-only pass.
- Do not edit runtime or tests.
- Do not arm implementation allowlist in this pass.
- Do not change placement writer contract, event schema, validator/materializer/tools, events/known_facts semantics, Project Open From Directory, rotation normalization, projection-stale policy, canonical-bounds guard, required-label guard, Add/Edit identity/metadata writers, or measurement writer behavior.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
