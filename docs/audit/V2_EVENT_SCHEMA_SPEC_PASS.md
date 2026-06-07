# V2_EVENT_SCHEMA_SPEC_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs/spec synchronization pass. The bound architecture and prior scope lock were accepted before this pass. Claude Code / Opus remains the recommended next helper for post-audit. No implementation, executable schema, validator, materializer, writer service, UI write behavior, Project ZIP change, test creation, runtime work, tag, or release mutation is allowed.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `fc0034d docs: close out V2 event schema spec scope`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Latest commits included `docs: close out V2 event schema spec scope` and `docs: lock V2 event schema spec scope`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_CLOSEOUT_PASS`, next `V2_EVENT_SCHEMA_SPEC_PASS`.

## Scope drift check

PASS. This pass is docs/spec only. It does not modify runtime code, Flutter runtime, tests, schema files, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. `docs/spec/V2_EVENT_SCHEMA_SPEC.md` documents V2 event schema/spec requirements under the accepted scope lock and routes to audit-only review.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_SCHEMA_SPEC_PASS.md`

`docs/PROJECT_MEMORY.md` did not need a new compact pointer.

## Spec document created

Created `docs/spec/V2_EVENT_SCHEMA_SPEC.md` as Markdown-only requirements. It is not an executable schema, JSON schema, validator, tool, generated artifact, test, runtime implementation, Project ZIP change, or source file.

## Event schema/spec summary

The spec records:

- `events.jsonl` as canonical truth and `known_facts.json` as projection/cache,
- accepted event names `measurement_recorded`, `component_created`, `component_updated`, and `event_invalidated`,
- rejected aliases including `measurement_saved`, `component_edited`, `event_superseded`, and `measurement_updated`,
- common event envelope requirements,
- actor/source/confirmation requirements,
- fail-closed schema-version compatibility requirements,
- `measurement_recorded` payload, reading, units, edge states, and materializer boundaries,
- value provenance separation for measured values vs helper/reference/candidate/note/source context,
- target / `Koht` / pin composite handling,
- component create/update payload rules,
- event invalidation semantics,
- relation field requirements,
- conflict handling,
- legacy/back-compat behavior,
- prohibited fields/promotions,
- later validator/materializer/test requirements,
- open implementation decisions.

## L1-L4 handling

- L1: `corrects_event_id` and `supersedes_event_id` are both documented; `supersedes_event_id` is projection-effective, while `corrects_event_id` is audit intent unless a later audited schema collapses or binds them.
- L2: measurement correction uses `measurement_recorded` with `supersedes_event_id`; `measurement_updated` is rejected.
- L3: component invalidation must surface dependent measurements and must never silently cascade-drop them; exact projection shape is deferred to materializer pass.
- L4: legacy V1/V1.1 events without per-event `schema_version` are treated as V1 baseline; mixed-version stream validation and fail-closed unsupported versions are required.

## Boundaries preserved

- Future implementation remains blocked until separately scoped/audited passes.
- No schema files or JSON schema files were created.
- No validators, tools, materializer, writer service, Flutter UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, assets, samples, platform folders, tags, or release objects were changed.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events or facts.
- `board_graph.json` and `view_state.json` remain forbidden.
- Reference Images remain local sidecar and non-canonical.
- Activity Timeline and Measure Momentum remain deferred.

## Validation result

- `py -3 tools\validate_all.py`: PASS, 236 tests.
- `docs/CURRENT_STATE.md` remains compact at 62 lines.
- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` agree on current pass `V2_EVENT_SCHEMA_SPEC_PASS` and next recommended pass `V2_EVENT_SCHEMA_SPEC_POST_AUDIT_PASS`.
- No current/next self-loop.
- Final status and diff checks must show docs-only allowed changes plus the known unrelated untracked local paths.

## Post-audit readiness

Safe for Claude Code / Opus post-audit after final status/diff checks confirm no forbidden files changed.

## Route decision

Next recommended pass:

`V2_EVENT_SCHEMA_SPEC_POST_AUDIT_PASS`

Purpose: Claude Code / Opus audit-only review of the docs/spec record for scope drift, architecture binding, L1-L4 handling, fail-closed compatibility, value provenance, evidence boundaries, and route safety.
