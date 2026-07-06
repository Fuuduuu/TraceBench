# CURRENT_STATE

Last updated: 2026-07-06

## Current route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Active pass

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_POST_AUDIT_PASS` closes out the pushed Phase 1 typed Board Canvas selection implementation and releases the active implementation lock.

No implementation pass is currently armed.

## Closed implementation

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS` is recorded as accepted and pushed.

Implementation commit:

- `9a9b3cfcabb7da7986595a8feafadf9966086d75` (`refactor: add typed board canvas selection`)

Claude audit recorded for the implementation:

- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Typed selection behavior recorded

- Introduced a typed UI-local `CanvasSelection` model.
- Added `EmptyCanvasSelection`.
- Added `ComponentPlacementSelection`.
- `ComponentPlacementSelection` carries `placementKey`, `componentId`, and `canvasAnchor`.
- Kept selection UI-local inside `_BoardCanvasScreenState`.
- Preserved `selectedPlacementKey` compatibility getter/adapter.
- Routed selection writes through typed helper methods.
- Migrated canvas hit-test selection toward typed `ComponentPlacementSelection`.
- Preserved component tap selection/highlight behavior.
- Preserved right-panel / inspector selected component context.
- Preserved placement selector behavior.
- Preserved empty canvas tap clearing behavior.
- Preserved measure-button selection fallback behavior.
- Preserved Add Component / `Lisa` selected-placement prefill behavior.
- Preserved `Salvesta` behavior and guards.
- Preserved explicit writer boundary: selection alone writes nothing.
- Tests assert typed selection architecture and forbidden selection classes are absent.

## Visual First product rule retained

VISUAL FIRST.

Board Canvas right-side panel/menu remains the primary surface for normal technician component work.

Old standalone Add/Edit/Measure-style pages remain transitional migration/removal debt. They are not primary technician workflow, were not touched by the typed-selection implementation, and must not be duplicated inside Board Canvas.

The accepted measurement/right-panel workflow remains accepted and was not reworked.

## Canonical boundaries retained

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

## Explicit non-changes

- No Riverpod/global provider extraction.
- No pin/contact/pad/net/trace/measurement/electrical selection semantics.
- No floating panel implementation.
- No router changes.
- No standalone Add/Edit/Measure page edits.
- No writer/schema/materializer/validator/tool changes.
- No canonical event changes.
- No events.jsonl / known_facts.json semantic changes.
- No `_incoming` use or staging.
- No durable `screenAnchor` storage.
- No duplicate `Komponendid` hub/card or old workflow menu.
- No navigation-only gateway.
- No four-card selector.
- No table/form-filling UX regression.

## Candidate follow-ups only

Future candidates remain inactive until the user chooses and scopes one:

- Board Canvas right-panel component creation flow.
- Board Canvas right-panel component metadata editing flow.
- Standalone Add/Edit route migration/removal after right-panel replacements exist.
- Standalone Measure route cleanup after right-panel measurement dependencies are verified.
- Docs compaction / Visual First alignment only after the current runtime chain is fully closed.

## Standing boundaries

- Do not stage, commit, or push unless explicitly requested.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
- Treat `_incoming` as design input only, not runtime truth.
