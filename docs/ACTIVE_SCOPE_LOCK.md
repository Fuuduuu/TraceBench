# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode

Docs-only product scope-lock.

## Purpose

Record the product decision for turning the existing Board Canvas `Komponendid` hub into a safe action gateway in a later implementation pass.

## Current pass write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md` only if taxonomy cross-reference wording is needed
- `docs/audit/BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS.md`

## Implementation pass armed

None.

The next active-lock sync pass must inspect live code and arm an exact implementation allowlist. This scope-lock does not authorize runtime or test edits.

## Locked product intent

Board Canvas is the primary technician-facing board/workbench surface.

The `Komponendid` hub should become a safe navigation/action gateway before any deeper integrated component-workflow rewrite.

Future intended actions:

- `Loo komponent`: navigate to the existing standalone Add Component identity flow.
- `Muuda andmeid`: navigate to the existing standalone Edit Component metadata flow.
- `Paiguta`: open/focus the existing Board Canvas `Lisa` / `Salvesta` visual placement workflow.
- `Mõõda komponenti`: route to Measure Sheet only if the next active-lock sync confirms direct navigation is safe without context propagation; otherwise keep informational/future.

## Must preserve

- `component_created` remains component identity/existence creation.
- `component_updated` remains component metadata update.
- `component_visual_placement_confirmed` remains visual placement confirmation.
- `measurement_recorded` remains measurement write.
- Existing standalone Add/Edit routes remain available.
- Existing Measure Sheet route remains available.
- Existing Board Canvas placement save guards remain intact.
- Board Canvas renderer/painter read-only boundary remains intact.

## Forbidden in this pass

- No runtime edits.
- No test edits.
- No writer edits.
- No schema/tool/materializer/validator edits.
- No events.jsonl / known_facts.json edits.
- No router changes.
- No route hiding or deletion.
- No screen deletion.
- No writer semantic merge.
- No component identity creation from placement.
- No pins/contacts/pads/nets/electrical facts from marker drafts.
- No AI-authored canonical facts.
- No `_incoming` edits or staging.
- No implementation allowlist arming.
- Do not stage, commit, or push.

## Future active-lock sync expectations

The next pass should read live code and decide the exact implementation allowlist. Candidate surfaces may include Board Canvas and related widget tests, but paths must be verified live before arming.

Do not arm broad directories.
Do not arm schema/tools/events/known_facts/_incoming.
Do not arm writer files unless live code proves a direct need; expected answer is no.