# REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`

## Lane
`V1_1_IMPLEMENTATION_PASS`

## Mode
Narrow implementation (Model B).

## Result
Completed.

## Implementation summary
- Added `Reference Images` route and Project overview entry action.
- Added local sidecar import/view module:
  - `lib/features/reference_images/services/reference_image_sidecar_service.dart`
  - `lib/features/reference_images/screens/reference_images_screen.dart`
- Import behavior:
  - local picker only,
  - extension allowlist: `png`, `jpg`, `jpeg`, `webp`,
  - copies files into `.tracebench_local/reference_images/`,
  - updates non-canonical ledger `.tracebench_local/reference_images.json`.
- Metadata persisted per item:
  - `reference_image_id`
  - `original_filename_display`
  - `stored_relative_path`
  - `mime_type`
  - `file_size_bytes`
  - `sha256` (computed in-app)
  - `imported_at`
  - `source = local_file_picker`
  - `project_id`
  - `notes` optional (not edited in this pass).
- Viewer behavior:
  - read-only list + preview,
  - explicit safety copy:
    - reference only
    - not evidence
    - not included in Project ZIP
    - not used by AI
    - renderer writes: none

## Boundary confirmation
- No Project ZIP tooling/contract changes.
- No `events.jsonl` writes or event schema changes.
- No `known_facts.json` writes or known_facts schema/model changes.
- No materializer changes.
- No Board Canvas overlay/reference layer/transform behavior.
- No URL import/download.
- No AI/OCR/CV/detection/proposal behavior.
- No `board_graph.json` / `view_state.json` surfaces added.

## Tests and validation
- Added/updated widget tests:
  - `test/widget/project_overview_screen_test.dart`
  - `test/widget/reference_images_screen_test.dart`
- Validation commands:
  - `py -3 -m unittest tests.test_project_zip`
  - `py -3 tools\validate_all.py`
  - `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`

## Next recommended pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_POST_AUDIT_PASS`
