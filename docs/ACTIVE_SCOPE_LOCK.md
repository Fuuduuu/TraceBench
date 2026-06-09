# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS`

## Goal

Close out the accepted and pushed `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS`.

This pass records post-audit `ACCEPT_AS_IS`, keeps TRC-03 out of scope, and routes to the narrow Save Measurement path-canonicalization hardening implementation pass.

## Write allowlist for this closeout pass

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if needed as compact pointer
- `docs/audit/V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_CLOSEOUT_PASS.md`

Do not write outside these surfaces.

## Accepted closeout facts

- `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS` is accepted and pushed.
- Commit message: `docs: lock save measurement path canonicalization hardening scope`.
- Post-audit result: `ACCEPT_AS_IS`.
- `safe_to_commit: YES`.
- Future implementation remains limited to Save Measurement path/project-directory canonicalization hardening.
- Add Component remains deferred.
- TRC-03 remains excluded from this route.

## Next implementation boundary

`V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS` may implement only the accepted scope-lock surface:

- normalize/canonicalize project directory before deriving `events.jsonl`;
- ensure derived `events.jsonl` stays inside the selected local project directory;
- reject missing, relative, malformed, traversal-like, or non-canonical project directory inputs before writer invocation;
- use platform-safe path handling if already available or minimally introduced;
- add focused unit/widget tests for accepted and rejected path cases;
- preserve accepted writer-service validation-before-append, lock, idempotency, durable append, and readback guarantees.

## Forbidden surfaces

- No Add/Edit Component implementation.
- No deterministic `clientOperationId` UUID/ULID/random change.
- No writer service behavior change unless separately scoped and audited.
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
- No Project ZIP changes.
- No Activity Timeline implementation.
- No Measure Momentum implementation.
- No Photo Markup / Repair Map / Visual Trace Shape Assist.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation.
- No automatic second event.

## Route lock

Next recommended pass is `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS`.

Do not route to Add Component yet. Do not include TRC-03 ID-generation changes in this route.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
- artifact scan
