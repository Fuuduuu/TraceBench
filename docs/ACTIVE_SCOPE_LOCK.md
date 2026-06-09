# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS`
- Lane: `CODEX / SMALL_HARDENING_IMPL`
- Mode: narrow Save Measurement path/project-directory canonicalization hardening
- Next recommended pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_POST_AUDIT_PASS`

## Goal

Implement the accepted Save Measurement path/project-directory canonicalization hardening scope lock.

This pass hardens only `V2SaveMeasurementService` / Save Measurement project-directory path handling so derived `events.jsonl` cannot escape the selected local project directory and unsafe project-directory inputs fail closed before writer invocation.

## Write allowlist for this implementation pass

Implementation and tests:

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `lib/features/measure_sheet/screens/measure_sheet_screen.dart` only for not-saved error mapping
- `test/unit/v2_save_measurement_writer_test.dart`
- `test/widget/measure_sheet_screen_test.dart`

Governance/audit:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS.md`

Do not write outside these surfaces.

## Required implementation behavior

- Normalize/canonicalize project directory before deriving `events.jsonl`.
- Ensure derived `events.jsonl` stays inside the selected local project directory.
- Reject missing, relative, malformed, traversal-like, or non-canonical project-directory inputs before writer invocation.
- Do not call the Python writer when path validation fails.
- Map path validation failure to a clear not-saved UI outcome if UI mapping is needed.
- Preserve accepted writer-service validation-before-append, lock, idempotency, durable append, and readback guarantees.
- Preserve Save Measurement event construction as `measurement_recorded` only.
- Preserve deterministic `clientOperationId`; TRC-03 remains explicitly out of scope.

## Required tests

- Normal local project directory still saves.
- Missing project directory remains not-saved.
- Traversal-like `projectDirectory` is rejected.
- `events.jsonl` cannot escape the selected project directory.
- Canonicalized path is used for writer invocation.
- Writer is not called when path validation fails.
- Error maps to not-saved outcome.
- Save Measurement still emits only `measurement_recorded`.
- Existing idempotent writer result still does not duplicate local `ProjectState.events`.

## Forbidden surfaces

- No Add/Edit Component implementation.
- No deterministic `clientOperationId` UUID/ULID/random change.
- No writer service contract change beyond Save Measurement path validation before invocation.
- No validator behavior change.
- No materializer behavior change.
- No schema files or JSON schema change.
- No Project ZIP import/export change.
- No Board Canvas change.
- No Reference Images change.
- No AI/OCR/CV change.
- No Activity Timeline change.
- No Measure Momentum change.
- No broad filesystem refactor.
- No app-wide storage architecture change.
- No platform folder, generated artifact, asset, sample, tag, or release change.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- UI uses the accepted writer service adapter and never appends directly to `events.jsonl`.
- No Project ZIP changes.
- No Activity Timeline implementation.
- No Measure Momentum implementation.
- No Photo Markup / Repair Map / Visual Trace Shape Assist.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation.
- No automatic second event.

## Route lock

Next recommended pass is `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_POST_AUDIT_PASS`.

Do not route to Add Component yet. Do not include TRC-03 ID-generation changes in this route.

## Validation

- dart format on changed Dart files
- dart analyze changed Dart files
- `flutter test test\widget\measure_sheet_screen_test.dart test\unit\v2_save_measurement_writer_test.dart --reporter expanded`
- `flutter test --reporter expanded`
- `py -3 tools\validate_all.py`
- `git diff --check`
- `git status --short --branch`
- `git diff --name-only`
