# ACTIVE_SCOPE_LOCK.md

## Current pass

`TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_SMOKE_PASS`

## Lane

`CODEX / DOCS_SYNC_QA_RUN`

## Next recommended pass

`V1_1_POST_MEASURE_SHEET_READONLY_SHELL_ROUTE_REVIEW_PASS`

## Scope

Docs-only manual smoke record for the accepted/pushed read-only technician-first Measure Sheet shell.

Record the user-performed Windows app smoke result: all listed read-only shell checks passed, no blocking issue observed, and next routing should go to read-only route review before any further implementation.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_SMOKE_PASS.md`

## Forbidden surfaces

- Runtime code and Flutter implementation files.
- Tests.
- Schemas, validators, tools, and materializer behavior.
- Project ZIP logic or contract.
- Board Canvas runtime or write/edit behavior.
- Reference Images runtime.
- AI/OCR/CV, source search, URL import, datasheet parser, or localStorage behavior.
- `events.jsonl`, `known_facts.json`, generated artifacts, assets, samples, platform folders, tags, or release objects.
- Real Measure Sheet Save Measurement, Add Component, Edit Component, event-writing, canonical fact creation, or persistence.

## Boundary summary

- Measure Sheet shell remains read-only/display-only.
- Save-looking affordance remains disabled and non-writing.
- Human remains the sensor; AI remains the graph engine.
- Status/dot means only that a reading exists or was recorded here.
- Reference/source/candidate/note values remain non-canonical and must not look measured.
- Do not route directly to implementation until route review selects and scope-locks it.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`