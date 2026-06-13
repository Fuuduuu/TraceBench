# Active Scope Lock

## Current pass

`V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-closeout mode for the accepted/pushed `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS`
implementation. No runtime/test changes are allowed in this pass.

Current goal:

- confirm closeout ledger records for `fix(measure-sheet): remove inert unit display`;
- preserve route/docs continuity and existing protected-surface boundaries while setting
  next state to `NEEDS_USER_DECISION`.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only closeout + governance alignment.

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_CLOSEOUT_PASS.md`

## Forbidden touches

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `schemas/`
- Writer/validator/materializer semantic changes
- Event schema/model changes
- `Project ZIP`
- `Board Canvas` runtime/write/edit
- `Reference Images` runtime
- `AI/OCR/CV`
- Add/Edit Component runtime
- `Muu ühik`/custom unit implementation
- `Save Measurement` event-model changes
- `pubspec.yaml`, `pubspec.lock`, dependency/config files
- generated files, samples, platform folders, and toolchain/package files

## Route lock

Current: `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_CLOSEOUT_PASS`
Next: `NEEDS_USER_DECISION`
