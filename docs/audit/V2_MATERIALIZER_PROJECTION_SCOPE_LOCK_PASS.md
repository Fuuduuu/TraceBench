# V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock. The V2 event-writing architecture, V2 event schema/spec, and V2 validator implementation are already accepted, pushed, and closed out. This pass does not implement materializer logic and does not modify validator code, schema files, JSON schema files, writer service, Flutter UI, tests, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `b473ce8 docs: close out V2 validator extension`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_VALIDATOR_EXTENSION_CLOSEOUT_PASS`, next `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`.

## Scope drift check

PASS. This pass is docs-only and updates only allowed governance/state/intake/deferred docs plus this audit record.

No materializer code, validator code, runtime code, Flutter UI, tests, schema files, JSON schema files, writer service, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, asset, sample, generated artifact, platform folder, tag, or release object was changed.

## Verdict

PASS. Future `V2_MATERIALIZER_PROJECTION_PASS` scope is locked for post-audit.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because the stable product invariants already have canonical owners; this pass only records the active route and future implementation boundary.

## Materializer scope locked

Future pass:

`V2_MATERIALIZER_PROJECTION_PASS`

Future lane:

`MATERIALIZER_PASS`

Future mode:

Implementation of V2 materializer projection only.

The future implementation must bind to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`

The future implementation may touch only minimal materializer/projection files, focused materializer tests, governance/audit docs, and accepted materializer fixture/test inputs if needed. Exact file names must be discovered in that future pass.

Any need to touch validator, schema files, writer service, Flutter UI, Project ZIP import/export, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Projection requirements

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- The materializer reads validated events and derives projection.
- The materializer must never treat `known_facts.json` as source of truth.
- Future materializer may project from validated `measurement_recorded`, `component_created`, `component_updated`, and `event_invalidated` events.
- Future projection may include measurement history, active measurement entries, target-linked measurement summaries, value provenance, `source_event_id`, `target_key`, `display_label`, `mode`, `value`, `unit`, `state` when present, and `conditions` when needed.
- Future projection may include `component_id`, current label/reference designator, `component_kind`, `pin_count`, hint fields as hints only, display/navigation hints, component history pointers, and `updated_by_event_ids`.
- `component_updated` applies field-level changes in event order for safe mutable fields and must not mutate the original `component_created` event.
- `event_invalidated` is human-authored and append-only; invalidated events remain in history and are excluded from current projection only under accepted invalidation rules.
- V1/V1.1 events without per-event `schema_version` remain V1 baseline; existing projection behavior and fixtures must not regress.

Projection must preserve value provenance:

- `human_entered`
- `human_confirmed_from_reference`
- `human_confirmed_from_candidate`
- visible context values as non-canonical context only

Projection must keep separate canonical facts, reference values, candidate values, notes, helper suggestions, and activity status.

Future materializer must not derive:

- component health
- fault diagnosis
- fault probability
- confirmed net identity
- confirmed pin mapping
- component identity
- visual trace connectivity
- electrical identity from template or footprint hints
- physical placement proof from rough location or photo
- reference/candidate/helper/source/note context as canonical measurement

## Conflict/orphan handling locked

Future materializer must handle `origin_event_id`, `corrects_event_id`, `supersedes_event_id`, and `invalidates_event_id`.

The `corrects_event_id` vs `supersedes_event_id` distinction from `docs/spec/V2_EVENT_SCHEMA_SPEC.md` is preserved: `supersedes_event_id` is projection-effective replacement/correction, while `corrects_event_id` is audit intent unless a later audited spec update changes that. Measurement correction remains `measurement_recorded` plus `supersedes_event_id`; there is no `measurement_updated`.

Explicit supersession/correction chains may resolve deterministically.

Unsuperseded divergent human measurements for the same target/mode/context must surface conflict. Latest-timestamp-wins is forbidden. `known_facts.json` must preserve conflicting `source_event_ids`. Human resolution requires a new correction, supersession, or invalidation event.

L3 component-invalidation orphan handling is locked: dependent measurements must surface and must never be silently cascade-dropped. Exact projection shape is deferred to the implementation pass.

## Future implementation allowlist

The future `V2_MATERIALIZER_PROJECTION_PASS` may modify only:

- minimal materializer/projection files discovered in that pass,
- focused materializer tests,
- docs/governance/audit files,
- accepted materializer fixture/test inputs if needed.

The future implementation must include focused tests for:

- V2 measurement projection,
- value provenance preservation,
- `component_created` projection,
- `component_updated` projection,
- `event_invalidated` excluding active projection but preserving history,
- superseded measurement resolution,
- unsuperseded divergent measurements surfaced as conflict,
- conflicting `source_event_ids` preserved,
- no latest-timestamp-wins,
- L3 orphan handling with dependent measurements surfaced,
- V1/V1.1 fixture compatibility,
- no forbidden artifact generation,
- no reference/candidate/helper context promoted to facts.

## Boundaries preserved

- No materializer implementation in this scope-lock pass.
- No validator code.
- No tests.
- No runtime code.
- No Flutter UI.
- No schema files.
- No JSON schema files.
- No writer service.
- No Project ZIP logic.
- No Board Canvas runtime.
- No Reference Images runtime.
- No AI/OCR/CV.
- No URL import or source search.
- No assets, samples, generated artifacts, platform folders, tags, or release objects.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- AI/helper never authors canonical events or facts.
- `board_graph.json` and `view_state.json` remain forbidden.
- Reference Images remain local sidecar and non-canonical.
- Activity Timeline and Measure Momentum remain deferred.

## Validation result

PASS. `py -3 tools\validate_all.py` passed with 247 tests.

Post-edit status checks confirmed docs-only tracked changes, the expected new audit document, no staged files, compact `CURRENT_STATE.md`, route agreement between `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md`, no current/next self-loop, no literal artifact markers in touched files, and no runtime/source/schema/sample/platform file changes.

## Safe for Claude Code / Opus post-audit

Yes. Safe for Claude Code / Opus post-audit as `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_POST_AUDIT_PASS`.

## Next recommended pass

`V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_POST_AUDIT_PASS`
