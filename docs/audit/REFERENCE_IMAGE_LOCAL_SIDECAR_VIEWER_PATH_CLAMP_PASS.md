# REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS`

## Lane
`V1_1_IMPLEMENTATION_PASS`

## Mode
Narrow implementation hardening.

## Result
Completed.

## Implementation summary
- Updated `resolveStoredImageFile` in:
  - `lib/features/reference_images/services/reference_image_sidecar_service.dart`
- Hardening behavior added:
  - reject absolute ledger paths,
  - reject ledger paths with `..` traversal segments,
  - require sidecar prefix `.tracebench_local/reference_images/`,
  - reject resolved paths outside sidecar image root.
- Return type changed to nullable (`File?`) so invalid/unresolved paths return `null`.
- Valid generated sidecar paths continue resolving.

## Tests added
- Updated:
  - `test/widget/reference_images_screen_test.dart`
- Added focused coverage for:
  - absolute path rejection,
  - `..` traversal rejection,
  - escape/outside-root rejection,
  - valid sidecar-path resolution.

## Boundary confirmation
- No URL import.
- No AI/OCR/CV.
- No Board Canvas overlay.
- No transform/matrix/photo alignment computation.
- No `events.jsonl` writes.
- No `known_facts.json` writes.
- No schema/materializer/Project ZIP tooling changes.
- No sample/asset/generated-artifact/tag/release-object changes.
- No `board_graph.json` / `view_state.json`.
- Model B remains local sidecar-only and non-canonical.

## Validation
- `flutter test test/widget/reference_images_screen_test.dart --reporter expanded`
- `flutter test --reporter expanded`
- `py -3 tools\validate_all.py`

## Next recommended pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_POST_AUDIT_PASS`
