# VECTOR_FOOTPRINT_LIBRARY_SPEC.md

PASS_ID: `VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS`  
Lane: `DOCS_SYNC`  
Mode: spec-only (no runtime/schema/tooling implementation)

## 1. Purpose

Define the formal internal parametric vector footprint/template library contract for TraceBench before renderer/UI implementation.

This specification defines physical package geometry templates only.

## 2. Hard boundaries

- `template_id` does not imply component identity.
- `template_id` does not imply electrical function.
- `template_id` does not imply pin mapping confirmation.
- `template_id` does not imply measured net.
- `template_id` does not imply fault evidence.
- AI suggestions remain `unconfirmed_ai_proposal` until explicit human confirmation through accepted event paths.
- Renderer implementation is deferred.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Project ZIP contract remains unchanged.

## 3. Footprint template model

A footprint template is a deterministic package/geometry definition used by future renderers and inspectors.

Template objects are library definitions, not canonical measured facts.

Future human-confirmed assignment of a template to a component is event-driven and separate from this library specification.

## 4. Required template fields

Each template definition must include:

- `template_id`: stable package/geometry identifier.
- `template_version`: template format/version identifier.
- `package_family`: coarse package family grouping.
- `display_name`: user-facing label.
- `description`: short human-readable purpose/shape summary.
- `body_shape`: geometric body kind (for example rect/rounded_rect/oval/custom_path).
- `body_width`: body width in template coordinate units.
- `body_height`: body height in template coordinate units.
- `origin`: canonical local origin definition for placement/rotation operations.
- `bounding_box`: deterministic total footprint bounds.
- `label_anchor`: preferred designator/text anchor area.
- `orientation_marker`: orientation indicator definition.
- `pin_anchors`: explicit pin anchor collection.
- `pin_groups`: optional logical grouping of pins (for layout/readability, not electrical proof).
- `pin_count_rules`: constraints for valid pin-count variants.
- `default_pin_pitch`: default pitch hint for parametric generation.
- `allowed_variants`: allowed parametric variant declarations.
- `default_style_tokens`: default visual token names (stroke/fill/opacity/line style keys).
- `lod_hints`: level-of-detail hints for future renderer consumption.
- `hit_test_shape`: canonical interaction geometry hint for future hit testing.
- `accessibility_label_template`: default accessibility string template.

## 5. Pin anchor model

Each pin anchor entry must support:

- `pin_number`
- `anchor_x`
- `anchor_y`
- `side`
- `shape`
- size as either:
  - `width` + `height`, or
  - `radius`
- optional label anchor metadata

Pin anchor semantics are visual/placement metadata and do not confirm electrical pin mapping by themselves.

## 6. Variant parameter model

Variants must support parameterization for:

- `pins_per_side`
- `pitch`
- `body_width`
- `body_height`
- `lead_length`
- `lead_width`
- `orientation_marker`

Variant application must remain deterministic from template input + variant parameters.

## 7. V1 locked template set

V1 core template set:

- `unknown_rect`
- `chip_0402`
- `chip_0603`
- `chip_0805`
- `chip_1206`
- `two_pin_smd`
- `two_pin_axial`
- `three_pin_smd_generic`
- `three_pin_through_hole_generic`
- `sot23_3`
- `sot23_5`
- `sot223`
- `soic_8`
- `soic_14`
- `soic_16`
- `header_1xn`
- `header_2xn`

## 8. Deferred template families

Explicitly deferred from V1:

- `qfn` families (`qfn_16`, `qfn_24`, `qfn_32`)
- `qfp` / `tqfp` families
- relay blocks
- complex connector systems
- transformers
- large modules

## 9. Forbidden template naming (identity leakage guard)

Forbidden as template IDs:

- `mosfet`
- `regulator`
- `diode`
- `microcontroller`
- `opamp`
- `relay_driver`
- `power_supply`
- `5v_regulator`
- `eeprom`

Rationale:

- package/geometry naming prevents accidental conversion of visual template selection into electrical identity claims.
- this preserves evidence-floor discipline and avoids identity leakage into canonical truth surfaces.

## 10. Future renderer consumption contract (non-implementation)

Future renderer may consume template definitions as read-only geometry sources.

Expected consumption characteristics:

- deterministic geometry output for same template + variant parameters.
- explicit `bounding_box` for culling/spatial indexing later.
- explicit `pin_anchors` for future overlay/inspection alignment.
- explicit `label_anchor` for stable designator placement.
- `lod_hints` for future zoom-dependent drawing decisions.
- `hit_test_shape` as future interaction hint only.

This specification does not lock renderer class architecture, canvas stack, scene graph design, spatial index algorithm, or hit-testing implementation details.

## 11. Future AI proposal interaction (non-persistence)

Future AI layers may suggest candidate templates for a component as visual hypotheses only.

Rules:

- candidate suggestions stay `unconfirmed_ai_proposal`.
- ranking order is not proof.
- no automatic canonicalization.
- no bulk confirm-all flow in initial design.

Top-3 candidate display belongs to a future AI proposal workflow pass and is not a core requirement of this footprint library specification.

## 12. Data ownership and evidence boundaries

- template definitions are library assets/configuration, not canonical measured facts.
- canonical facts still come from accepted events in `events.jsonl`.
- `known_facts.json` remains a projection and may carry confirmed visual placement facts only through accepted event paths.
- template selection alone must not create identity/net/measurement/fault facts.
- no `board_graph.json` or `view_state.json` is introduced in V1 by this spec.
- no Project ZIP contract change is introduced by this spec.

## 13. Future implementation-pass test expectations

A future implementation pass should include tests for:

- deterministic template expansion from template + variant parameters.
- required-field validation for template definitions.
- invalid forbidden naming rejection/policy enforcement in template registry checks.
- pin-anchor geometry integrity (required fields and shape-size consistency).
- variant constraint enforcement (`pin_count_rules`, allowed ranges/sets).
- consistent `bounding_box`/origin/orientation-marker behavior.
- LOD hint presence/shape contract handling.
- evidence-boundary checks:
  - template assignment does not imply identity,
  - template assignment does not imply electrical net,
  - template assignment does not imply measurement/fault evidence.
- AI candidate handling checks:
  - suggestions remain non-canonical until explicit human confirmation.

## 14. Recommended next pass

`VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_PASS`

Reason:

- audit this formal spec for internal consistency and boundary compliance before any renderer/UI implementation scope lock.
