# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS`
- Next recommended pass: `DOCS_DRIFT_MINI_CLEANUP_PASS`
- Docs drift countdown: `0`

## Handoff snapshot (compact)

### Latest accepted alignment-governance state
- `PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS` completed (`PASS_WITH_NITS`).
  - Accepted `PHOTO_ALIGNMENT_DART_MODEL_PASS` as completed and scope-compliant after Claude Code audit.
  - Accepted Dart model state:
    - Dart KnownFacts support for `known_facts.photo_to_board_alignments`,
    - `AlignmentPointFact`, `PhotoToBoardAlignmentFact`, `KnownFacts.photoToBoardAlignments`,
    - missing `photo_to_board_alignments` defaults to empty list,
    - exact JSON key parity and field-preserving round-trip behavior,
    - exact `reference_points_photo` and `reference_points_board` preservation,
    - `notes` present/absent behavior accepted,
    - `status=user_confirmed_alignment` preserved,
    - `coordinate_space_from=photo_local` and `coordinate_space_to=board_normalized` preserved.
  - Deferred surfaces unchanged:
    - no Flutter UI / board canvas rendering,
    - no transform computation,
    - no coordinate conversion,
    - no Project ZIP changes,
    - no event/schema/validator/materializer changes.
  - Non-blocking nits recorded:
    - previous active scope-lock pass pointer was stale and is aligned in this closeout,
    - no dedicated notes-absent-only test (currently covered via round-trip),
    - no multi-item `photo_to_board_alignments` parsing test.
- `PHOTO_ALIGNMENT_DART_MODEL_PASS` completed.
  - Added Dart KnownFacts parsing/serialization support for optional `photo_to_board_alignments`.
  - Added `PhotoToBoardAlignmentFact` and alignment point model support in Dart KnownFacts.
  - Added `KnownFacts.photoToBoardAlignments` with missing-field default to empty list.
  - Preserved JSON key parity and value preservation for:
    - `alignment_id`, `source_photo_id`, `board_side`,
    - `coordinate_space_from`, `coordinate_space_to`,
    - `reference_points_photo`, `reference_points_board`,
    - `transform_type`, `alignment_quality_label`,
    - `notes` (optional), `source_event_id`, `status`.
  - Confirmed no transform computation, coordinate conversion, inference expansion, or UI/runtime behavior changes.
- `PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS` completed.
  - Locked future Dart KnownFacts direction for `known_facts.photo_to_board_alignments` before implementation.
  - Recorded accepted baseline:
    - `photo_to_board_alignment_confirmed` schema/validator support is accepted,
    - `known_facts.photo_to_board_alignments` projection is accepted,
    - `known_facts` schema support is accepted,
    - Dart KnownFacts support remains deferred until `PHOTO_ALIGNMENT_DART_MODEL_PASS`,
    - no board-canvas rendering/alignment UI is added.
  - Locked future Dart model scope:
    - add `PhotoToBoardAlignmentFact` and `KnownFacts.photoToBoardAlignments`,
    - preserve snake_case JSON key parity for all alignment fields,
    - default missing `photo_to_board_alignments` to empty list,
    - preserve values verbatim with no transform computation or coordinate conversion.
  - Deferred/forbidden remain unchanged:
    - no Dart/Flutter UI implementation in scope-lock pass,
    - no schema/tool/materializer changes,
    - no Project ZIP contract change.
- `PHOTO_ALIGNMENT_MATERIALIZER_CLOSEOUT_PASS` completed (`PASS_WITH_NITS`).
  - Accepted `PHOTO_ALIGNMENT_MATERIALIZER_PASS` as scope-compliant after Claude Code audit.
  - Recorded non-blocking nits:
    - side-effect test does not explicitly assert `damage_regions == []` and `suspect_regions == []`,
    - no direct JSON Schema library validation test against a projected `photo_to_board_alignments` item.
  - Deferred surfaces remain unchanged:
    - no Dart KnownFacts model support yet,
    - no Flutter/UI/rendering support yet,
    - no transform matrix computation,
    - no photo-local evidence conversion,
    - no Project ZIP contract change.
- `PHOTO_ALIGNMENT_MATERIALIZER_PASS` completed.
  - Added materializer projection for accepted user `photo_to_board_alignment_confirmed` events into optional `known_facts.photo_to_board_alignments`.
  - Added known_facts schema support for `photo_to_board_alignments`.
  - Projection behavior:
    - accepted events only,
    - actor type user only,
    - latest accepted event wins per `alignment_id`,
    - projected `status=user_confirmed_alignment`,
    - `source_event_id` preserved from winning event.
  - Explicitly deferred/forbidden in this pass:
    - no transform matrix computation,
    - no photo-local geometry conversion/render overlay data,
    - no side effects into components/pins/nets/measurements/visual_traces/fault flows,
    - no Project ZIP contract changes,
    - no Dart/Flutter alignment support.
- `PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS` completed.
  - Future alignment projection ownership is locked to Python materializer + `known_facts` schema.
  - Future projection direction is locked (`photo_to_board_alignments`, accepted user events only, latest accepted per `alignment_id`).
  - Transform matrix computation and photo-local geometry conversion are explicitly deferred.
  - No side effects into components/pins/nets/measurements/visual_traces/fault paths.
  - `photo_reference_points_set` and `photo_layer_aligned` remain reserved/deferred placeholders.
- `PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS` and `PHOTO_ALIGNMENT_EVENT_SCHEMA_CLOSEOUT_PASS` are accepted.
  - `photo_to_board_alignment_confirmed` schema/validator/test/sample support exists.
  - Materializer projection, known_facts projection schema/model, Dart model, and UI alignment remain deferred.

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
