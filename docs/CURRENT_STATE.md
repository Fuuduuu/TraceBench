# Current State

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS`

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_POST_AUDIT_PASS`

## Latest accepted route

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS` is accepted, post-audited, committed, and pushed. The current pass implements the accepted technician-first UI consolidation slice for Save/Add/Edit presentation only.

The three core V2 UI write flows remain accepted and pushed:

- Save Measurement -> `measurement_recorded`;
- Add Component -> `component_created`;
- Edit Component -> `component_updated`.

## Implementation summary

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS` is scoped to UI presentation and workflow consolidation only:

- Save Measurement, Add Component, and Edit Component writer adapters remain unchanged;
- technician-first flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`;
- default UI stays simple and fast;
- technical writer/event details move behind progressive disclosure where practical;
- hints, candidates, templates, photos, and AI context remain visually subordinate and non-canonical;
- not-saved, success, stale-projection, empty-state, and narrow-layout states should be consistent;
- canonical event-writing behavior must remain unchanged.

Binding sources/specs/files for this implementation are listed in `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS.md`.

Pinned validation sequence is also recorded in that audit doc.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output never authors canonical events/facts.
- Writer-service behavior remains unchanged.
- Save/Add/Edit event construction semantics remain unchanged.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- No validator/materializer/schema, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Strategy capture audit: `docs/audit/V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS.md`
- Closeout audit: `docs/audit/V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_CLOSEOUT_PASS.md`
- Scope lock audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS.md`
- Scope lock closeout audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_CLOSEOUT_PASS.md`
- Implementation audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS.md`
