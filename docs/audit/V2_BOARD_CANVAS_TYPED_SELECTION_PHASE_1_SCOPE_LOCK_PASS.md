# V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS

## Mode

Docs-only architecture scope-lock.

## Baseline verification

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main...origin/main`
- Baseline HEAD: `fd62df8 docs: close out visual-first component workflow cleanup`
- Starting tracked diff: clean
- Starting cached diff: clean
- `git diff --check` before edit: PASS
- Route gate before edit: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- Active lock before edit: no active implementation lock armed
- Known untracked scratch remained unrelated and untouched

## Goal

Lock a future Phase 1 Board Canvas typed selection implementation before runtime/test work starts.

This pass records architecture decision and future implementation boundaries only. It does not implement runtime behavior, does not edit tests, and does not arm runtime files directly.

## Product rule

VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal technician component work.

Do not rebuild old standalone Add/Edit/Measure workflows as a new Board Canvas menu. Do not resurrect:

- navigation-only gateway
- four-card mode selector
- `Komponendid` hub/card
- `Uus komponent` / `Muuda andmeid` / `Paiguta` / `Mõõda` workflow menu
- table/form-filling UX inside Board Canvas

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. They are not primary technician workflow and must be migrated/removed only through separately scoped passes.

## Architecture decision locked

Introduce a typed UI-local `CanvasSelection` model as the future Board Canvas selection layer.

Phase 1 scope:

- Component placement selection only.
- UI-local state inside `_BoardCanvasScreenState`.
- No Riverpod/global provider extraction in Phase 1.
- No pin/contact/pad/net/trace/measurement/electrical selection semantics in Phase 1.
- No floating panel implementation in Phase 1.
- No router or standalone page changes in Phase 1.
- No writer/schema/materializer/validator/tool changes in Phase 1.
- No canonical event changes in Phase 1.
- No `_incoming` use or staging.

Preferred future Phase 1 implementation shape:

- Introduce a typed `CanvasSelection` abstraction.
- Include `EmptyCanvasSelection`.
- Include `ComponentPlacementSelection`.
- `ComponentPlacementSelection` may carry:
  - `placementKey`
  - `componentId`
  - `canvasAnchor`
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

## Measurement boundary

The accepted measurement/right-panel workflow remains accepted and must not be reworked by this scope-lock.

Standalone measurement route cleanup is future migration/removal debt only after dependency verification and scoped replacement.

## Future implementation routing

Current route after this scope-lock:

- Current: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS`
- Next: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`

The next active-lock sync should inspect live code and arm the exact allowlist for `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`.

Likely future candidate surfaces, not armed by this pass:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Boundary confirmation

- Docs-only pass.
- No runtime edits.
- No test edits.
- No router edits.
- No standalone Add/Edit/Measure page edits.
- No writer/schema/materializer/validator/tool edits.
- No events.jsonl / known_facts.json semantic changes.
- No `_incoming` edits or staging.
- No staging, commit, or push.

## Validation commands

- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`
