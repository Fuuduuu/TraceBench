# V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for repo-local, read-only docs and diagnostic evidence capture.

## Tool / plugin / download capability report

### Available local capabilities

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- Flutter/Dart: YES
- Python: YES
- Node/npm: YES
- browser/HTML preview capability: NOT required for this diagnosis pass
- screenshot/image inspection capability: NOT requested for this pass
- visible plugins/tools: Airtable, Browser, Build Web Apps, Canva, CircleCI, Cloudflare, CodeRabbit, Codex Security, Documents, Figma, GitHub, Gmail, Google Calendar, Google Drive, Mem, OpenAI Developers, Picsart, Presentations, Remotion, Spreadsheets, Superpowers

### Candidate tool downloads

No additional tool download is required to complete this pass.

No missing required tool was identified, so `NEEDS_TOOL_DOWNLOAD_DECISION` is not triggered.

## Startup state

- `docs/CURRENT_STATE.md` current pass was `V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS`.
- `docs/CURRENT_STATE.md` next pass was `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`.
- latest accepted route remained `V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_POST_AUDIT_PASS` as `ACCEPT_AS_IS`.
- `docs/ACTIVE_SCOPE_LOCK.md` lane was docs-only diagnosis scope with allowlist matching this pass.

## Scope drift check

PASS.

- PASS_ID exists in `docs/PASS_QUEUE.md` and is the current pass.
- scope-lock lane/type is docs-sync and this pass performs no runtime change.
- write allowlist matches: state files and `docs/audit/V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS.md`.
- no protected surfaces were changed.
- evidence-floor constraints satisfied: no invented measurements, no invented identities, no invented links.
- no unapproved code/tool/schema/materializer/writer/service/ZIP files were touched.

## Files changed

- `docs/CURRENT_STATE.md` (current/next pass routing, diagnosis pointer)
- `docs/ACTIVE_SCOPE_LOCK.md` (lock to diagnosis capture scope)
- `docs/PASS_QUEUE.md` (current/next pass and row status updates)
- `docs/AUDIT_INDEX.md` (new audit index row)
- `docs/WORK_INTAKE_INDEX.md` (`WI-060` marked diagnosis-complete and routed)
- `docs/audit/V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS.md` (new diagnosis audit artifact)

## Diagnosis capture summary

Source diagnostic input:

- Smoke project path: `C:\Users\Kasutaja\Desktop\TraceBench_ui_consolidation_smoke\ui_consolidation_project\prj_7db68402\events.jsonl`
- Observed error: `MeasurementWriteException: Existing events contain missing or non-integer sequence`
- Smoke events had no `sequence` field and were schema-valid V2 event shape.
- `schema_version = 2.0-draft`, `event_type = component_created`, event IDs `evt_000001`, `evt_000002`.
- Legacy measurement write path remained reachable:
  - `lib/app/router.dart` route `/project/measurements/new`
  - `project overview` action routes to that screen
  - screen uses legacy `MeasurementRecordScreen`
  - legacy screen uses `MeasurementEventWriter`
- Accepted V2 write path remains:
  - `/project/measure-sheet`
  - `MeasureSheetScreen`
  - `V2SaveMeasurementWriter` / `tools/event_writer_service.py`
  - no sequence requirement in V2 surface
- Validator (`tools/validate_events_jsonl.py`) accepts V2 events without sequence.

Root cause conclusion:

- High-confidence root cause is stale legacy route/write-path compatibility, not V2 schema behavior.
- Fixing this by adding sequence to V2 events is explicitly not accepted.
- Root cause recorded for `WI-060`: retire/close legacy `/project/measurements/new` write path.

## WI-060 update

- `WI-060` moved to `diagnosis-complete`.
- diagnosis wording now states:
  - stale V1 route `/project/measurements/new` still reaches legacy writer
  - legacy writer rejects sequence-less V2 events
  - route should move to legacy write-path retirement scope lock

## Route decision

- current pass: `V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS`
- next recommended pass: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`
- suggested follow-up naming:
  - `V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_CAPTURE_POST_AUDIT_PASS` (preferred), or
  - `V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_POST_AUDIT_PASS` if convention keeps one-shot naming.

## Validation result

- `py -3 tools\\validate_all.py`: PASS
- `git diff --check`: PASS
- `git status --short --branch`: PASS
- `git diff --name-only`: PASS

## Safety gate

- `safe_for_post_audit`: YES
