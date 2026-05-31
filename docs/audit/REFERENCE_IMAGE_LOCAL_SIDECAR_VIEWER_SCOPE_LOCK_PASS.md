# REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_SCOPE_LOCK_PASS

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_SCOPE_LOCK_PASS`

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
  - `VALIDATE_ALL_FIXTURE_COVERAGE_PASS` (`1563dab`)
  - `VALIDATE_ALL_FIXTURE_COVERAGE_CLOSEOUT_PASS` (`55d42e7`)
- `REFERENCE_IMAGE_IMPORT_PRE_SCOPE_AUDIT_PASS` confirmation:
  - accepted from user-provided audit context,
  - audit-only, no repo modifications.

## Architecture decision recorded
- GPT Pro architecture decision accepted: **Model B**.
- V1.1 reference images are:
  - project-associated local sidecar data,
  - local copied image files,
  - non-canonical metadata ledger.
- Explicitly outside:
  - `events.jsonl`,
  - `known_facts.json`,
  - materializer/projection logic,
  - Board Canvas evidence rendering,
  - Project ZIP (first implementation pass).

## Rejected/deferred for first pass
- Model C (Project ZIP inclusion) rejected for first pass.
- Model D (canonical events) rejected for V1.1.
- URL download/import rejected/deferred.
- Board Canvas overlay, transform/matrix/photo-alignment behavior rejected/deferred.
- AI/OCR/CV/detection/proposal UI rejected/deferred.

## Locked next implementation pass
- PASS_ID: `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`
- Lane: narrow `FLUTTER_PASS` (V1.1 implementation).

## Locked implementation allowlist direction (next pass)
- Primary runtime surfaces:
  - `lib/features/reference_images/**` (new feature module)
  - `lib/app/router.dart` (route wiring only if required)
  - `lib/features/project/screens/project_overview_screen.dart` (entry action only if required)
- Optional feature-local tests:
  - `test/widget/reference_images*_test.dart`
  - existing navigation/widget tests only if required by this feature wiring.
- Docs ledger/audit updates for that implementation pass.

## Locked storage and metadata boundary
- Reference images are local sidecar only (non-canonical).
- Conceptual storage shape locked for implementation planning:
  - `.tracebench_local/reference_images/`
  - `.tracebench_local/reference_images.json`
- Metadata direction (non-canonical):
  - `reference_image_id`
  - `original_filename_display`
  - `stored_relative_path`
  - `mime_type` (or detected type)
  - `file_size_bytes`
  - `sha256`
  - `imported_at`
  - `source = local_file_picker`
  - `project_id` or project-root binding
  - `notes` (optional user text only)

## Forbidden metadata direction
- Must not include evidence/AI/fault/geometry linkage fields:
  - `component_id`, `net_id`, `measurement_id`, `fault_type`,
  - `confidence`, `ai_label`, `detected_part`,
  - `alignment_id`, `board_side`, `coordinate_space`,
  - `bbox`, `trace_id`.

## Locked forbidden surfaces (next implementation pass)
- No writes to `events.jsonl` and no reference-image event schema work.
- No writes to `known_facts.json` and no materializer integration.
- No `schemas/**` changes.
- No Project ZIP tooling/contract changes.
- No Board Canvas overlay/reference-image layer.
- No background photo helper.
- No transform/matrix/homography/affine computation.
- No photo-local evidence board rendering.
- No visual_trace/damage/suspect or measurement geometry overlays.
- No AI/OCR/CV/detection/proposal UI.
- No URL download/import.
- No `board_graph.json` / `view_state.json`.

## Locked stop conditions (next implementation pass)
Stop and report instead of implementing if:
- Project ZIP tooling change is required.
- Sidecar path would be included by current ZIP exporter.
- Any `events.jsonl`/`known_facts.json`/schema/materializer changes are required.
- URL import/download is required.
- Board Canvas overlay/reference layer is required.
- Transform/matrix/photo alignment computation is required.
- AI/OCR/CV/detection/proposal behavior is requested.
- Sample/asset edits are required without explicit separate scope.

## UI wording guard (next implementation pass)
- Forbid evidence-implying terms:
  - `confirmed`, `detected`, `measured`, `fault`, `suspect`, `probability`, `net`, `trace proof`, `AI found`.
- Prefer:
  - `reference only`, `local sidecar`, `not evidence`, `not included in Project ZIP`, `not used by AI`, `renderer writes: none`.

## Governance routing lock
- Optional later UX review: Claude Design can review panel/viewer wording/layout after scoped implementation.
- Required post-implementation review: `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_POST_AUDIT_PASS` (Claude Code).

## Evidence boundary confirmation
- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view remains no-write unless separately scoped.
- Reference images remain non-canonical sidecar context only.
- V2 event-writing architecture remains separate and later.

## Next recommended pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS`

## Forbidden-surface confirmation
- This pass is docs-only.
- No code/tools/tests/schemas/materializer/runtime/sample/asset/generated/tag/release-object changes.
