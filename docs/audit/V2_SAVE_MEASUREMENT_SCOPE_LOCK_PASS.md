# V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock. The V2 architecture, schema/spec, validator, materializer, writer service, and recovered writer-service closeout record are accepted and pushed. This pass does not implement UI writes and does not modify Flutter UI, writer service, validator, materializer, schema files, JSON schema files, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, tests, assets, samples, generated artifacts, platform folders, tags, or release objects.

## Startup state

- Branch: `main`.
- HEAD was synced with `origin/main` at `98b58c9 docs: recover V2 writer service closeout record`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths remained `.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, and `windows/`.
- Tags included `v1.0.0-rc1` and `v1.1.0-rc1`.
- Governance route before this pass was current `V2_EVENT_WRITER_SERVICE_CLOSEOUT_RECOVERY_PASS`, next `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`.

## Scope drift check

PASS. This pass is docs-only and updates only allowed governance/state/intake/deferred docs plus this audit record.

No code, UI implementation, tests, writer service, validator, materializer, schema files, JSON schema files, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects were changed.

## Verdict

PASS. Future `V2_SAVE_MEASUREMENT_PASS` scope is locked for post-audit. Implementation remains blocked until this scope lock is accepted by `V2_SAVE_MEASUREMENT_SCOPE_LOCK_POST_AUDIT_PASS`.

## Files changed

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS.md`

`docs/PROJECT_MEMORY.md` was not changed because the stable technician-first, human-confirmed, append-only invariants already have canonical owners.

## Save Measurement scope locked

Future pass:

`V2_SAVE_MEASUREMENT_PASS`

Future lane:

`FLUTTER_PASS / UI_WRITE_FLOW`

Future mode:

Scoped implementation of Save Measurement UI flow only.

Future implementation may turn the read-only Measure Sheet save affordance into a real human-confirmed Save Measurement flow, create a valid V2 `measurement_recorded` event, submit it through the accepted V2 event writer service, and preserve technician-first workflow boundaries.

## Binding sources

Future implementation must bind to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- accepted writer service in `tools/event_writer_service.py`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`
- accepted V2 architecture record in `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`

Do not reinterpret Save Measurement rules from chat memory.

## Event construction requirements

Future Save Measurement must produce only `measurement_recorded`.

It must not produce:

- `component_created`
- `component_updated`
- `event_invalidated`
- activity timeline events
- note events
- Project ZIP changes

Future implementation must construct a valid V2 event according to `docs/spec/V2_EVENT_SCHEMA_SPEC.md`, including:

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
- `measurement_id`
- `measured_at`
- `target`
- `reading`
- `value_provenance`

Future Save Measurement event must use:

- `actor.type = human`
- `source.type = explicit_user_confirmation`
- `confirmation.confirmed = true`

Future UI must reject or avoid AI/helper/renderer/OCR/CV/reference image/activity timeline/debug log/localStorage authorship.

## Writer service usage requirements

- Future UI must submit the candidate event through the accepted V2 writer service.
- UI must not append directly to `events.jsonl`.
- UI must not bypass validator-before-append.
- UI must respect `client_operation_id` idempotency.
- UI must handle writer errors without pretending a failed save succeeded.
- Writer validation failure means not saved.
- Writer append failure means not saved.
- Lock conflict must surface as a clear retryable error.
- Idempotent duplicate retry must resolve as existing/no duplicate.

## Human confirmation / value provenance requirements

- Save Measurement creates a canonical event only after explicit human action.
- The user must enter or explicitly verify the measured value.
- Helper/reference/candidate values must not auto-populate the confirmable measured field.
- One-tap confirmation of suggested/reference/candidate values is forbidden.
- AI/helper must not author events.
- Reading must include mode, value or state, unit, and `display_value`.
- Primary units remain `V` / `Ω` / `Diode` / `Beep`.
- `A`/current remains advanced by default under `Lisainfo` / `Tehnilised detailid`.
- Invalid mode/unit combinations must not be submitted.
- Future UI must preserve selected `Koht` / target context: `target_key`, `display_label`, known `component_id`, known `pin_id`, and point-to-point `from_target` / `to_target` when applicable.
- `Koht` must not imply net identity.
- `pin_id` must not imply confirmed pin mapping.
- Value provenance must record `human_entered`, `human_confirmed_from_reference`, or `human_confirmed_from_candidate`.
- Context values remain non-canonical: `helper_suggestion`, `reference_value`, `candidate_value`, `note_value`, and `source_research_value`.
- Projection must not conflate context with measured value.

## Error handling / after-save requirements

Allowed after writer success:

- show confirmation,
- keep selected `Koht`/context,
- optionally suggest next point as workflow aid only.

Forbidden after save:

- diagnosis,
- probability/confidence,
- fault ranking,
- AI-created facts,
- helper-authored event,
- automatic second event,
- net inference,
- component identity confirmation.

Future UI must distinguish:

- validation failure = not saved,
- writer append failure = not saved,
- lock conflict = clear retryable error,
- idempotent duplicate retry = existing/no duplicate,
- materializer/projection refresh failure, if shown later, must not erase canonical event.

## Future implementation allowlist

Future implementation may touch only:

- minimal Measure Sheet / UI files required for Save Measurement,
- minimal provider/service integration needed to call the accepted writer service,
- focused widget/unit tests for Save Measurement,
- docs/governance/audit files,
- accepted UI fixtures if needed.

Any need to touch validator, materializer, writer service behavior, schema files, JSON schema files, Project ZIP import/export, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Tests locked for future implementation

Future implementation must include focused tests for:

- Save button disabled until required human-entered/verified fields exist.
- Valid Save Measurement calls writer once.
- Generated event is `measurement_recorded`.
- Actor/source/confirmation fields are correct.
- `value_provenance` is preserved.
- Helper/reference/candidate values do not auto-fill measured value.
- One-tap suggested value promotion is forbidden.
- Writer validation failure shows not saved.
- Writer append failure shows not saved.
- Lock conflict shows retryable/clear error.
- Idempotent duplicate retry does not duplicate.
- Selected `Koht`/context remains after successful save.
- No diagnosis/probability/verified/good/correct wording.
- No Board Canvas / Reference Images / Guided Helper write path.
- No Project ZIP changes.

## Boundaries preserved

- No code.
- No UI implementation.
- No tests.
- No writer service changes.
- No validator changes.
- No materializer changes.
- No schema files.
- No JSON schema files.
- No Project ZIP changes.
- No assets, samples, or platform changes.
- No generated artifacts.
- No tags or releases.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical facts.
- Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, and Activity Timeline remain protected from this write flow.
- Add/Edit Component, Project ZIP, Activity Timeline, and Measure Momentum remain separately scoped later work.

## Validation result

PASS.

- `py -3 tools\validate_all.py`: PASS, 268 tests.
- `git status --short --branch`: docs-only tracked changes plus known unrelated untracked paths.
- `git diff --name-only`: allowed governance docs only; new audit artifact is `docs/audit/V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS.md`.

## Safe for Claude Code / Opus post-audit

YES. Expected next pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_POST_AUDIT_PASS`.

## Next recommended pass

`V2_SAVE_MEASUREMENT_SCOPE_LOCK_POST_AUDIT_PASS`
