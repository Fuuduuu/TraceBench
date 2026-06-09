# V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS

## Pass

- PASS_ID: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS`
- Lane: `CODEX / SMALL_HARDENING_IMPL`
- Type: implementation
- Current route input: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_CLOSEOUT_PASS`
- Next recommended pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_POST_AUDIT_PASS`

## Scope

Implement the accepted Save Measurement path/project-directory canonicalization hardening scope lock.

Allowed implementation surface:

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `lib/features/measure_sheet/screens/measure_sheet_screen.dart` only for not-saved error mapping
- `test/unit/v2_save_measurement_writer_test.dart`
- `test/widget/measure_sheet_screen_test.dart`

Governance updates:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS.md`

## Implementation summary

- Added project-directory path validation before Python discovery and writer invocation.
- Added canonical project-directory resolution before deriving `events.jsonl`.
- Added fail-closed rejection for relative, traversal-like, missing, malformed, non-directory, link-backed `events.jsonl`, or directory-backed `events.jsonl` paths.
- Ensured writer invocation receives the canonicalized `events.jsonl` path.
- Added `invalidProjectDirectory` failure kind.
- Mapped invalid project path failures to a clear not-saved UI outcome: `Not saved: project path is invalid.`
- Preserved Save Measurement write behavior through the accepted writer service adapter.

## Path canonicalization behavior

- `projectState.projectDirectory` must be present and non-empty.
- The project path must be an absolute local path.
- Raw traversal segments (`..`) are rejected before canonicalization.
- The project path must resolve to an existing directory.
- `events.jsonl` is derived only from the canonical project directory and static filename.
- Existing `events.jsonl` may not be a link or directory.
- The derived `events.jsonl` parent must canonicalize back to the selected project directory.
- Unsafe path validation failures occur before Python discovery or writer process invocation.

## Tests added or updated

- Normal local project directory save behavior remains covered.
- Canonicalized project path is used for writer invocation.
- Missing project directory path is rejected before writer invocation.
- Relative project directory path is rejected before writer invocation.
- Traversal-like project directory path is rejected so `events.jsonl` cannot escape the selected project directory.
- Non-canonical project directory path is rejected before writer invocation.
- Invalid project directory error maps to not-saved UI copy.
- Existing coverage remains for hard-coded `measurement_recorded` event type.
- Existing coverage remains for idempotent writer results not duplicating local `ProjectState.events`.

## Explicit exclusions

- No deterministic `clientOperationId` change; TRC-03 remains excluded.
- No Add/Edit Component implementation.
- No Project ZIP changes.
- No validator changes.
- No materializer changes.
- No schema or JSON schema changes.
- No Board Canvas changes.
- No Reference Images changes.
- No AI/OCR/CV changes.
- No Activity Timeline changes.
- No Measure Momentum changes.
- No assets, samples, platform folders, generated artifacts, tags, or release changes.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- UI never appends directly to `events.jsonl`; the accepted writer service remains responsible for validation-before-append, lock handling, idempotency, durable append, and readback.
- Save Measurement creates only `measurement_recorded`.
- No automatic second event is introduced.

## Validation plan

- dart format on changed Dart files
- dart analyze changed Dart files
- `flutter test test\widget\measure_sheet_screen_test.dart test\unit\v2_save_measurement_writer_test.dart --reporter expanded`
- `flutter test --reporter expanded`
- `py -3 tools\validate_all.py`
- `git diff --check`
- `git status --short --branch`
- `git diff --name-only`
