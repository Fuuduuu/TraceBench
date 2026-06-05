# TRACEBENCH_IDEALAB_WORKFLOW_ANCHOR_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate because this is a repo-local docs/product-governance anchor. Claude Code / Opus should lightly audit afterward because the pass touches durable governance/product memory. GPT Pro is not needed because GPT Pro already produced the Ideelabor synthesis. Gemini Pro Deep Research and Claude Design are not needed for this anchor; Claude Design is deferred to the later UX design pass.

## Scope drift check

PASS. This pass records product direction and future pass candidates only. It changes docs/governance files and does not implement measurement UI, event writing, schemas, sidecars, Board Canvas behavior, AI/helper behavior, Project ZIP behavior, or V2 architecture.

## Verdict

PASS. Ideelabor technician-first workflow direction is accepted as product workflow guidance and anti-drift memory.

## Source and prototype references

- Source: Ideelabor chat — technician-first workflow / no spreadsheet UX direction.
- Source: BoardFact Measure Sheet prototype — visual/design input only.
- GPT Pro synthesis: `TRACEBENCH_IDEALAB_TECHNICIAN_FIRST_SYNTHESIS_PASS`.
- Known prototype file: `BoardFact Measure Sheet example.html`.
- Referenced prototype bundle files: `measure.css` and `measure.js`.
- The prototype is not implementation source and must not be copied blindly into Flutter.

## Accepted product direction

TraceBench should be a technician-first bench workflow, not an engineering spreadsheet.

- Default workflow: select place/component/pin -> measure -> enter value -> choose unit -> save -> show status / next step.
- Short form: `Koht -> Väärtus -> Ühik -> Salvesta`.
- Target user: repair technicians who can solder, replace PCB components, identify parts, and use a multimeter.
- Normal users should not need to understand canonical schemas, event IDs, projection state, sidecar semantics, or internal graph rules.
- Default UI must be measure-first, not form-first.
- Default visible fields should stay small: `Koht`, `Väärtus`, `Ühik`, `Salvesta mõõtmine`.
- Advanced/internal details belong behind progressive disclosure such as `Lisainfo`, `Tehnilised detailid`, and inspector/details panels.
- Users should not be forced to fill provenance/schema/status fields per measurement.
- Human local measurement must visually outrank research/reference/candidate values.
- Reference/research/candidate values must not look measured.

## AI/helper boundary

Allowed future helper direction:

- suggest next measurements,
- organize accepted context,
- surface gaps/conflicts,
- summarize confirmed facts.

Forbidden helper drift:

- create canonical facts,
- diagnose faults,
- infer nets,
- confirm component identity,
- produce probability-style fault claims.

## Prototype workflow direction captured

The BoardFact Measure Sheet prototype demonstrates workflow direction only:

- read-only board/canvas pane,
- large `Mõõda` primary button,
- quick measurement sheet,
- auto-filled `Koht`,
- large `Väärtus` input,
- unit chips such as V / Ω / Diode / Beep,
- disabled save until minimum input exists,
- measurements list,
- collapsible `Lisainfo`,
- collapsible `Tehnilised detailid`,
- read-only / no-board-write messaging.

## Do-not-copy rules

- Do not copy HTML/CSS/JS directly into Flutter.
- Do not copy localStorage persistence behavior into evidence workflow.
- Do not introduce network font dependencies from the prototype.
- Do not treat prototype `save` behavior as implementation permission.
- Do not turn the prototype into event writing without V2 event-writing architecture scope lock.

## Ask-before-design rule

Before any UX design or implementation pass tries to reproduce the visual measurement sheet, ask the user for:

- HTML,
- CSS,
- JS,
- screenshots or screen recording if available,
- whether the prototype is visual-only or whether behavior should be preserved.

## Future pass roadmap

Preferred sequence after this anchor:

1. `TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS`
   - non-canonical sourced/reference/research values;
   - research notes never become facts without human measurement/confirmation;
   - must stay sidecar/non-canonical unless separately scoped.
2. `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`
   - Claude Design review of measurement sheet UX;
   - requires the full prototype bundle request first.
3. `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS`
   - safe helper behavior only: suggest next measurements, show missing measurements, highlight conflicts;
   - no AI diagnosis and no fact creation.
4. `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS`
   - measured vs reference vs hint vs candidate value display rules.
5. `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`
   - required before real Save Measurement / Add Component / Edit Component behavior.
6. `QUICK_MEASUREMENT_SHEET_IMPLEMENTATION_PASS`
   - only after V2 event-writing architecture and UX design are accepted;
   - requires full prototype bundle and final design spec.

Optional/later candidates: `POWER_RAIL_EXPLORER_LITE_SCOPE_LOCK_PASS`, `EXTERNAL_RESEARCH_LEADS_FEASIBILITY_LAB_SCOPE_LOCK_PASS`, and commercial-readiness / GTM / licensing strategy lane.

## Do-not-drift rules

Do not drift into AI diagnosis, fault probability, automatic net inference, component identity confirmation from footprint alone, reference image evidence promotion, spreadsheet-style mandatory fields, broad schema changes without architecture review, Board Canvas write/edit semantics, Project ZIP changes without explicit scope, web/crawler/AI import in primary UI, reference/research values looking measured, or prototype-to-production shortcuts.

## Existing hard boundaries preserved

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage/suspect are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only.
- No V2 implementation is included in this pass.

## Next recommended pass

`TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS`
