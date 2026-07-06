# PASS_QUEUE

Last updated: 2026-07-06

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Latest closeout

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_POST_AUDIT_PASS` records and closes the pushed `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS` implementation.

Implementation commit recorded:

- `9a9b3cfcabb7da7986595a8feafadf9966086d75` (`refactor: add typed board canvas selection`)

Claude implementation audit recorded:

- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Closed behavior summary

Phase 1 typed Board Canvas selection now introduces UI-local typed selection architecture while preserving current behavior through compatibility adapters.

Recorded behavior:

- `CanvasSelection` model introduced.
- `EmptyCanvasSelection` introduced.
- `ComponentPlacementSelection` introduced with `placementKey`, `componentId`, and `canvasAnchor`.
- Selection remains UI-local inside `_BoardCanvasScreenState`.
- `selectedPlacementKey` compatibility getter/adapter remains for incremental migration.
- Canvas hit-test selection moves toward typed `ComponentPlacementSelection`.
- Component tap selection/highlight, right-panel context, placement selector, empty-canvas clearing, measure-button fallback, Add Component prefill, and `Salvesta` guards remain preserved.
- Selection alone writes no canonical data.

## Visual First guardrails

VISUAL FIRST.

Board Canvas right-side panel/menu remains the primary surface for normal component work.

Do not rebuild old standalone Add/Edit/Measure workflows as a new Board Canvas menu. Do not resurrect navigation-only gateway behavior, a four-card mode selector, `Komponendid` hub/card, `Uus komponent` / `Muuda andmeid` / `Paiguta` / `Mõõda` workflow menu, or table/form-filling UX inside Board Canvas.

Old standalone Add/Edit/Measure-style pages remain transitional migration/removal debt and were not changed by this implementation.

## Canonical split preserved

- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Explicit non-changes recorded

- No Riverpod/global provider extraction.
- No pin/contact/pad/net/trace/measurement/electrical selection semantics.
- No floating panel implementation.
- No router or standalone page changes.
- No writer/schema/materializer/validator/tool changes.
- No canonical event changes.
- No events.jsonl / known_facts.json semantic changes.
- No `_incoming` use or staging.
- No durable `screenAnchor` storage.

## Candidate follow-ups, not active route

- Board Canvas right-panel component creation flow.
- Board Canvas right-panel component metadata editing flow.
- Standalone Add/Edit route migration/removal after right-panel replacements exist.
- Standalone Measure route cleanup after right-panel measurement dependencies are verified.
- Docs compaction / Visual First alignment only after the current runtime chain is fully closed.

## Scope gate rules

- One narrow pass at a time.
- Active implementation allowlists live in `docs/ACTIVE_SCOPE_LOCK.md`.
- Runtime/test implementation may begin only after an active-lock sync pass arms exact files.
- Do not stage, commit, or push from Codex unless explicitly requested.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
