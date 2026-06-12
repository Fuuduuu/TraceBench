# V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Repository-local Codex execution is appropriate for this docs-only scope-lock pass and routing transition.

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Tool / plugin / download capability report

### Available local capabilities

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- Flutter/Dart: YES
- Python: YES
- Node/npm: YES
- browser/HTML preview capability: NOT REQUIRED
- screenshot/image inspection capability: NOT REQUIRED
- visible plugins/tools: Airtable, Browser, Build Web Apps, CircleCI, Cloudflare, CodeRabbit, Codex Security, Documents, Figma, GitHub, Gmail, Google Calendar, Google Drive, Mem, OpenAI Developers, Picsart, Presentations, Remotion, Spreadsheets, Superpowers

### Candidate tool downloads

- No additional tool downloads are required for this docs-only scope lock pass.
- No install/enable/enablement action is needed.
- No missing tool is blocking.

## Startup state

- `docs/CURRENT_STATE.md` previously set current pass to `V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md` was in diagnosis-capture mode and `docs/PASS_QUEUE.md` routed next to `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`.
- `docs/WORK_INTAKE_INDEX.md` contains `WI-060` as diagnosis-complete with routing to legacy path retirement.
- New lock pass `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS` is now active.

## Scope drift check

PASS.

- PASS_ID exists in `docs/PASS_QUEUE.md`.
- Active scope lock current pass and next recommendations are aligned in both `docs/CURRENT_STATE.md` and `docs/ACTIVE_SCOPE_LOCK.md`.
- Current write allowlist matches this pass objective:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/WORK_INTAKE_INDEX.md`
  - `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS.md`
- No protected surfaces are changed in this pass.
- Evidence-floor checks passed: no new measurements/components/nets/AI facts were invented.
- Validation command family for docs-only scope lock is defined and executed.
- No forbidden runtime/tool/schema/materializer/writer/service/filesystem surfaces were modified.

## Files changed

- `docs/CURRENT_STATE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS.md`

## Scope lock summary

- This pass locks a narrow future implementation path for retiring stale V1 write-path compatibility in V2 projects.
- Confirmed legacy flow remains active: `/project/measurements/new -> MeasurementRecordScreen -> MeasurementEventWriter`.
- Confirmed accepted V2 flow remains: `/project/measure-sheet -> MeasureSheetScreen -> V2SaveMeasurementWriter -> tools/event_writer_service.py`.
- This lock is intentionally compatibility-only; it does not implement runtime changes yet.
- This lock must close before continuing broader Save Measurement UI flow fixes or unit-selection cleanup.

## Diagnosis basis

- Prior diagnosis pass logged that valid V2 smoke events omitted `sequence`.
- The same smoke run failed with `MeasurementWriteException: Existing events contain missing or non-integer sequence`.
- Validator accepts V2 sequence-less events; legacy writer rejects those events under its sequence guard.
- Root cause is stale legacy route reachability, not V2 event payload shape.

## Future implementation allowlist

The next implementation pass may:

- remove or redirect `/project/measurements/new` to `/project/measure-sheet`
- update Project Overview measurement action route to the V2 measure-sheet path
- retire or isolate `MeasurementRecordScreen` where no longer reachable in normal V2 flow
- retire or isolate `MeasurementEventWriter` if no longer needed by active routes
- add focused route/widget tests covering:
  - positive path: Project Overview -> measure-sheet path for V2 projects
  - negative path: legacy `/project/measurements/new` unreachable from normal Project Overview flow

No V2 event-construction change is part of this scope.

## Forbidden surfaces

- runtime code outside locked route-remediation area
- `lib/**` and `test/**` changes are forbidden unless explicitly allowlisted in the future route-remediation implementation pass for this scope.
- `lib/**` and `test/**` files outside the allowlist are forbidden in future implementation.
- `schemas/**`, `samples/**`, `assets/**`, generated files, platform files, tags/releases
- writer service behavior changes
- validator changes
- materializer changes
- Project ZIP contract
- Board Canvas write/edit runtime
- Reference Images runtime
- AI/OCR/CV paths
- Activity Timeline
- Measure Momentum
- Photo Markup
- Repair Map
- Visual Trace Shape Assist
- broader Add Component redesign
- Save Measurement unit-selection redesign
- PCB-first Project Overview redesign
- do not add `sequence` to V2 events to satisfy legacy `MeasurementEventWriter`
- do not change accepted V2 event model to support legacy writer expectations
- the defect is stale legacy route/writer reachability, not V2 event sequence semantics

## WI-060 handling

- `WI-060` remains `diagnosis-complete` in `docs/WORK_INTAKE_INDEX.md`.
- It is not marked closed in this pass.
- This pass explicitly routes WI-060 remediation toward implementation + post-audit.

## Route decision

- Current pass set to `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`.
- Next recommended pass is `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_POST_AUDIT_PASS`.

## Validation result

- `py -3 tools\validate_all.py`: PASS
- `git diff --check`: PASS
- `git status --short --branch`: PASS
- `git diff --name-only`: PASS

## safe_for_post_audit

YES
