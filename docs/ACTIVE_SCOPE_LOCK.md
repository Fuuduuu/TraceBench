# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SYNC_SCOPE_LOCK`
- Mode: docs-only scope lock for future V2 materializer projection
- Next recommended pass: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_POST_AUDIT_PASS`

## Goal

Lock the scope for future `V2_MATERIALIZER_PROJECTION_PASS`.

This pass defines what the later materializer implementation may project from validated V2 events into `known_facts.json`. It does not implement projection logic.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS.md`

`docs/PROJECT_MEMORY.md` is not required unless this pass discovers a new stable invariant without an existing owner.

## Forbidden surfaces

Do not modify materializer code, validator code, schema files, JSON schema files, writer service, Flutter UI, tests, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Binding sources

Future materializer work must bind to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`

Do not reinterpret projection rules from chat memory.

## Future implementation pass locked

Future pass:

`V2_MATERIALIZER_PROJECTION_PASS`

Future lane:

`MATERIALIZER_PASS`

Future mode:

Implementation of V2 materializer projection only.

The future implementation pass may touch only minimal materializer/projection files, focused materializer tests, governance/audit docs, and accepted materializer fixture/test inputs if needed. Exact file names must be discovered in that future pass.

Any need to touch validator, schema files, writer service, Flutter UI, Project ZIP import/export, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Projection source lock

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- The materializer reads validated events and derives projection.
- The materializer must never treat `known_facts.json` as source of truth.

## V2 event projection scope

Future materializer projection may read and project from validated:

- `measurement_recorded`
- `component_created`
- `component_updated`
- `event_invalidated`

## Measurement projection lock

Future materializer may project:

- measurement history
- active measurement entries
- target-linked measurement summaries
- value provenance
- `source_event_id`
- `target_key`
- `display_label`
- `mode`
- `value`
- `unit`
- `state` when present
- `conditions` when needed

Future materializer must not derive:

- component health
- fault diagnosis
- fault probability
- confirmed net identity
- confirmed pin mapping
- component identity
- visual trace connectivity

## Value provenance lock

Projection must preserve:

- `human_entered`
- `human_confirmed_from_reference`
- `human_confirmed_from_candidate`
- visible context values as non-canonical context only

Projection must not conflate:

- reference value with measured value
- candidate value with measured value
- helper suggestion with measured value
- note/source/research context with canonical measurement

## Component projection lock

Future materializer may project from `component_created` and `component_updated`:

- `component_id`
- current label / `reference_designator`
- `component_kind`
- `pin_count` when present
- `template_id_hint` / `footprint_hint` as hints only
- `side` / `rough_location` / `rotation_hint` as display/navigation hints only
- component history pointers
- `source_event_id` / `updated_by_event_ids`

Future materializer must not derive:

- electrical identity from `template_id_hint` or `footprint_hint`
- net identity
- pin map proof
- physical placement proof from rough location or photo
- fault status
- probability

`component_updated` applies field-level changes in event order for safe mutable fields. It must not mutate the original `component_created` event. Dangerous fields remain deferred unless explicitly allowed by the binding spec.

## Invalidation and relation lock

`event_invalidated` is human-authored and append-only.

- The invalidated event remains in history.
- The invalidated event is excluded from current projection only according to accepted invalidation rules.
- Invalidation itself can be corrected or superseded by later events.
- No deletion or mutation of the invalidated event is allowed.

Future materializer must handle:

- `origin_event_id`
- `corrects_event_id`
- `supersedes_event_id`
- `invalidates_event_id`

Carry forward the spec distinction: `supersedes_event_id` is projection-effective replacement/correction; `corrects_event_id` is audit intent unless a later audited spec update changes that. Measurement correction path remains `measurement_recorded` plus `supersedes_event_id`; there is no `measurement_updated`.

## Conflict and orphan lock

Explicit supersession/correction chains may resolve deterministically.

Unsuperseded divergent human measurements for the same target/mode/context must surface conflict. The materializer must not use latest-timestamp-wins. `known_facts.json` must preserve conflicting `source_event_ids`. Human resolution requires a new correction, supersession, or invalidation event.

L3 component-invalidation orphan handling must surface dependent measurements and must never silently cascade-drop dependent measurements. Exact projection shape is deferred to the materializer implementation pass, but this principle is locked.

## Legacy and context separation lock

- V1/V1.1 events without per-event `schema_version` remain V1 baseline.
- Existing `known_facts.json` projection behavior must not regress.
- V2 materializer behavior must not break existing V1/V1.1 fixtures.
- Mixed-version stream projection must be safe.

Projection must keep separate:

- canonical facts
- reference values
- candidate values
- notes
- helper suggestions
- activity status

Only canonical event payload values confirmed through explicit human event-writing flow may become facts.

## Forbidden artifacts and promotions

Future materializer work must not introduce:

- `board_graph.json`
- `view_state.json`
- Reference Images as evidence/source
- AI/OCR/CV facts
- URL/source-search facts
- visual-trace-to-net promotion
- template-id-to-identity promotion
- photo/damage/suspect-to-proof promotion

Future pass may propose or implement minimal `known_facts.json` projection fields needed for V2 events, but only within materializer scope. If projection shape changes are broad or affect Project ZIP/import-export, stop and require separate scope.

## Future materializer test lock

Future implementation must include focused materializer tests for:

- V2 measurement projection
- value provenance preservation
- `component_created` projection
- `component_updated` projection
- `event_invalidated` excluding active projection but preserving history
- superseded measurement resolution
- unsuperseded divergent measurements surfaced as conflict
- conflicting `source_event_ids` preserved
- no latest-timestamp-wins
- L3 orphan handling: dependent measurements surfaced, not cascade-dropped
- V1/V1.1 fixture compatibility
- no forbidden artifact generation
- no reference/candidate/helper context promoted to facts

## Route lock

Next recommended pass is `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_POST_AUDIT_PASS`.

Do not route directly to `V2_MATERIALIZER_PROJECTION_PASS` until this scope lock is post-audited. Do not route to writer service, UI writes, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
