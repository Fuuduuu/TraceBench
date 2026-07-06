# ACTIVE_SCOPE_LOCK

Last updated: 2026-07-06

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock state

No active implementation lock is armed.

The `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS` implementation lock is released by `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_POST_AUDIT_PASS`.

## Released implementation pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

Implementation commit recorded:

- `9a9b3cfcabb7da7986595a8feafadf9966086d75` (`refactor: add typed board canvas selection`)

Claude audit recorded for the implementation:

- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Released allowlist

The prior implementation allowlist is no longer active:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

A future implementation pass must be separately scoped and actively armed before any runtime/test files may be edited.

## Closed typed selection behavior

- UI-local `CanvasSelection` model introduced.
- `EmptyCanvasSelection` and `ComponentPlacementSelection` introduced.
- `ComponentPlacementSelection` carries `placementKey`, `componentId`, and `canvasAnchor`.
- `selectedPlacementKey` compatibility getter/adapter preserved.
- Canvas hit-test selection migrated toward typed `ComponentPlacementSelection`.
- Existing component selection, right-panel context, placement selector, empty-canvas clearing, measure fallback, Add Component prefill, and `Salvesta` guards preserved.
- Selection alone writes no canonical data.

## Visual First rule retained

VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal component work.

Do not resurrect a navigation-only gateway, four-card mode selector, `Komponendid` hub/card, old standalone workflow menu, or table/form-filling UX inside Board Canvas.

Old standalone Add/Edit/Measure-style pages remain transitional migration/removal debt.

## Canonical boundary retained

- UI selection must not create or imply canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Visual placement must not create component identity.
- Visual/contact draft state must not create pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions.
- The accepted measurement/right-panel workflow remains accepted and was not reworked.
