# ACTIVE_SCOPE_LOCK.md

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock

None. No implementation pass is armed.

## Write allowlist

No files are currently armed for implementation.

## Current accepted placement boundaries

- Board Canvas renderer/painter remains read-only: renderer writes none.
- Explicit human-confirmed Add Component panel `Salvesta` is the scoped canonical placement write path.
- Placement writer emits only `component_visual_placement_confirmed`.
- `known_facts.json` remains projection/cache and is not directly mutated by Flutter.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.
- Invalid `board_normalized` placement drafts are guarded before writer call.
- Rotation normalization and projection-stale behavior are accepted and remain unchanged unless separately scoped.

## Candidate only

Likely next candidate, not armed: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS`.

## Protected surfaces remain locked unless separately scoped

- schema / validator / materializer / projection semantics
- placement writer contract
- events / `known_facts.json` semantics
- Project Open From Directory behavior
- rotation normalization behavior
- component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- samples/assets and `_incoming`

## Route note

Future work must start from `NEEDS_USER_DECISION` with a fresh scope-lock or active-lock sync before any implementation edits.