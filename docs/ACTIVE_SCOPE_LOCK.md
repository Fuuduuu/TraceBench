# Active Scope Lock

## Current pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS`

## Type

`FLUTTER_PASS`

## Lane

`CODEX / IMPLEMENTATION`

## Mode

Runtime route-remediation implementation for legacy measurement write-path retirement.
No sequence semantics, event-service, schema, validator, materializer, Project ZIP,
Board Canvas write/edit, Reference Images runtime, Activity Timeline, Measure
Momentum, AI/OCR/CV, or other protected-surface changes.

## Next recommended pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS.md`
- `lib/app/router.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`

## Closeout direction

- `/project/measurements/new` is a compatibility route and must hard-redirect to `/project/measure-sheet`.
- Project Overview `Lisa mõõtmine` action must navigate to `/project/measure-sheet`.
- V2 normal write path must remain:
  - `/project/measure-sheet -> MeasureSheetScreen -> V2SaveMeasurementWriter`.
- Legacy route reachability through normal Overview flow must be retired.

## Forbidden surfaces

- `lib/**` and `test/**` changes are forbidden outside the explicit allowlist above.
- Do not add `sequence` to V2 events to satisfy legacy writer expectations.
- Do not change V2 event model semantics to satisfy `MeasurementEventWriter`.
- Do not change `tools/event_writer_service.py` behavior.
- Do not change schema/validator/materializer/Project ZIP.
- Do not modify Activity Timeline, Measure Momentum, Photo Markup, Repair Map, or Visual Trace Shape Assist runtime.
- No broad redesigns to Add Component, PCB-first Project Overview, or Save Measurement unit-selection flow.

## Route lock

Current: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS`
Next: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_PASS`
