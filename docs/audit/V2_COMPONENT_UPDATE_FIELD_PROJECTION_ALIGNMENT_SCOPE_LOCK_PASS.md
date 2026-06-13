# V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS

## Verdict

PASS pending post-audit.

## Type

Scope lock.

## Model routing check

- `docs/CURRENT_STATE.md` current pass is `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS`.
- `docs/PASS_QUEUE.md` current pass is `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md` current pass is `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS`.
- All three documents route next to
  `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_POST_AUDIT_PASS`
  for a short-lived scope-lock handoff.
- `docs/AUDIT_INDEX.md` contains the lock audit entry as `current`.
- `docs/WORK_INTAKE_INDEX.md` records WI-066 for projection-contract alignment follow-through.

## Tool/plugin/download capability report

- Local filesystem and git tooling available.
- Required local tooling already present; no installs/downloads/updates performed.
- AGENTS-required TraceBench skills already available.
- No dependency, plugin, MCP, or package changes required in this docs-only pass.

## Binding sources

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EDIT_COMPONENT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_EDIT_COMPONENT_PASS.md`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `lib/features/components/screens/edit_component_screen.dart`
- `lib/features/components/services/v2_edit_component_writer.dart`

## Precondition checks

- Read order targets were respected and canonical owners aligned:
  - state in `CURRENT_STATE.md`
  - queue in `PASS_QUEUE.md`
  - lock in `ACTIVE_SCOPE_LOCK.md`
- This is a docs-only governance pass; implementation surfaces are not modified.

## Current-code mismatch evidence

Observed before pass-locking:

- `lib/features/components/screens/edit_component_screen.dart` emits component update
  changes from `_changesFor(...)` that include `package_hint`.
- `lib/features/components/services/v2_edit_component_writer.dart` forwards each
  change field as-is inside `component_updated` changes.
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md` and writer validation currently allow broad
  `field` payload values for component updates, but projection/known-facts
  alignment depends on materializer field handling.
- `tools/materialize_known_facts.py` applies `V2ComponentChange` only when
  `field in V2_COMPONENT_FIELDS and field != "component_id"`, so updates for
  fields not present there are not consistently projected as intended.

## Chosen policy

- Validator/materializer alignment is the primary future implementation seam.
- `package_hint` is kept as a component hint/context field.
- `package_hint` is projected to `known_facts.json` as hint-only component
  metadata when accepted by the validator.
- A shared mutable field contract must be defined and used by both validator and
  materializer for component updates.
- `component_updated` must reject unknown fields.
- `component_updated` must reject proof-like/unsafe field names.
- `component_created` / `package_hint` projection parity must be considered in the
  same future pass if `package_hint` is confirmed accepted on create.
- UI/writer emitted fields must be checked against the same shared contract.
- UI/writer alone is not sufficient to close canonical-to-projection contract drift.

## Future implementation allowlist

- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- relevant validator/materializer tests
- `test/widget/edit_component_screen_test.dart` if emitted-field assertions are
  required
- `lib/features/components/screens/edit_component_screen.dart` only for focused
  emitted-field alignment checks
- `lib/features/components/services/v2_edit_component_writer.dart` only if a
  narrow allowlist guard is needed and contract tests prove the contract.
- governance/audit docs

## Future forbidden

- UI-only mitigation presented as the only contract-fix route.
- `tools/event_writer_service.py`
- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- Save Measurement UI
- Add Component UI
- Project ZIP import/export
- Board Canvas runtime/write/edit
- Reference Images runtime
- AI/OCR/CV
- Visual Trace Shape Assist
- Photo Markup
- Repair Map
- `pubspec.yaml`, `pubspec.lock`, dependency config/lock/runtime files
- package/dependency files
- generated artifacts/platform/sample trees
- broad Edit Component redesign
- Edit Component empty state UX
- Save Measurement unit cleanup
- PCB-first redesign
- `sequence` addition
- V2 schema/model rewrite without this scope lock

## Required future tests

- validator accepts only explicit component field allowlist for `component_updated`
- validator rejects unknown `component_updated` change fields
- validator rejects proof-like/unsafe component field names
- validator still requires `field`, `old_value_observed`, `new_value`, and `change_kind`
- materializer projects every validator-accepted user-visible component field
- `package_hint` projects as hint-only metadata when accepted
- `component_created` + `package_hint` projection/validation parity is tested if the
  create-side gap is confirmed in code
- UI/widget test asserts Edit Component emits only allowed fields when UI checks are required
- no `sequence` field in component updates
- no AI/helper/candidate/reference/photo/`visual_trace` promotion to canonical fields
- no writer-service semantic change

## Route decision

Current pass: `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS`

Next recommended pass:
`V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_POST_AUDIT_PASS`

## Validation

Required checks run for this pass transition:

- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
- `git log --oneline --decorate -12`

Expected result:

- Repo shows only the docs edits listed in this lock pass.
- Working tree is clean of runtime/test/schema changes.

## Safe-for-reaudit

`safe_for_reaudit: YES`
