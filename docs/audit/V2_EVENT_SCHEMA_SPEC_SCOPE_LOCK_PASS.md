# V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs/spec-only scope lock. The accepted V2 event-writing architecture has already gone through GPT Pro architecture review and Claude Code / Opus post-audit. This pass does not implement schemas, validators, materializers, writer services, UI writes, Project ZIP behavior, tests, generated artifacts, or runtime behavior.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `9db4f50 docs: close out V2 event-writing architecture`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_CLOSEOUT_PASS`, next `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS`.

## Scope drift check

PASS. This pass is docs-only and updates only governance/state/intake/deferred docs plus this audit record. It does not modify runtime code, Flutter runtime, tests, schemas, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. The scope for the future `V2_EVENT_SCHEMA_SPEC_PASS` is locked as docs/spec only.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because no new stable product invariant was needed beyond the existing compact V2 architecture pointer.

## Event schema/spec scope locked

Future pass:

- PASS_ID: `V2_EVENT_SCHEMA_SPEC_PASS`
- Lane: `DOCS_SPEC / EVENT_SCHEMA`
- Mode: docs/spec only.

The future schema/spec pass may document the locked event shape and requirements, but it must not create schema files, JSON schema files, validator implementation, materializer implementation, writer service code, UI write behavior, tests, Project ZIP behavior, generated artifacts, or runtime behavior.

## Allowed future schema/spec documentation

The future `V2_EVENT_SCHEMA_SPEC_PASS` may document:

- common event envelope fields: `schema_version`, `event_id`, `event_type`, `created_at`, `project_id`, `client_operation_id`, `actor`, `source`, `confirmation`, and `payload`;
- canonical event names: `measurement_recorded`, `component_created`, `component_updated`, and `event_invalidated`;
- rejected aliases: `measurement_saved`, `component_edited`, `event_superseded` as an initial canonical event type, and `measurement_updated`;
- value provenance: `human_entered`, `human_confirmed_from_reference`, `human_confirmed_from_candidate`, helper/reference/candidate/note context remains non-canonical, and helper/reference/candidate values must not auto-populate the confirmable measured field;
- measurement schema/spec, including reading mode, value, unit, `display_value`, V / Ω / Diode / Beep primary modes, and A/current advanced by default under `Lisainfo` / `Tehnilised detailid`;
- target / Koht / pin model, including target composite, `target_key`, display label, known `component_id`, known `pin_id`, from/to point-to-point targets, and dotted labels such as `Q2.1 -> R17.1`;
- rule that Koht does not imply net identity and `pin_id` does not imply confirmed pin mapping;
- relation fields: `origin_event_id`, `corrects_event_id`, `supersedes_event_id`, and `invalidates_event_id`;
- correction / invalidation rules: `event_invalidated` is human-authored only, append-only, no deletion/mutation, reversal via new event only, invalidation can itself be corrected/superseded, and validator rules reject AI/helper/renderer/import-inference invalidation;
- conflict rules with no latest-timestamp-wins;
- legacy/back-compat rules for v1/v1.1 events without per-event `schema_version` as v1 baseline, mixed-version stream validation, unsupported newer canonical event types failing closed, imported `known_facts.json` as projection/cache, and import regeneration from events.

## Boundaries preserved

- Human is the sensor. AI is the graph engine.
- AI/helper must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` remains forbidden.
- `view_state.json` remains forbidden.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage/suspect/source/research/reference/candidate/note values are not proof or probability.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## P1-P10 remain locked

- P1 confirmation/value provenance.
- P2 schema versioning/fail-closed forward compatibility.
- P3 conflict handling.
- P4 `event_invalidated` semantics.
- P5 event naming decisions.
- P6 ID/relation taxonomy.
- P7 Koht/pin targeting model.
- P8 Activity Timeline derivation.
- P9 single-writer/project-lock requirement.
- P10 durable full-text architecture capture.

## L1-L4 carried forward

- L1: define `corrects_event_id` vs `supersedes_event_id` precisely or collapse.
- L2: document measurement correction path as `measurement_recorded` plus `supersedes_event_id`; no `measurement_updated`.
- L3: component-invalidation orphan handling must surface dependent measurements and never silently cascade-drop.
- L4: legacy events without per-event `schema_version` are v1 baseline; mixed-version stream validation must be defined.

## Future schema/spec pass constraints

`V2_EVENT_SCHEMA_SPEC_PASS` must stay docs/spec only. It must not route into or implement:

- schema files or JSON schema files;
- validator code;
- materializer code;
- event writer service;
- Save Measurement, Add Component, or Edit Component UI writes;
- Project ZIP import/export behavior;
- Activity Timeline implementation;
- Measure Momentum implementation;
- tests or generated artifacts.

The next pass must be the independent scope-lock post-audit before any route to `V2_EVENT_SCHEMA_SPEC_PASS`.

## Validation result

- `py -3 tools\validate_all.py`: PASS, 236 tests.
- `git diff --name-only`: docs-only tracked changes in `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, `docs/DEFERRED_FEATURES.md`, `docs/PASS_QUEUE.md`, and `docs/WORK_INTAKE_INDEX.md`.
- `git status --short --branch`: branch `main...origin/main`, tracked docs changes only, new audit doc `docs/audit/V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS.md`, and only known unrelated untracked local paths.
- Literal artifact check: no new newline-escape artifacts in this pass diff or new audit file.

## Safe for post-audit

Yes. This scope lock is safe for Claude Code / Opus post-audit as `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_POST_AUDIT_PASS`.

## Next recommended pass

`V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_POST_AUDIT_PASS`
