# V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. `CODEX / DOCS_SCOPE_LOCK` is the correct lane for this narrow future implementation lock.

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock only. No runtime, test, schema, tool, or writer-service edits in this pass.

## AGENTS/skills usage note

- Read `AGENTS.md`.
- Reviewed local guidance in:
  - `.agents/skills/tracebench-scope-lock/SKILL.md`
  - `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
  - `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
  - `.agents/skills/tracebench-safe-staging/SKILL.md`

## Tool / plugin / download capability report

### Available local capabilities

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- local Python execution: YES
- Flutter/Dart tooling: available but unused in this lock pass
- plugin install/configure/download: NOT USED
- MCP/plugin enablement: NOT USED
- external dependency/plugin/toolchain updates: NOT USED

### Constraint summary

- No new tool/plugin/dependency installs, MCP enablement, downloads, or dependency/config updates were performed.
- No runtime/tooling/service/surface files were modified.

## Precondition result

- Branch is `main`.
- `git status --short --branch` before this pass showed known untracked artifacts only and no tracked file diffs beyond docs edits introduced by this pass.
- `git log --oneline --decorate -8` points at the expected `f4ae399` current HEAD.
- `git diff --name-status` before edits showed only tracked docs touched by this lane plus untracked artifacts.
- `git diff --cached --name-status` was empty before changes.
- `PASS_ID` exists in `docs/PASS_QUEUE.md`.

## Current-code findings that define scope lock

Read-only inspection confirms the current unit-selection implementation is deterministic:

1. There is exactly one active unit selector — `DropdownButtonFormField<_UnitOption>` keyed `measure-sheet-unit-dropdown` — which drives `_selectedUnit` and gates Save.
2. `_UnitDisplay` is a static, non-interactive informational panel with heading `Text('Ühik')` and a `const Wrap` of `_ContextChip` widgets.
3. `_ContextChip` is a plain `Chip(label: Text(label))` with no `onPressed`/`onSelected`/gesture callback.
4. Save flow gating currently requires:
   - non-empty measurement value,
   - selected unit (`_selectedUnit != null`),
   - explicit target selection (`_selectedTargetKey != null`) carried from prior target-selection lock,
   - no active save-in-progress state.
5. Existing explicit target behavior from the prior implementation lock remains intact:
   - no implicit `components.first` target selection,
   - user must explicitly select from `measure-sheet-target-dropdown`,
   - no automatic target fallback in the current lock context.
6. Existing tests currently assert explicit target and write-shape boundaries, but there is no dedicated assertion that the non-interactive `_UnitDisplay` panel is removed/hidden to keep the dropdown as the single active affordance.
7. Current test evidence does not contain a positive proof that the future-locked UX refinement has yet been implemented.

## Exact current UX risk

The risk is a misleading/redundant inert affordance:

- `_UnitDisplay` chips visually resemble selectable unit options,
- but they are static/non-interactive and do not participate in unit selection,
- while only `measure-sheet-unit-dropdown` mutates `_selectedUnit`.

Unit selection itself is deterministic today because only the dropdown mutates `_selectedUnit`.

## Chosen future UX policy

Future implementation must choose and enforce one primary control model. Selected policy:

- **Policy B**: Keep a dropdown as the only primary unit selector and remove/hide the non-interactive `_UnitDisplay` unit chips/panel so the dropdown is the single unambiguous unit affordance.

This policy is explicit and narrow; it does not include custom unit input in this pass.

## Locked future implementation scope

`V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_PASS` is locked to the following future behavior:

- exactly one active unit-selection source of truth,
- visible selected unit state before Save,
- existing explicit target-selection requirement unchanged,
- Save disabled until unit + value + explicit target conditions are all satisfied,
- no sequence additions and no V2 event-schema/writer-service semantic changes,
- no custom-unit (`Muu ühik`) behavior added in this locked scope.

## Allowed future implementation files

- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `test/widget/measure_sheet_screen_test.dart` (focused unit-control and regression coverage)
- route/overview tests only if narrowly needed to prove unchanged behavior.

## Forbidden future touches

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `schemas/`
- Project ZIP import/export surfaces
- Board Canvas runtime/write/edit
- Reference Images runtime
- AI/OCR/CV
- Visual Trace Shape Assist
- Photo Markup
- Repair Map
- Add Component UI
- Edit Component UI
- `lib/features/add_component/...`
- `lib/features/edit_component/...`
- `component_updated` contract/surface changes
- measurement event schema/validator/materializer/model edits
- `pubspec.yaml`, `pubspec.lock`, package/config/dependency files
- generated artifacts, platform folders, samples

## Required future tests

The implementation pass must include focused tests for:

1. unit selection has one primary UI control under Policy B,
2. the non-interactive `_UnitDisplay` unit chips/panel is removed or hidden so the dropdown is the only unit affordance,
3. selected unit is visibly reflected in the measurement form,
4. Save remains disabled until value + unit + explicit target conditions pass,
5. Save can proceed with explicit target and selected unit on valid input,
6. existing explicit-target behavior from prior lock remains unchanged:
   - no writer call before explicit target,
   - explicit component/pin selection required,
   - no-target state stays blocked,
7. boundary/source tests remain:
   - no `sequence` field in V2 save path,
   - no legacy `MeasurementEventWriter` re-introduction,
   - no direct `event_writer_service` UI write path,
   - no AI/confidence/proof inference paths,
8. no custom unit (`Muu ühik`) feature is introduced in this scope.

## Boundary preservation notes

- `events.jsonl` remains canonical truth and `known_facts.json` remains projection/cache.
- writer semantics and V2 event boundaries remain unchanged until a dedicated implementation pass.
- no sequence field is added to V2 events under this lock or its immediate test scope.
- explicit target-selection and target payload contracts from `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_PASS` remain unchanged.
- no hidden canonical inference from candidate/reference/AI context in unit selection.

## Scope drift check

PASS.

- `PASS_ID` exists in `docs/PASS_QUEUE.md`.
- Route docs (`docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`) are already aligned to:
  `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS` -> `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_POST_AUDIT_PASS`.
- Write allowlist is docs-only + future implementation file specification, no runtime implementation started in this pass.
- No protected runtime surfaces were edited.
- Evidence-floor boundaries respected.

## Validation

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Route decision

Current pass: `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS`

Next pass: `V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_POST_AUDIT_PASS`

## Verdict candidate

PASS if docs-only scope-lock records are accurate, route-consistent, and no forbidden/runtime/test/schema/tool files are changed.

## safe_for_reaudit

YES

### exact explicit staging commands (if safe_for_reaudit == YES)

- `git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/WORK_INTAKE_INDEX.md docs/audit/V2_SAVE_MEASUREMENT_UNIT_CONTROL_UX_SCOPE_LOCK_PASS.md`
