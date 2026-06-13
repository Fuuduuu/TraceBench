# V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SMOKE_CLOSEOUT_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only smoke closeout because runtime route-remediation was implemented, committed, pushed, and this pass only records manual evidence plus state/queue/audit ledger updates.

## Tool / plugin / download capability report

Available local capabilities:

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- Python: YES
- Flutter/Dart: YES
- Node/npm: YES
- browser/HTML preview capability: not needed for this pass
- local plugin/app list in context: Airtable, Browser, Build Web Apps, CircleCI, Cloudflare, CodeRabbit, Codex Security, Documents, Figma, GitHub, Gmail, Google Calendar, Google Drive, Mem, OpenAI Developers, Picsart, Presentations, Remotion, Spreadsheets, Superpowers.

No additional tools/plugins/downloads were required; no install/update was performed.

## Scope drift check

PASS. This pass writes only the explicitly allowed files:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SMOKE_CLOSEOUT_PASS.md`

No files were changed under runtime, schema, validator, materializer, writer service, Project ZIP, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, assets, samples, generated artifacts, tests, or platform folders.

## Manual smoke status

Result: `PASS_WITH_ENVIRONMENT_LIMITATION`.

- Observed environment:
  - Save was attempted while project was not opened from a local folder.
- Observed route behavior:
  - Project Overview action `Lisa mõõtmine` opens V2 measure-sheet flow.
  - `/project/measurements/new` resolves through the compatibility redirect to `/project/measure-sheet`.
  - `MeasurementRecordScreen` was not observed in the standard save flow.
- Save result:
  - `"Not saved: project must be opened from a local folder."`
- Observed evidence scope:
  - Legacy writer reachability was not demonstrated in normal flow.
  - Legacy-sequence exception evidence (`missing/non-integer sequence`) was not observed in this run.
  - `events.jsonl` and `known_facts.json` append/persistence evidence was not proven due the local-folder limitation.

Recorded smoke marker:

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SMOKE_PASS = PASS_WITH_ENVIRONMENT_LIMITATION`.

## Preservation checks

- Runtime implementation acceptance remains:
  - `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS` accepted via
    `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_RECHECK_PASS` (`ACCEPT_AS_IS`, `safe_to_commit: YES`).
  - commit `f49bd63 fix: retire legacy measurement write path`.
- Compatibility route remains:
  - `/project/measurements/new` -> `/project/measure-sheet`
  - `Lisa mõõtmine` -> `/project/measure-sheet`
- No `sequence` field was added to V2 events in this route-remediation path.
- No changes were introduced in this closeout to:
  - event model/schema/validator/materializer
  - writer service/runtime code
  - Project ZIP

## Backlog candidate

Non-blocking follow-up candidate remains:

- `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS`
  (Save Measurement duplicated unit controls).

## Route decision

Current pass: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SMOKE_CLOSEOUT_PASS`.

Next recommended pass: `NEEDS_USER_DECISION`.

## Validation result

- `git diff -- docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/AUDIT_INDEX.md docs/WORK_INTAKE_INDEX.md docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SMOKE_CLOSEOUT_PASS.md`
- `git diff --check`
- `git status --short --branch`

All closeout commands complete.
