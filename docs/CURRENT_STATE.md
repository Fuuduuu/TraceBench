# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active pass is armed. Route control remains with the user after the canonical placement chain closeouts.

This docs-only truth sync records the accepted post-chain reality and does not arm implementation.

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

## Recent implementation chain recorded

- `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`: placement writer + explicit selected-component `Salvesta`.
- `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`: local-folder open path preserves `projectDirectory`.
- `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`: writer-boundary rotation normalization.
- `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`: truthful projection-stale copy after save.
- `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`: status/action copy distinguishes renderer read-only from explicit save.
- `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`: pre-writer canonical-bounds guard.

## Candidate only

Likely next candidate, not armed: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS`.

## Boundary confirmation

This truth-sync is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Route safety reminders

- Do not use `git add .`.
- Do not use `git add -A`.
- Do not use `git commit -am`.
- Stage only exact files when staging is explicitly requested.
- Repo docs and verified git state outrank handoff text.