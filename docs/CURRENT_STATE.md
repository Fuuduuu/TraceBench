# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only scope-lock is active for a future Add Component / `Lisa komponent` required draft label/name copy fix.

This pass documents scope only. It does not arm runtime implementation, tests, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Scope summary

Manual smoke showed that `Salvesta` becomes inactive when the required draft label/name is empty, but the UI does not make that reason clear enough. The future implementation must make the required label/name blocker visible and understandable without depending on hover, tooltip, or clicking a disabled button.

Locked product intent for the future implementation:

- If required draft label/name is missing, `Salvesta` may remain disabled.
- Persistent visible copy must explain the missing label/name reason.
- Writer must not be invoked while the label/name is missing.
- `events.jsonl` must not grow for the missing-label draft state.
- Entering a valid label/name may enable `Salvesta` only when all other guards are satisfied.

## Current accepted placement reality

- Open project from folder works through `ProjectLoader.loadFromDirectory` and preserves `projectDirectory` for folder-backed writer smoke.
- Board Canvas renderer/painter remains read-only: renderer writes none.
- Explicit human-confirmed Board Canvas Add Component panel `Salvesta` can append canonical `component_visual_placement_confirmed` events when the selected existing component, local project folder, required label, canonical bounds, and writer validation are satisfied.
- Placement writer exists at `lib/features/components/services/v2_placement_writer.dart` and emits only `component_visual_placement_confirmed`.
- Rotation is normalized at the writer boundary to `-180 <= rotation_deg < 180`.
- Invalid `board_normalized` placement drafts are guarded before writer call.
- Successful placement save marks/shows projection stale or refresh-needed; `known_facts.json` remains projection/cache and is not directly mutated by Flutter.
- Visual placement save does not create identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.

## Future implementation boundaries

The next active-lock sync must inspect live code and arm exact files. Likely candidate surfaces are Board Canvas screen and Board Canvas widget tests, but this scope-lock does not arm them.

Future work must not change placement writer contract, canonical event schema, validator/tools/materializer, Project Open From Directory behavior, rotation normalization, projection-stale behavior, canonical-bounds guard, `known_facts.json` mutation behavior, component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, Board Canvas redesign, selected-placement prefill/edit flow, or `Muuda` / `Tühista` behavior unless separately scoped.

## Boundary confirmation

This scope-lock is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Route safety reminders

- Do not use `git add .`.
- Do not use `git add -A`.
- Do not use `git commit -am`.
- Stage only exact files when staging is explicitly requested.
- Repo docs and verified git state outrank handoff text.