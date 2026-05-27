# KNOWN_FACTS_DART_PLACEMENT_PARITY_PASS

## Lane

`FLUTTER_PASS`

## Goal

Add Dart KnownFacts model parity for `known_facts.component_visual_placements` so future renderer work consumes `ProjectState.knownFacts` instead of raw JSON parsing.

## Files changed

- `lib/shared/models/known_facts.dart`
- `test/unit/known_facts_parsing_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`

## Implementation summary

1. Added `ComponentVisualPlacementFact` model with projection-matching fields:
   - `component_id`, `coordinate_space`, `board_side`
   - `center_x`, `center_y`, `rotation_deg`
   - `scale` or `width`+`height`
   - optional `source_photo_id`, optional `template_id`
   - `source_event_id`, `status`
2. Added `KnownFacts.componentVisualPlacements`.
3. Added parse support for top-level `component_visual_placements` with empty-list default when missing.
4. Added `toJson` parity for placement list (included when non-empty).
5. Preserved sizing mode without inferring missing `scale`/`width`/`height`.
6. Added optional component removal parity fields on `ComponentFact`:
   - `installationStatus` (`installation_status`)
   - `removedByEventId` (`removed_by_event_id`)
   because current Python projection already emits those fields.

## Boundaries confirmed

- No schema changes.
- No validator/tool/materializer changes.
- No Project ZIP contract changes.
- No renderer/UI/canvas/CustomPainter/scene-graph/spatial-index/hit-test work.
- No `events.jsonl`/`known_facts.json` artifact edits.
- No `board_graph.json` / `view_state.json` introduced.

## Validation

- `py -3 tools\validate_all.py`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `git diff --name-only`
- `git status --short --branch`
