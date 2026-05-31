# REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_SCOPE_LOCK_PASS

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock.

## Result
Completed.

## Gate confirmation
- Branch confirmed: `main`
- Remote confirmed: `origin https://github.com/Fuuduuu/TraceBench.git`
- HEAD sync confirmed: `origin/main...HEAD = 0 0`
- Tracked working tree confirmed clean at gate start.
- Only known unrelated local untracked paths present:
  - `.idea/`
  - `.metadata`
  - `assets/samples/pelle_pv20_minimal/metadata/`
  - `trace_bench_viewer.iml`
  - `windows/`
- Tag confirmation:
  - local `v1.0.0-rc1` exists,
  - remote `origin` tag exists.
- Accepted/pushed confirmation:
  - `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_SCOPE_LOCK_PASS` (`90af6e7`)
  - `VALIDATE_ALL_FIXTURE_COVERAGE_PASS` (`1563dab`)
  - `VALIDATE_ALL_FIXTURE_COVERAGE_CLOSEOUT_PASS` (`55d42e7`)
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS` status:
  - blocked before implementation,
  - no repo modifications.
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_AUDIT_PASS`:
  - accepted from audit context with verdict `PASS`.

## Audit verdict recorded
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_AUDIT_PASS = PASS`.
- Audit confirms:
  - `.tracebench_local` is currently not excluded from Project ZIP export,
  - exclusion hardening is safe and narrow,
  - this is contract-preserving hardening, not contract expansion,
  - full Project ZIP contract audit is not required for this exclusion-only change.

## Locked next implementation pass
- PASS_ID: `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS`
- Lane: `TOOLS_PASS`

## Locked next-pass implementation goal
- Add `.tracebench_local` to ZIP export exclusions.
- Add/adjust tests proving `.tracebench_local/reference_images/**` and `.tracebench_local/reference_images.json` are not exported.
- Preserve required Project ZIP contents.
- Preserve existing exclusion behavior (`.codex`, `.git`, `__pycache__`, `.env`, logs, etc.).
- Update `docs/PROJECT_ZIP_SPEC.md` to explicitly note `.tracebench_local` is local sidecar and excluded from ZIP.

## Validate/import symmetry decision
- Decision: **included** as optional but in-scope hardening.
- `tools/validate_project_zip.py` may be updated in the same pass for defense-in-depth symmetry if change remains narrow.
- If changed, tests must prove crafted ZIPs containing `.tracebench_local` are rejected or safely ignored per locked behavior.

## Exact allowed files for next implementation pass
- `tools/export_project_zip.py`
- `tests/test_project_zip.py`
- `docs/PROJECT_ZIP_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS.md`
- Optional (locked by this scope decision):
  - `tools/validate_project_zip.py`

## Exact forbidden files/surfaces for next implementation pass
- No Flutter/runtime/reference-viewer implementation.
- No `events.jsonl` or `known_facts.json` changes.
- No `schemas/**`.
- No materializer changes.
- No sample/asset changes.
- No Project ZIP inclusion of reference images.
- No Project ZIP contract expansion.
- No URL import/download.
- No Board Canvas overlay.
- No transform/matrix/photo alignment behavior.
- No AI/OCR/CV/detection/proposal behavior.
- No `board_graph.json` / `view_state.json`.
- No tag/release-object mutation.

## Required tests locked for next implementation pass
1. Export project with:
   - `.tracebench_local/reference_images/<file>`
   - `.tracebench_local/reference_images.json`
2. Assert exported ZIP has no `.tracebench_local` entries.
3. Assert required ZIP paths remain present.
4. Assert existing ZIP exclusion tests continue to pass.
5. Run:
   - `py -3 -m unittest tests.test_project_zip`
   - `py -3 tools\validate_all.py`
6. If `tools/validate_project_zip.py` changes:
   - add/adjust test for crafted ZIP containing `.tracebench_local` per locked symmetry behavior.

## Boundary confirmation
- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Reference images remain non-canonical sidecar data only.
- No Board Canvas evidence/rendering expansion.
- No Project ZIP contract expansion.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- V2 event-writing architecture remains separate from V1.1 hardening.

## Next recommended pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_ZIP_EXCLUSION_PASS`

## Forbidden-surface confirmation
- Docs-only updates in this pass.
- No code/tools/tests/schema/materializer/runtime/sample/asset/generated/tag/release-object changes.
