# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `TRACEBENCH_DOCS_SCOPE_ALIGNMENT_CLEANUP_PASS`
- Lane: `CODEX / DOCS_SYNC`
- Mode: docs-only cleanup and scope alignment
- Next recommended pass: `V2_VALIDATOR_EXTENSION_PASS`

## Goal

Apply the tight docs cleanup recommended by Claude Code / Opus in `TRACEBENCH_DOCS_SCOPE_ALIGNMENT_AND_SOURCE_GUIDE_REFRESH_AUDIT_PASS`.

This pass reduces duplicated routing logic, clarifies the external Source Guide pointer, harmonizes `board_graph.json` / `view_state.json` forbidden wording, keeps `CURRENT_STATE.md` compact, and returns routing to `V2_VALIDATOR_EXTENSION_PASS`.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/PROJECT_MEMORY.md`
- `docs/ARCHITECTURE_BOUNDARIES.md`
- `docs/MODEL_ROUTING.md`
- `docs/audit/TRACEBENCH_DOCS_SCOPE_ALIGNMENT_CLEANUP_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schema files, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Accepted input

- `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS` accepted/pushed and closed out.
- Current accepted route before this cleanup: current `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_CLOSEOUT_PASS`, next `V2_VALIDATOR_EXTENSION_PASS`.
- Claude Code / Opus audit result for this cleanup input: `PASS_CLEANUP_RECOMMENDED`.
- Cleanup is non-blocking but recommended before executable validator work.

## Cleanup scope

- Reduce duplicated routing logic in `docs/SOURCES_INDEX_CURRENT.md` by pointing to canonical owner `docs/MODEL_ROUTING.md`.
- Clarify `TraceBench_Project_Source_Guide.md` is external/non-repo orientation-only material and not canonical governance.
- Harmonize `board_graph.json` / `view_state.json` wording in allowed docs without weakening the boundary.
- Optionally add one-line V2 staged-order notes without redrawing Mermaid flows.
- Keep `docs/CURRENT_STATE.md` compact.

## Next pass lock

- Next implementation pass: `V2_VALIDATOR_EXTENSION_PASS`
- Lane: `VALIDATOR_PASS`
- Mode: implementation of validator support for V2 event schema/spec only

The implementation may proceed only under the accepted scope lock. It may touch only the minimal validator/tooling/test surfaces required to validate V2 events. Exact file names must be discovered during that pass.

## Future validator scope

`V2_VALIDATOR_EXTENSION_PASS` may validate only requirements from `docs/spec/V2_EVENT_SCHEMA_SPEC.md`, including:

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

`V2_VALIDATOR_EXTENSION_PASS` may likely touch:

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

Next recommended pass is `V2_VALIDATOR_EXTENSION_PASS`.

Purpose: first executable V2 validator implementation pass under the accepted validator scope lock.

Do not route to materializer, writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum from this cleanup.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
