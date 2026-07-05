# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only scope-lock is active for future standalone Add Component / Edit Component labeling cleanup.

No runtime, test, router, writer, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` edits are authorized by this pass.

## Scope intent

Standalone Add Component and Edit Component remain transitional canonical writer flows:

- Standalone Add Component creates component identity/existence with `component_created`.
- Standalone Edit Component updates component metadata with `component_updated`.
- Board Canvas `Lisa` / `Salvesta` confirms visual placement for an already selected existing component with `component_visual_placement_confirmed`.

The future implementation should make user-facing labels/copy distinguish identity creation, metadata editing, and visual placement confirmation.

## Live-code findings

- Project Overview owns visible Add/Edit action buttons that route to `/project/components/add` and `/project/components/edit`.
- Standalone Add Component currently uses `Lisa komponent` copy and records `component_created`.
- Standalone Edit Component currently uses `Muuda komponenti` copy and records `component_updated`.
- Board Canvas currently uses `Lisa komponent` / `Salvesta` language for selected-component visual placement confirmation.
- Existing widget tests assert labels and writer event types for Project Overview, Add Component, Edit Component, and Board Canvas.

## Boundary confirmation

- No route hiding, screen deletion, runtime implementation, or test migration is authorized by this scope-lock.
- No writer/schema/validator/materializer/tool/event/known_facts semantics changes are authorized.
- The next active-lock sync must inspect live code and arm exact implementation files before any runtime/test changes.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
