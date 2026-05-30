# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS`
- Next recommended pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS`
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

### Board-canvas photo-alignment readiness scope lock
- Ready:
  - schema/validator support for `photo_to_board_alignment_confirmed`,
  - materializer projection to `known_facts.photo_to_board_alignments`,
  - `known_facts` schema support,
  - Dart KnownFacts support for `photoToBoardAlignments`,
  - existing read-only board-canvas shell + inspector + read-only measurement/visual-trace metadata summaries.
- Not ready:
  - board-canvas photo-alignment UI,
  - background photo helper,
  - transform computation,
  - photo-local evidence conversion,
  - visual_trace/damage/suspect canvas geometry rendering,
  - any Project ZIP contract change.
- Locked boundaries remain:
  - alignment data is reference-point data only,
  - renderer must not compute canonical truth,
  - no hidden-truth helper state,
  - no `board_graph.json` / `view_state.json`,
  - renderer writes nothing.

### Board-canvas photo-alignment readiness panel scope lock (current)
- Panel type locked:
  - read-only readiness/status metadata panel only,
  - no canvas geometry, overlays, photo rendering, or event writing.
- Panel placement locked:
  - project/photo-level board-canvas panel,
  - may appear when `KnownFacts.photoToBoardAlignments` is non-empty,
  - must not imply alignment is a selected-component property.
- Allowed displayed fields only:
  - `alignment_id`
  - `source_photo_id`
  - `board_side`
  - `coordinate_space_from`
  - `coordinate_space_to`
  - reference-point count only
  - `transform_type` (labeled `declared type — not computed`)
  - `alignment_quality_label`
  - `source_event_id`
  - `status`
- Required safety copy locked:
  - `Photo alignment readiness — metadata only`
  - `Stores alignment reference points only.`
  - `Does not confirm identity, nets, measurements, or faults.`
  - `No photo-local evidence is rendered on board canvas.`
  - `No transform is computed.`
  - `renderer writes: none`
  - `Not electrical proof.`
- Explicitly forbidden:
  - raw reference-point x/y display,
  - transformed coordinates or any transform matrix/math output,
  - mapped visual_trace/damage/suspect regions,
  - background photo/image overlay rendering,
  - edit/confirm/save/apply/event-writing controls.

### Board-canvas photo-alignment UI audit closeout
- GPT Pro verdict recorded: `PREFER_METADATA_ONLY_NEXT`.
- Claude Code verdict recorded: `PASS`.
- Accepted UI decision: `READINESS_PANEL_ONLY`.
- Accepted V1-safe direction:
  - show photo-alignment readiness/status metadata only,
  - keep no background photo helper,
  - no transform/matrix computation,
  - no photo-local evidence conversion,
  - no visual_trace/damage/suspect canvas geometry rendering,
  - no event-writing UI,
  - no Project ZIP contract change,
  - no `board_graph.json` / `view_state.json`.
- Scope lock outcome:
  - `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS` completed.
  - Next implementation direction: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS`.

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
