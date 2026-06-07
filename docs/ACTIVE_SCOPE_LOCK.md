# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_SCHEMA_SPEC_PASS`
- Lane: `CODEX / DOCS_SPEC / EVENT_SCHEMA`
- Mode: docs/spec only
- Next recommended pass: `V2_EVENT_SCHEMA_SPEC_POST_AUDIT_PASS`

## Goal

Write the V2 event schema/spec documentation under the accepted `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS`, binding future schema/validator/materializer/writer/UI work to the accepted V2 event-writing architecture record without creating executable schema, validator, runtime, or test artifacts.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_SCHEMA_SPEC_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schema files, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Binding sources

- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md` remains the accepted V2 event-writing architecture source of truth.
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_CLOSEOUT_PASS.md` records the accepted architecture closeout.
- `docs/audit/V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS.md` locks this pass as docs/spec only.
- `docs/audit/V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_CLOSEOUT_PASS.md` records Claude Code / Opus `ACCEPT_AS_IS` for the scope lock and routes here.

## Spec scope

This pass may document requirements for:

- common event envelope fields,
- canonical and rejected event names,
- `schema_version` and fail-closed compatibility,
- actor/source/confirmation rules,
- `measurement_recorded`,
- `component_created`,
- `component_updated`,
- `event_invalidated`,
- value provenance,
- target / `Koht` / pin handling,
- relation fields,
- correction/supersession/invalidation behavior,
- conflict handling,
- legacy/back-compat rules,
- prohibited fields/promotions,
- requirements for later validator, materializer, and test passes.

This pass must not create schema files or implement any validator, materializer, writer, UI, ZIP, Activity Timeline, or Measure Momentum behavior.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not author canonical events or facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.
- Visual traces, photos, alignment, damage, suspect markers, source/research/reference/candidate/note values, template IDs, and footprint families are not proof of electrical facts, measurements, identity, pin maps, fault, or probability.

## Route lock

Next recommended pass is `V2_EVENT_SCHEMA_SPEC_POST_AUDIT_PASS`.

Purpose: Claude Code / Opus audit-only review of the docs/spec event schema record for architecture binding, L1-L4 handling, fail-closed compatibility, value provenance, evidence boundaries, and scope drift.

Do not route to validator implementation, materializer implementation, writer service, UI write behavior, Project ZIP changes, Activity Timeline implementation, or Measure Momentum implementation from this pass.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
