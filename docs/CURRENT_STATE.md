# CURRENT_STATE.md

Project: TraceBench AI / BoardFact  
Branch: `main`

- Current pass: `V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`
- Next recommended pass: `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`
- Current-state maintenance trigger pointer: `docs/MEMORY_MAINTENANCE.md` owns the rule; keep this file below the ~120-line trigger.

## Compact handoff

- V1 RC is fixed and protected; tag `v1.0.0-rc1` exists locally and on `origin`.
- V1.1 hardening is effectively complete and `v1.1.0-rc1` is verified:
  - annotated tag exists locally and on `origin`,
  - tag target is `da3f055aac912b6da43a23eeda0bd33811bb29f8`,
  - no tag/release mutation was performed by AI.
- V1.1 full-app manual smoke is accepted as `PASS_WITH_NITS`:
  - user observed image add, project create/load, and general app behavior working,
  - no new visible issue was observed,
  - some checklist surfaces were not explicitly itemized, so no extra coverage is invented.
- Ideelabor product anchor is accepted: TraceBench should be a technician-first bench workflow, not an engineering spreadsheet.
- V2 event-writing architecture remains later and separately scoped.

## Latest accepted baseline

- Reference Images remain Model B local sidecar only:
  - local `.tracebench_local/reference_images/` storage and `.tracebench_local/reference_images.json` ledger,
  - read-only viewer with accepted V1.1 UX slices,
  - outside Project ZIP, `events.jsonl`, `known_facts.json`, materializer, Board Canvas, AI/OCR/CV, and URL import.
- Board Canvas remains read-only:
  - visual polish is accepted/pushed,
  - `renderer writes: none` remains part of the UI boundary,
  - display-only footprint rendering uses existing template geometry,
  - no schema/model/materializer/Project ZIP changes and no `board_graph.json` or `view_state.json`.
- Project Creator reliability fix is accepted/pushed:
  - production `ProjectCreator` remains untouched,
  - test fake writes `known_facts.json` synchronously,
  - targeted project creator test passed (`7/7`), full Flutter suite repeated passed (`5/5`), and `py -3 tools\validate_all.py` passed.
- Governance/test hygiene baseline is accepted/pushed:
  - memory read/conflict ownership is reconciled,
  - `flutter analyze` has 0 errors and 5 explicitly deferred residuals,
  - full Flutter suite passed (`195/195`) and `py -3 tools\validate_all.py` passed.

## Ideelabor product anchor

- Compact direction: Ideelabor / BoardFact prototype remains visual and workflow input only; TraceBench stays technician-first with `Koht -> Väärtus -> Ühik -> Salvesta`, measure-first defaults, internals behind `Lisainfo` / `Tehnilised detailid`, human measurements above reference/research/candidate context, and helper guidance that may suggest or surface gaps without diagnosis or fact creation.

## Recent completed summary

- `V1_1_MEMORY_SYSTEM_RECONCILIATION_CLOSEOUT_PASS`: accepted/pushed docs-only memory ownership closeout.
- `V1_1_TEST_AND_LINT_HYGIENE_CLOSEOUT_PASS`: accepted/pushed hygiene closeout with 5 explicitly deferred analyzer residuals.
- `V1_1_READINESS_DOCS_SYNC_AND_TAG_DECISION_PASS`: accepted/pushed readiness/tag-decision sync.
- `V1_1_RC_TAG_VERIFICATION_CLOSEOUT_PASS`: records user-created/pushed verified `v1.1.0-rc1` milestone tag.
- `V1_1_FULL_APP_MANUAL_SMOKE_CLOSEOUT_PASS`: records automated/static baseline PASS and user live smoke `PASS_WITH_NITS`.
- `TRACEBENCH_IDEALAB_WORKFLOW_ANCHOR_PASS`: records accepted technician-first workflow direction and future route candidates.
- `TRACEBENCH_POST_SOURCED_VALUES_SCOPE_ROUTE_REVIEW_PASS`: read-only route review returned `PASS` and selected `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS` as highest-value, lowest-risk, ready-now next pass.
- `REFERENCE_VALUES_PANEL_IMPL_CLOSEOUT_PASS`: records accepted/pushed display-only Reference Values Panel implementation and post-audit `ACCEPT_AS_IS`.
- `V1_1_POST_REFERENCE_VALUES_PANEL_ROUTE_REVIEW_PASS`: read-only Claude Code / Opus route review returned `PASS` from user-provided route context and selected `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS`; V2 event-writing remains deferred.
- `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_CLOSEOUT_PASS`: accepted/pushed docs-only closeout for the helper scope lock and post-audit patch.
- `GUIDED_MEASUREMENT_FLOW_IMPL_CLOSEOUT_PASS`: accepted/pushed docs-only closeout for the read-only Guided Measurement helper implementation and post-audit `ACCEPT_AS_IS`.
- `TRACEBENCH_IDEALAB_RESIDUAL_PRODUCT_GUARDRAILS_PASS`: accepted/pushed docs-only product guardrail capture before post-helper route review; records activity-log separation, measure momentum, offline/prototype cautions, A-unit placement, Estonian labels, and compactness rules.
- `V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`: current read-only route-review record; Claude Code / Opus returned `PASS` and selected `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS` before any V2 architecture decision.

## Future candidates

- `TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS`: completed/pushed docs-only scope lock; non-canonical sourced/reference/research/candidate values remain sidecar concepts below human measurements.
- `TRACEBENCH_POST_SOURCED_VALUES_SCOPE_ROUTE_REVIEW_PASS`: accepted read-only route review; selected `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS` because it builds on the just-locked sidecar boundary, clarifies measured/reference/candidate/note display before UX/helper work, avoids premature V2 event writing, and does not start implementation.
- `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS`: accepted/pushed docs-only scope lock; locked display/provenance rules for measured, reference/source, candidate, and note values while preserving non-canonical boundaries.
- `REFERENCE_VALUES_PANEL_SCOPE_LOCK_POST_AUDIT_PASS`: accepted from Claude Code / Opus audit context (`ACCEPT_AS_IS`; no blocker/high/medium findings; LOW prior route-review status tidy applied; validation PASS).
- `REFERENCE_VALUES_PANEL_SCOPE_LOCK_CLOSEOUT_PASS`: accepted/pushed docs-only closeout; recorded scope lock acceptance, post-audit `ACCEPT_AS_IS`, validation PASS, and preserved evidence boundaries.
- `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PREP_PASS`: completed/pushed docs/source-prep; created the safe prototype source folder and README handoff restrictions.
- `REFERENCE_VALUES_PANEL_IMPL_PASS`: accepted/pushed display-only implementation; added a Reference Values Panel inside the read-only Measure Sheet shell and writes no canonical facts.
- `REFERENCE_VALUES_PANEL_IMPL_POST_AUDIT_PASS`: accepted from Claude Code / Opus audit context (`ACCEPT_AS_IS`; no blocker/high/medium/low findings; validation baseline green).
- `REFERENCE_VALUES_PANEL_IMPL_CLOSEOUT_PASS`: accepted/pushed docs-only closeout; records accepted implementation, post-audit acceptance, validation state, and preserved non-canonical boundaries.
- `V1_1_POST_REFERENCE_VALUES_PANEL_ROUTE_REVIEW_PASS`: accepted from folded route context in `docs/audit/GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS.md`; selected `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS`.
- `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`: accepted/pushed docs-only design review record; Claude Design returned `ACCEPT_WITH_NITS`, no prototype files were touched, and no implementation was produced.
- `TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS`: accepted/pushed docs-only scope lock; locks the first implementation-safe read-only/display-only Measure Sheet shell scope from UX review findings without starting implementation.
- `TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_POST_AUDIT_PASS`: accepted from Claude Code / Opus audit context (`NEEDS_SMALL_PATCH`; scope substance accepted; deferred-feature text artifact cleanup applied and validation passed).
- `TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_CLOSEOUT_PASS`: accepted/pushed docs-only closeout; records accepted scope lock, resolved post-audit patch, and route to read-only shell implementation.
- `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS`: accepted/pushed implementation; added a read-only/display Measure Sheet shell, overview navigation, focused tests, and no event-writing or canonical mutation.
- `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_POST_AUDIT_PASS`: accepted from Claude Code / Opus audit context (`NEEDS_SMALL_PATCH`; LOW analyzer const regression patched; validation returned to baseline).
- `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_CLOSEOUT_PASS`: accepted/pushed docs-only closeout for the read-only shell implementation.
- `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_SMOKE_PASS`: accepted/pushed manual Windows smoke; user launched the app and reported all read-only shell checks PASS.
- `V1_1_POST_MEASURE_SHEET_READONLY_SHELL_ROUTE_REVIEW_PASS`: accepted/pushed route-review record; Claude Code / Opus returned PASS and selected `REFERENCE_VALUES_PANEL_IMPL_PASS`.
- `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS`: accepted/pushed docs-only scope lock for a future read-only helper that may suggest next measurements, show missing readings, and surface gaps/conflicts only; no diagnosis, probability, net inference, identity confirmation, or fact creation.
- `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS`: accepted from audit context (`NEEDS_SMALL_PATCH`; missing `AUDIT_INDEX` route-review row patched and validation PASS).
- `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_CLOSEOUT_PASS`: accepted/pushed docs-only closeout; records accepted scope lock, post-audit patch, validation state, and preserved helper boundaries.
- `GUIDED_MEASUREMENT_FLOW_IMPL_PASS`: accepted/pushed read-only Measure Sheet helper implementation; helper suggests neutral next checks, missing-reading prompts, and gap/conflict prompts while writing nothing.
- `GUIDED_MEASUREMENT_FLOW_IMPL_POST_AUDIT_PASS`: accepted from Claude Code / Opus audit context (`ACCEPT_AS_IS`; no blocker/high/medium/low findings; validation baseline green; trailing-newline style NIT only).
- `GUIDED_MEASUREMENT_FLOW_IMPL_CLOSEOUT_PASS`: accepted/pushed docs-only closeout for the accepted implementation and post-audit result.
- `TRACEBENCH_IDEALAB_RESIDUAL_PRODUCT_GUARDRAILS_PASS`: accepted/pushed docs-only product guardrail capture; no implementation routing.
- `V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`: current route-review record; read-only audit returned `PASS` and selected `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`.
- `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`: next consolidated manual Windows smoke for the full read-only Measure Sheet surface before high-stakes V2 event-writing architecture.
- `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`: required before real Save Measurement / Add Component / Edit Component behavior.
- `QUICK_MEASUREMENT_SHEET_IMPLEMENTATION_PASS`: only after V2 event-writing architecture and UX design are accepted.
- Later: power-rail explorer lite, external research leads feasibility lab, commercial-readiness/GTM/licensing lane.
## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts; photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage/suspect are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only and renderer writes nothing.
- Do not drift into spreadsheet-style mandatory fields, AI diagnosis, fault probability, automatic net inference, or prototype-to-production shortcuts.

## Next recommended pass

`GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`
