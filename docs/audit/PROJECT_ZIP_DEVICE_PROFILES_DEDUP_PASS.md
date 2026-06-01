# PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS

## PASS_ID
`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS`

## Lane
`TOOLS_PASS`

## Mode
Narrow Project ZIP export hardening. No runtime/model/schema/materializer/sample/asset/test-surface changes.

## Scope lock result
- Implementation target accepted from scope lock: `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS`.
- Root cause: duplicate archive-name emission for `device_profiles/default.json` when project contains `device_profiles/default.json`.
- Fix: deduplicate exported ZIP entries by archive name before write.

## Implementation summary
- Updated `tools/export_project_zip.py`:
  - added deterministic dedup state during file collection.
  - ensured each archive path is appended only once even when multiple collectors target the same relative path.
  - preserved existing required contents and exclusion rules.
- Required ZIP behavior preserved:
  - `.tracebench_local`, `.codex`, `.git`, `__pycache__`, `.env`, logs are still excluded.
  - `board_graph.json` and `view_state.json` remain excluded and rejected by Project ZIP validation contract.

## Test updates
- Added in `tests/test_project_zip.py`:
  - `test_export_project_zip_has_unique_archive_names`
  - `test_export_project_zip_default_device_profile_once_when_present`
- Coverage:
  - no duplicate archive names in exported ZIP.
  - `device_profiles/default.json` appears exactly once when present in source project.
  - required ZIP paths remain present in this scenario.

## Evidence boundaries (preserved)
- `events.jsonl` remains canonical.
- `known_facts.json` remains materialized projection.
- No event-writing UI or transform/reference-image overlay behavior added.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.

## Next recommended pass
`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_POST_AUDIT_PASS`

