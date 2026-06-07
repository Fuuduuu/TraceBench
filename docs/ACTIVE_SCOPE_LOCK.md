# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SYNC_SCOPE_LOCK`
- Mode: docs-only scope lock
- Next recommended pass: `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_POST_AUDIT_PASS`

## Goal

Lock the scope for future `V2_VALIDATOR_EXTENSION_PASS` without implementing validator code.

This pass defines what the future validator extension may validate. It must not implement validation logic or touch executable validator/tooling/test/schema surfaces.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schema files, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Binding sources

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md` is the binding requirements source for validator requirements.
- `docs/audit/V2_EVENT_SCHEMA_SPEC_PASS.md` records the accepted Markdown-only spec pass.
- `docs/audit/V2_EVENT_SCHEMA_SPEC_CLOSEOUT_PASS.md` records the accepted spec closeout and route to this pass.
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md` remains the accepted V2 event-writing architecture source.

Do not reinterpret validator rules from chat memory.

## Future pass locked

- Future pass: `V2_VALIDATOR_EXTENSION_PASS`
- Future lane: `VALIDATOR_PASS`
- Future mode: implementation of validator support for V2 event schema/spec only

The future implementation may touch only the minimal validator/tooling/test surfaces required to validate V2 events. Exact file names must be discovered during that future pass.

## Future validator scope

Future `V2_VALIDATOR_EXTENSION_PASS` may validate only requirements from `docs/spec/V2_EVENT_SCHEMA_SPEC.md`, including:

- common event envelope fields,
- canonical event type allowlist and rejected aliases,
- actor/source/confirmation rules,
- `schema_version` and fail-closed compatibility,
- `measurement_recorded` payload, reading shape, modes/units, and value provenance,
- target / `Koht` / pin composite shape,
- `component_created`,
- `component_updated`,
- `event_invalidated`,
- relation fields and circular/missing-reference checks,
- correction/supersession/invalidation rules,
- no latest-timestamp-wins conflict behavior encoded by validator,
- legacy V1/V1.1 baseline and mixed-version stream handling,
- prohibited fields/promotions,
- forbidden artifact/reference rejection for `board_graph.json` and `view_state.json`,
- Reference Images/local sidecar remaining non-canonical and not validator authority.

## Future implementation allowlist

Future `V2_VALIDATOR_EXTENSION_PASS` may likely touch:

- existing validator/tooling files only as required,
- validator tests only as required,
- docs/governance/audit files,
- fixture/sample test inputs only if already accepted by the validator test pattern.

Any need to touch materializer, Project ZIP import/export, writer service, Flutter UI, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not author canonical events or facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
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

Next recommended pass is `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_POST_AUDIT_PASS`.

Purpose: Claude Code / Opus audit-only review of the validator scope lock for scope drift, binding to `docs/spec/V2_EVENT_SCHEMA_SPEC.md`, future implementation allowlist safety, and preservation of evidence boundaries.

Do not route directly to `V2_VALIDATOR_EXTENSION_PASS` until this scope lock is post-audited. Do not route to materializer, writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
