# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_ADD_COMPONENT_SCOPE_LOCK_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_ADD_COMPONENT_PASS`

## Goal

Close out the accepted and pushed `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`.

This pass records post-audit `ACCEPT_AS_IS`, `safe_to_commit: YES`, preserves the Add Component identity/hint boundary, and routes next to `V2_ADD_COMPONENT_PASS`.

## Write allowlist for this closeout pass

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if needed as compact pointer
- `docs/audit/V2_ADD_COMPONENT_SCOPE_LOCK_CLOSEOUT_PASS.md`

Do not write outside these surfaces.

## Accepted closeout facts

- `V2_ADD_COMPONENT_SCOPE_LOCK_PASS` is accepted, post-audited, pushed, and ready to close out.
- Scope-lock commit message: `docs: lock V2 add component scope`.
- Post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit: YES`.
- Add Component may proceed next only through `V2_ADD_COMPONENT_PASS`.

## Preserved future implementation boundary

- Future Add Component creates only `component_created`.
- Future UI must use the accepted writer-service adapter pattern.
- Future UI must never append directly to `events.jsonl`.
- Human confirmation is required.
- Future event construction must preserve:
  - `actor.type = human`
  - `source.type = explicit_user_confirmation`
  - `confirmation.confirmed = true`
- Template, footprint, package, photo, helper, candidate, vector, and AI context remain hints/context only.
- No automatic component identity confirmation.
- `template_id` / footprint / package family remains visual or geometry hint only, not electrical identity.
- Save Measurement accepted behavior remains unchanged.

## Forbidden routes and surfaces

Do not route this closeout to:

- Edit Component
- Project ZIP
- Activity Timeline
- Measure Momentum
- Photo Markup
- Repair Map
- Visual Trace Shape Assist
- AI/OCR/CV

Do not modify:

- runtime code
- tests
- schemas or JSON schemas
- validators
- materializers
- writer service
- Project ZIP logic
- Board Canvas runtime
- Reference Images runtime
- assets or samples
- generated artifacts
- platform folders
- tags or releases

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- Human is the sensor; AI is the graph engine.
- No direct UI append to `events.jsonl`.
- No `board_graph.json` or `view_state.json` generation or acceptance.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation from template, footprint, package, photo, visual, reference, helper, candidate, or AI context.
- No automatic second event.

## Route lock

- Current pass: `V2_ADD_COMPONENT_SCOPE_LOCK_CLOSEOUT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_PASS`

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
- artifact scan