# Active Scope Lock

## Current pass

`V2_EDIT_COMPONENT_PASS`

## Type

`implementation`

## Lane

`CODEX / FLUTTER_PASS / UI_WRITE_FLOW`

## Mode

Implement only the accepted V2 Edit Component UI write-flow. Do not broaden into Edit-adjacent surfaces or other canonical write flows.

## Audit contract

Apply `docs/AUDIT_CONTRACT.md` contract: `implementation-post-audit`.

## Next recommended pass

`V2_EDIT_COMPONENT_POST_AUDIT_PASS`

## Write allowlist for this pass

- Minimal Edit Component UI/service/provider files required for human-confirmed `component_updated`.
- Minimal writer-adapter integration if needed.
- Focused Edit Component widget/unit tests.
- Focused Project Overview navigation tests if route/discoverability is added.
- Focused Add Component tests only if shared code is touched.
- Focused Save Measurement tests only if shared writer/path code is touched.
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md` only if needed
- `docs/audit/V2_EDIT_COMPONENT_PASS.md`

## Required behavior

- Edit Component creates only `component_updated`.
- Edit targets an existing component only and must not create a new component.
- UI/service uses the accepted writer-service adapter pattern.
- UI/service never appends directly to `events.jsonl`.
- `actor.type = human`.
- `source.type = explicit_user_confirmation`.
- `confirmation.confirmed = true`.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remains hint/context only.
- No automatic identity confirmation, pin mapping, net, measurement, fault proof, diagnosis, or probability.
- Save Measurement and Add Component accepted behavior remains unchanged.

## Forbidden surfaces

- Save Measurement behavior changes.
- Add Component behavior changes unless shared safe integration is explicitly needed and documented.
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

## Validation

- `dart format` on changed Dart files.
- `dart analyze` changed Dart files.
- Focused Edit Component tests.
- Focused Add Component tests if shared code touched.
- Focused Save Measurement tests if shared writer/path code touched.
- `flutter test --reporter expanded`.
- `py -3 tools\validate_all.py`.
- `git diff --check`.
- `git status --short --branch`.
- `git diff --name-only`.

## Route lock

Current: `V2_EDIT_COMPONENT_PASS`.
Next: `V2_EDIT_COMPONENT_POST_AUDIT_PASS`.
