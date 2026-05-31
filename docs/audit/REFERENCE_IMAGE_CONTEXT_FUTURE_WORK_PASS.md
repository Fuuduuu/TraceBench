# REFERENCE_IMAGE_CONTEXT_FUTURE_WORK_PASS

## PASS_ID
`REFERENCE_IMAGE_CONTEXT_FUTURE_WORK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only future-work / roadmap note.

## Reason

User requested future capability to load internet/local board-layout reference images for AI proposal context, while preserving TraceBench evidence boundaries.

## Future-work summary

- Added `docs/REFERENCE_IMAGE_CONTEXT_FUTURE_WORK.md`.
- Recorded reference-image context as roadmap direction only.
- Explicitly kept reference images non-canonical.
- Explicitly kept AI outputs proposal-only until human confirmation through accepted event paths.
- No implementation started.

## V1.1 candidate recorded

- `REFERENCE_IMAGE_IMPORT_SCOPE_LOCK_PASS`
- Direction: reference-only import/viewer metadata path with local copy + provenance (`source_url`, `sha256`, filenames, `source_type`, `reference_only` status), no overlays/transforms/fact creation.

## V2 candidate recorded

- `REFERENCE_IMAGE_AI_CONTEXT_SCOPE_AUDIT_PASS`
- Direction: AI proposal generation from reference-image context (component/connector/OCR/placement candidates, top-3 alternatives, uncertainty notes), still `unconfirmed_ai_proposal` only.

## High-risk V2 candidate recorded

- `BOARD_CANVAS_REFERENCE_IMAGE_LAYER_SCOPE_AUDIT_PASS`
- Direction: optional reference layer near/on Board Canvas with explicit watermark/toggle only.
- Gate locked: GPT Pro + Claude Code required before implementation.

## V2+ research candidate recorded

- `AI_LAYOUT_PROPOSAL_BENCHMARK_SCOPE_PASS`
- Direction: benchmark top-1/top-3 proposal quality from reference-image context, with non-canonical outputs only.

## Hard boundaries locked

Reference images must not:
- create canonical facts,
- confirm identity/pins/nets/measurements/faults,
- bypass human confirmation,
- create `board_graph.json` / `view_state.json`,
- weaken Project ZIP/local-first contract,
- auto-accept AI output.

## Release-route preservation

- Current release-tag route preserved.
- Next remains: `V1_RELEASE_TAG_VERIFICATION_PASS`
- Then: `V1_TO_V2_ROADMAP_DECISION_PASS`

## Validation result

- `py -3 tools\validate_all.py` PASS.

## Forbidden-surface confirmation

- Docs-only changes.
- No code/schema/tool/test/sample/asset/runtime modifications.
- No generated artifacts.
- No git tag changes.
