# V2_EDIT_COMPONENT_SCOPE_LOCK_PASS

## Verdict

PASS pending post-audit.

## Type

Scope lock.

## Audit contract

Applies `docs/AUDIT_CONTRACT.md` contract: `scope-lock-post-audit`.

## Goal

Lock the future V2 Edit Component UI write-flow as the next canonical write surface after accepted Save Measurement and Add Component.

## Locked behavior for future implementation

- Future implementation must create only `component_updated`.
- Future UI must use the accepted writer-service adapter pattern.
- Future UI and Dart service must never append directly to `events.jsonl`.
- Human confirmation is required: `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Editing must patch or update an existing component only; it must not create a new component.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remains hint/context only.
- No automatic identity confirmation, pin mapping, net, measurement, fault proof, diagnosis, or probability.
- Save Measurement and Add Component accepted behavior must remain unchanged.

## Binding sources

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_ADD_COMPONENT_PASS.md`
- `docs/audit/V2_ADD_COMPONENT_CLOSEOUT_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PASS.md`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`

## Future implementation allowlist

- Minimal Edit Component UI/service/provider files required for human-confirmed `component_updated`.
- Minimal writer-adapter integration if needed.
- Focused Edit Component widget/unit tests.
- Governance/audit docs.

## Future forbidden surfaces

- Save Measurement behavior changes.
- Add Component behavior changes unless shared safe integration is explicitly needed.
- Project ZIP.
- Activity Timeline.
- Measure Momentum.
- Board Canvas write/edit.
- Reference Images runtime.
- AI/OCR/CV.
- Photo Markup / Repair Map / Visual Trace Shape Assist.
- Validator behavior.
- Materializer behavior.
- Schema / JSON schema files.
- `tools/event_writer_service.py` behavior.
- Platform/generated/assets/samples/tags/releases.

## Future implementation test requirements

- Edit button disabled until an existing component and human-confirmed changes exist.
- Valid Edit Component calls writer once.
- Generated event is only `component_updated`.
- Actor/source/confirmation fields are correct.
- Update target references an existing component.
- Hints remain hints only and do not auto-confirm identity.
- Writer validation failure shows not-saved.
- Writer append/path/lock failure shows not-saved.
- Idempotent existing result does not duplicate local UI state.
- No diagnosis/probability/verified/good/correct wording.
- No Board Canvas / Reference Images / Guided Helper write path.
- No Project ZIP changes.
- Save Measurement and Add Component tests remain green.

## Boundaries preserved by this pass

- Docs-only scope lock.
- No code, tests, tools, validator, materializer, schema, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, Activity Timeline, Measure Momentum, samples/assets, generated artifacts, platform folders, tags, or releases changed.
- No completed pass history reopened or pruned.

## Route decision

Current pass: `V2_EDIT_COMPONENT_SCOPE_LOCK_PASS`.

Next recommended pass: `V2_EDIT_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`.

Do not route directly to `V2_EDIT_COMPONENT_PASS`.

## Validation

Required by pass:

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
