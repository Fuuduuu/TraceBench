# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_MATERIALIZER_PROJECTION_PASS`
- Lane: `CODEX / MATERIALIZER_PASS`
- Mode: scoped materializer implementation only
- Next recommended pass: `V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS`

## Goal

Implement the first V2 projection path from validated V2 events into `known_facts.json` under the accepted materializer projection scope lock.

This pass is limited to V2 projection for:

- `measurement_recorded`
- `component_created`
- `component_updated`
- `event_invalidated`

## Write allowlist

- Existing materializer/projection files
- Focused materializer tests
- Accepted materializer fixture/test inputs if required
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_MATERIALIZER_PROJECTION_PASS.md`

`docs/PROJECT_MEMORY.md` is not required for this pass because stable evidence/projection invariants already have canonical owners.

## Forbidden surfaces

Do not modify validator code except on a hard blocker that requires stopping first. Do not modify schemas, JSON schema files, writer service, Flutter UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples outside accepted materializer fixtures, generated artifacts, platform folders, tags, or release objects.

## Binding sources

Implementation remains bound to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- `docs/audit/V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS.md`

Do not reinterpret projection rules from chat memory.

## Implemented projection boundary

The materializer may project from V2 events with `schema_version: 2.0-draft` and accepted canonical V2 event types only within this pass scope.

Projected materializer state remains a cache/projection:

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- V2 measurement projection preserves `source_event_id`, target linkage, reading values, conditions, validity fields, and value provenance.
- V2 component projection preserves current display fields, hints as hints only, source/update event pointers, and component history.
- V2 invalidation preserves history and marks affected projected entries invalidated or orphaned instead of deleting dependent measurements.
- Supersession resolves explicit `supersedes_event_id` chains.
- Unsuperseded divergent measurements for the same target/mode/context surface conflict markers with source event IDs.

## Boundaries preserved

- No schema files.
- No JSON schema files.
- No writer service.
- No Flutter UI writes.
- No Save/Add/Edit behavior.
- No Project ZIP changes.
- No Board Canvas runtime changes.
- No Reference Images runtime changes.
- No AI/OCR/CV.
- No URL import or source search.
- No Activity Timeline.
- No Measure Momentum.
- No generated artifacts, platform folders, tags, or release objects.
- No diagnosis, probability, confirmed net identity, confirmed pin mapping, component identity, visual-trace connectivity, or template/photo proof is derived.
- `board_graph.json` and `view_state.json` remain forbidden.
- AI/helper never authors canonical events or facts.
- Reference Images remain local sidecar and non-canonical.

## Route lock

Next recommended pass is `V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS`.

Purpose: independent Claude Code / Opus post-audit of the scoped materializer implementation.

Do not route next to writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 -m unittest tests.test_materialize_known_facts.MaterializeKnownFactsTests -v`
- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
