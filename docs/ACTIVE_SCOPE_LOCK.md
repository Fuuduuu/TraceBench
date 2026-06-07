# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SYNC_SCOPE_LOCK`
- Mode: docs-only scope lock for the future V2 Save Measurement implementation pass
- Next recommended pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_POST_AUDIT_PASS`

## Goal

Lock the scope for future `V2_SAVE_MEASUREMENT_PASS`.

This pass defines what the future Save Measurement implementation is allowed to do:

- turn the read-only Measure Sheet save affordance into a real human-confirmed Save Measurement flow,
- create a valid V2 `measurement_recorded` event,
- submit it through the accepted V2 event writer service,
- preserve the technician-first workflow and evidence boundaries.

This pass does not implement UI or event-writing behavior.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact pointer is needed
- `docs/audit/V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS.md`

Do not write outside these files.

## Forbidden surfaces

Do not modify Flutter UI, writer service, validator, materializer, schema files, JSON schema files, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, tests, assets, samples, generated artifacts, platform folders, tags, or release objects.

Do not implement UI writes. Do not route directly to `V2_SAVE_MEASUREMENT_PASS` until this scope lock is post-audited. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

Do not reinterpret Save Measurement rules from chat memory.

## Binding sources

Future Save Measurement implementation must bind to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- accepted writer service in `tools/event_writer_service.py`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`
- accepted V2 architecture record in `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`

## Future implementation scope

Future pass:

`V2_SAVE_MEASUREMENT_PASS`

Future lane:

`FLUTTER_PASS / UI_WRITE_FLOW`

Future mode:

Scoped implementation of Save Measurement UI flow only.

Future implementation may touch only:

- minimal Measure Sheet / UI files required for Save Measurement,
- minimal provider/service integration needed to call the accepted writer service,
- focused widget/unit tests for Save Measurement,
- docs/governance/audit files,
- accepted UI fixtures if needed.

Any need to touch validator, materializer, writer service behavior, schema files, JSON schema files, Project ZIP import/export, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Save Measurement requirements

- Save Measurement creates a canonical event only after explicit human action.
- The user must enter or explicitly verify the measured value.
- Helper/reference/candidate values must not auto-populate the confirmable measured field.
- One-tap confirmation of suggested/reference/candidate values is forbidden.
- AI/helper must not author events.
- Future Save Measurement must produce only `measurement_recorded`.
- Future UI must submit the candidate event through the accepted V2 writer service and must not append directly to `events.jsonl`.
- Future UI must not bypass validator-before-append and must respect `client_operation_id` idempotency.
- Future UI must handle writer errors without pretending a failed save succeeded.
- Future event construction must include the required common V2 envelope and `measurement_recorded` payload fields from the accepted spec.
- Future event must use `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Primary units remain `V` / `Ω` / `Diode` / `Beep`; `A`/current remains advanced by default under `Lisainfo` / `Tehnilised detailid`.
- Reading must include mode, value or state, unit, and `display_value`.
- Future UI must preserve selected `Koht` / target context while not implying net identity or confirmed pin mapping.
- Value provenance must distinguish `human_entered`, `human_confirmed_from_reference`, and `human_confirmed_from_candidate` from non-canonical context values.
- After writer success the UI may show confirmation, keep selected `Koht`/context, and optionally suggest a next point as workflow aid only.
- Error states must distinguish validation failure, writer append failure, lock conflict, idempotent duplicate retry, and any later projection-refresh failure.
- Save Measurement must not turn Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, or Activity Timeline into write surfaces.

## Future tests to lock

Future implementation must include focused tests for:

- Save button disabled until required human-entered/verified fields exist.
- Valid Save Measurement calls writer once.
- Generated event is `measurement_recorded`.
- Actor/source/confirmation fields are correct.
- `value_provenance` is preserved.
- Helper/reference/candidate values do not auto-fill measured value.
- One-tap suggested value promotion is forbidden.
- Writer validation failure shows not saved.
- Writer append failure shows not saved.
- Lock conflict shows retryable/clear error.
- Idempotent duplicate retry does not duplicate.
- Selected `Koht`/context remains after successful save.
- No diagnosis/probability/verified/good/correct wording.
- No Board Canvas / Reference Images / Guided Helper write path.
- No Project ZIP changes.

## Route lock

Next recommended pass is `V2_SAVE_MEASUREMENT_SCOPE_LOCK_POST_AUDIT_PASS`.

Purpose: independent audit-only review of this docs-only Save Measurement scope lock.

Do not route directly to `V2_SAVE_MEASUREMENT_PASS` until this scope lock is accepted by post-audit. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
