# REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS

PASS_ID: `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_IMPL_PASS`
Lane: `FLUTTER_PASS`
Mode: `Narrow responsive layout implementation`

## Scope

Implement constrained-width responsive behavior for `ReferenceImagesScreen` only.

- keep existing safety copy and required strings,
- keep existing metadata grouping/accessibility behavior,
- keep Model-B/reference-image sidecar boundaries,
- keep no transform/overlay/Board Canvas/AI/Project ZIP scope expansion.

## Files written

- `lib/features/reference_images/screens/reference_images_screen.dart`
- `test/widget/reference_images_screen_test.dart`

## Result

- Implemented narrow-window responsive layout behavior in `ReferenceImagesScreen`.
- Added deterministic stacked narrow layout for list + preview with stable panel keys.
- Preserved wide layout and behavior for existing wide-screen flow.
- Prevented constrained-width overflow for long stored-path/SHA metadata fields by wrapping text in the preview card.
- Kept all test setup filesystem-light and avoided real `Image.file` decode in responsive tests.
- Added/updated bounded widget coverage for:
  - wide layout structure,
  - narrow stacked layout behavior,
  - responsive metadata rendering in constrained width.

## Validation run in this pass

- `flutter test test/widget/reference_images_screen_test.dart --reporter expanded`
- `flutter test --reporter expanded`
- `py -3 tools\validate_all.py`

## Boundary checks

- No service/storage/model/tool/schema/materializer/Project ZIP changes.
- No `board_graph.json` / `view_state.json` behavior added.
- Required safety strings remain unchanged and present in existing states.
- Evidence boundaries remain unchanged for Reference Images (local sidecar preview only).

## Route

- Next pass: `REFERENCE_IMAGES_UX_RESPONSIVE_LAYOUT_POST_AUDIT_PASS`
