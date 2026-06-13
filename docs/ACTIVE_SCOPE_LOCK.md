# Active Scope Lock

## Current pass

`V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_PASS`

## Type

`CODEX / DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope-lock pass that freezes the future implementation boundaries for
explicit Save Measurement target selection before writing and does not change
runtime behavior.

## Next recommended pass

`V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_POST_AUDIT_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- Runtime behavior and implementation changes are forbidden in this pass.
- `schemas/`, `validator/`, `materializer/`, and writer service files.
- `Project ZIP`, `Board Canvas` write/edit runtime, `Reference Images` runtime.
- `AI/OCR/CV`, `Activity Timeline`, `Measure Momentum`.
- `Photo Markup`, `Repair Map`, `Visual Trace Shape Assist`.
- `samples/`, generated artifacts, platform folders, tags/releases.
- Plugin dependency updates, MCP/plugin enablement, or external installs in this pass.
- `sequence` remains forbidden in V2 event payloads from Save Measurement scope.
- Future implementation MUST:
  - touch only `lib/features/measure_sheet/screens/measure_sheet_screen.dart` and
  `test/widget/measure_sheet_screen_test.dart`, and
  - do so under a separate implementation pass after this lock post-audit.

## Route lock

Current: `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_PASS`
Next: `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_POST_AUDIT_PASS`
