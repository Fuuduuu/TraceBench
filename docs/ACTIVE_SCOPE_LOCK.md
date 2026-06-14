# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`

## Type

`IMPLEMENTATION`

## Lane

`CODEX / FLUTTER_UI_LAYOUT_POLISH`

## Mode

Narrow implementation pass for Workbench Home layout proportion balance. Only proportional/layout polish in existing screen code, no router or runtime semantic changes.

## Current goal

- Tune `ProjectOverviewScreen` proportions so the central board/workbench zone is dominant.
- Keep the top context/title band compact.
- Reduce right action-rail and grouped card footprint.
- Reduce stats/chips visual weight below the board.
- Preserve `Lisa mõõtmine`, secondary action reachability, and route/key contracts.
- Preserve zero-event/render behavior, read-only board/workbench, and future-tool inertness.

## Next recommended pass

`V2_WORKBENCH_HOME_LAYOUT_BALANCE_POST_AUDIT_PASS`

## Scope decision

- scope type: `FLUTTER_UI_LAYOUT_POLISH`
- lane: `CODEX / FLUTTER_UI_LAYOUT_POLISH`
- mode: implementation polish in existing overview widgets only.

## Current status from requested baseline

- latest accepted/pushed implementation: `V2_WORKBENCH_HOME_SHELL_PASS`
- latest implementation milestone completed: Workbench Home presentation slice in `ProjectOverviewScreen` via commit `3f133a5` (`feat(project-overview): add workbench home shell`).
- route drift target: `V2_WORKBENCH_HOME_SHELL_PASS` -> layout polish (`V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`).

## File allowlist for this pass

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS.md`

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
- Add Component / Edit Component / Save Measurement writer/service schema/validator/materializer changes
- writer/event/schema/materializer/projection/validator changes
- Project ZIP / reference image runtime changes
- AI/OCR/CV/photo/members/repair-map changes

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

Closeout boundary carry-forward:

- Workbench Home shell completed in implementation pass.
- Board Canvas remains read-only unless separately scoped.
- no writer/event/schema/projection/materializer/validator runtime changes.
- no runtime changes to Project ZIP/Reference Images/AI/OCR/CV.
- future tool modules remain inert in this closeout.
- no `sequence` addition to V2 events.

## Route lock

Current: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS`

Next: `V2_WORKBENCH_HOME_LAYOUT_BALANCE_POST_AUDIT_PASS`

## Exact allowed focus

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_LAYOUT_BALANCE_PASS.md`
