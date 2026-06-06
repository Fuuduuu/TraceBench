# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SYNC_SCOPE_LOCK`
- Mode: docs/spec-only scope lock; no runtime or schema implementation
- Next recommended pass: `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_POST_AUDIT_PASS`

## Goal

Lock the boundaries for the future `V2_EVENT_SCHEMA_SPEC_PASS`, which may document the V2 event schema/spec in detail but must not create schema files, validator code, materializer code, writer service code, UI write behavior, tests, or generated artifacts.

## Binding architecture

- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md` is the accepted architecture source for this track.
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_CLOSEOUT_PASS.md` records Claude Code / Opus `ACCEPT_AS_IS` post-audit and closeout.
- Future implementation passes must bind to these accepted docs, not chat memory.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schemas, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Future pass locked

- Future pass name: `V2_EVENT_SCHEMA_SPEC_PASS`
- Future lane: `DOCS_SPEC / EVENT_SCHEMA`
- Future mode: docs/spec only; no schema file implementation, validator code, materializer code, writer service, UI write behavior, Project ZIP change, Activity Timeline implementation, or Measure Momentum implementation.

The future pass may document only:

- common event envelope: `schema_version`, `event_id`, `event_type`, `created_at`, `project_id`, `client_operation_id`, `actor`, `source`, `confirmation`, and `payload`;
- canonical event names: `measurement_recorded`, `component_created`, `component_updated`, and `event_invalidated`;
- rejected aliases: `measurement_saved`, `component_edited`, `event_superseded` as an initial canonical event type, and `measurement_updated`;
- value provenance: `human_entered`, `human_confirmed_from_reference`, `human_confirmed_from_candidate`, non-canonical helper/reference/candidate/note context, and no helper/reference/candidate auto-fill into the confirmable measured field;
- measurement schema/spec: reading mode, value, unit, `display_value`, V / Ω / Diode / Beep primary modes, and A/current advanced by default under `Lisainfo` / `Tehnilised detailid`;
- target / Koht / pin model, including target composites, `target_key`, dotted labels such as `Q2.1 -> R17.1`, from/to measurements, and the rule that Koht or `pin_id` does not imply net identity or confirmed pin mapping;
- relation fields: `origin_event_id`, `corrects_event_id`, `supersedes_event_id`, and `invalidates_event_id`;
- correction / invalidation rules, including human-authored-only `event_invalidated`, append-only behavior, no deletion/mutation, reversal via new event only, invalidation correction/supersession, and AI/helper/renderer/import-inference invalidation rejection;
- conflict projection rules with no latest-timestamp-wins;
- v1/v1.1 legacy and mixed-version stream rules;
- imported `known_facts.json` as projection/cache with import regeneration from events.

## Locked open items to carry forward

- L1: define `corrects_event_id` vs `supersedes_event_id` precisely or collapse.
- L2: document measurement correction path as `measurement_recorded` plus `supersedes_event_id`; no `measurement_updated`.
- L3: component-invalidation orphan handling must surface dependent measurements and never silently cascade-drop.
- L4: legacy events without per-event `schema_version` are v1 baseline; mixed-version stream validation must be defined.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not author canonical events or facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage/suspect/source/research/reference/candidate/note values are not proof or probability.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.
- V2 implementation remains blocked until later individually scoped and audited passes.

## Route lock

Next recommended pass is `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_POST_AUDIT_PASS`.

Do not route directly to `V2_EVENT_SCHEMA_SPEC_PASS` until this scope lock is independently post-audited. Do not route to validator, materializer, writer service, UI writes, Project ZIP, Activity Timeline, or Measure Momentum implementation from this pass.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
