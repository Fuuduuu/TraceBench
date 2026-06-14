# Active Scope Lock

## Current pass

`V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock. No runtime, tests, writer/service, schema/materializer/validator, tool, sample, platform, dependency, or generated-file edits in this pass.

## Current goal

- lock the first Workbench Home implementation slice after Opus strategy direction:
  - accept `MODIFY_PROMPT_FIRST` + Option C / Hybrid,
  - create a board-centered Workbench Home frame,
  - keep the first slice presentation-only,
  - preserve existing route/contracts and zero-event guarantees.

## Next recommended pass

`V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_POST_AUDIT_PASS`

## Scope decision

- scope type: `DOCS_SCOPE_LOCK`
- lane: `CODEX / DOCS_SCOPE_LOCK`
- mode: read-only governance lock pass.

## Current status from requested baseline

- latest accepted/pushed implementation: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_CLOSEOUT_PASS`
- option state to lock: `V2_WORKBENCH_HOME_UI_ROLLOUT_STRATEGY_REVIEW_PASS`
- route drift to lock on: Option C / Hybrid Workbench Home shell.

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS.md`

## Allowed future implementation surfaces

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart` (or closest existing overview test file)
- route tests only for unchanged route/keys and read-only assertions
- governance/docs files listed in allowlist
- optional tiny presentation-only child widget files if aligned to project conventions.

## Forbidden touches

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart` and other writer runtime
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- schemas
- event model/schema changes
- writer/service/validator/materializer runtime semantic changes
- `Project ZIP`
- Board Canvas authoring/write/edit behavior
- Board Canvas renderer richness that changes behavior (pan/zoom/markers/contour/photo/layers/AI candidate tools)
- Reference Images runtime changes
- AI/OCR/CV
- Visual Trace Shape Assist
- Photo Markup / Repair Map
- Save Measurement target/unit semantics
- Add/Edit Component write/event semantics
- `Muu ühik` / custom unit
- `sequence` addition to V2 events
- router behavior changes
- `pubspec.yaml`, `pubspec.lock`, dependency/config files
- generated files, platform folders, samples
- analyzer/lint cleanup
- broad docs hygiene unrelated to this lock
- production copying of design mockups/CSS (`workbench.css`, `redesign.css`, html mockups)

## Route lock

Current: `V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS`

Next: `V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_POST_AUDIT_PASS`
