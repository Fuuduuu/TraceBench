# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS`
- Next recommended pass: `PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_AUDIT_PASS`
- Docs drift countdown: `5`

## Handoff snapshot (compact)

### Latest accepted photo-alignment state
- `PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS` is accepted (`PASS_WITH_NITS`).
- Accepted implementation chain:
  - `photo_to_board_alignment_confirmed` schema/validator support,
  - `known_facts.photo_to_board_alignments` materializer projection support,
  - `known_facts` schema support for `photo_to_board_alignments`,
  - Dart KnownFacts support for `photoToBoardAlignments`.
- Latest implementation follow-up:
  - `PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_PASS` added test-only hardening for non-blocking materializer audit nits:
    - explicit no-side-effect assertions for `damage_regions` and `suspect_regions`,
    - direct schema-contract validation test for projected `photo_to_board_alignments` items.
  - `PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS` added test-only hardening for non-blocking Dart model audit nits:
    - dedicated `notes`-absent parsing/toJson omission coverage for `PhotoToBoardAlignmentFact`,
    - multi-item `photo_to_board_alignments` parse/round-trip ordering and point-preservation coverage.
- Accepted Dart parity behavior:
  - missing `photo_to_board_alignments` defaults to empty list,
  - JSON key parity is preserved,
  - alignment fields round-trip via `fromJson`/`toJson`,
  - `reference_points_photo` and `reference_points_board` are preserved exactly.

### Still deferred
- Flutter/UI alignment rendering.
- Board-canvas photo alignment UI.
- Background photo helper.
- Transform matrix computation.
- Photo-local evidence conversion.
- Project ZIP contract change.

### Board-canvas accepted read-only state
- `/project/board-canvas` route and shell are accepted.
- Board-normalized component placement rendering is accepted.
- Read-only inspector is accepted.
- Read-only measurement summary metadata is accepted.
- Read-only visual_trace metadata summary is accepted.
- `renderer writes: none` remains visible.
- Visual_trace/damage/suspect canvas geometry rendering remains deferred.
- Background photo helper and photo-to-board alignment UI remain deferred.

### Hard boundaries (unchanged)
- `events.jsonl` is canonical event truth.
- `known_facts.json` is Python-materialized projection.
- Renderer/view code writes nothing.
- `board_graph.json` and `view_state.json` remain forbidden artifacts.
- `visual_trace` remains visual-only (no net promotion).
- `template_id` does not imply identity/electrical truth.
- AI proposals remain unconfirmed unless human-confirmed through accepted event path.

## Canonical pointers
- Pass sequencing and queue ownership: `docs/PASS_QUEUE.md`
- Allowed/forbidden active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Audit evidence index: `docs/AUDIT_INDEX.md`
- Detailed historical evidence: `docs/audit/*.md`
