# PASS_QUEUE

Last updated: 2026-07-06

## Route

Current: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS`
Next: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current pass summary

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS` is a docs-only architecture scope-lock for typed Board Canvas selection Phase 1.

It locks the decision to introduce a future UI-local `CanvasSelection` model while keeping Phase 1 limited to component placement selection inside `_BoardCanvasScreenState`.

No implementation files are armed by this scope-lock. The next pass should be a docs-only active-lock sync that inspects live code and arms the exact implementation allowlist for `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`.

## Visual First guardrails

VISUAL FIRST.

Board Canvas right-side panel/menu remains the primary surface for normal component work.

Do not rebuild old standalone Add/Edit/Measure workflows as a new Board Canvas menu. Do not resurrect navigation-only gateway behavior, a four-card mode selector, `Komponendid` hub/card, `Uus komponent` / `Muuda andmeid` / `Paiguta` / `Mõõda` workflow menu, or table/form-filling UX inside Board Canvas.

Old standalone Add/Edit/Measure-style pages remain transitional migration/removal debt and are not changed by this pass.

## Canonical split preserved

- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Phase 1 typed selection scope

Future implementation may define:

- `CanvasSelection`
- `EmptyCanvasSelection`
- `ComponentPlacementSelection` carrying `placementKey`, `componentId`, and `canvasAnchor`
- `selectedPlacementKey` compatibility getter/adapter for incremental migration

Future implementation must not include:

- Riverpod/global provider extraction
- pin/contact/pad/net/trace/measurement/electrical selection semantics
- floating panel implementation
- router or standalone page changes
- writer/schema/materializer/validator/tool changes
- canonical event changes
- `_incoming` use or staging

## Scope gate rules

- One narrow pass at a time.
- Active implementation allowlists live in `docs/ACTIVE_SCOPE_LOCK.md`.
- Runtime/test implementation may begin only after the active-lock sync pass arms exact files.
- Do not stage, commit, or push from Codex unless explicitly requested.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
