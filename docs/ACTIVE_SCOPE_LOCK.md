# Active Scope Lock

## Current pass

`V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock for the first narrow implementation slice only. No runtime/test
schema/tool changes are allowed in this pass.

Current goal:

- lock `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS` as a narrow, safe future implementation slice:
  presentation-only PCB-first Project Overview shell centered on board/PCB context;
- preserve all V2 save/add/edit writer, event, sequence, and projection boundaries;
- preserve all existing route behavior outside this shell plan;
- keep Board Canvas in read-only mode.

## Next recommended pass

`V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_POST_AUDIT_PASS`

## Scope decision

- scope type: `DOCS_SCOPE_LOCK`
- lane: `CODEX / DOCS_SCOPE_LOCK`
- mode: docs-only scope-lock + governance alignment.

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS.md`

## Allowed future implementation surfaces

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart` (or closest existing overview test file)
- route tests only for unchanged route reachability and existing flow assertions
- existing governance/doc updates

## Forbidden touches

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
- route redesign outside Project Overview shell
- analyzer/lint cleanup
- `pubspec.yaml`, `pubspec.lock`, dependency/config files
- generated files, samples, platform folders, and toolchain/package files

## Route lock

Current: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS`
Next: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_POST_AUDIT_PASS`
