# V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Docs-only scope-lock work is appropriate for Codex in this lane.

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Tool / plugin / download capability report

### Available local capabilities

- filesystem read: YES
- shell/PowerShell: YES
- git: YES
- local Python execution: YES
- Flutter/Dart tooling: YES
- plugin install/configure/download: NOT USED
- external MCP/plugin enablement: NOT USED

### Plugin / download constraint summary

- No new tool or plugin was installed, enabled, configured, or downloaded.
- No external dependency/toolchain changes were attempted.

## Start-state checks

- `git status --short --branch`: repository clean of staged or unstaged tracked file edits before this pass; only known untracked scratch artifacts existed.
- `git log --oneline --decorate -8`: `HEAD` is at `9666dbf` as expected from the previous docs tooling/scope lock history before this pass.
- `git diff --name-status`: no pre-pass tracked diffs.
- `git diff --cached --name-status`: no staged changes before this pass.

## Scope drift check

PASS.

- PASS_ID exists in `docs/PASS_QUEUE.md`.
- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` were aligned before edit.
- Write allowlist for this pass is docs-only and matches this pass requirement.
- No protected runtime/runtime-adjacent surfaces were modified in this pass.
- Evidence-floor checks passed: no new measurements/components/nets/AI facts were introduced by documentation updates.

## Current-code (read-only) findings that must inform scope lock

1. `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
   - `_MeasureSheetSelection.fromProject` chooses:
     - first component via `components.first`.
     - first pin via `_firstPinLabel` from `componentPinIndex` first entry / first matching pin.
   - `_MeasureSheetSelection.targetKey` is computed as `pinId ?? componentId ?? 'unknown_target'`.
   - `_canSave` depends on `_formKey(selection)` and therefore on `selection.hasSaveTarget`.
   - `selection.hasSaveTarget` is `componentId != null || pinId != null`.
   - No explicit target-pick control is present; the UI shows `selection.kohtLabel` in a read-only flow field.

2. `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
   - Existing writer call path still supports explicit target IDs via `componentId`/`pinId`.
   - `target_kind` remains computed from provided IDs; this pass does not request changing writer-service behavior.

3. `test/widget/measure_sheet_screen_test.dart`
   - Existing tests verify write request contains chosen component/pin values (e.g., Q2 / Q2.1) and save idempotency/validation behavior.
   - No existing test asserts that `target` auto-selection is forbidden.
   - No existing test covers no-components/no-pins explicit-blocking behavior for Save Measurement target.

## Scope-lock risk summary

### Exact current risk

The current Measure Sheet runtime implicitly auto-selects the first component (`components.first`) and then first pin for display and selection derivation. This can allow a technician to save a valid `measurement_recorded` event against the wrong target if the projected state differs from what was intended.

### Locked behavior rules for future implementation

- Save Measurement must require explicit user target selection before write.
- Save must remain disabled until:
  - target is explicitly selected,
  - measurement value is entered,
  - unit is selected,
  - save not already in progress.
- The measure-sheet UI may keep projection data as read-only context, labels, and helper copy.
- If no components/pins are present, show clear no-target guidance and keep Save disabled.
- Explicit target can only be component-level and/or pin-level when supported by existing projection/fact data.

### Explicitly forbidden future behavior

- No implicit auto-selection from `components.first` / first pin.
- No save without explicit target choice from user controls.
- No inferred targets from photo/AI/reference/visual-trace hints.
- No introduction of `sequence` into V2 events.
- No change to accepted V2 event semantics in this scope lock.

## Allowed future implementation/touch surface (if accepted later)

- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `test/widget/measure_sheet_screen_test.dart`

### Conditional future touch

- Route and overview tests only if necessary for narrow navigation/affordance assertions.
- No route behavior change is expected in this locked implementation slice.

## Forbidden future touch surfaces unless separately scoped

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `schemas/`
- Project ZIP runtime/import/export surfaces
- Board Canvas runtime/edit behavior
- Reference Images runtime
- AI/OCR/CV paths
- Visual Trace Shape Assist
- Photo Markup
- Repair Map
- package/dependency/tooling config files
- generated artifacts and platform folders

## Required future tests to prove lock behavior

1. Save remains disabled when no explicit target exists, even with valid value + unit.
2. Selecting explicit component target enables Save when value + unit are valid.
3. Selecting explicit pin target saves using explicit target metadata.
4. Save does not silently use `components.first` / first pin as target.
5. No-component / no-pin state shows clear message and keeps Save disabled.
6. Boundary tests remain in place for non-V2 model changes:
   - still uses `v2SaveMeasurementWriterProvider`,
   - no `/project/measurements/new` dependency,
   - no `sequence` in target flow,
   - no writer-schema-modelity changes.

## Non-goals

- Do **not** change duplicated unit controls in this pass.
- Do not add custom unit (`Muu ühik`) behavior.
- Do not introduce PCB-first `Project Overview` redesign.
- Do not introduce board-point based new measurement target model.
- Do not modify V2 event schema, writer semantics, Project ZIP, Board Canvas runtime, Reference Images runtime, tests, or tests-only runtime tools in this scope-lock pass.

## Boundary preservation notes

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No V2 event model changes are made.
- No schema/model/validator/materializer/writer-service behavioral change is made.
- No `sequence` is added to Save Measurement V2 payloads.
- Candidate/reference/context fields are not promoted to canonical truth in this scope lock.

## Files changed

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_PASS.md`

## Validation run plan

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Route decision

- Current route remains docs-only scope lock:
  `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_PASS`.
- Next route:
  `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_SCOPE_LOCK_POST_AUDIT_PASS`.

## safe_for_reaudit

YES
