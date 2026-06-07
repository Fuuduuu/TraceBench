# V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock. The accepted V2 event schema/spec is already committed and post-audited, and `docs/spec/V2_EVENT_SCHEMA_SPEC.md` is the binding source for future validator requirements. This pass does not implement validator code or modify tools, schemas, materializer, writer service, Flutter UI, tests, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `8935088 docs: close out V2 event schema spec`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_EVENT_SCHEMA_SPEC_CLOSEOUT_PASS`, next `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`.

## Scope drift check

PASS. This pass is docs-only and updates only allowed governance/state/intake/deferred docs plus this scope-lock audit record. It does not modify runtime code, Flutter runtime, tests, schema files, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Verdict

PASS. The future `V2_VALIDATOR_EXTENSION_PASS` is scoped as validator implementation only after this scope lock is post-audited.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because no new stable product invariant was needed beyond existing compact pointers and the accepted V2 spec.

## Validator scope locked

Future pass:

`V2_VALIDATOR_EXTENSION_PASS`

Future lane:

`VALIDATOR_PASS`

Future mode:

Implementation of validator support for V2 event schema/spec only.

The future implementation must bind to `docs/spec/V2_EVENT_SCHEMA_SPEC.md`. It must not reinterpret validator rules from chat memory.

This current scope-lock pass does not implement validation logic.

## Boundaries preserved

- No code changes.
- No validator code.
- No tests.
- No schema files.
- No JSON schema files.
- No materializer.
- No writer service.
- No UI.
- No Project ZIP changes.
- No assets, samples, or platform changes.
- No generated artifacts.
- No tags or releases.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Human is the sensor. AI is the graph engine.
- AI/helper never authors canonical events/facts.
- `board_graph.json` and `view_state.json` remain forbidden.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels/alignment are not facts/proof.
- Damage/suspect/source/research/reference/candidate/note values are not proof/probability.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## Future implementation allowlist

The future `V2_VALIDATOR_EXTENSION_PASS` may likely touch:

- existing validator/tooling files only as required,
- validator tests only as required,
- docs/governance/audit files,
- fixture/sample test inputs only if already accepted by the validator test pattern.

Exact file names must be discovered in that future pass.

Stop and require separate scope if future implementation needs to touch:

- materializer,
- Project ZIP import/export,
- writer service,
- Flutter UI,
- Board Canvas,
- Reference Images runtime,
- AI/OCR/CV,
- URL/source search,
- platform folders,
- generated artifacts,
- tags/releases.

## Future validator requirements

Future `V2_VALIDATOR_EXTENSION_PASS` may validate only the accepted spec requirements below.

### Common event envelope

Validate required common event envelope fields:

- `schema_version`
- `event_id`
- `event_type`
- `created_at`
- `project_id`
- `client_operation_id`
- `actor`
- `source`
- `confirmation`
- `payload`

### Canonical event types and aliases

Accept only initial V2 canonical event types:

- `measurement_recorded`
- `component_created`
- `component_updated`
- `event_invalidated`

Reject aliases and non-initial canonical event names:

- `measurement_saved`
- `component_edited`
- `event_superseded` as an initial canonical event type
- `measurement_updated`
- `replaces_event`

### Actor, source, and confirmation

Validate:

- `actor.type` must be `human`,
- `source.type` must be `explicit_user_confirmation`,
- `confirmation.confirmed` must be `true`.

Reject AI/helper/OCR/CV/renderer/import-inference/activity timeline/debug log/reference image/photo alignment/visual trace/localStorage as canonical authors or sources.

### Schema version and fail-closed behavior

Validate:

- V2 canonical events require `schema_version`,
- unsupported `schema_version` fails closed,
- unknown canonical `event_type` fails closed,
- legacy V1/V1.1 events without per-event `schema_version` are V1 baseline,
- mixed-version stream validation is explicit,
- older builds must not silently ignore V2 canonical events.

### `measurement_recorded`

Validate required payload fields:

- `measurement_id`
- `measured_at`
- `target`
- `reading`
- `value_provenance`

Validate reading shape:

- `mode`
- `value`
- `unit`
- `display_value`
- optional `state`

Validate supported mode/unit pairs:

- `voltage` / `V`
- `resistance` / `Ω`
- `diode` / `diode`
- `continuity` / `beep`
- `current` / `A`

`A` / current remains advanced by default in UI, but validator scope is schema only, not UI placement.

### Value provenance

Validate allowed measured value sources:

- `human_entered`
- `human_confirmed_from_reference`
- `human_confirmed_from_candidate`

Validate allowed non-canonical context types:

- `helper_suggestion`
- `reference_value`
- `candidate_value`
- `note_value`
- `source_research_value`

Reject:

- missing `value_provenance` for `measurement_recorded`,
- context value promotion into `reading.value` without explicit human-confirmed source,
- one-tap helper/reference/candidate promotion patterns if represented in event fields.

### Target / `Koht` / pin

Validate target composite requirements:

- `target_key`,
- `display_label`,
- `component_id` when known,
- `pin_id` when known,
- from/to point-to-point target shape,
- dotted labels such as `Q2.1` and `R17.1`,
- point-to-point labels such as `Q2.1 -> R17.1`.

Preserve:

- `Koht` does not imply net identity,
- `pin_id` does not imply confirmed pin mapping.

### `component_created`

Validate:

- stable `component_id`,
- `label`,
- `component_kind` or `unknown`,
- `created_context`,
- `reference_designator` as mutable label,
- `template_id_hint` / `footprint_hint` as hints only.

Reject fields that imply identity, net, fault, or probability proof.

### `component_updated`

Validate:

- `component_id`,
- `changes`,
- `edit_reason`,
- each change includes `field`, `old_value_observed`, `new_value`, and `change_kind`,
- allowed `change_kind`: `set`, `replace`, `clear`, `mark_unknown`, `correct_typo`.

Reject mutation of the original `component_created` event and reject `measurement_updated`.

### `event_invalidated`

Validate:

- `invalidates_event_id`,
- `target_entity_id`,
- `reason`,
- optional `human_note`,
- human-authored only,
- append-only behavior,
- no deletion/mutation,
- reversal only via new event.

Reject AI/helper/renderer/import-inference invalidation.

### Relation fields

Validate relation fields:

- `origin_event_id`
- `corrects_event_id`
- `supersedes_event_id`
- `invalidates_event_id`

Validate references exist when required and reject circular relation chains.

### Correction, conflict, and back-compat

Validate:

- measurement correction path uses `measurement_recorded` plus `supersedes_event_id`,
- no `measurement_updated`,
- unsuperseded divergent human measurements remain representable as conflict for later projection,
- validator must not encode latest-timestamp-wins,
- V1/V1.1 events without `schema_version` are V1 baseline,
- unsupported newer canonical events fail closed.

### Prohibited fields and promotions

Reject or flag:

- `ai_confidence`
- `probability`
- `diagnosis`
- `fault_probability`
- `auto_detected`
- `ocr_text_as_fact`
- `cv_component_match`
- `photo_proof`
- `visual_trace_net`
- `template_identity`
- `board_graph_ref`
- `view_state_ref`
- `reference_image_evidence`
- `local_storage_source`
- `damage_proves_fault`
- `suspect_probability`

### Forbidden artifacts and non-canonical sidecars

Preserve:

- `board_graph.json` remains rejected,
- `view_state.json` remains rejected,
- Reference Images remain local sidecar and non-canonical,
- local sidecar data must not become canonical validator source.

## Validation result

PASS. `py -3 tools\validate_all.py` passed with 236 tests.

Post-edit status checks confirmed docs-only tracked changes, the expected new audit document, no staged unrelated untracked paths, compact `CURRENT_STATE.md`, route agreement between `CURRENT_STATE.md`, `PASS_QUEUE.md`, and `ACTIVE_SCOPE_LOCK.md`, no current/next self-loop, and no runtime/schema/source/sample file changes.

## Safe for Claude Code / Opus post-audit

YES. Safe for Claude Code / Opus audit-only review as `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_POST_AUDIT_PASS`.

## Next recommended pass

`V2_VALIDATOR_EXTENSION_SCOPE_LOCK_POST_AUDIT_PASS`
