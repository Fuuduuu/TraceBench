# V2_VALIDATOR_EXTENSION_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local scoped validator implementation because `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS` is accepted/pushed and closed out, and `docs/spec/V2_EVENT_SCHEMA_SPEC.md` is the binding requirements source. This pass changes only the existing JSONL validator, focused validator tests, and allowed governance/audit docs.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `01369d0 docs: align governance scope docs and source pointers`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `TRACEBENCH_DOCS_SCOPE_ALIGNMENT_CLEANUP_PASS`, next `V2_VALIDATOR_EXTENSION_PASS`.

## Scope drift check

PASS. Actual changes stayed within the allowed validator implementation surface:

- existing validator/tooling file,
- existing validator test file,
- allowed governance docs,
- new audit record for this pass.

No schema files, JSON schema files, materializer code, writer service, Flutter UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, assets, samples, platform folders, tags, or release objects were changed.

## Verdict

PASS. The existing event JSONL validator now has scoped V2 validation support for the accepted Markdown spec and remains compatible with the V1/V1.1 baseline.

## Files changed

- `tools/validate_events_jsonl.py`
- `tests/test_validate_events_jsonl.py`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_VALIDATOR_EXTENSION_PASS.md`

## Validator implementation summary

- Added a separate V2-shaped-event path in `tools/validate_events_jsonl.py`.
- Supported V2 schema version is `2.0-draft`.
- V1 validation remains the existing path; legacy V1/V1.1-style events without per-event `schema_version` are accepted as baseline when they are not V2-shaped.
- V2 events do not require V1 `sequence` or `status`.
- Unsupported V2 schema versions and unknown V2 event types fail closed.
- Rejected aliases are explicit: `measurement_saved`, `component_edited`, `event_superseded`, `measurement_updated`, and `replaces_event`.
- Existing Project ZIP validator behavior for `board_graph.json` and `view_state.json` remains unchanged and covered by existing tests.

## Validator requirements covered

- Common envelope: `schema_version`, `event_id`, `event_type`, `created_at`, `project_id`, `client_operation_id`, `actor`, `source`, `confirmation`, and `payload`.
- Actor/source/confirmation: requires `actor.type == human`, `source.type == explicit_user_confirmation`, and `confirmation.confirmed == true`.
- `measurement_recorded`: required payload fields, reading shape, supported mode/unit pairs, edge states, target composite, and value provenance.
- Value provenance: allowed measured sources, allowed context types, missing provenance rejection, context-source-to-reading rejection, and one-tap context-promotion rejection.
- Target / `Koht` / pin: component-pin and point-to-point target composites with dotted labels and `Q2.1 -> R17.1` style labels.
- `component_created`: stable component ID, label, component kind, created context, hint fields only, duplicate ID rejection, and proof-field rejection.
- `component_updated`: component reference, non-empty changes, `edit_reason`, required change fields, and allowed `change_kind`.
- `event_invalidated`: required invalidation payload, prior-event reference, target entity, reason, optional human note, and human/source boundary through common envelope.
- Relation fields: `origin_event_id`, `corrects_event_id`, `supersedes_event_id`, and `invalidates_event_id` must reference prior events when present; self-cycle is rejected.
- Prohibited canonical fields/promotions: recursive rejection for the accepted prohibited-field list, including `board_graph_ref`, `view_state_ref`, `reference_image_evidence`, and `visual_trace_net`.
- Back-compat: V1/V1.1 no-per-event-schema baseline remains loadable.

## Tests added/updated

Added focused V2 tests to `tests/test_validate_events_jsonl.py` covering:

- valid `measurement_recorded`,
- valid `component_created` / `component_updated` / `event_invalidated` stream,
- rejected aliases,
- missing and unsupported `schema_version`,
- unknown V2 event type,
- forbidden actors and sources,
- missing `value_provenance`,
- context-to-reading and one-tap promotion rejection,
- valid dotted and point-to-point targets,
- prohibited fields/promotions,
- invalidation source boundary,
- detectable relation self-cycle,
- legacy V1 without per-event `schema_version`.

Existing Project ZIP tests continue to cover `board_graph.json` and `view_state.json` rejection.

## Boundaries preserved

- No schema files or JSON schema files were created or modified.
- No materializer implementation.
- No writer service.
- No Flutter UI write behavior.
- No Save Measurement, Add Component, or Edit Component implementation.
- No Project ZIP logic changes.
- No Board Canvas or Reference Images runtime changes.
- No AI/OCR/CV, URL import, or source search changes.
- No generated artifacts, assets, samples, platform folders, tags, or release objects.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- AI/helper never authors canonical events/facts.
- Reference Images remain local sidecar and non-canonical.
- Activity Timeline and Measure Momentum remain deferred.

## Validation result

PASS.

- `py -3 -m unittest tests.test_validate_events_jsonl.ValidateV2EventsJsonlTests -v`: PASS, 11 tests.
- `py -3 -m unittest tests.test_validate_events_jsonl -v`: PASS, 114 tests.
- `py -3 tools\validate_all.py`: PASS, 247 tests.

## NITs / open implementation choices

- `2.0-draft` is the supported V2 validator schema label for this pass, matching the accepted architecture closeout note that this draft label was acceptable. A later executable schema/versioning pass may formalize or migrate the label.
- V2 `event_id` currently reuses the existing validator `evt_######` pattern. UUIDv7/ULID remains an open architecture/spec item for a later dedicated schema/ID pass.
- Relation-cycle rejection covers self-cycles and missing/future references in the current append-only validator scope. Richer relation graph checks can be extended if later relation semantics require them.

## Safe for Claude Code / Opus post-audit

YES. Safe for Claude Code / Opus audit-only review as `V2_VALIDATOR_EXTENSION_POST_AUDIT_PASS`.

## Next recommended pass

`V2_VALIDATOR_EXTENSION_POST_AUDIT_PASS`
