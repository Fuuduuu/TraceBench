# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_GEMINI_SECURITY_TRIAGE_PASS`
- Lane: `CODEX / DOCS_TRIAGE`
- Mode: docs-only security triage
- Next recommended pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS`

## Goal

Capture and triage external Gemini audit findings after the accepted and closed-out `V2_SAVE_MEASUREMENT_PASS`.

This pass records advisory findings only. It does not implement code, change runtime behavior, modify tests, or open a new write surface.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if needed for compact durable pointer
- `docs/audit/V2_SAVE_MEASUREMENT_GEMINI_SECURITY_TRIAGE_PASS.md`

Do not write outside these surfaces.

## Forbidden surfaces

- Flutter runtime behavior
- tests
- writer service
- validator
- materializer
- schema files
- Project ZIP logic
- Board Canvas
- Reference Images
- AI/OCR/CV
- Activity Timeline
- Measure Momentum
- Add/Edit Component
- assets
- samples
- platform folders
- generated artifacts
- tags
- releases

## Triage facts

- Gemini audit is external advisory input, not a repo-local post-audit gate.
- Gemini overall verdict: `SAFE_TO_CONTINUE`.
- Gemini does not invalidate accepted `V2_SAVE_MEASUREMENT_PASS`.
- TRC-01 MEDIUM: project-directory/path construction risk in `V2SaveMeasurementService` / `_joinPath`; classify as candidate hardening work.
- TRC-02 LOW: external Python writer service invoked via OS process; process args are safer than shell strings, but permissions and command boundary should remain explicit.
- TRC-03 LOW/design-sensitive: deterministic `clientOperationId`; do not blindly replace with UUID/ULID before idempotency/retry semantics are reviewed.
- TRC-04 INFO: reading value/string input should remain centrally validated and safely encoded downstream.

## Route lock

Next recommended pass is `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS`.

Reason: TRC-01 is MEDIUM and concerns the project path boundary for the first accepted V2 write-flow. Insert a narrow hardening scope lock before opening Add Component.

Add Component remains the intended next V2 write surface after this hardening decision path, but do not route directly to `V2_ADD_COMPONENT_PASS` or implementation.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- No Add/Edit Component implementation.
- No Project ZIP changes.
- No Activity Timeline implementation.
- No Measure Momentum implementation.
- No Photo Markup / Repair Map / Visual Trace Shape Assist.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation.
- No automatic second event.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
