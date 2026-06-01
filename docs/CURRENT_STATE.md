# CURRENT_STATE.md

Project: TraceBench AI / BoardFact  
Branch: `main`

- Current pass: `TRACEBENCH_GOVERNANCE_DIAGRAMS_CLOSEOUT_PASS`
- Next recommended pass: `DOCS_DRIFT_MINI_CLEANUP_PASS`
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
- Accepted copy/safety pass is `REFERENCE_IMAGES_UX_POLISH_COPY_SAFETY_IMPL_PASS`:
  - required safety strings are now visible in empty state,
  - import label is `Import from this computer`,
  - SHA-256 caption in selected metadata is `File integrity / duplicate check — not an evidence seal.`,
  - service behavior is unchanged in this slice.
- `PROJECT_EXPORTER_TEST_FAILURE_TRIAGE_PASS` confirmed as an unrelated, order-dependent test isolation issue:
  - failing case is in `test/unit/project_exporter_test.dart` only,
  - deterministic when running the full `project_exporter_test.dart` file,
  - by-name test run succeeds,
  - no reference-image scope coupling,
  - production command discovery remains a likely candidate-safe area requiring a test-only isolation fix.
- `PROJECT_EXPORTER_TEST_FIX_PASS` applied a test-only normalization of fallback-version assertions in
  `test/unit/project_exporter_test.dart`:
  - normalizes executable checks (`py`/`python3`/`python`) via basename,
  - keeps the fallback behavior assertion deterministic across full-file execution,
  - does not touch production `ProjectExporter` code.
- `PROJECT_EXPORTER_TEST_FIX_PASS` is accepted (`PASS`) after Claude Code post-audit:
  - `PROJECT_EXPORTER_TEST_FIX_POST_AUDIT_PASS` concluded ACCEPT_AS_IS,
  - full-file `project_exporter_test.dart`: 12/12 passing,
  - full Flutter suite: 186 tests passed,
  - `py -3 tools\validate_all.py`: PASS,
  - order-dependent isolate bug in this test is resolved,
  - only a harmless redundant assertion remained as NIT.
- `TRACEBENCH_GOVERNANCE_DIAGRAMS_PASS` is accepted:
  - `docs/PASS_LIFECYCLE.md` tracks pass-chain states.
  - `docs/ARCHITECTURE_BOUNDARIES.md` tracks evidence-boundary flow.
  - `docs/MODEL_ROUTING.md` includes compact tool/model routing Mermaid updates.
- `TRACEBENCH_GOVERNANCE_DIAGRAMS_POST_AUDIT_PASS` is the preceding pass gate result.
- `TRACEBENCH_GOVERNANCE_DIAGRAMS_CLOSEOUT_PASS` records final PASS acceptance and moves sequencing forward to docs drift cleanup.

- Current card-sync previously recorded the final Claude Design scope-lock card for implementation:
  - six fixed zones,
  - required copy and microcopy contract,
  - required metadata groups and required states (including narrow-window behavior),
  - accessibility targets and explicit forbidden wording,
  - strict `Reference Images` and `Board Canvas` track separation.
- `BOARD_CANVAS_READONLY_VISUAL_POLISH_SCOPE_LOCK_PASS` remains separate and deferred.

## Non-blocking NITs

- `docs/MODEL_ROUTING.md` is a routing/state graph, not a full approval-flow graph.
- `docs/ARCHITECTURE_BOUNDARIES.md` does not call out “no URL import” as a separate node; this is covered in governance notes and existing boundary text.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- `events.jsonl` is canonical event truth.
- `known_facts.json` is the materialized projection.
- Renderer/view writes nothing.
- `photo` content is non-factual unless separately confirmed through accepted event paths.
- `visual_trace` is visual-only and never an electrical net.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Local reference images remain Model B: non-canonical sidecar only, outside ZIP/events/known_facts/materializer/Board Canvas evidence surfaces.
