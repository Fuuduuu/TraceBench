# REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_SCOPE_LOCK_PASS

PASS_ID: `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_SCOPE_LOCK_PASS`

Lane: `DOCS_SYNC`

Mode: `Docs-only scope lock`

## Result

In progress.

## Scope lock

- Locked the next implementation pass as:
  - `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS`
- Scope is narrow: responsive/narrow-window layout handling only.
- Wide layout must remain functionally stable; narrow layout may stack/flow sections to avoid overflow and cramped columns.
- Long stored-path/SHA text must wrap/clip/scroll safely without dropping required safety strings.
- Existing metadata grouping, copy/safety framing, accessibility semantics, and empty/missing/error-state behavior are preserved as-is unless width constraints require non-breaking layout reflow.

## Inputs recorded

- `REFERENCE_IMAGES_UX_POST_SLICE_SMOKE_RUN_PASS` is accepted (`PASS_WITH_NITS`), and it documented:
  - non-responsive cramped narrow layout,
  - safety card + import row density,
  - long stored path / SHA visibility issues in constrained widths.

## Allowed implementation surfaces

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS.md`

## Forbidden surfaces

- no transform / projection conversion / overlay feature work
- no Board Canvas link/overlay/send-to-board
- no AI/OCR/CV
- no URL import
- no events/known_facts/materializer/tool/schema/runtime/samples/assets changes
- no `board_graph.json` / `view_state.json`

## Required test-shape rules

- No real `Image.file` decode in widget tests.
- No filesystem-heavy widget tests.
- Use existing preview placeholder path/seam where image rendering is required in tests.
- Bounded pumps only.
- Constrain tests for both wide and narrow widths when layout behavior is validated.

## Route

- Next pass: `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS`
