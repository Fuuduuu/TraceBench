# BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md

PASS_ID: `BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_DESIGN_PASS`  
Lane: `DOCS_SYNC / DESIGN_ONLY`  
Status: Accepted design baseline; later placement schema/validator/projection passes are implemented; `VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS` locked footprint scope and `VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS` now formalizes the footprint template contract in `docs/VECTOR_FOOTPRINT_LIBRARY_SPEC.md`.

## 1. Goal

Define a future boardview-like vector canvas and internal vector footprint/template library for repair mapping, while preserving TraceBench evidence boundaries.

## 2. Non-goals (this pass)

- No runtime Flutter implementation.
- No event model/schema/tooling changes.
- No `board_graph.json` or `view_state.json`.
- No AI-generated confirmed facts.
- No camera/OCR/CV, source search, KiCad import/export, cloud/BLE.

## 2.1 Scope-lock addendum (`VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS`)

Locked before any renderer/UI implementation:

- Footprint library direction is parametric package/geometry templates.
- `template_id` is never electrical identity proof, pin-mapping confirmation, measured-net proof, or fault evidence.
- Template naming is package/geometry-first; identity-claim template IDs are forbidden as proof.
- V1 template set is deliberately small; advanced package families are deferred.
- Renderer-facing requirements are locked (deterministic, bbox/pin/label/LOD friendly), but renderer implementation choices are explicitly deferred.
- AI Top-3/ranking UX remains external-lab input only and is not a footprint-library implementation requirement.
- Static SVG is optional as reference/icon asset only; core dynamic model remains parametric templates.

## 2.2 Footprint spec addendum (`VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS`)

- Formal footprint/template contract is defined in `docs/VECTOR_FOOTPRINT_LIBRARY_SPEC.md`.
- Required template fields, pin-anchor model, and variant parameter model are specified there.
- V1 template set, deferred families, and forbidden identity-leaking names are locked there.
- Human-facing identity-leakage guardrails and unknown fallback template policy are locked there.
- Template-local coordinate frame/origin/axis/unit convention is locked there.
- This board-vector document remains the higher-level boardview/AI-boundary design surface.

## 2.3 Placement editor architecture decision (`BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`)

- Source review recorded: `ROUTE_REVIEW_COMPONENT_ADD_PLACEMENT_VISUAL_CONTACT_LAYOUT`.
- Add Component writes `component_created` only; it confirms identity/existence, not placement, side, rotation, size, shape, or contacts.
- Board Canvas renderer remains read-only/bodyOnly and does not write events.
- Board Canvas local builder/ghost remains UI-local draft until a future placement editor implementation.
- The Board Canvas right-panel / ghost draft is the intended first owner for the official UI-local placement editor.
- Future placement Confirm must use a dedicated placement writer service; renderer/painter code remains read-only.
- `component_visual_placement_confirmed` must be aligned to the V2 event regime before writer/UI implementation: `schema_version: 2.0-draft`, `actor.type: human`, source block, `confirmation.confirmed: true`, and idempotent `client_operation_id` precedent where applicable.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- Confirmed visual placement size uses `width` + `height`; `scale` is import/backward compatibility only unless later scoped.
- VectorFootprintLibrary / footprint recipe model owns canonical visual vocabulary; Board Canvas starter templates are UI presets only.
- Visual contact layout is a separate future event/projection and must not be folded into `component_visual_placement_confirmed`.
- AI marker conversion remains future scope: AI proposal/sidecar/UI-local candidate only until human confirmation through the placement editor path.

## 2.4 Placement event V2 regime scope-lock (`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`)

- `component_visual_placement_confirmed` must align to the V2 event regime before placement writer/editor implementation.
- Future protected implementation target: `schema_version: 2.0-draft`, `actor.type: human`, source block, `confirmation.confirmed: true`, and `client_operation_id` / idempotency precedent where applicable.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- Current repo scaffold remains V1-shaped until separately implemented: schema/validator/materializer paths currently carry the V1 envelope and accepted user-authored placement expectations.
- The future protected implementation must reconcile `schemas/events.schema.json`, `tools/validate_events_jsonl.py`, `tools/materialize_known_facts.py`, V2 event-type ownership, and focused tests/samples as explicitly scoped.
- Materializer must not silently drop V2 human-authored placement events after migration.
- This scope-lock does not implement the migration.

## 3. Hard evidence boundaries

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- BoardGraph projection/renderer remain derived, read-only surfaces.
- `visual_trace` remains visual-only evidence.
- AI proposal content is never canonical until explicit human confirmation.
- Renderer writes nothing to `events.jsonl`, `known_facts.json`, or Project ZIP artifacts.

## 4. Layer model

1. Canonical fact layer:
   - Source: accepted events in `events.jsonl`.
   - Authority: only human-confirmed/event-validated facts.
2. Materialized projection layer:
   - Source: Python materializer output (`known_facts.json`).
   - Authority: derived summary only, not independent truth.
3. Proposal layer (manual + AI):
   - Source: UI/session render state in V1 design.
   - Authority: draft-only, non-canonical.
4. Volatile render layer:
   - Source: viewport/layout/theme/opacities/toggles.
   - Authority: display-only.

## 5. AI proposal boundary

Every AI-placed/suggested/fitted/routed/labeled object starts as:

`status = "unconfirmed_ai_proposal"`

Rules:

- Not a project fact.
- Not written as `component_created`, `pin_defined`, `visual_trace_added`, `measurement_recorded`, or `net_connection_confirmed`.
- Not treated as confirmed in `known_facts.json`.
- Must not affect electrical graph, fault candidates, customer evidence, or Project ZIP evidence output.
- Must remain draft/render-only in V1 unless a future pass explicitly accepts proposal persistence.

## 6. Visual styling for `unconfirmed_ai_proposal`

- Primary tone: reddish.
- Outline: dashed.
- Fill: ghosted/transparent.
- Badge: `Unconfirmed` + `AI proposal`.
- No electrical certainty colors/badges.
- No measured/net-confirmed badge.

## 7. Theme and background/reference layers

- Boardview supports both Light and Dark modes.
- Default mode is vector-only canvas.
- Optional background photo/reference layer:
  - toggle ON/OFF
  - adjustable opacity
- Vector components also support adjustable opacity/transparency for overlay work.
- Background photo/reference layer is helper-only visual context.
- Photo pixels, opacity, alignment, and overlay fitting must not create component identity, placement, trace, measurement, net, or fault facts.

## 8. Footprint/template library model

Core rule: footprint/package template is independent from confirmed electrical identity.

Naming preference:

- package-based names (`sot23_3`, `soic_8`, `chip_0805`, `qfn_32`)
- avoid identity-claim names (`MOSFET`, `IC`, `resistor`) unless human-confirmed separately
- forbidden as template-proof IDs: `mosfet`, `regulator`, `diode`, `microcontroller`, `opamp`, `relay_driver`, `power_supply`, `5v_regulator`, `eeprom`, `transistor`

Template design:

- body shape from reusable vector template
- configurable pins/legs per side (where applicable)
- explicit pin anchor points
- centered label/designator area (`U2`, `C17`, `R45`, `K72`)
- orientation/rotation metadata

Locked V1 template core set:

- `unknown_rect`
- `unknown_2pin`
- `unknown_3pin`
- `unknown_multi_pin`
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

Deferred initially:

- `qfn_16`
- `qfn_24`
- `qfn_32`
- `qfp` / `tqfp` families
- relay blocks
- complex connectors
- transformers
- large modules

## 9. Placement model (design semantics)

Placement states:

1. temporary draft placement (manual, unsaved render intent)
2. AI proposal placement (`unconfirmed_ai_proposal`)
3. human-confirmed visual placement fact (`component_visual_placement_confirmed` canonical event path; visual/documentation-only)

Confirmation workflow constraints:

- human confirms one object at a time
- no initial "confirm all AI suggestions"
- identity confirmation and placement confirmation are separate actions
- visual contact layout confirmation is separate from placement confirmation and is not electrical confirmation

## 10. Trace/routing/color model

- User can define/select trace colors manually (e.g., 5V, 18V, GND, signal, custom).
- Color/category is visual metadata only by default.
- `visual_trace` is not a confirmed electrical net.
- Confirmed electrical net still requires accepted measurement/source-backed evidence.

## 11. Coordinate systems

1. `photo_local`:
   - pixel coordinates in original image space.
2. `board_normalized`:
   - normalized board plane (e.g., 0..1 x/y) for resolution-independent placement.
3. `graph_layout`:
   - derived readability layout for graph views; non-canonical display transform.

Mapping rule:

- electrical and confirmed identity facts are coordinate-space agnostic truth.
- human-confirmed placement facts, if later accepted by a dedicated event-model pass, must explicitly declare `coordinate_space`.
- render systems may map between spaces but must not rewrite canonical evidence.

## 12. Customer report/export boundary

- User/customer can choose whether boardview is included in customer-facing report/export.
- Initial safe default:
  - include confirmed facts only
  - exclude `unconfirmed_ai_proposal` content
- Future optional proposal export requires explicit scope pass and clear proposal labeling.

## 13. V1 / V2 / deferred roadmap

V1 (design baseline only):

- vector-first boardview concept
- optional reference photo layer behavior
- unconfirmed AI proposal styling and boundary rules
- one-by-one confirmation workflow requirement

V2 candidates (future scoped passes):

- renderer/editor consumption of already accepted visual placement canonical/projection data
- internal footprint library management UI
- optional report-export mode that can include clearly labeled proposal overlays

Deferred:

- auto-confirm flows
- hidden-layer inference
- electrical certainty from visual-only data
- proposal persistence without dedicated audit/scope lock

## 14. Additional design inputs still needed

- final default color tokens for dark/light theme and accessibility contrast thresholds
- initial minimum footprint set for first usable release
- explicit policy for per-object opacity persistence (session-only vs project-level, if ever)
- report UX wording for boardview include/exclude choice

## 15. Recommended next pass

`BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS` (`DOCS_SYNC`):

- lock read-only renderer scope only (no implementation yet).
- keep renderer/editor/AI proposal persistence implementation deferred until scope lock is accepted.
- preserve evidence boundaries:
  - templates remain package/geometry metadata only,
  - `visual_trace` remains visual-only,
  - no `board_graph.json` / `view_state.json`.
