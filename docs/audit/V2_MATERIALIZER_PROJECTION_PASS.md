# V2_MATERIALIZER_PROJECTION_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local scoped materializer implementation because `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS` is accepted, pushed, post-audited, and closed out. This pass changes only the existing materializer, focused materializer tests, allowed governance docs, and this audit record.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `f38e944 docs: close out V2 materializer projection scope`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS`, next `V2_MATERIALIZER_PROJECTION_PASS`.

## Scope drift check

PASS. Actual changes stayed within the accepted materializer implementation boundary:

- existing materializer/projection file,
- focused materializer tests,
- allowed governance docs,
- new audit record for this pass.

No validator code, schema files, JSON schema files, writer service, Flutter UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, asset/sample fixture, generated artifact, platform folder, tag, or release object was changed.

## Verdict

PASS. The existing materializer now projects the scoped V2 event types into `known_facts.json` while preserving V1/V1.1 behavior and the accepted evidence boundaries.

## Files changed

- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_MATERIALIZER_PROJECTION_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because no new stable product invariant needed a compact pointer; the pass records implementation evidence and routing state.

## Materializer implementation summary

- Added a V2-shaped-event path in `tools/materialize_known_facts.py` for events with `schema_version: 2.0-draft`.
- Kept V1/V1.1 events on the existing legacy path, including accepted-only `status` handling.
- Projected V2 `measurement_recorded` entries with target, reading, value provenance, conditions, source event, origin event, and validity fields.
- Projected V2 `component_created` entries with current display/navigation fields, hint fields as hints, source event, validity fields, update event pointers, and component history.
- Projected V2 `component_updated` by applying safe field-level changes to the projection while preserving update history.
- Projected V2 `event_invalidated` into invalidation history and validity/orphan markers without deleting historical projected entries.

## Projection behavior implemented

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains a projection/cache.
- V2 measurements preserve `value_provenance.context_values_visible` as context only; reference/helper context is not promoted to a measured value.
- Explicit `supersedes_event_id` marks the prior measurement as `superseded` and the replacement as active.
- `corrects_event_id` is preserved as audit intent when present.
- V2 and V1/V1.1 measurement streams can be materialized together.
- The materializer does not generate `board_graph.json`, `view_state.json`, or equivalent top-level projection keys.

## Conflict/orphan handling

- Unsuperseded divergent V2 measurements for the same target/mode/context are marked `active_conflict`.
- Conflict records preserve the conflicting `source_event_ids`.
- Latest-timestamp-wins is not used for divergent V2 measurements.
- Component-created event invalidation marks the component projection invalidated and surfaces dependent measurements in `orphaned_measurements`.
- Dependent measurements are not cascade-dropped when their component becomes invalidated.

## Tests added/updated

Focused materializer tests were added in `tests/test_materialize_known_facts.py` for:

- V2 measurement projection and provenance preservation,
- V2 component creation/update projection and history,
- V2 invalidation preserving history,
- V2 supersession resolution,
- unsuperseded divergent measurements surfacing conflict,
- L3 component-invalidation orphan surfacing,
- mixed V1/V2 projection compatibility,
- no forbidden artifact generation.

The RED run failed before implementation because V2 events were not materialized. After implementation the focused materializer suite passed.

## Boundaries preserved

- No validator code changes.
- No schema or JSON schema files.
- No writer service.
- No Flutter UI write behavior.
- No Save Measurement, Add Component, or Edit Component implementation.
- No Project ZIP logic changes.
- No Board Canvas or Reference Images runtime changes.
- No AI/OCR/CV, URL import, or source search changes.
- No generated artifacts, assets, samples, platform folders, tags, or release objects.
- No diagnosis, probability, confirmed net identity, confirmed pin mapping, component identity, visual-trace connectivity, or template/photo proof is derived.
- `board_graph.json` and `view_state.json` remain forbidden.
- Activity Timeline and Measure Momentum remain deferred.

## Validation result

PASS.

- RED check: `py -3 -m unittest tests.test_materialize_known_facts.MaterializeKnownFactsTests -v` failed before implementation on the new V2 projection tests while existing V1 tests continued passing.
- Focused materializer suite after implementation: `py -3 -m unittest tests.test_materialize_known_facts.MaterializeKnownFactsTests -v` PASS, 86 tests.
- Full validation: `py -3 tools\validate_all.py` PASS, 255 tests.

## NITs / open implementation choices

- V2 conflict grouping currently keys divergent measurements by target key, mode, and conditions. Richer context grouping can be extended later if the accepted spec adds additional context dimensions.
- V2 projection shapes for `event_invalidations`, `measurement_conflicts`, and `orphaned_measurements` are intentionally minimal projection/cache records and are not schema-file contracts in this pass.

## Safe for Claude Code / Opus post-audit

YES. Safe for Claude Code / Opus audit-only review as `V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS`.

## Next recommended pass

`V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS`
