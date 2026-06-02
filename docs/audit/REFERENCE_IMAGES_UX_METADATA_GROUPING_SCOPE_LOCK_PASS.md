# REFERENCE_IMAGES_UX_METADATA_GROUPING_SCOPE_LOCK_PASS

PASS_ID: `REFERENCE_IMAGES_UX_METADATA_GROUPING_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC`
Mode: `Docs-only scope lock`

## Scope lock decision

`REFERENCE_IMAGES_UX_STATES_CLOSEOUT_PASS` is accepted/pushed and recorded as complete.

This pass locks the next implementation slice:

- `REFERENCE_IMAGES_UX_METADATA_GROUPING_IMPL_PASS`

## Locked implementation slice

- Group selected-image metadata in `ReferenceImagesScreen` into stable sections:
  1. Identity / user-supplied display
  2. File details
  3. Provenance
  4. Optional notes section (only if present)
- Improve metadata labels/copy to reflect existing fields as user-supplied or provenance metadata.
- Keep model and storage unchanged.
- Preserve current safety strings.

## Required metadata grouping content targets

- Identity / user-supplied display:
  - Reference ID
  - As imported
  - Your notes (if present)
- File details:
  - Type
  - Size
- Provenance:
  - Imported
  - Source / added via local file picker
  - Project / project binding
- Optional SHA-256 caption (when SHA-256 is rendered):  
  `File integrity / duplicate check — not an evidence seal.`

## Required implementation/test guardrails

- Allowed implementation files:
  - `lib/features/reference_images/screens/reference_images_screen.dart`
  - `test/widget/reference_images_screen_test.dart`
- Governance/doc files:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
- Test-shape rules for the next implementation:
  - avoid filesystem-heavy widget test setup
  - avoid real `Image.file` decode in widget tests
  - no real temp image file writes
  - use fake service records / deterministic resolve-null path when possible
  - if preview rendering is needed in tests, use an injected placeholder seam with production default unchanged
- Do not modify:
  - service/storage/model/schema/tool/materializer/sample/assets/runtime files
  - Project ZIP scope
  - `board_graph.json` / `view_state.json`
  - Board Canvas / AI / URL import / transform / overlay routes

## Evidence boundaries (retained)

- Human is the sensor; AI is the graph engine.
- `events.jsonl` remains canonical.
- `known_facts.json` remains a materialized projection.
- Renderer/view writes nothing.
- Reference images remain local sidecar Model-B artifacts and non-canonical:
  - outside `events.jsonl`
  - outside `known_facts.json`
  - outside materializer
  - outside Board Canvas evidence rendering
  - outside AI/OCR/CV

## Required validation notes

- Scope lock validation remains docs-only:
  - `py -3 tools\validate_all.py`
  - `git status --short --branch`
  - `git diff --name-only`

## Next recommended pass

`REFERENCE_IMAGES_UX_METADATA_GROUPING_IMPL_PASS`
