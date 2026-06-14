# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_SHELL_PASS`

## Type

`FLUTTER_IMPLEMENTATION`

## Lane

`CODEX / FLUTTER_IMPLEMENTATION_PASS`

## Mode

Narrow Flutter implementation pass. Render-focused Workbench Home slice only; no runtime event/writer/model/schema/test surface changes.

## Current goal

- implement the first Workbench Home presentation slice from Option C / Hybrid:
  - board-centered workbench frame as the dominant context,
  - `Lisa mõõtmine` as the primary technician action,
  - grouped secondary actions for Add/Edit/Board/Reference,
  - read-only board center with sparse-placement placeholder and no write affordance,
  - unchanged route semantics and zero-event behavior at shell level.

## Next recommended pass

`V2_WORKBENCH_HOME_SHELL_POST_AUDIT_PASS`

## Scope decision

- scope type: `FLUTTER_IMPLEMENTATION`
- lane: `CODEX / FLUTTER_IMPLEMENTATION_PASS`
- mode: narrow runtime shell composition implementation.

## Current status from requested baseline

- latest accepted/pushed implementation: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_CLOSEOUT_PASS`
- latest implementation milestone to adapt: first Workbench Home slice in `ProjectOverviewScreen`.
- route drift to implement: Option C / Hybrid Workbench Home shell with no runtime semantics changes.

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_SHELL_PASS.md`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`

## Forbidden touches

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- schemas
- event model/schema changes
- writer/service/validator/materializer semantic changes
- `Project ZIP`
- `pubspec.yaml`, `pubspec.lock`, dependency/config files
- generated files, platform folders, samples
- tests outside this overview focus
- analyzer/lint cleanup
- `sequence` addition to V2 events
- runtime changes to writer/service/surfaces listed in `docs/PROTECTED_SURFACES.md`

## Forbidden future touches for this pass

- no Board Canvas authoring/write/edit
- no Reference Images runtime change
- no AI/OCR/CV
- no Visual Trace Shape Assist
- no Photo Markup / Repair Map
- no Save Measurement target/unit semantics
- no Add/Edit Component writer/event semantics
- no `Muu ühik` / custom unit behavior
- no router behavior changes outside existing compatibility
- no broad docs hygiene unrelated to this pass

## Route lock

Current: `V2_WORKBENCH_HOME_SHELL_PASS`

Next: `V2_WORKBENCH_HOME_SHELL_POST_AUDIT_PASS`

## Exact allowed focus

- `ProjectOverviewScreen` shell layout/labels/keys
- event-free behavior and projection-summary rendering for sparse placement scenarios
- action-group visibility and preserved existing routes
- inertia of future tools (no navigation, no onPressed handlers)
