# Active Scope Lock

## Current pass

`V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_PASS`

## Type

`FLUTTER_IMPLEMENTATION`

## Lane

`CODEX / FLUTTER_IMPLEMENTATION_PASS`

## Mode

Narrow Flutter implementation pass for presentation-only shell composition. No writer,
validator/materializer/schema/tool/runtime-surface changes are allowed in this pass.

Current goal:

- implement `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_PASS` as a presentation-only
  PCB-first Project Overview shell with `Lisa mõõtmine` dominant.
- preserve all V2 save/add/edit writer, event, sequence, and projection boundaries;
- preserve all existing route behavior outside this shell plan;
- keep Board Canvas and Reference Images availability, but in read-only modes;
- ensure Board/PCB status and stale projection messaging remain visible and read-only.

## Next recommended pass

`V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_POST_AUDIT_PASS`

## Scope decision

- scope type: `FLUTTER_IMPLEMENTATION`
- lane: `CODEX / FLUTTER_IMPLEMENTATION_PASS`
- mode: narrow widget/UI implementation + scoped route-preserving tests.

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
- governance updates required for current/pass routing

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

Current: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_PASS`
Next: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_POST_AUDIT_PASS`
