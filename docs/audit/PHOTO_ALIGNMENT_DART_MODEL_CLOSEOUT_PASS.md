# PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS

## PASS_ID
`PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only audit closeout.

## Audit verdict recorded
Claude Code audit verdict: `PASS_WITH_NITS`.

## Acceptance decision
`PHOTO_ALIGNMENT_DART_MODEL_PASS` is accepted as completed and scope-compliant.

## Accepted Dart model state
- Dart KnownFacts support for `known_facts.photo_to_board_alignments` is accepted.
- `AlignmentPointFact` is accepted.
- `PhotoToBoardAlignmentFact` is accepted.
- `KnownFacts.photoToBoardAlignments` is accepted.
- Missing `photo_to_board_alignments` defaults to an empty list.
- JSON key parity is exact.
- `fromJson`/`toJson` round-trip preserves all alignment fields.
- `reference_points_photo` and `reference_points_board` are preserved exactly.
- `notes` present/absent behavior is accepted.
- `status=user_confirmed_alignment` is preserved.
- `coordinate_space_from=photo_local` is preserved.
- `coordinate_space_to=board_normalized` is preserved.

## Deferred surfaces (unchanged)
- No Flutter UI / board canvas rendering.
- No transform computation.
- No coordinate conversion.
- No Project ZIP changes.
- No event/schema/validator/materializer changes.

## Non-blocking nits recorded
- `ACTIVE_SCOPE_LOCK.md` pass-identity pointer was stale and is aligned by this closeout.
- No dedicated notes-absent-only test; currently covered via round-trip test.
- No multi-item `photo_to_board_alignments` parsing test.
- Docs drift countdown reached `0`; docs-drift cleanup is due soon.

## Hard-boundary confirmation
- Renderer writes nothing.
- No `board_graph.json`.
- No `view_state.json`.
- No `visual_trace -> net` promotion.
- No photo-local evidence rendering.
- No AI proposal canonicalization.

## Next recommended pass
`DOCS_DRIFT_MINI_CLEANUP_PASS`
