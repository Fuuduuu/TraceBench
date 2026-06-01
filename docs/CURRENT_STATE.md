# CURRENT_STATE.md

Project: TraceBench AI / BoardFact  
Branch: `main`

- Current pass: `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS`
- Next recommended pass: `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`
- Docs drift countdown: `5`

## Handoff snapshot (bounded)

- V1 is fixed and verified:
  - `v1.0.0-rc1` exists locally and on `origin`.
  - `V1_RELEASE_TAG_VERIFICATION_CLOSEOUT_PASS`, `V1_TO_V2_ROADMAP_DECISION_PASS`, and `SOURCE_GUIDE_SYNC_AFTER_V1_RC_PASS` are accepted.
- Roadmap remains:
  - `TAG_V1_RC_FIRST`
  - then `V1_1_HARDENING`
  - then `V2_EVENT_WRITING_ARCHITECTURE`.
- V2 remains event-writing-first and does not start with photo overlay/transform/background-photo-helper.
- Accepted baseline for this phase:
  - Board Canvas V1 remains read-only and evidence-safe.
  - `photo_to_board_alignment_confirmed` chain accepted end-to-end:
    - schema + validator
    - `known_facts.photo_to_board_alignments` materializer projection
    - known_facts schema support
    - Dart `photoToBoardAlignments` parity.
  - Positive fixture `board_canvas_positive_smoke` is accepted and evidence-safe.
  - Local sidecar reference-image flow is accepted under Model B:
    - local `.tracebench_local/reference_images/` storage,
    - `.tracebench_local/reference_images.json` ledger,
    - read-only viewer safety copy,
    - no event/log/materializer/surface expansion,
    - `resolveStoredImageFile` clamps path escape/traversal.
  - `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS` is completed; duplicate `device_profiles/default.json` ZIP entries are resolved.
- Claude Design review for Reference Images UX polish direction is accepted as GO for safe `REFERENCE_IMAGES_UX` polishing scope.
- `REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_ADDENDUM_PASS` is accepted as final UX deepening input.
- `REFERENCE_IMAGES_UX_POLISH_SCOPE_LOCK_CARD_SYNC_PASS` is accepted as final implementation input sync.
- `REFERENCE_IMAGES_UX_POLISH_RECOVERY_AUDIT_PASS` is accepted with `PASS`; broad implementation was reverted and a constrained recovery slice was selected.
- Current copy/safety scope lock is `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_SCOPE_LOCK_PASS`; implementation next is:
  - `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`

- Current card-sync previously recorded the final Claude Design scope-lock card for implementation:
  - six fixed zones,
  - required copy and microcopy contract,
  - required metadata groups and required states (including narrow-window behavior),
  - accessibility targets and explicit forbidden wording,
  - strict `Reference Images` and `Board Canvas` track separation.
- `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS` remains separate and deferred.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- `events.jsonl` is canonical event truth.
- `known_facts.json` is the materialized projection.
- Renderer/view writes nothing.
- `photo` content is non-factual unless separately confirmed through accepted event paths.
- `visual_trace` is visual-only and never an electrical net.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Local reference images remain Model B: non-canonical sidecar only, outside ZIP/events/known_facts/materializer/Board Canvas evidence surfaces.
