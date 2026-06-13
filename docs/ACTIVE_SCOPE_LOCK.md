# Active Scope Lock

## Current pass

`V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock for V2 component field contract alignment.
No runtime, schema, writer, test, or model-surface edits are part of this pass.
Validator/materializer contract repair is the future implementation seam, not UI-only enforcement.

## Next recommended pass

`V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_POST_AUDIT_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- Runtime changes outside the above allowlist are forbidden in this pass.
- `schemas/`, `tools/event_writer_service.py`.
- `lib/features/components/services/v2_edit_component_writer.dart`
  (unless the validator/materializer contract is already in place and UI tests
  prove emitted field claims).
- Project ZIP contract/runtime, Board Canvas write/edit, Reference Images runtime.
- AI/OCR/CV, Activity Timeline, Measure Momentum, Photo Markup, Repair Map,
  Visual Trace Shape Assist.
- `samples/`, generated artifacts, platform folders, tags/releases.
- Dependency/plugin/tool installs, plugin enablement, MCP/package/dependency config
  changes.
- No `sequence` is added in V2 component payloads.
- `pubspec.yaml`, `pubspec.lock`, package/dependency files remain forbidden.

## Route lock

Current: `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS`
Next: `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_POST_AUDIT_PASS`
