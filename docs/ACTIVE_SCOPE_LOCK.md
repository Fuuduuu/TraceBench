# Active Scope Lock

## Current pass

`V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout of already accepted/pushed `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS`.
No runtime/test/schema/materializer/validator/sequence or feature surfaces are changed in this pass.
Closeout preserves the accepted boundary that component projection contract alignment is complete:
`component_updated` is shared-policy constrained, and only allowed hint/context fields (`package_hint`, `human_note`) project as metadata.

## Next recommended pass

`NEEDS_USER_DECISION`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS.md`
- `docs/audit/V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_CLOSEOUT_PASS.md`

## Forbidden surfaces

Runtime/schema/validator/materializer/tools/event_writer_service/surface changes outside the docs
allowlist are forbidden in this pass.

- `lib/` runtime
- `test/` (runtime test edits)
- `schemas/`
- `tools/event_writer_service.py`
- `tools/*.py` semantic edits
- `tools/event_writer_service.py` implementation changes
- `pubspec.yaml`, `pubspec.lock`, package/dependency files
- `samples/`, generated artifacts, platform folders, tags/releases
- Dependency/plugin/tool installs, plugin enablement, MCP/package/dependency config changes
- `Project ZIP`, Board Canvas runtime/write/edit, `Reference Images` runtime, AI/OCR/CV, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist
- No `sequence` is added in V2 component payloads.

## Route lock

Current: `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_CLOSEOUT_PASS`
Next: `NEEDS_USER_DECISION`
