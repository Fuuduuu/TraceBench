# Active Scope Lock

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS`

## Type

`FLUTTER_PASS / UI_CONSOLIDATION`

## Lane

`CODEX / IMPLEMENTATION`

## Mode

Implement the accepted technician-first UI consolidation for existing Save Measurement, Add Component, and Edit Component presentation only. Preserve writer-service behavior and event construction semantics unchanged.

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_POST_AUDIT_PASS`

## Write allowlist for this pass

- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `test/widget/measure_sheet_screen_test.dart`
- `test/widget/add_component_screen_test.dart`
- `test/widget/edit_component_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS.md`

## Implementation scope

- Consolidate user-facing Save/Add/Edit presentation only.
- Preserve technician-first flow `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`.
- Keep default UI simple and fast.
- Put technical writer/event details behind progressive disclosure where practical.
- Keep hints/candidates/templates/photos/AI context visually subordinate and non-canonical.
- Make success, not-saved, stale-projection, empty, and narrow-layout states more consistent.
- Preserve canonical event-writing behavior unchanged.

## Binding sources/specs/files inspected

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_CLOSEOUT_PASS.md`
- `docs/audit/V2_ADD_COMPONENT_PASS.md`
- `docs/audit/V2_ADD_COMPONENT_CLOSEOUT_PASS.md`
- `docs/audit/V2_EDIT_COMPONENT_PASS.md`
- `docs/audit/V2_EDIT_COMPONENT_CLOSEOUT_PASS.md`
- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `lib/features/components/services/v2_add_component_writer.dart`
- `lib/features/components/services/v2_edit_component_writer.dart`
- Save/Add/Edit screen and focused widget/unit test files.

## Locked future implementation must not touch

- Event writer service behavior.
- Save Measurement / Add Component / Edit Component event construction semantics.
- Validator/materializer/schema.
- Project ZIP.
- Activity Timeline.
- Measure Momentum.
- Board Canvas write/edit.
- Reference Images runtime.
- AI/OCR/CV.
- Photo Markup / Repair Map / Visual Trace Shape Assist.
- Assets/samples/platform/generated/tags/releases.
- New event types.
- Direct Flutter append to `events.jsonl`.

## Test requirements to lock

- Save/Add/Edit still call the writer exactly as before.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- Not-saved messages remain clear and consistent.
- Success states remain clear and non-diagnostic.
- Stale-projection state remains visible where relevant.
- Hints remain visually subordinate.
- No forbidden wording: verified/good/correct/detected/probability/diagnosis/fault ranking.
- Empty states guide the user without creating facts.
- Narrow layout remains usable.
- No Project ZIP / Board Canvas / Reference Images / AI write path appears.

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
- writer service behavior
- validator
- materializer
- schema / JSON schema
- AI/OCR/CV
- URL/source search
- Activity Timeline implementation
- Save/Add/Edit event construction semantic changes
- Measure Momentum implementation
- Photo Markup / Repair Map / Visual Trace Shape Assist
- platform/generated files
- tags/releases

## Route lock

Current: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS`.
Next: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_POST_AUDIT_PASS`.
