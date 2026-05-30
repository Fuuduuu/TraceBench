# PHOTO_FLOW_SPEC.md

## 1. Current accepted state

Photo-flow alignment support is partially implemented and accepted at schema/validator/projection/model level.

Accepted implementation chain:
- `photo_to_board_alignment_confirmed` schema + validator support is implemented and accepted.
- `known_facts.photo_to_board_alignments` materializer projection is implemented and accepted.
- `known_facts` schema support for `photo_to_board_alignments` is implemented and accepted.
- Dart KnownFacts support for `photoToBoardAlignments` is implemented and accepted.
- QA hardening for materializer and Dart model coverage is implemented and accepted.

This is canonical event/projection/model support only.
Board-canvas alignment UI/rendering remains deferred.

## 2. Event family status

| event_type | status | role |
|---|---|---|
| photo_added | implemented/accepted | Canonical photo reference event for photo evidence metadata. |
| damage_region_marked | implemented/accepted | Canonical visual damage-region metadata event (visual evidence only). |
| suspect_region_marked | implemented/accepted | Canonical visual suspect-region metadata event (visual evidence only). |
| visual_trace_added | implemented/accepted | Canonical visual trace metadata event (visual evidence only; not an electrical net). |
| photo_to_board_alignment_confirmed | implemented/accepted | Canonical user-confirmed photo-local -> board-normalized alignment event. |
| photo_reference_points_set | reserved/deferred placeholder | Placeholder only; unsafe for writer usage until separately formalized end-to-end. |
| photo_layer_aligned | reserved/deferred placeholder | Placeholder only; unsafe for writer usage until separately formalized end-to-end. |

### 2.1 Placeholder readiness status (explicit)

- `photo_reference_points_set` currently has:
  - no payload schema,
  - no validator business logic,
  - no materializer projection,
  - no Dart model.
- `photo_layer_aligned` currently has:
  - no payload schema,
  - no validator business logic,
  - no materializer projection,
  - no Dart model.
- Both remain reserved/deferred and are not writer-ready.

## 3. photo_added payload spec

Required:
- `photo_id`
- `mode`
- `path`

Payload rules:
- `photo_id` pattern: `^photo_[a-z0-9_]+$`
- `mode` enum V1:
  - `normal`
  - `backlight`
  - `macro`
  - `side_light`
- `path` must start with `photos/`
- path extensions allowed:
  - `jpg`
  - `jpeg`
  - `png`
  - `webp`

Optional:
- `notes`
- `sha256`
- `source_device`
- `exif_stripped`
- `layer`

Constraints:
- `photo_id` unique across project
- `actor.type=ai` forbidden
- `photo_added` may not create components
- `photo_added` may not create nets
- `photo_added` may not confirm identity
- missing referenced photo file is **WARNING** in V1, not ERROR
- `photos/` remains optional in Project ZIP

Materializer:
- `known_facts.photos` list.

## 4. damage_region_marked payload spec

Required:
- `region_id`
- `photo_id`
- `bbox`
  - `x`
  - `y`
  - `width`
  - `height`
- `damage_type`

`damage_type` enum:
- `burn`
- `corrosion`
- `physical_break`
- `solder_bridge`
- `missing_component`
- `lifted_pad`
- `unknown`

Optional:
- `notes`
- `severity`
  - `minor`
  - `moderate`
  - `severe`
- `affects_components`

Constraints:
- `photo_id` must reference existing `photo_added.photo_id`
- `actor.type=ai` forbidden
- `damage_region_marked` does not create component facts
- `damage_region_marked` does not affect fault candidates in V1
- `affects_components` is visual annotation only
- no freeform polygons in V1

Materializer:
- `known_facts.damage_regions` list.

## 5. suspect_region_marked payload spec

Required:
- `region_id`
- `photo_id`
- `bbox`
- `reason`

Optional:
- `notes`
- `affects_components`
- `priority`
  - `low`
  - `medium`
  - `high`

Constraints:
- `photo_id` must reference existing `photo_added.photo_id`
- `actor.type=ai` forbidden
- `suspect_region_marked` does not create components
- `suspect_region_marked` does not affect fault probability in V1
- `suspect_region_marked` is visual/context-only.

Materializer:
- `known_facts.suspect_regions` list.

## 6. visual_trace_added payload spec

Required:
- `trace_id`
- `photo_id`
- `from_point`
  - `x`
  - `y`
- `to_point`
  - `x`
  - `y`

Optional:
- `from_component`
- `to_component`
- `from_pin`
- `to_pin`
- `confidence`
  - `low`
  - `medium`
  - `high`
- `layer`
  - `top`
  - `bottom`
  - `inner_unknown`
- `notes`

Hard constraints:
- `evidence_type` is locked to `visual_trace`
- `actor.type=ai` forbidden.
- `visual_trace_added` never creates `net_connection_confirmed`.
- `visual_trace_added` never confirms electrical connection.
- `from_pin` / `to_pin` are visual estimates only.
- visual trace can only become electrical fact through separate human measurement:
  `visual_trace_added` -> `measurement_recorded` by `user` -> `net_connection_confirmed` with measured basis

Materializer:
- `known_facts.visual_traces` list.
- Do not add visual traces to `known_facts.nets`.

## 6.1 photo_to_board_alignment_confirmed payload direction (implemented)

Required payload fields:
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from`
- `coordinate_space_to`
- `reference_points_photo`
- `reference_points_board`
- `transform_type`
- `alignment_quality_label`

Optional:
- `notes`

Canonical constraints:
- `alignment_id` pattern: `^ALN[0-9]+$`
- `coordinate_space_from == photo_local`
- `coordinate_space_to == board_normalized`
- `transform_type` enum: `similarity | affine`
- `actor.type == user` required for accepted canonical alignment event
- `source_photo_id` must reference prior accepted `photo_added`
- `graph_layout` is rejected for canonical alignment coordinate-space roles
- forbidden identity/net/measurement/fault confirmation fields are rejected

## 7. Evidence boundary rules

- `photo_added`/`damage_region_marked`/`suspect_region_marked`/`visual_trace_added` are **visual context** only.
- only `measurement_recorded` and accepted evidence can move electrical graph state.

Rules:
- `photo_added` may not create `component_created`.
- `photo_added` may not create `net_connection_confirmed`.
- `damage_region_marked` may not affect fault candidates in V1.
- `suspect_region_marked` may not affect fault probability in V1.
- `visual_trace_added` may not auto-promote to `net_connection_confirmed`.
- no hidden-layer inference from photo evidence.
- `photo_to_board_alignment_confirmed` is geometric alignment evidence only:
  - not component identity confirmation,
  - not pin mapping confirmation,
  - not net confirmation,
  - not measurement confirmation,
  - not fault proof.
- AI transform proposals are not canonical truth.
- Renderer/view code writes nothing.

## 8. Capture modes

V1 allowed as metadata:
- `normal`
- `backlight`
- `macro`
- `side_light`

Deferred:
- `darkfield`
- `cross_polarized`
- `uv`
- `thermal`

Backlight note:
- useful for visual topology on simple PCBs
- metadata only
- not electrical proof
- requires manual continuity measurement before net confirmation

## 9. Project ZIP photo implications

Rules:
- `photos/` optional
- photo files optional in V1
- missing photo file referenced by event = warning, not error
- `sha256` optional
- EXIF not processed in V1
- `exif_stripped` records user/tool intent
- `known_facts.json` includes projection families for:
  - `photos`
  - `damage_regions`
  - `suspect_regions`
  - `visual_traces`
  - `photo_to_board_alignments`
- `customer_report.md` may mention `photo_id` as text only

No Project ZIP tooling changes are in scope unless separately authorized.
No `board_graph.json` or `view_state.json` artifacts.

## 10. Flutter/UI implications

- Board-canvas photo-alignment readiness metadata panel is implemented and accepted.
- Current accepted UI support remains metadata-only.
- Full photo-alignment UI workflow remains deferred.
- No background photo helper is implemented.
- No transform matrix/homography computation is implemented.
- No photo-local evidence geometry is rendered on board canvas.
- No visual_trace/damage/suspect canvas geometry rendering is implemented.
- No Project ZIP contract changes are implemented for alignment UI surfaces.

## 11. Test and audit evidence pointers

Authoritative implementation and coverage evidence:
- `tests/test_validate_events_jsonl.py`
- `tests/test_materialize_known_facts.py`
- `test/unit/known_facts_parsing_test.dart`
- `docs/audit/PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_EVENT_SCHEMA_CLOSEOUT_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_CLOSEOUT_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_DART_MODEL_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_CLOSEOUT_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS.md`
- `docs/audit/PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_CLOSEOUT_PASS.md`

## 12. Deferred

- `photo_reference_points_set` placeholder formalization
- `photo_layer_aligned` placeholder formalization
- freeform polygon regions
- `darkfield` / `cross_polarized` / `uv` / `thermal` modes
- Flutter camera capture
- EXIF stripping pipeline behavior
- photo file import via file picker
- board-canvas photo alignment UI
- background photo helper
- transform matrix computation/homography output
- photo-local evidence conversion onto board canvas
- visual_trace canvas geometry rendering
- damage/suspect canvas geometry rendering
- Project ZIP contract changes

## 13. Canonical owners (implemented state)

- Event schema + payload contract:
  - `schemas/events.schema.json`
- Event semantic validation:
  - `tools/validate_events_jsonl.py`
- Materialized projection:
  - `tools/materialize_known_facts.py`
- known_facts schema contract:
  - `schemas/known_facts.schema.json`
- Dart KnownFacts projection model:
  - `lib/shared/models/known_facts.dart`
- Board-canvas read-only UI boundary owner:
  - `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- Audit and acceptance evidence:
  - `docs/audit/*.md`

## 14. Dart model safety warning

Dart alignment model support stores alignment reference-point data only.

It does not compute:
- transform matrices,
- similarity/affine solutions,
- homographies,
- board-canvas overlay geometry.

It does not convert photo-local evidence into board-canvas rendered evidence.
