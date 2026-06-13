# Active Scope Lock

## Current pass

`V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS`

## Type

`FLUTTER_IMPLEMENTATION_PASS`

## Lane

`CODEX / FLUTTER_IMPLEMENTATION_PASS`

## Mode

Implementation pass for a narrow Save Measurement unit-control UX refinement. The scope is
to remove the misleading static unit-display panel while preserving all existing
V2 boundaries.

Current goal:

- remove/hide the non-interactive unit chip panel (`_UnitDisplay`) so the existing
  `measure-sheet-unit-dropdown` is the single active unit affordance;
- preserve explicit target-selection behavior from
  `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_PASS`;
- preserve all accepted V2 measurement runtime boundaries and no-sequence contract.

## Next recommended pass

`V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_POST_AUDIT_PASS`

## Scope decision

- scope type: `FLUTTER_IMPLEMENTATION_PASS`
- lane: `CODEX / FLUTTER_IMPLEMENTATION_PASS`
- mode: implementation + focused docs alignment.

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS.md`
- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `test/widget/measure_sheet_screen_test.dart`

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

Current: `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS`
Next: `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_POST_AUDIT_PASS`
