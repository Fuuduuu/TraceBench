# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`

## Goal

Close out the accepted and pushed `V2_SAVE_MEASUREMENT_PASS` implementation.

This pass records GPT Pro substitute post-audit acceptance, final validation state, and the accepted Save Measurement write-flow boundaries. It does not implement code or open any new write surface.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only for compact durable pointer correction
- `docs/audit/V2_SAVE_MEASUREMENT_CLOSEOUT_PASS.md`

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

## Accepted closeout facts

- `V2_SAVE_MEASUREMENT_PASS` was implemented, audited, accepted, committed, and pushed as `feat: add V2 save measurement flow`.
- GPT Pro substitute post-audit recheck returned `ACCEPT_AS_IS` and `safe_to_commit: YES`.
- Prior HIGH findings were fixed: event type is hard-enforced to `measurement_recorded`, and idempotent existing writer results do not duplicate local `ProjectState.events`.
- Save Measurement is the first accepted V2 UI write-flow.
- Save Measurement creates only `measurement_recorded` through the accepted writer service adapter.
- UI does not append directly to `events.jsonl`.
- Writer service remains responsible for validation-before-append, lock handling, idempotency, durable append, and readback.
- Event construction preserves `schema_version = 2.0-draft`, `actor.type = human`, `source.type = explicit_user_confirmation`, `confirmation.confirmed = true`, and `value_provenance`.
- Helper/reference/candidate values do not auto-fill the measured field.
- One-tap promotion remains forbidden.
- Error states distinguish not-saved outcomes.
- Existing idempotent writer results do not duplicate local `ProjectState.events`.
- Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, and Activity Timeline remain read-only/non-writing surfaces.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- No Add/Edit Component opened.
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

Reason: Save Measurement write-flow is accepted. The next V2 canonical-write surface should be Add Component, but Add Component is a protected write surface and must start with scope lock, not implementation.

Do not route directly to `V2_ADD_COMPONENT_PASS`, Edit Component, Project ZIP, Activity Timeline, Measure Momentum, Photo Markup, or Repair Map.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
