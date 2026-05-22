
## 1. Photo-flow milestone scope

First implementation pass after this:
PHOTO_EVENT_SCHEMA_HARDENING_PASS

Scope of that future pass:
- add $defs to `schemas/events.schema.json` for:
  - `photo_added`
  - `damage_region_marked`
  - `suspect_region_marked`
  - `visual_trace_added`
- extend stdlib-only Python validator
- extend materializer:
  - `photos`
  - `damage_regions`
  - `suspect_regions`
  - `visual_traces`
- add 2 Pelle PV20 sample events:
  - `evt_000014` `photo_added`
  - `evt_000015` `damage_region_marked`

No Flutter code in that pass.
No camera.
No OCR/CV.
No AI.

## 2. Allowed event types in V1 photo-flow

| event_type | allowed in next schema pass | status | reason |
|---|---|---|---|
| photo_added | allowed | allowed | Required to store photo references and capture metadata. |
| damage_region_marked | allowed | allowed | Required to record visual damage context. |
| suspect_region_marked | allowed | allowed | Required to record visual suspect context. |
| visual_trace_added | allowed | allowed, visual evidence only | Must remain non-electrical hypothesis until measured. |
| photo_reference_points_set | deferred | deferred | Requires additional point-reference contract. |
| photo_layer_aligned | deferred | deferred | Requires image alignment contract and evidence policy. |

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
- `known_facts.json` will later include:
  - `photos`
  - `damage_regions`
  - `suspect_regions`
  - `visual_traces`
- `customer_report.md` may mention `photo_id` as text only

No Project ZIP tooling change in this docs-only pass.

## 10. Flutter/UI implications

No Flutter changes in `PHOTO_EVENT_SCHEMA_HARDENING_PASS`.

Future `FLUTTER_PHOTO_LIST_PASS` may add:
- read-only Photos tab
- photo mode label in beginner mode
- `photo_id` visible only in advanced mode
- damage region count only, no coordinate overlay
- no camera
- no file picker for photos yet
- no OCR/CV

## 11. Pelle PV20 sample expansion for future schema pass

Future `PHOTO_EVENT_SCHEMA_HARDENING_PASS` should add:

`evt_000014`:
- `event_type`: `photo_added`
- payload:
  - `photo_id`: `photo_top_backlight_001`
  - `mode`: `backlight`
  - `path`: `photos/top_backlight_001.jpg`
  - `layer`: `top`
  - `exif_stripped`: `null`
  - `notes`: `Backlight foto enne remonti`

`evt_000015`:
- `event_type`: `damage_region_marked`
- payload:
  - `region_id`: `DMG001`
  - `photo_id`: `photo_top_backlight_001`
  - `bbox`:
    - `x`: `120`
    - `y`: `85`
    - `width`: `45`
    - `height`: `30`
  - `damage_type`: `burn`
  - `severity`: `moderate`
  - `notes`: `Põletuslaik Q2 piirkonnas`

Do not add actual photo files.
Do not add `visual_trace_added` yet.
Do not add `suspect_region_marked` yet.

## 12. Tests required for PHOTO_EVENT_SCHEMA_HARDENING_PASS

Validator tests:
- `test_photo_added_valid_passes`
- `test_photo_added_ai_actor_rejected`
- `test_photo_added_invalid_path_rejected`
- `test_damage_region_requires_photo_id_cross_reference`
- `test_damage_region_unknown_photo_id_rejected`
- `test_visual_trace_requires_photo_id`
- `test_visual_trace_not_added_to_nets_in_materializer`

Materializer tests:
- `test_photos_list_in_known_facts`
- `test_damage_regions_in_known_facts`
- `test_visual_trace_evidence_type_is_visual_trace`
- `test_visual_trace_not_in_nets_list`

Schema sample tests:
- `test_valid_photo_added_sample_validates`
- `test_valid_damage_region_sample_validates`

## 13. Deferred

- `photo_reference_points_set`
- `photo_layer_aligned`
- freeform polygon regions
- `darkfield` / `cross_polarized` / `uv` / `thermal` modes
- Flutter camera capture
- EXIF stripping
- photo file import via file_picker
- visual trace overlay
- damage/suspect overlays
- real photo files in sample
