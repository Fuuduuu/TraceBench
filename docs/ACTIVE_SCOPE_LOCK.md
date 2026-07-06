# ACTIVE_SCOPE_LOCK

Last updated: 2026-07-06

## Current pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Active lock state

Docs-only architecture scope-lock is active.

No runtime implementation lock is armed by this pass.

## Write allowlist for this scope-lock

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS.md`

## Future implementation pass to route toward

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

The next active-lock sync must inspect live code and arm the exact implementation allowlist. Expected candidate surfaces are likely limited to Board Canvas screen and Board Canvas widget tests, but this scope-lock does not arm them directly.

## Locked Phase 1 architecture

Future implementation should introduce a typed UI-local `CanvasSelection` model as the Board Canvas selection layer.

Phase 1 allowed architecture:

- UI-local state inside `_BoardCanvasScreenState`.
- Component placement selection only.
- `CanvasSelection` abstraction.
- `EmptyCanvasSelection`.
- `ComponentPlacementSelection` with `placementKey`, `componentId`, and `canvasAnchor`.
- `selectedPlacementKey` compatibility getter/adapter for incremental migration.

Phase 1 forbidden architecture:

- No Riverpod/global provider extraction.
- No pin/contact/pad/net/trace/measurement/electrical selection semantics.
- No floating panel implementation.
- No router or standalone page changes.
- No writer/schema/materializer/validator/tool changes.
- No canonical event changes.
- No `_incoming` use or staging.
- No storage of `screenAnchor` as durable selection state.

## Visual First rule retained

VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal component work.

Do not resurrect a navigation-only gateway, four-card mode selector, `Komponendid` hub/card, old standalone workflow menu, or table/form-filling UX inside Board Canvas.

## Canonical boundary retained

- UI selection must not create or imply canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Visual placement must not create component identity.
- Visual/contact draft state must not create pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions.
- The accepted measurement/right-panel workflow remains accepted and must not be reworked by this scope-lock.
