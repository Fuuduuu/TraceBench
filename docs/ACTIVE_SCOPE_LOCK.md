# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_VALIDATOR_EXTENSION_PASS`
- Lane: `CODEX / VALIDATOR_PASS`
- Mode: scoped validator implementation for accepted V2 event schema/spec requirements
- Next recommended pass: `V2_VALIDATOR_EXTENSION_POST_AUDIT_PASS`

## Goal

Implement only the first executable V2 validator support required by `docs/spec/V2_EVENT_SCHEMA_SPEC.md` and the accepted validator scope lock.

This pass is limited to the existing event validator and focused validator tests. It does not create schema files or implement materializer, writer service, UI write behavior, Project ZIP changes, Activity Timeline, or Measure Momentum.

## Write allowlist

- `tools/validate_events_jsonl.py`
- `tests/test_validate_events_jsonl.py`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_VALIDATOR_EXTENSION_PASS.md`

## Forbidden surfaces

Do not modify Flutter UI, materializer, writer service, Project ZIP import/export logic beyond existing validator checks, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, assets, samples, platform folders, tags, release objects, schema files, or JSON schema files.

Do not implement Save Measurement, Add Component, Edit Component, Activity Timeline, or Measure Momentum.

## Binding sources

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_VALIDATOR_EXTENSION_SCOPE_LOCK_CLOSEOUT_PASS.md`
- `docs/audit/V2_EVENT_SCHEMA_SPEC_PASS.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- `docs/PROTECTED_SURFACES.md`

Repo docs win over chat memory.

## Implemented validator scope

`V2_VALIDATOR_EXTENSION_PASS` validates only the accepted V2 event schema/spec requirements in the existing JSONL validator:

- common V2 event envelope fields,
- supported validator schema version `2.0-draft`,
- canonical event type allowlist and rejected aliases,
- actor/source/confirmation rules,
- fail-closed unsupported schema/event behavior,
- V1/V1.1 no-per-event-schema legacy baseline,
- `measurement_recorded` payload, reading mode/unit pairs, and value provenance,
- target / `Koht` / pin composite shape including dotted and point-to-point labels,
- `component_created`,
- `component_updated`,
- `event_invalidated`,
- relation field existence and self-cycle rejection where detectable,
- prohibited canonical fields/promotions,
- Reference Images/local sidecar remaining non-canonical and not validator authority.

Existing Project ZIP validator behavior continues to reject `board_graph.json` and `view_state.json`; this pass did not change ZIP logic.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not author canonical events or facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage, suspect, source, research, reference, candidate, and note values are not proof or probability.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.
- Activity Timeline and Measure Momentum implementation remain deferred.

## Route lock

Next recommended pass is `V2_VALIDATOR_EXTENSION_POST_AUDIT_PASS`.

Purpose: independent Claude Code / Opus audit-only review of this validator implementation.

Do not route to materializer, writer service, UI writes, Save/Add/Edit, Project ZIP changes, Activity Timeline, or Measure Momentum from this pass.

## Validation

- `py -3 -m unittest tests.test_validate_events_jsonl.ValidateV2EventsJsonlTests -v`
- `py -3 -m unittest tests.test_validate_events_jsonl -v`
- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
