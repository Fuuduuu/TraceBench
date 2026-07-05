# ACTIVE_SCOPE_LOCK.md

## Current pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Active lock

Docs-only scope-lock for a future Add Component / `Lisa komponent` required draft label/name copy fix.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS.md`

## Implementation allowlist

No runtime or test implementation files are armed by this pass.

The next active-lock sync must inspect live code and arm exact files for `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`.

Likely candidate surfaces, not armed here:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Locked future behavior

- If the required draft label/name is missing, `Salvesta` may remain disabled.
- The missing-label reason must be shown as visible persistent UI copy.
- The reason must not depend on hover, tooltip, or clicking a disabled button.
- Writer must not be invoked while the label/name is missing.
- `events.jsonl` must not grow for missing-label draft state.
- Entering a valid label/name may enable `Salvesta` only when all other guards are satisfied.

## Current accepted placement boundaries

- Board Canvas renderer/painter remains read-only: renderer writes none.
- Explicit human-confirmed Add Component panel `Salvesta` is the scoped canonical placement write path.
- Placement writer emits only `component_visual_placement_confirmed`.
- `known_facts.json` remains projection/cache and is not directly mutated by Flutter.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.
- Invalid `board_normalized` placement drafts are guarded before writer call.
- Rotation normalization and projection-stale behavior are accepted and remain unchanged unless separately scoped.

## Protected surfaces remain locked unless separately scoped

- schema / validator / materializer / projection semantics
- placement writer contract
- events / `known_facts.json` semantics
- Project Open From Directory behavior
- rotation normalization behavior
- projection-stale behavior
- canonical-bounds guard behavior
- component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- selected-placement prefill/edit flow
- `Muuda` / `Tühista` behavior
- samples/assets and `_incoming`

## Route note

After this scope-lock is accepted and pushed, route should proceed to `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS` so the exact implementation allowlist can be armed from live code.