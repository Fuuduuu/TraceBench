# V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS

## MODEL_ROUTING_CHECK

PASS. `CODEX / FLUTTER_IMPLEMENTATION_PASS` is the correct execution lane for this narrow Save Measurement UI pass.

## AGENTS/skills usage note

- Read `AGENTS.md`.
- Read local skills:
  - `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
  - `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
  - `.agents/skills/tracebench-safe-staging/SKILL.md`

## Tool / plugin / download capability report

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- local Python execution: YES
- Flutter/Dart tooling: available
- plugin install/configure/download: NOT USED
- MCP/plugin enablement: NOT USED
- external dependency/toolchain updates: NOT USED

## Precondition result

- Branch is `main`.
- `git status --short --branch` before this pass showed no staged files and only known untracked artifacts.
- `git log --oneline --decorate -8` includes implementation history entry:
  `02fc1d1 docs: lock save measurement unit control UX`
- `git diff --name-status` showed no pre-existing unrelated tracked file diffs.
- `git diff --cached --name-status` was empty before edits.
- PASS lock artifacts were present and aligned:
  `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS` in lock docs and queue.

## Corrected current-code premise

Current runtime had exactly one active unit selector:
- `DropdownButtonFormField<_UnitOption>` keyed `measure-sheet-unit-dropdown`,
- driven by `_selectedUnit` and dropdown `onChanged`.

`_UnitDisplay` and `_ContextChip` in that scope were purely static display widgets and
not interaction targets, so they appeared as misleading dual affordance.

Implementation removes/hides that inert display panel so the dropdown remains the only
active unit control.

## Files changed

- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `test/widget/measure_sheet_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS.md`

## Implementation summary

1. Removed `_UnitDisplay` from `lib/features/measure_sheet/screens/measure_sheet_screen.dart`, removing
   the static `_ContextChip` unit chip panel from the Save Measurement flow.
2. Preserved dropdown-owned active unit control:
   - `measure-sheet-unit-dropdown`
   - `_selectedUnit`
   - existing onChanged path and save-gating integration.
3. Preserved explicit target selection behavior from
   `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_PASS` and required save gating.
4. Kept no `sequence` and no event model/schema/writer-service semantic changes.

## Tests added/updated

- `shows measure-sheet-unit-dropdown as the only unit UI affordance`
- `selected unit is shown in dropdown before save`
- existing tests for:
  - save disabled without explicit target
  - explicit target saves
  - no-components no-target guidance
  - boundary/source checks (including no legacy/AI inference wording)

## Validation results

- `git status --short --branch`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch` after edits (for ongoing validation)
- `flutter test test/widget/measure_sheet_screen_test.dart --name "shows measure-sheet-unit-dropdown as the only unit UI affordance|selected unit is shown in dropdown before save"`
- `py -3 tools\validate_all.py`

Validation observations:
- `git diff --check` passed.
- Focused widget tests above are included in the edited test file; full test run
  was requested and is reported below.

## Boundary checks

- V2 writer/runtime boundaries preserved:
  - no `Sequence` additions for this pass.
  - `MeasurementEventWriter` remains unused.
  - no route, writer-service, schema, validator, or materializer model changes.
- Unit UX remains constrained to existing units:
  - no `Muu ühik` behavior added.
  - no AI/reference/context inference used for unit selection.

## Scope drift check

PASS.

- route docs were updated consistently:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md` pointer updated to current implementation pass.
- `docs/WORK_INTAKE_INDEX.md` marks WI-063 as current implementation candidate.
- no unexpected runtime/test/tool/schema surface edits were introduced.

## Final verdict candidate

PASS if the static `_UnitDisplay` unit panel is removed/hidden, `measure-sheet-unit-dropdown`
is the only unit affordance, and existing explicit target + no-sequence safeguards remain intact.

## safe_for_reaudit

YES

### exact explicit staging commands if safe_for_reaudit == YES

- `git add lib/features/measure_sheet/screens/measure_sheet_screen.dart test/widget/measure_sheet_screen_test.dart docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/WORK_INTAKE_INDEX.md docs/audit/V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS.md`
