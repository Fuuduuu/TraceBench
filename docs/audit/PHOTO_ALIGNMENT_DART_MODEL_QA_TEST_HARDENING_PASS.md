# PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS

## PASS_ID
`PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS`

## Lane
`QA_PASS / FLUTTER_TEST_PASS`

## Mode
Narrow Dart model test hardening only. No production behavior changes.

## Scope-compliant changes

### 1) Dedicated notes-absent behavior coverage
- Updated `test/unit/known_facts_parsing_test.dart`.
- Added dedicated test:
  - `photo_to_board_alignments notes absent parses null and omits notes on toJson`
- Assertions:
  - parsing alignment item without `notes` yields `PhotoToBoardAlignmentFact.notes == null`,
  - `KnownFacts.toJson()` output omits the `notes` key when absent.

### 2) Multi-item parse/round-trip coverage
- Added test:
  - `photo_to_board_alignments multi-item parse and round-trip preserves ordering and point lists`
- Assertions:
  - at least two alignment items parse,
  - both `alignment_id` values are preserved,
  - `reference_points_photo` and `reference_points_board` are preserved per item,
  - `toJson` preserves both items and their order.

## Non-goals preserved
- No changes to `lib/shared/models/known_facts.dart`.
- No transform computation, coordinate conversion, UI/rendering logic, or runtime behavior changes.
- No schema/tool/materializer/Project ZIP changes.

## Validation
- `py -3 tools\validate_all.py` -> PASS
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded` -> PASS

## Next recommended pass
`PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_AUDIT_PASS`
