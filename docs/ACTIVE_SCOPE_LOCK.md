# Active Scope Lock

## Current pass

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS`

## Type

`docs-strategy-capture`

## Lane

`CODEX / DOCS_SYNC`

## Mode

Docs-only UX/UI strategy capture after accepted V2 Save Measurement, Add Component, and Edit Component write flows. Do not implement UI changes or broaden feature scope.

## Next recommended pass

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_POST_AUDIT_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md` only if needed
- `docs/PROJECT_MEMORY.md` only if needed as a compact durable product pointer
- `docs/audit/V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS.md`

## Strategy capture to record

- The three core V2 UI write flows are accepted: Save Measurement, Add Component, and Edit Component.
- Main workbench is partially shaped, but the flow needs technician-first consolidation before further feature expansion.
- The preferred core flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`.
- Default UI should be simple and fast; technical details stay behind progressive disclosure.
- Evidence, provenance, schema, and event IDs should not dominate normal technician use.
- Hints, candidates, templates, photos, and AI context remain visually subordinate and non-canonical.
- UI polish must not change canonical event-writing behavior.

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tools/**`
- `schemas/**`
- `samples/**`
- `assets/**`
- `events.jsonl`
- `known_facts.json`
- Project ZIP behavior
- Board Canvas runtime
- Reference Images runtime
- writer service
- validator
- materializer
- AI/OCR/CV
- URL/source search
- Activity Timeline implementation
- Add/Edit/Save implementation changes
- Measure Momentum implementation
- platform/generated files
- tags/releases

## Route lock

Current: `V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS`.
Next: `V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_POST_AUDIT_PASS`.
