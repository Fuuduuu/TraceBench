# PASS_QUEUE

Last updated: 2026-07-06

## Route

Current: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`
Next: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

## Current pass summary

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS` is a docs-only active-lock sync for typed Board Canvas selection Phase 1.

It reads live code and arms the exact implementation allowlist for `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`.

The sync performs no runtime or test implementation.

## Implementation pass armed

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

Exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Live-code findings:

- Current Board Canvas selection state is UI-local and raw placement-key based through `_selectedPlacementKey`.
- Add Component placement context uses `_addComponentTemplatePlacementContextKey`.
- Board Canvas already has placement entries, selected-placement draft seeding, canvas interaction, and hit/selection plumbing suitable for typed-selection Phase 1 migration.
- Board Canvas widget tests already cover selection helpers, no-write paths, placement draft behavior, writer invocation boundaries, and source-level canvas interaction checks.
- No additional files are needed for Phase 1 based on live-code inspection.

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

Implementation may define:

- `CanvasSelection`
- `EmptyCanvasSelection`
- `ComponentPlacementSelection` carrying `placementKey`, `componentId`, and `canvasAnchor`
- `selectedPlacementKey` compatibility getter/adapter for incremental migration

Implementation must not include:

- Riverpod/global provider extraction
- pin/contact/pad/net/trace/measurement/electrical selection semantics
- floating panel implementation
- router or standalone page changes
- writer/schema/materializer/validator/tool changes
- canonical event changes
- `_incoming` use or staging
- any file outside the two-file implementation allowlist

## Scope gate rules

- One narrow pass at a time.
- Active implementation allowlists live in `docs/ACTIVE_SCOPE_LOCK.md`.
- Runtime/test implementation may begin only after the active-lock sync pass arms exact files.
- Do not stage, commit, or push from Codex unless explicitly requested.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
