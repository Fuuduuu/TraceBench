# V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS

## Type

`docs-strategy-capture`

## Lane

`CODEX / DOCS_SYNC`

## Purpose

Capture the UX/UI strategy direction after the accepted V2 Save Measurement, Add Component, and Edit Component write flows.

This pass is docs-only. It does not implement UI changes, runtime behavior, tests, tools, schemas, validator behavior, materializer behavior, Project ZIP behavior, Board Canvas behavior, Reference Images behavior, AI/OCR/CV, Activity Timeline, Measure Momentum, assets, samples, platform files, generated artifacts, tags, or release objects.

## Accepted baseline

The three core V2 UI write flows are accepted:

- Save Measurement creates only `measurement_recorded`.
- Add Component creates only `component_created`.
- Edit Component creates only `component_updated`.

All three accepted flows preserve the writer-service boundary and avoid direct Flutter append to `events.jsonl`.

## Strategy captured

The main workbench is partially shaped. Save/Add/Edit are functional, but the workflow and visual system need consolidation before additional feature expansion.

Future UI work should be technician-first, not spreadsheet-first:

- Core workflow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`.
- Default UI should stay simple and fast.
- Technical details should be behind progressive disclosure.
- Evidence, provenance, schema, and event IDs should not dominate the normal technician view.
- Hints, candidates, templates, photos, and AI context must remain visually subordinate.
- Not-saved, success, and stale-projection states should be consistent across Save/Add/Edit.
- Empty states should be useful and clear.
- Narrow layout, tablet, and desktop responsiveness should be considered.
- Estonian technician-first labels should be preferred.
- Accessibility and contrast should be included.
- UI polish must not change canonical event-writing behavior.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output does not author canonical events or facts.
- Hints/candidates/templates/photos/AI context remain non-canonical unless a separately scoped human-confirmed write flow creates an accepted event.
- No Project ZIP, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist, validator, materializer, schema, asset/sample, platform, generated artifact, tag, or release work is included.

## Route decision

Current pass: `V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS`.

Next recommended pass: `V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_POST_AUDIT_PASS`.

Likely route after accepted post-audit and closeout: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS`.

## Validation

Validation commands for handoff:

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
