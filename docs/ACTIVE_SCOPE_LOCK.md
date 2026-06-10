# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_ADD_COMPONENT_PASS`
- Lane: `CODEX / FLUTTER_PASS / UI_WRITE_FLOW`
- Mode: narrow V2 Add Component implementation
- Next recommended pass: `V2_ADD_COMPONENT_POST_AUDIT_PASS`

## Goal

Implement the accepted V2 Add Component UI write-flow only.

The pass may create only `component_created` events through the accepted writer-service adapter. The UI/service must never append directly to `events.jsonl`.

## Write allowlist for this pass

- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/services/v2_add_component_writer.dart`
- `lib/app/router.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/add_component_screen_test.dart`
- `test/unit/v2_add_component_writer_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PASS_QUEUE.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_ADD_COMPONENT_PASS.md`

Do not write outside these surfaces.

## Required implementation boundaries

- Future/current event type is hard-limited to `component_created`.
- Event construction must preserve `actor.type = human`.
- Event construction must preserve `source.type = explicit_user_confirmation`.
- Event construction must preserve `confirmation.confirmed = true`.
- UI/service must call the accepted writer-service adapter boundary.
- UI/service must never directly append to `events.jsonl`.
- Idempotent existing writer results must not duplicate local `ProjectState.events`.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remain hints/context only.
- Hints must not auto-confirm component identity, pins, nets, measurements, or faults.
- Save Measurement behavior remains unchanged.

## Forbidden surfaces

Do not modify or implement:

- Save Measurement behavior except shared safe integration if explicitly required.
- Edit Component.
- Project ZIP.
- Activity Timeline.
- Measure Momentum.
- Board Canvas write/edit behavior.
- Reference Images runtime.
- AI/OCR/CV.
- Photo Markup / Repair Map / Visual Trace Shape Assist.
- Validator behavior.
- Materializer behavior.
- Schema / JSON schema files.
- `tools/event_writer_service.py` behavior.
- Platform/generated/assets/samples/tags/releases.
- Deterministic idempotency semantics outside the Add Component request itself.

## Test requirements

- Add button disabled until required human-entered/confirmed component fields exist.
- Valid Add Component calls the writer once.
- Generated event is only `component_created`.
- Actor/source/confirmation are correct.
- Candidate/template/photo/helper values do not auto-confirm identity.
- Package/footprint/template hints remain hints only.
- Writer validation failure shows not saved.
- Writer append/path/lock failure shows not saved.
- Idempotent existing result does not duplicate local UI state.
- No diagnosis/probability/verified/good/correct wording.
- No Board Canvas / Reference Images / Guided Helper write path.
- No Project ZIP changes.

## Route lock

- Current pass: `V2_ADD_COMPONENT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_POST_AUDIT_PASS`

## Validation

- `dart format` on changed Dart files.
- `dart analyze` changed Dart files.
- Focused Add Component tests.
- Focused Save Measurement tests only if shared Save Measurement code is touched.
- `flutter test --reporter expanded`.
- `py -3 tools\validate_all.py`.
- `git diff --check`.
- `git status --short --branch`.
- `git diff --name-only`.
