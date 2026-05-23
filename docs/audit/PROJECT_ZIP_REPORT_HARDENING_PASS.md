# PROJECT_ZIP_REPORT_HARDENING_PASS

## Status

Completed

## Lane

TOOLS_PASS

## Scope

Lock and implement combined Project ZIP + customer report hardening from scope lock:
- hard reject V1 `board_graph.json` and `view_state.json` artifacts in validation
- update export to skip forbidden artifacts by default
- harden `tests/test_project_zip.py` with forbidden-entry and report-boundary tests
- confirm optional photo-file behavior is warning-only for missing references

## Files changed

- tools/export_project_zip.py
- tools/validate_project_zip.py
- tests/test_project_zip.py
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/PROJECT_ZIP_REPORT_HARDENING_PASS.md

## Validation

`py -3 tools\validate_all.py`

## Results

- `board_graph.json` and `view_state.json` are now treated as hard V1 ZIP errors in validation.
- Validation now emits warning-level messages for missing optional photo files referenced in `known_facts.json`.
- Export path skips forbidden artifacts instead of including them.
- Tests added for:
  - `test_zip_rejects_board_graph_json`
  - `test_zip_rejects_view_state_json`
  - `test_project_dir_rejects_board_graph_json_if_directory_validation_supported`
  - `test_project_dir_rejects_view_state_json_if_directory_validation_supported`
  - `test_customer_report_boundary_forbids_inference_claims`
  - `test_customer_report_keeps_visual_trace_non_electrical`
  - `test_missing_optional_photo_file_is_warning_not_error`
  - `test_export_does_not_include_forbidden_v1_artifacts`

## Forbidden-surface confirmation

No schema changes, Flutter/Dart changes, event-writing, event envelope changes,
UI/Photo-import changes, or Project ZIP contract expansion were introduced in this pass.
No `events.jsonl` or `known_facts.json` sample material was mutated.
`board_graph.json` and `view_state.json` were enforced as hard errors in V1 tooling validation.
