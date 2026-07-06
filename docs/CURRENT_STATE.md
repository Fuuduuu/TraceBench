# CURRENT_STATE

Last updated: 2026-07-06

## Current route

Current: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS`
Next: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Active pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS` is a docs-only architecture scope-lock for a future Phase 1 Board Canvas typed selection implementation.

This pass records architecture intent only. It does not implement runtime behavior, does not edit tests, and does not arm runtime files directly. The next pass is expected to be an implementation active-lock sync that reads live code and arms the exact implementation allowlist.

## Visual First product rule

VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal technician component work.

Do not rebuild old standalone Add/Edit/Measure workflows as a new Board Canvas menu. Do not resurrect a navigation-only gateway, four-card mode selector, `Komponendid` hub/card, `Uus komponent` / `Muuda andmeid` / `Paiguta` / `Mõõda` workflow menu, or table/form-filling UX inside Board Canvas.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. They are not the primary technician workflow and must be migrated/removed only through separately scoped passes.

The accepted measurement/right-panel workflow remains accepted and is not reworked by this scope-lock.

## Typed selection architecture decision

Future Phase 1 should introduce a typed UI-local `CanvasSelection` model as the Board Canvas selection layer.

Phase 1 is limited to component placement selection only:

- UI-local state inside `_BoardCanvasScreenState`.
- No Riverpod/global provider extraction in Phase 1.
- No pin/contact/pad/net/trace/measurement/electrical selection semantics in Phase 1.
- No floating panel implementation in Phase 1.
- No router or standalone page changes in Phase 1.
- No writer/schema/materializer/validator/tool changes in Phase 1.
- No canonical event changes in Phase 1.
- No `_incoming` use or staging.

Preferred future implementation shape:

- Introduce a typed `CanvasSelection` abstraction.
- Include `EmptyCanvasSelection`.
- Include `ComponentPlacementSelection`.
- `ComponentPlacementSelection` may carry `placementKey`, `componentId`, and `canvasAnchor`.
- `screenAnchor` should not be stored as durable selection state in Phase 1; future floating panel position should be derived from `canvasAnchor` plus current canvas transform / RenderBox data.
- Preserve a `selectedPlacementKey` compatibility getter/adapter so existing right-panel/painter code can migrate incrementally.
- Canvas hit-test can later report typed selection instead of raw placement key.
- Empty canvas tap can later produce `EmptyCanvasSelection`.

## Canonical boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human is the sensor; AI is the graph engine.
- UI selection must not create or imply canonical facts.
- Visual placement must not create component identity.
- Visual/contact draft state must not create pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions.
- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Standing boundaries

- Do not edit runtime or tests in this scope-lock.
- Do not touch router, standalone Add/Edit/Measure pages, writers, schema, validator, materializer, tools, events, known_facts, samples, assets, or `_incoming`.
- Do not stage, commit, or push.
