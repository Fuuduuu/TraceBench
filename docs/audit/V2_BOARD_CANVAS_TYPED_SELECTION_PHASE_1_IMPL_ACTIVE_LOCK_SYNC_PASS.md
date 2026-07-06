# V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only implementation active-lock sync.

## Baseline verification

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main...origin/main`
- Baseline HEAD: `06ce0de docs: lock typed canvas selection phase 1`
- Starting tracked diff: clean
- Starting cached diff: clean
- `git diff --check` before edit: PASS
- Route gate before edit:
  - Current: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_SCOPE_LOCK_PASS`
  - Next: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Active lock before edit: no runtime implementation lock armed; scope-lock pointed to `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`
- Known untracked scratch remained unrelated and untouched

## Goal

Arm the exact implementation allowlist for `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`.

This pass does not implement runtime behavior and does not edit tests.

## Live-code findings

- `lib/features/board_canvas/screens/board_canvas_screen.dart` currently owns Board Canvas selection state locally inside `_BoardCanvasScreenState`.
- Current compatibility selection is raw placement-key based through `_selectedPlacementKey`.
- Add Component placement context is also keyed through `_addComponentTemplatePlacementContextKey`.
- The Board Canvas screen already contains placement entries, placement draft seeding from selected placement, `InteractiveViewer` / `GestureDetector` canvas interaction, and hit/selection plumbing that can be migrated behind a typed selection adapter.
- `test/widget/board_canvas_screen_test.dart` already contains Board Canvas selection helper coverage, placement draft tests, no-write assertions, writer-boundary tests, renderer read-only checks, and source checks for `InteractiveViewer`, `GestureDetector`, `onPlacementSelected`, and placement hit testing.
- Live-code inspection did not justify arming any file outside the Board Canvas screen and Board Canvas widget test.

## Implementation pass armed

`V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal

Introduce a typed UI-local `CanvasSelection` model as the Board Canvas selection layer while preserving existing behavior through a `selectedPlacementKey` compatibility adapter.

Phase 1 may include:

- `CanvasSelection`
- `EmptyCanvasSelection`
- `ComponentPlacementSelection`
- `ComponentPlacementSelection.placementKey`
- `ComponentPlacementSelection.componentId`
- `ComponentPlacementSelection.canvasAnchor`
- a compatibility getter/adapter for selected placement key
- migration of existing placement selection and empty canvas tap plumbing to typed UI-local selection
- focused Board Canvas widget tests

## Forbidden surfaces

- No files outside the exact implementation allowlist.
- No Riverpod/global provider extraction.
- No pin/contact/pad/net/trace/measurement/electrical selection semantics.
- No floating panel implementation.
- No storage of `screenAnchor` as durable selection state.
- No router edits.
- No standalone Add/Edit/Measure page edits.
- No writer edits.
- No schema edits.
- No validator/materializer/tool edits.
- No events.jsonl / known_facts.json semantic changes.
- No samples/assets edits.
- No `_incoming` edits, imports, copies, or staging.
- No staging, commit, or push.

## Route after sync

- Current: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `V2_BOARD_CANVAS_TYPED_SELECTION_PHASE_1_IMPL_PASS`

## Boundary confirmation

- Docs-only sync.
- No runtime implementation.
- No test implementation.
- No protected event/fact/projection semantics changed.
- Visual First product rule preserved.
- Canonical event split preserved:
  - `component_created` = component identity/existence creation
  - `component_updated` = component metadata update
  - `component_visual_placement_confirmed` = visual placement confirmation
  - `measurement_recorded` = measurement write

## Validation commands

- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit status

- `RETRO_CLAUDE_READY`
- `DO_NOT_CLAIM_CLAUDE_REVIEW`
