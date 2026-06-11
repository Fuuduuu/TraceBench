# Current State

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_POST_AUDIT_PASS`

## Latest accepted route

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS` is accepted and closed out. The current pass locks the future technician-first UI consolidation scope only.

The three core V2 UI write flows remain accepted and pushed:

- Save Measurement -> `measurement_recorded`;
- Add Component -> `component_created`;
- Edit Component -> `component_updated`.

## Scope lock summary

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS` locks future UI consolidation for Save/Add/Edit only:

- technician-first workbench, not spreadsheet-first;
- core flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`;
- default UI stays simple and fast, with technical details behind progressive disclosure;
- evidence, provenance, schema, and event IDs should not dominate the technician view;
- hints, candidates, templates, photos, and AI context remain visually subordinate;
- not-saved, success, and stale-projection states should be consistent across Save/Add/Edit;
- empty states, narrow layout, tablet/desktop responsiveness, accessibility, and contrast are in scope for future implementation;
- UI polish must not change canonical event-writing behavior;
- implementation remains blocked until post-audit accepts this scope lock.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output never authors canonical events/facts.
- No event writer service behavior, Save/Add/Edit event construction semantics, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, validator, materializer, schema, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Strategy capture audit: `docs/audit/V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS.md`
- Closeout audit: `docs/audit/V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_CLOSEOUT_PASS.md`
- Scope lock audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS.md`
