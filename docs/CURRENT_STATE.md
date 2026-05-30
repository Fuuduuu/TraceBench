# CURRENT_STATE.md

Project: TraceBench AI / BoardFact
Branch: main

- Current pass: `BOARD_CANVAS_ALIGNMENT_READINESS_QA_CLOSEOUT_PASS`
- Next recommended pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_LOCK_PASS`
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

### Board-canvas photo-alignment readiness panel scope lock
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

### Board-canvas photo-alignment readiness panel pass
- Added read-only project/photo-level readiness metadata panel on board canvas.
- Panel is shown when `KnownFacts.photoToBoardAlignments` is non-empty.
- Panel uses constrained scrollable layout to avoid RenderFlex overflow on smaller viewports.
- Panel displays metadata only:
  - `alignment_id`
  - `source_photo_id`
  - `board_side`
  - `coordinate_space_from`
  - `coordinate_space_to`
  - reference pair count only
  - `transform_type` as `declared type — not computed`
  - `alignment_quality_label`
  - `source_event_id`
  - `status`
- Required safety copy is present and non-actionable.
- Raw reference-point `x/y` coordinates are not displayed.
- No background photo helper, overlay rendering, transform computation, or event-writing behavior was added.

### Board-canvas photo-alignment readiness panel closeout (accepted)
- Claude Code audit verdict recorded: `PASS_WITH_NITS`.
- Accepted implementation state:
  - panel is read-only metadata-only UI,
  - panel is project/photo-level and not per-component identity,
  - panel appears when `KnownFacts.photoToBoardAlignments` is non-empty,
  - panel is absent when no alignments exist,
  - panel shows allowed metadata with reference pair count only,
  - panel labels `transform_type` as `declared type — not computed`,
  - panel shows required safety copy,
  - `renderer writes: none` remains visible,
  - overflow/layout fix accepted and RenderFlex overflow is gone.
- Confirmed deferred/forbidden surfaces remain unchanged:
  - no background photo helper,
  - no transform/matrix computation,
  - no photo-local evidence conversion,
  - no visual_trace/damage/suspect canvas geometry,
  - no event-writing/edit/confirm/save/apply UI,
  - no `board_graph.json` / `view_state.json`.
- Non-blocking nits recorded:
  - `reference pairs` label casing is inconsistent with other InspectorField labels,
  - no multi-alignment panel test yet,
  - ACTIVE_SCOPE_LOCK pointer was stale and is aligned by this closeout.

### Board-canvas photo-alignment readiness panel nits followup (accepted)
- Narrow QA/polish follow-up implemented for non-blocking audit nits.
- Readiness-panel label casing normalized from `reference pairs` to `Reference pairs`.
- Added focused multi-alignment readiness-panel widget coverage that verifies:
  - two alignments render in stable KnownFacts order,
  - both `alignment_id` and `source_photo_id` values are visible,
  - per-alignment `Reference pairs` counts are visible,
  - `declared type — not computed` wording remains visible,
  - required safety copy remains visible,
  - raw reference-point `x/y` values are not displayed,
  - forbidden action labels remain absent.
- No scope expansion: no schema/tool/materializer/Dart model/Project ZIP/runtime behavior changes.

### Board-canvas photo-alignment readiness panel nits followup closeout (accepted)
- Claude Code audit verdict recorded: `PASS`.
- `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_PASS` accepted as completed and scope-compliant.
- Accepted follow-up state recorded:
  - `Reference pairs` label casing fix accepted.
  - Multi-alignment readiness-panel widget test accepted.
  - Audit-confirmed coverage includes multiple entries rendering, both alignment/source-photo IDs, per-entry reference-pair counts, stable ordering, retained `declared type — not computed` wording, required safety copy visibility, no raw `x/y` display, and no forbidden action labels.
  - No product-scope expansion and no runtime/schema/tool/model changes.
- Non-blocking note recorded:
  - `ACTIVE_SCOPE_LOCK.md` pointer was stale and is aligned by this closeout.

### Board-canvas alignment readiness QA pass (accepted)
- Added broader board-canvas readiness QA coverage without product behavior changes.
- New combined-state widget coverage verifies readiness panel stability with:
  - board-normalized placements,
  - selected component inspector,
  - read-only measurement summary,
  - read-only visual-trace metadata summary,
  - `photoToBoardAlignments` present,
  - `renderer writes: none` visible.
- QA confirms readiness panel remains project/photo-level metadata:
  - panel remains visible/consistent while switching selected components,
  - alignment metadata does not collapse into selected-component identity semantics.
- QA confirms alignment boundaries in combined state:
  - allowed metadata and `Reference pairs` count visible,
  - `declared type — not computed` retained,
  - required safety copy retained,
  - raw reference-point `x/y` values absent,
  - forbidden overlay/transform/edit/event-writing action labels absent.
- Production code unchanged in this pass; test hardening only.

### Board-canvas alignment readiness QA closeout (current)
- Claude Code audit verdict recorded: `PASS`.
- `BOARD_CANVAS_ALIGNMENT_READINESS_QA_PASS` accepted as completed and scope-compliant.
- Accepted QA state recorded:
  - pass remained strictly test-only,
  - production board-canvas code unchanged,
  - no new UI feature or data-model behavior added,
  - no transform computation or coordinate conversion added,
  - no background photo helper/overlay/event-writing behavior added,
  - combined-state readiness widget coverage accepted,
  - readiness panel remains project/photo-level metadata across selection changes,
  - raw `x/y` values remain hidden,
  - forbidden alignment actions remain absent,
  - validation suites passed.
- Non-blocking note recorded:
  - `ACTIVE_SCOPE_LOCK.md` pointer was stale and is aligned by this closeout.

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
