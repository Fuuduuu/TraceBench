# ACTIVE_SCOPE_LOCK.md

## Current pass

`TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_CLOSEOUT_PASS`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_SMOKE_PASS`

## Scope

Docs-only closeout for the accepted and pushed `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS`.

Record that the read-only technician-first Measure Sheet shell was implemented, independently post-audited, patched, validated, committed, and pushed. Route next to manual/user-visible smoke before any guided-measurement or event-writing scope.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_CLOSEOUT_PASS.md`

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
- App copy must not imply the app measured, inferred, verified, diagnosed, or confirmed facts.
- Dot/chip/status copy means only that a reading exists or was recorded here.
- Reference/source/candidate/note values remain non-canonical and must not look measured.
- Narrow-window context fallback must preserve selected `Koht` context.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
