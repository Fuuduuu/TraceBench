# PHOTO_ALIGNMENT_DART_MODEL_PASS

## PASS_ID
`PHOTO_ALIGNMENT_DART_MODEL_PASS`

## Lane
`FLUTTER_PASS`

## Mode
Implement narrow Dart KnownFacts model parity only.

## Implemented

### 1) Dart model additions
- Added `AlignmentPointFact` in `lib/shared/models/known_facts.dart`.
- Added `PhotoToBoardAlignmentFact` in `lib/shared/models/known_facts.dart`.
- Added `KnownFacts.photoToBoardAlignments`.

### 2) KnownFacts parsing support
- Added top-level parse support for optional `photo_to_board_alignments`.
- Missing `photo_to_board_alignments` defaults to an empty list.

### 3) KnownFacts serialization support
- Added `toJson` emission for `photo_to_board_alignments` when non-empty (matching existing optional projection style).
- Preserves field parity and values exactly for:
  - `alignment_id`
  - `source_photo_id`
  - `board_side`
  - `coordinate_space_from`
  - `coordinate_space_to`
  - `reference_points_photo`
  - `reference_points_board`
  - `transform_type`
  - `alignment_quality_label`
  - `notes` (optional)
  - `source_event_id`
  - `status`

### 4) Unit tests
- Updated `test/unit/known_facts_parsing_test.dart` with coverage for:
  - parsing `photo_to_board_alignments`,
  - missing field defaults to empty list,
  - round-trip `toJson` field preservation,
  - notes present behavior,
  - notes absent behavior,
  - exact preservation of `reference_points_photo` and `reference_points_board`,
  - preservation of `status=user_confirmed_alignment`,
  - preservation of `coordinate_space_from=photo_local` and `coordinate_space_to=board_normalized`,
  - no computed transform fields in output.

## Boundary confirmation
- No schema/tool/materializer changes.
- No Flutter UI or board-canvas rendering changes.
- No transform computation or coordinate conversion.
- No inference expansion into identity/pins/nets/measurements/faults/repair conclusions.
- No Project ZIP tooling changes.

## Next recommended pass
`PHOTO_ALIGNMENT_DART_MODEL_AUDIT_PASS`
