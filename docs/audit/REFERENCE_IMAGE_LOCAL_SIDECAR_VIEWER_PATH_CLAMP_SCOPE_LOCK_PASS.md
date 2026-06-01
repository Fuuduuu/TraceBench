# REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_SCOPE_LOCK_PASS

## PASS_ID
`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock.

## Verdict
Completed.

## Scope-lock purpose
Lock a narrow defense-in-depth follow-up for the accepted V1.1 Model-B local sidecar reference-image viewer.

## Accepted finding recorded
- Source: Claude post-audit for `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PASS` (`PASS`, `ACCEPT_AS_IS`).
- Finding level: LOW, non-blocking.
- Finding: preview read path resolution trusts `stored_relative_path` from local ledger data and does not yet revalidate/clamp that resolved path remains under `.tracebench_local/reference_images/`.
- Risk profile: relevant only for hand-edited local ledger data; normal import-generated records are safe.

## Locked next pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS`
- Lane: small V1.1 implementation hardening.

## Locked implementation goal (next pass)
- Harden `resolveStoredImageFile` (or equivalent preview resolver) so resolved paths cannot escape `.tracebench_local/reference_images/`.
- Reject/return null for:
  - absolute paths,
  - `..` traversal/escape patterns,
  - resolved paths outside sidecar image directory.
- Preserve valid generated sidecar relative paths.

## Locked allowed surfaces for next implementation pass
- `lib/features/reference_images/services/reference_image_sidecar_service.dart`
- `test/widget/reference_images_screen_test.dart` (or existing focused equivalent if required)
- docs/governance files:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS.md`

## Required tests locked for next pass
- Focused test proving path traversal/escape is rejected or unresolved:
  - absolute ledger path rejected,
  - `..` traversal path rejected,
  - path resolving outside `.tracebench_local/reference_images/` rejected.
- Positive control proving valid generated sidecar path still resolves.

## Explicit out-of-scope lock
- No URL import.
- No AI/OCR/CV.
- No Board Canvas overlay/reference layer.
- No transform/matrix/photo-alignment computation.
- No `events.jsonl` writes.
- No `known_facts.json` writes.
- No schema/materializer/tooling changes.
- No Project ZIP tooling/contract changes.
- No sample/asset/generated-artifact/tag/release-object changes.
- No `board_graph.json` / `view_state.json`.
- No SHA-256 or ID-generation refactor in this path-clamp pass.

## Boundary confirmation
- Model B remains unchanged:
  - local sidecar only,
  - non-canonical,
  - outside ZIP/events/known_facts/materializer/Board Canvas evidence rendering/AI.

## Next recommended pass
- `REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS`
