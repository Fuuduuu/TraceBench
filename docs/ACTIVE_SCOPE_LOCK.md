# Active Scope Lock

## Current pass

`V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope-lock pass before implementation. This lock defines the next narrow Save
Measurement unit-control UX scope and captures the exact current risk and allowed
future behavior.

Current goal:

- define a single, unambiguous technician-first unit-control model for Save Measurement;
- preserve existing explicit target requirement from `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_PASS`;
- preserve all accepted V2 measurement runtime boundaries and no-sequence contract;
- keep implementation blocked in this pass.

## Next recommended pass

`V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_POST_AUDIT_PASS`

## Current scope lock decision

- scope type: `DOCS_SCOPE_LOCK`
- lane: `CODEX / DOCS_SCOPE_LOCK`
- mode: governance docs-only lock only; no runtime/test/schema/tool changes.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS.md`

## Allowed future implementation files (pass scope)

If/when this lock is implemented in a future implementation pass:

- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `test/widget/measure_sheet_screen_test.dart`

## Forbidden future touches

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
- `Muu ühik` / custom unit implementation
- `Save Measurement` event-model changes
- `pubspec.yaml`, `pubspec.lock`, dependency/config files
- generated files, samples, platform folders, and toolchain/package files

## Forbidden surfaces

Runtime/code changes outside the allowlist are forbidden until a separate
implementation lane opens.

- No `sequence` is added to V2 events.
- No event-type/projection contract changes.
- Do not rework route architecture in this lock.
- No `MeasurementEventWriter` reintroduction or legacy route fallback in scope.
- Do not touch tests in this docs-only lock pass.

## Route lock

Current: `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS`
Next: `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_POST_AUDIT_PASS`
