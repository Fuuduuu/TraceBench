# Active Scope Lock

## Current pass

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_CLOSEOUT_PASS`

## Type

`docs-closeout`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Docs-only closeout for the accepted and pushed V2 Measure Sheet UX strategy capture. Do not implement UI changes or broaden feature scope.

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md` only if needed
- `docs/audit/V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_CLOSEOUT_PASS.md`

## Closeout acceptance to record

- `V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS` accepted/pushed.
- Post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit: YES`.
- Accepted commit: `ddc9690 docs: capture V2 measure sheet UX strategy`.
- Accepted strategy: technician-first workbench, not spreadsheet-first.
- Core flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`.
- Default UI remains simple and fast, with technical details behind progressive disclosure.
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

Current: `V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_CLOSEOUT_PASS`.
Next: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS`.
