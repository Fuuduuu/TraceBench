# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `PHOTO_ALIGNMENT_MATERIALIZER_PASS`
- Next recommended pass: `PHOTO_ALIGNMENT_MATERIALIZER_AUDIT_PASS`
- Docs drift countdown: `4`

## Handoff snapshot (compact)

### Latest accepted alignment-governance state
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
