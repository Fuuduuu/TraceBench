# PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS

## PASS_ID
`PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock.

## Scope-lock decision
Lock the future Dart KnownFacts direction for `known_facts.photo_to_board_alignments` before implementation.

## Accepted baseline recorded
- `photo_to_board_alignment_confirmed` schema/validator support is accepted.
- `known_facts.photo_to_board_alignments` materializer projection is accepted.
- `known_facts` schema support for projected alignments is accepted.
- Dart KnownFacts support is still deferred.
- No board-canvas rendering/alignment UI exists.

## Future implementation pass
`PHOTO_ALIGNMENT_DART_MODEL_PASS`

## Future implementation allowlist
- `lib/shared/models/known_facts.dart`
- `test/unit/known_facts_parsing_test.dart` (or existing equivalent KnownFacts parsing test file)
- docs ledger/audit files

## Locked Dart model direction

### New model objects
- Add `PhotoToBoardAlignmentFact`.
- Add `KnownFacts.photoToBoardAlignments`.

### Locked fields
- `alignmentId`
- `sourcePhotoId`
- `boardSide`
- `coordinateSpaceFrom`
- `coordinateSpaceTo`
- `referencePointsPhoto`
- `referencePointsBoard`
- `transformType`
- `alignmentQualityLabel`
- `notes` (optional)
- `sourceEventId`
- `status`

### Point model direction
- Use a simple typed point value object only if it matches existing KnownFacts style.
- Otherwise use a narrowly-scoped alignment point model for this feature.
- Preserve `x`/`y` values exactly.
- Do not compute transforms.

## Locked JSON key parity
Dart parsing/serialization must support:
- `photo_to_board_alignments`
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from`
- `coordinate_space_to`
- `reference_points_photo`
- `reference_points_board`
- `transform_type`
- `alignment_quality_label`
- `notes`
- `source_event_id`
- `status`

## Locked missing-field behavior
- Missing `photo_to_board_alignments` must default to an empty list.
- Existing KnownFacts parsing behavior must remain intact for older projects.
- `toJson` emission should follow existing optional-projection style, preferably emitting `photo_to_board_alignments` only when non-empty if consistent with current KnownFacts conventions.

## Locked boundary rules
Future Dart model pass must not:
- compute transform matrices,
- compute homographies,
- convert photo-local coordinates to board coordinates,
- render or prepare overlay geometry,
- infer component identity/pin mapping/nets/measurements/faults,
- create event-writing paths,
- mutate ProjectState canonical facts.

## Future tests required
- parses `photo_to_board_alignments`
- missing `photo_to_board_alignments` defaults to empty list
- round-trip `toJson` preserves all fields
- notes present/absent behavior
- `reference_points_photo` preserved exactly
- `reference_points_board` preserved exactly
- `status=user_confirmed_alignment` preserved
- `coordinate_space_from=photo_local` preserved
- `coordinate_space_to=board_normalized` preserved
- no transform matrix field exists
- no `board_graph.json` / `view_state.json` behavior
- existing KnownFacts tests still pass

## Next recommended pass
`PHOTO_ALIGNMENT_DART_MODEL_PASS`
