# CURRENT_STATE.md

Project: TraceBench AI / BoardFact  
Branch: `main`

- Current pass: `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS`
- Next recommended pass: `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_POST_AUDIT_PASS`
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
  - `py -3 tools\validate_all.py` includes `board_canvas_positive_smoke` in baseline fixture checks.
- Current pass is narrow Project ZIP tooling implementation:
  - remove duplicate archive entries for `device_profiles/default.json` during export.
  - keep required ZIP contents, exclusions, and forbidden artifact checks unchanged.

- V1.1 post-smoke review action:
  - manual side-effect note identified a LOW export hygiene issue:
    duplicate `device_profiles/default.json` in exported ZIP.
  - confirmed root cause was duplicate arc collection:
    project walk + explicit `device_profiles/` collection.
  - routed to `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS`
    then `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS` for narrow implementation.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- `events.jsonl` is canonical event truth.
- `known_facts.json` is the materialized projection.
- Renderer/view writes nothing.
- `photo` content is non-factual unless separately confirmed through accepted event paths.
- `visual_trace` is visual-only and never an electrical net.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- This active pass is tooling-only and does not touch runtime/schema/materializer/samples/assets.

