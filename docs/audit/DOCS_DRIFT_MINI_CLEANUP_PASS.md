# DOCS_DRIFT_MINI_CLEANUP_PASS

## PASS_ID
`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only drift cleanup.

## Purpose
Reset docs drift after `PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS` and align compact handoff/governance files.

## What was aligned
- `docs/CURRENT_STATE.md`
  - current pass set to `DOCS_DRIFT_MINI_CLEANUP_PASS`,
  - stale next recommended route to `PHOTO_ALIGNMENT_DART_MODEL_AUDIT_PASS` removed,
  - next recommended pass set to `PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_PASS`,
  - docs drift countdown reset from `0` to standard value `5`,
  - latest accepted photo-alignment state compacted.
- `docs/PASS_QUEUE.md`
  - current/next pointers aligned to cleanup completion and forward routing,
  - confirmed `PHOTO_ALIGNMENT_DART_MODEL_AUDIT_PASS` is already completed via accepted closeout flow,
  - stale next-pass references removed from active routing path,
  - docs drift countdown reset to `5`.
- `docs/ACTIVE_SCOPE_LOCK.md`
  - current pass updated to `DOCS_DRIFT_MINI_CLEANUP_PASS`,
  - allowed surfaces updated for docs-only cleanup scope,
  - next recommended pass aligned to `PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_PASS`.
- `docs/AUDIT_INDEX.md`
  - added index row for `DOCS_DRIFT_MINI_CLEANUP_PASS`.

## Accepted alignment state reaffirmed
- `photo_to_board_alignment_confirmed` schema/validator support accepted.
- `known_facts.photo_to_board_alignments` materializer projection accepted.
- `known_facts` schema support accepted.
- Dart KnownFacts `photoToBoardAlignments` support accepted.

## Deferred surfaces reaffirmed
- Flutter/UI alignment rendering remains deferred.
- Board-canvas photo alignment UI remains deferred.
- Background photo helper remains deferred.
- Transform matrix computation remains deferred.
- Photo-local evidence conversion remains deferred.
- Project ZIP contract changes remain deferred.

## Optional stale-check surfaces
- `docs/PROJECT_MEMORY.md` and `docs/TRUTH_INDEX.md` were reviewed for this pass and left unchanged.

## Next recommended pass
`PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_PASS`
