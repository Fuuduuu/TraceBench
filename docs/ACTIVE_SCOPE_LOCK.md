# Active Scope Lock

## Current pass

`V2_EDIT_COMPONENT_EMPTY_STATE_UX_PASS`

## Type

`FLUTTER_IMPLEMENTATION_PASS`

## Lane

`CODEX / FLUTTER_IMPLEMENTATION_PASS`

## Mode

Narrow implementation pass for the Edit Component no-components empty-state UX.
Runtime behavior remains constrained to `lib/features/components/screens/edit_component_screen.dart`
and `test/widget/edit_component_screen_test.dart`.

Current goal:

- lock a future UX behavior when Edit Component is opened with zero known components;
- preserve accepted V2 Edit Component runtime boundaries unchanged (`component_updated` only, existing-component writes, explicit human confirmation).
- keep `Edit Component` behavior unchanged when components exist.

## Next recommended pass

`V2_EDIT_COMPONENT_EMPTY_STATE_UX_POST_AUDIT_PASS`

## Current scope lock decision

- scope type: `FLUTTER_IMPLEMENTATION_PASS`
- lane: `CODEX / FLUTTER_IMPLEMENTATION_PASS`
- mode: implementation begins; runtime edit-screen and widget tests only.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_EDIT_COMPONENT_EMPTY_STATE_UX_SCOPE_LOCK_PASS.md`
- `lib/features/components/screens/edit_component_screen.dart`
- `test/widget/edit_component_screen_test.dart`
- `docs/audit/V2_EDIT_COMPONENT_EMPTY_STATE_UX_PASS.md`

## Allowed implementation files (pass scope)

- `lib/features/components/screens/edit_component_screen.dart`
- `test/widget/edit_component_screen_test.dart`
- optional narrow route/overview tests only if needed for an existing Add Component action assertion

## Forbidden future surfaces

- `lib/features/components/services/v2_edit_component_writer.dart`
- `test/widget` beyond the allowlisted Edit Component widget test file
- `schemas/`
- `tools/`
- writer service, validator, materializer semantic changes
- `Project ZIP`, Board Canvas runtime/write/edit, Reference Images runtime
- AI/OCR/CV
- Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist
- `pubspec.yaml`, `pubspec.lock`, package/dependency files
- `samples/`, generated files, platform folders, tags/releases
- Add Component domain model/copy/design changes
- canonical event/sequence changes to V2
- `MeasurementEventWriter` reintroduction or legacy route fallback
- no runtime implementation beyond this targeted screen and test pass

## Forbidden surfaces

Runtime/code changes outside the allowlist are forbidden until a separate implementation lane opens.

- No `sequence` is added to V2 events in this lock.
- No event type/model changes are allowed.
- Do not change `tools/event_writer_service.py` behavior or route.
- Preserve: `Edit Component` remains existing-component-only with no component auto-creation.
- Preserve existing Add Component and Save Measurement accepted behavior.
- Preserve the existing `/project/components/edit` route contract unless a separate route-review pass allows changes.

## Route lock

Current: `V2_EDIT_COMPONENT_EMPTY_STATE_UX_PASS`
Next: `V2_EDIT_COMPONENT_EMPTY_STATE_UX_POST_AUDIT_PASS`
