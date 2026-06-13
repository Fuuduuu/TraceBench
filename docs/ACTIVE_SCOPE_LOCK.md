# Active Scope Lock

## Current pass

`V2_EDIT_COMPONENT_EMPTY_STATE_UX_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout pass. This pass records accepted implementation closure for
`V2_EDIT_COMPONENT_EMPTY_STATE_UX_PASS`.

Current goal:

- preserve accepted no-components empty-state behavior and route to existing Add Component flow.
- preserve accepted V2 Edit Component runtime boundaries unchanged (`component_updated` only, existing-component targeting, explicit human confirmation).
- keep next pass decision at `NEEDS_USER_DECISION`.

## Next recommended pass

`NEEDS_USER_DECISION`

## Current scope lock decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: governance docs-only closeout only; no runtime/test/schema/tool changes.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_EDIT_COMPONENT_EMPTY_STATE_UX_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_EDIT_COMPONENT_EMPTY_STATE_UX_PASS.md`
- `docs/audit/V2_EDIT_COMPONENT_EMPTY_STATE_UX_CLOSEOUT_PASS.md`

## Allowed implementation files (pass scope)

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_EDIT_COMPONENT_EMPTY_STATE_UX_CLOSEOUT_PASS.md`

## Forbidden future surfaces

- `lib/features/components/services/v2_edit_component_writer.dart`
- `test/widget` (closed out in docs-only pass)
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
- no runtime/testing implementation in this closeout lane

## Forbidden surfaces

Runtime/code changes outside the allowlist are forbidden until a separate implementation lane opens.

- No `sequence` is added to V2 events in this lock.
- No event type/model changes are allowed.
- Do not change `tools/event_writer_service.py` behavior or route.
- Preserve: `Edit Component` remains existing-component-only with no component auto-creation.
- Preserve existing Add Component and Save Measurement accepted behavior.
- Preserve the existing `/project/components/edit` route contract unless a separate route-review pass allows changes.

## Route lock

Current: `V2_EDIT_COMPONENT_EMPTY_STATE_UX_CLOSEOUT_PASS`
Next: `NEEDS_USER_DECISION`
