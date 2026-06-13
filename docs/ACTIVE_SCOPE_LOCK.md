# Active Scope Lock

## Current pass

`V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS`

## Type

`VALIDATOR_MATERIALIZER_IMPLEMENTATION_PASS`

## Lane

`CODEX / VALIDATOR_MATERIALIZER_IMPLEMENTATION_PASS`

## Mode

Align validator acceptance and materializer projection for V2 component field contracts.
No writer-service, schema, event envelope, platform, ZIP, Board Canvas, AI/OCR/CV,
or unrelated runtime surface changes.
`component_updated`/projected-component fields must stay shared-contract constrained, with
`package_hint` treated as user-visible hint context.

## Next recommended pass

`V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_POST_AUDIT_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS.md`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `tests/test_validate_events_jsonl.py`
- `tests/test_materialize_known_facts.py`

## Forbidden surfaces

- Runtime/Writer/Schema changes outside the above allowlist are forbidden in this pass.
- `schemas/`, `tools/event_writer_service.py`.
- `lib/features/components/services/v2_edit_component_writer.dart`
  (unless a narrow allowlist-backed field contract guard is explicitly
  justified by UI alignment checks and this implementation remains primary to
  validator/materializer contract repair).
- `lib/features/components/screens/edit_component_screen.dart` unless only
  narrow emitted-field assertions are required by this pass.
- Project ZIP contract/runtime, Board Canvas write/edit, Reference Images runtime.
- AI/OCR/CV, Activity Timeline, Measure Momentum, Photo Markup, Repair Map,
  Visual Trace Shape Assist.
- `samples/`, generated artifacts, platform folders, tags/releases.
- Dependency/plugin/tool installs, plugin enablement, MCP/package/dependency config
  changes.
- No `sequence` is added in V2 component payloads.
- `pubspec.yaml`, `pubspec.lock`, package/dependency files remain forbidden.

## Route lock

Current: `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_PASS`
Next: `V2_COMPONENT_UPDATE_FIELD_PROJECTION_ALIGNMENT_POST_AUDIT_PASS`
