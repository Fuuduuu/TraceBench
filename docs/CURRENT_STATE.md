# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS`
- Next recommended pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS`
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
  - `PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_CLOSEOUT_PASS` accepted Claude Code audit verdict `PASS` for the materializer QA hardening pass and confirmed no production behavior changes.
  - `PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS` added test-only hardening for non-blocking Dart model audit nits:
    - dedicated `notes`-absent parsing/toJson omission coverage for `PhotoToBoardAlignmentFact`,
    - multi-item `photo_to_board_alignments` parse/round-trip ordering and point-preservation coverage.
  - `PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_CLOSEOUT_PASS` accepted Claude Code audit verdict `PASS` for the Dart QA hardening pass and confirmed scope compliance.
- Accepted Dart parity behavior:
  - missing `photo_to_board_alignments` defaults to empty list,
  - JSON key parity is preserved,
  - alignment fields round-trip via `fromJson`/`toJson`,
  - `reference_points_photo` and `reference_points_board` are preserved exactly.
  - dedicated `notes`-absent test and multi-item alignment parse/round-trip coverage are accepted with no production behavior changes.
- Accepted materializer QA hardening behavior:
  - explicit `damage_regions == []` and `suspect_regions == []` no-side-effect assertions are in place,
  - projected `photo_to_board_alignments` item contract validation against `known_facts` schema is in place,
  - no remaining materializer QA test gaps were identified by the closeout audit.
- `PHOTO_FLOW_SPEC_FIXUP_PASS` updates `PHOTO_FLOW_SPEC.md` to the accepted implemented state for photo alignment schema/validator/materializer/known_facts/Dart model/QA chain and removes stale pre-implementation wording.
- `PHOTO_FLOW_SPEC_FIXUP_CLOSEOUT_PASS` records Claude Code audit verdict `PASS_WITH_NITS`, accepts the spec fixup as scope-compliant, and preserves deferred board-canvas alignment/rendering surfaces.

### PHOTO_FLOW_SPEC nits followup (resolved)
- Placeholder event explicitness is now explicit (no payload schema/validator business logic/materializer projection/Dart model for `photo_reference_points_set` and `photo_layer_aligned`).
- Canonical-owner pointers now include `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md` for board-canvas read-only UI boundaries.
- Section numbering gap was removed.
- Durable wording now states: “No Project ZIP tooling changes are in scope unless separately authorized.”

### Non-blocking note
- One unrelated intermittent Flutter widget flake was observed in `measurement_write_screen_test.dart`; it is unrelated to photo-alignment/KnownFacts QA hardening and requires no fix in this closeout.

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
