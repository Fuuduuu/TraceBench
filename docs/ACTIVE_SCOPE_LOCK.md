# ACTIVE_SCOPE_LOCK.md

## Current pass

`VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS`

## Goal

Lock future internal parametric vector footprint/template library scope before any renderer/UI implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/audit/VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `tests/**`
- `lib/**`
- `test/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter renderer implementation
- `CustomPainter` implementation
- scene graph implementation
- spatial index implementation
- hit testing implementation
- component editing UI
- event-writing UI
- AI proposal persistence
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud
- Project ZIP contract changes

## Scope decisions

1. Primary footprint model is parametric package/geometry templates.
2. `template_id` is not identity/electrical function/pin-mapping confirmation/measured net/fault evidence.
3. Naming is package/geometry-first (`chip_0805`, `sot23_3`, `soic_8`, etc.) and identity-claim IDs (`mosfet`, `regulator`, `diode`, etc.) are forbidden as template proof.
4. V1 template set is intentionally small and locked:
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
5. Deferred initially:
   - `qfn_16`
   - `qfn_24`
   - `qfn_32`
   - `qfp` / `tqfp` families
   - relay blocks
   - complex connectors
   - transformers
   - large modules
6. Future `VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS` must define template metadata/geometry/pin-anchor/variant/style-LOD-hit-test-accessibility fields.
7. Pin-anchor model must support pin number, anchor coordinates, side/shape/size, and optional label anchor.
8. Variant model must support pins-per-side, pitch, body dimensions, lead dimensions, and orientation marker.
9. Lock renderer-facing requirements only (deterministic, bbox/pin/label aware, LOD-friendly, spatial-index friendly).
10. Do not lock renderer implementation choices yet (`CustomPainter` architecture, viewer container, spatial index algorithm, caching, hit testing strategy, layer-manager implementation).
11. Preserve future UI/UX design requirements as inputs only (dark/light, vector-only default, helper photo layer toggles/opacity, component opacity, layer toggles, side inspector, evidence badges, confirmed/stale/unconfirmed distinction, one-object confirmation, no confirm-all AI flow).
12. Background photo remains helper-only visual context; pixels/opacity/alignment cannot create identity/placement/trace/measurement/net/fault facts.
13. Trace color remains visual metadata only and does not confirm measured/electrical nets.
14. AI Top-3/ranking remains external lab and future audit input only; all AI suggestions remain `unconfirmed_ai_proposal`.
15. Data ownership remains unchanged:
   - footprint template definitions are not canonical facts
   - template assignment is event-driven only if later accepted
   - render state stays volatile
   - no `board_graph.json` / `view_state.json` in V1
   - no Project ZIP contract change in V1
16. Static SVG may be used later as reference/icon asset only; primary dynamic model remains parametric templates.
17. Next recommended pass is `VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS` (do not route directly to renderer/UI implementation).

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
