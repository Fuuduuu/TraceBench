# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_PASS`
- Lane: `CODEX / FLUTTER_PASS / UI_WRITE_FLOW`
- Mode: scoped Save Measurement UI implementation only
- Next recommended pass: `V2_SAVE_MEASUREMENT_POST_AUDIT_PASS`

## Goal

Implement the first V2 UI write flow: Save Measurement.

This pass turns the existing Measure Sheet save affordance into a human-confirmed Save Measurement flow that creates a valid V2 `measurement_recorded` event and submits it through the accepted V2 event writer service.

Canonical write target remains `events.jsonl`. UI must not append directly to `events.jsonl`.

## Write allowlist

- minimal Measure Sheet / UI files required for Save Measurement
- minimal provider/service integration needed to call the accepted writer service
- focused widget/unit tests for Save Measurement
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md` if needed
- `docs/audit/V2_SAVE_MEASUREMENT_PASS.md`

Do not write outside these surfaces.

## Forbidden surfaces

Do not implement Add Component or Edit Component.

Do not modify Project ZIP logic, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist, AI trace candidates, OCR, photo overlays, component vector templates, validator behavior, materializer behavior, writer service behavior, schema files, JSON schema files, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, platform folders, tags, or release objects.

Stop if implementation requires direct `events.jsonl` append from UI/provider code or changes to the accepted Python writer service.

## Binding sources

Implementation binds to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_SCOPE_LOCK_CLOSEOUT_PASS.md`
- accepted writer service in `tools/event_writer_service.py`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`
- accepted V2 architecture record in `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`

Repo docs win over chat memory.

## Save Measurement requirements

- Save Measurement creates a canonical event only after explicit human action.
- User must enter or explicitly verify the measured value.
- Helper/reference/candidate values must not auto-populate the measured field.
- One-tap promotion of helper/reference/candidate value is forbidden.
- AI/helper must not author events.
- UI must create only `measurement_recorded`.
- UI must call the accepted writer service and must not append directly to `events.jsonl`.
- UI must not bypass validator-before-append.
- UI must respect `client_operation_id` idempotency.
- UI must handle writer errors without pretending save succeeded.
- Event construction must include `schema_version`, `event_id`, `event_type`, `created_at`, `project_id`, `client_operation_id`, `actor`, `source`, `confirmation`, `payload`, `measurement_id`, `measured_at`, `target`, `reading`, and `value_provenance`.
- Event construction must use `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Reading must include mode, value or state, unit, and `display_value`.
- Primary units are `V` / `Ω` / `Diode` / `Beep`.
- Invalid mode/unit combinations must not be submitted.
- Selected `Koht` / target context must be preserved without implying net identity or confirmed pin mapping.
- Error states must distinguish validation failure, writer append failure, lock conflict, idempotent duplicate retry, and projection-refresh failure if later shown.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation.
- No automatic second event.
- No Add/Edit Component.
- No Project ZIP changes.
- No Activity Timeline implementation.
- No Measure Momentum implementation.
- Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, and Activity Timeline remain read-only/non-writing surfaces.

## Route lock

Next recommended pass is `V2_SAVE_MEASUREMENT_POST_AUDIT_PASS`.

Purpose: independent audit-only review of the Save Measurement UI write-flow implementation before any follow-up route opens.

Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- focused Save Measurement tests
- relevant Flutter/widget tests for changed Flutter files
- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
