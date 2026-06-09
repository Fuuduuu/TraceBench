# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`

## Goal

Close out the accepted and pushed `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS`.

This pass records post-audit `ACCEPT_AS_IS`, `safe_to_commit: YES`, validation state, accepted implementation behavior, and the route to Add Component scope lock only.

## Write allowlist for this closeout pass

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if needed as compact pointer
- `docs/audit/V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_CLOSEOUT_PASS.md`

Do not write outside these surfaces.

## Accepted closeout facts

- `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS` is implemented, audited, accepted, and pushed.
- Commit message: `fix: harden save measurement project path handling`.
- Post-audit result: `ACCEPT_AS_IS`.
- `safe_to_commit: YES`.
- Validation recorded:
  - `flutter analyze`: baseline only.
  - Focused tests: `30/30` PASS.
  - Full Flutter suite: `226` PASS.
  - `py -3 tools\validate_all.py`: `268` PASS.

## Accepted implementation behavior

- Save Measurement path/project-directory canonicalization hardening is implemented.
- Unsafe or non-canonical project paths fail closed.
- Derived `events.jsonl` cannot escape the selected project directory.
- Python writer is not called on invalid project paths.
- Invalid path maps to a clear not-saved UI outcome.
- Accepted writer-service boundary is preserved.
- Save Measurement remains `measurement_recorded` only.
- Deterministic `clientOperationId` is unchanged; TRC-03 remains excluded.

## Forbidden surfaces

- No Add/Edit Component implementation.
- No deterministic `clientOperationId` UUID/ULID/random change.
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

Next recommended pass is `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`.

Do not route directly to Add Component implementation. Add Component is a protected canonical-write surface and must begin with a scope lock.

## Validation

- `py -3 tools\validate_all.py`
- `git diff --check`
- `git status --short --branch`
- `git diff --name-only`
- artifact scan
