# REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS`

## Lane
`TOOLS_PASS`

## Mode
Narrow tooling hardening.

## Result
Completed.

## Scope confirmation
- Changed only allowed files:
  - `tools/export_project_zip.py`
  - `tools/validate_project_zip.py` (optional symmetry path, kept narrow)
  - `tests/test_project_zip.py`
  - `docs/PROJECT_ZIP_SPEC.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS.md`
- No Flutter/runtime/schema/materializer/sample/asset/generated artifact changes.
- No tag/release-object mutations.

## Implementation summary
- Added `.tracebench_local` to Project ZIP export exclusions in `tools/export_project_zip.py`.
- Added validator symmetry in `tools/validate_project_zip.py`:
  - `.tracebench_local` added to forbidden path parts,
  - directory validation now rejects entries containing forbidden path parts.
- Added/updated ZIP tests in `tests/test_project_zip.py`:
  - export excludes `.tracebench_local/reference_images/*` and `.tracebench_local/reference_images.json`,
  - crafted ZIP containing `.tracebench_local` is rejected,
  - project directory containing `.tracebench_local` is rejected by validator.
- Updated `docs/PROJECT_ZIP_SPEC.md` to explicitly document `.tracebench_local` sidecar exclusion.

## Contract and boundary confirmation
- This pass is exclusion hardening only.
- No Project ZIP contract expansion.
- Reference images remain non-canonical sidecar data.
- `events.jsonl` and `known_facts.json` semantics unchanged.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.

## Validate/import symmetry decision
- Implemented in this pass (narrow, defense-in-depth):
  - export excludes `.tracebench_local`,
  - validator rejects `.tracebench_local` entries in ZIPs and project directories.

## Validation run
- `py -3 -m unittest tests.test_project_zip` passed.
- `py -3 tools\validate_all.py` passed.

## Next recommended pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_POST_AUDIT_PASS`
