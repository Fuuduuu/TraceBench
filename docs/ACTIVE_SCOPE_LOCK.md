# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SCOPE_LOCK`
- Mode: docs-only scope lock
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`

## Goal

Lock the future V2 Add Component UI write-flow as the next canonical write surface after accepted Save Measurement and path/project-directory hardening.

This pass is a scope lock only. It does not implement Add Component and does not route directly to `V2_ADD_COMPONENT_PASS`.

## Write allowlist for this scope-lock pass

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/PROJECT_MEMORY.md` only if needed as compact pointer
- `docs/audit/V2_ADD_COMPONENT_SCOPE_LOCK_PASS.md`

Do not write outside these surfaces.

## Binding sources

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_CLOSEOUT_PASS.md`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`

## Locked future Add Component behavior

- Future Add Component is the next V2 canonical write surface.
- Future implementation must create only `component_created`.
- Future UI must use the accepted writer service adapter pattern.
- Future UI must never append directly to `events.jsonl`.
- Future event construction must preserve:
  - `actor.type = human`
  - `source.type = explicit_user_confirmation`
  - `confirmation.confirmed = true`
- AI/helper/reference/photo/vector/template/candidate data must not become confirmed component identity automatically.
- `template_id` / footprint / package family remains visual or geometry hint only, not electrical identity.
- Save Measurement accepted behavior must remain unchanged.

## Future implementation allowlist

Future implementation may touch only:

- minimal Add Component UI/service/provider files required for human-confirmed `component_created`
- minimal writer-adapter integration if needed
- focused Add Component widget/unit tests
- governance/audit docs

## Future implementation forbidden surfaces

Future implementation must not touch:

- Save Measurement behavior except shared safe integration if explicitly needed
- Edit Component
- Project ZIP
- Activity Timeline
- Measure Momentum
- Board Canvas write/edit
- Reference Images runtime
- AI/OCR/CV
- Photo Markup / Repair Map / Visual Trace Shape Assist
- validator behavior
- materializer behavior
- schema or JSON schema files
- `tools/event_writer_service.py` behavior unless separately scoped
- platform/generated/assets/samples/tags/releases

## Required future tests

Future implementation must include focused tests proving:

- Add button is disabled until required human-entered/confirmed component fields exist.
- Valid Add Component calls the writer once.
- Generated event is only `component_created`.
- Actor/source/confirmation are correct.
- Candidate/template/photo/helper values do not auto-confirm identity.
- Package/footprint/template hints remain hints only.
- Writer validation failure shows not saved.
- Writer append/path/lock failure shows not saved.
- Idempotent existing result does not duplicate local UI state.
- No diagnosis/probability/verified/good/correct wording is introduced.
- No Board Canvas / Reference Images / Guided Helper write path exists.
- No Project ZIP changes occur.

## Hard boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- Human is the sensor; AI is the graph engine.
- No direct UI append to `events.jsonl`.
- No schema, validator, materializer, writer-service, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, Activity Timeline, Measure Momentum, asset/sample, generated artifact, platform, tag, or release change in this scope-lock pass.
- No `board_graph.json` or `view_state.json` generation or acceptance.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation from template, footprint, package, photo, visual, reference, helper, or AI context.
- No automatic second event.

## Route lock

- Current pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`

Do not route directly to `V2_ADD_COMPONENT_PASS`.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
- artifact scan