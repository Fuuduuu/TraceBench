# ACTIVE_SCOPE_LOCK

Last updated: 2026-07-06

## Current pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

## Active lock state

Docs-only implementation active-lock sync is active.

The runtime implementation lock is now armed for `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`.

## Write allowlist for this active-lock sync

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Armed implementation pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

## Exact implementation write allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If implementation needs any additional file, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.

## Live-code findings

- Current Board Canvas selection is UI-local inside `_BoardCanvasScreenState`.
- Existing compatibility state is raw placement-key based through `_selectedPlacementKey`.
- Add Component placement context uses `_addComponentTemplatePlacementContextKey`.
- Board Canvas screen contains placement entry, placement draft seeding, and canvas interaction plumbing suitable for a typed-selection adapter.
- Board Canvas widget tests cover selection helpers, placement draft behavior, no-write assertions, writer boundaries, and canvas interaction source checks.
- Live-code inspection did not justify arming files outside the Board Canvas screen and Board Canvas widget tests.

## Locked Phase 1 architecture

Implementation should introduce a typed UI-local `CanvasSelection` model as the Board Canvas selection layer.

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
- No edits outside the exact implementation write allowlist.

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
