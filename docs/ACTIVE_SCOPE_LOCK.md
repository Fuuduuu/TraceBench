# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout for the accepted V2 Save Measurement scope lock
- Next recommended pass: `V2_SAVE_MEASUREMENT_PASS`

## Goal

Close out the accepted and pushed `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`.

Record that:

- `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS` was accepted/pushed as `docs: lock V2 save measurement scope`,
- Claude Code / Opus post-audit returned `ACCEPT_AS_IS`,
- no blocker/high/medium/low findings were reported,
- validation passed with `py -3 tools\validate_all.py`, 268 tests,
- future `V2_SAVE_MEASUREMENT_PASS` remains blocked until this closeout is accepted.

This pass does not implement Save Measurement UI behavior or event-writing behavior.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact pointer is needed
- `docs/audit/V2_SAVE_MEASUREMENT_SCOPE_LOCK_CLOSEOUT_PASS.md`

Do not write outside these files.

## Forbidden surfaces

Do not implement Flutter UI, Save Measurement, writer service changes, validator, materializer, schema files, JSON schema files, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, tests, assets, samples, generated artifacts, platform folders, tags, or release objects.

Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

Do not reinterpret Save Measurement rules from chat memory.

## Binding sources

Future Save Measurement implementation must bind to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- accepted writer service in `tools/event_writer_service.py`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`
- accepted V2 architecture record in `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted scope lock in `docs/audit/V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS.md`

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

- Future Save Measurement must produce only `measurement_recorded`.
- Future UI must submit the candidate event through the accepted V2 writer service.
- Future UI must never append directly to `events.jsonl`.
- Future UI must not bypass validator-before-append and must respect `client_operation_id` idempotency.
- Save Measurement creates a canonical event only after explicit human action.
- Future event must use `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Value provenance must distinguish `human_entered`, `human_confirmed_from_reference`, and `human_confirmed_from_candidate` from non-canonical context values.
- Helper/reference/candidate values must not auto-populate the confirmable measured field.
- One-tap confirmation of suggested/reference/candidate values is forbidden.
- Reading must include mode, value or state, unit, and `display_value`.
- Primary units remain `V` / `Ω` / `Diode` / `Beep`; `A`/current remains advanced by default under `Lisainfo` / `Tehnilised detailid`.
- Future UI must preserve selected `Koht` / target context while not implying net identity or confirmed pin mapping.
- Future UI must handle writer errors without pretending a failed save succeeded.
- Error states must distinguish validation failure, writer append failure, lock conflict, idempotent duplicate retry, and any later projection-refresh failure.
- After writer success the UI may show confirmation, keep selected `Koht`/context, and optionally suggest a next point as workflow aid only.
- Save Measurement must not turn Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, or Activity Timeline into write surfaces.

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

## Route lock

Next recommended pass is `V2_SAVE_MEASUREMENT_PASS`.

Purpose: first UI write-flow implementation using the accepted V2 writer service.

Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
