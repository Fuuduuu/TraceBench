# Current State

## Current pass

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS`

## Next recommended pass

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_POST_AUDIT_PASS`

## Latest accepted route

The three core V2 UI write flows are accepted and pushed:

- Save Measurement -> `measurement_recorded`;
- Add Component -> `component_created`;
- Edit Component -> `component_updated`.

## Strategy capture summary

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS` captures the next UI direction before more feature expansion:

- technician-first workbench, not spreadsheet-first;
- core flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`;
- default UI stays simple and fast, with technical details behind progressive disclosure;
- evidence, provenance, schema, and event IDs should not dominate the technician view;
- hints, candidates, templates, photos, and AI context remain visually subordinate;
- not-saved, success, and stale-projection states should be consistent across Save/Add/Edit;
- empty states, narrow layout, tablet/desktop responsiveness, accessibility, and contrast remain part of future UI consolidation;
- UI polish must not change canonical event-writing behavior.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output never authors canonical events/facts.
- No Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, validator, materializer, schema, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Strategy capture audit: `docs/audit/V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS.md`
