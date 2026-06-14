# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_SHELL_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout pass for `V2_WORKBENCH_HOME_SHELL_PASS`. No implementation/runtime changes.

## Current goal

- close out `V2_WORKBENCH_HOME_SHELL_PASS` after implementation acceptance:
  - record pushed implementation commit and validation summary,
  - preserve all implementation boundaries,
  - route docs to `NEEDS_USER_DECISION`,
  - keep Workbench Home deferred-future tool states inert for a future separate scope.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only closeout and governance record update only.

## Current status from requested baseline

- latest accepted/pushed implementation: `V2_WORKBENCH_HOME_SHELL_PASS`
- latest implementation milestone completed: Workbench Home presentation slice in `ProjectOverviewScreen`.
- route drift to closeout: `V2_WORKBENCH_HOME_SHELL_PASS` -> `V2_WORKBENCH_HOME_SHELL_CLOSEOUT_PASS`.

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_SHELL_CLOSEOUT_PASS.md`

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

Current: `V2_WORKBENCH_HOME_SHELL_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Exact allowed focus

- closeout governance updates in:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/WORK_INTAKE_INDEX.md`
  - `docs/audit/V2_WORKBENCH_HOME_SHELL_CLOSEOUT_PASS.md`
