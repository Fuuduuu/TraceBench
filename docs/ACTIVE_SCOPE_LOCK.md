# Active Scope Lock

## Current pass

`V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout of an accepted/pushed presentation-only PCB-first shell implementation. No writer,
validator/materializer/schema/tool/runtime-surface changes are allowed in this pass.

Current goal:

- close out `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_PASS` as docs-only closeout updates.
- preserve the accepted implementation outcome and regression-history context in governance docs.
- preserve all V2 save/add/edit writer, event, sequence, and projection boundaries;
- keep Board Canvas and Reference Images availability, but in read-only modes;
- keep existing routes and redirect behavior unchanged.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only governance closeout + route-consistency verification.

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

Current: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_CLOSEOUT_PASS`
Next: `NEEDS_USER_DECISION`
