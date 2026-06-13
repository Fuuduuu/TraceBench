# Active Scope Lock

## Current pass

`V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs-only closeout for the accepted
`V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_PASS` implementation. No runtime,
schema, writer, test, or model-surface edits are part of this pass.

## Next recommended pass

`NEEDS_USER_DECISION`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_CLOSEOUT_PASS.md`

## Forbidden surfaces

- Runtime changes outside the above allowlist are forbidden in this pass.
- `schemas/`, `tools/validate_events_jsonl.py`,
  `tools/materialize_known_facts.py`, `tools/event_writer_service.py`.
- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`.
- Project ZIP contract/runtime, Board Canvas write/edit, Reference Images runtime.
- AI/OCR/CV, Activity Timeline, Measure Momentum, Photo Markup, Repair Map,
  Visual Trace Shape Assist.
- `samples/`, generated artifacts, platform folders, tags/releases.
- Dependency/plugin/tool installs, plugin enablement, MCP/package/dependency config
  changes.
- No `sequence` is added in Save Measurement V2 payloads.
- `pubspec.yaml`, `pubspec.lock`, package/dependency files remain forbidden.

## Route lock

Current: `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_CLOSEOUT_PASS`
Next: `NEEDS_USER_DECISION`
