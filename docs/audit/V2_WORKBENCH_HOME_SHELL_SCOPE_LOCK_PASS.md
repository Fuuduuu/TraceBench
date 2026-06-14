# V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS.
`CODEX / DOCS_SCOPE_LOCK` is the correct lane for this docs-only scope-lock pass before implementation.

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock. No runtime, tests, schema, validator/materializer, writer-service, tool, sample, generated, or platform changes are allowed in this pass.

## AGENTS/skills usage note

- Read `AGENTS.md` for repo-level governance, read-order, and protected-surface priorities.
- Confirmed and used repo-local guidance entries:
  - `.agents/skills/tracebench-scope-lock/SKILL.md`
  - `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
  - `.agents/skills/tracebench-safe-staging/SKILL.md`
  - `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
- No MCP/plugin installs, enablements, downloads, or dependency/toolchain changes were required or performed.

## Tool / plugin / download capability report

### Available local capabilities

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- Flutter/Dart tooling: available but unused in this scope lock
- plugin/MCP install, configure, download, or dependency/tool updates: NOT USED

### Constraint summary

- No runtime, schema, validator/materializer, tool, writer, sequence, or route edits were made.
- No test files or generated/platform/sample artifacts were modified.
- Only governance/audit docs under the pass allowlist were updated.

## Precondition result

- Branch is `main`.
- `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md` were updated to current this pass.
- `docs/ACTIVE_SCOPE_LOCK.md` now points to `V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS`.
- `docs/AUDIT_INDEX.md` and `docs/WORK_INTAKE_INDEX.md` were updated for this pass.
- `docs/audit/V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS.md` was created.
- `git status --short --branch` and lock-gate checks were planned for final validation.

## Current-code read-only findings

Baseline read-only inspection covered the requested files and route references:

1. `lib/features/project/screens/project_overview_screen.dart`
   - `Lisa mõõtmine` and `Mõõda` flows remain list/card action-first with flat CTA layout.
   - Existing routes are already wired via `context.go(...)`.
   - Add/Edit Component and Board/Reference actions exist.
   - No writer or event emission logic exists in screen build path.
   - `ProjectionStaleBanner` is present and data-driven.
2. `test/widget/project_overview_screen_test.dart`
   - Covers stale-state rendering and required navigation actions (`Measure Sheet`, Add/Edit, Board Graph, Board Canvas, Reference Images).
   - Asserts legacy `/project/measurements/new` redirect.
   - Confirms manual-menu structure and action ordering expectations.
3. `lib/features/board_canvas/screens/board_canvas_screen.dart`
   - Explicitly texts read-only behavior.
   - No drag/create/event-write/AI/confidence semantics in projection/inspect path.
   - No `Project ZIP`/writer/materializer behavior.
4. `lib/app/router.dart`
   - Existing route graph already includes:
     - `/project/measure-sheet`
     - `/project/measurements/new` (redirect)
     - `/project/components/add`
     - `/project/components/edit`
     - `/project/board-canvas`
     - `/project/graph`
     - `/project/reference-images`
5. `test/integration/board_graph_end_to_end_test.dart`
   - Preserves Board Graph reachability via existing action key usage.
6. `test/integration/projection_stale_banner_end_to_end_test.dart`
   - Preserves stale banner-only behavior for stale projection state across routes.
7. `lib/features/project/screens/project_overview_screen.dart` + related test evidence confirms zero-event runtime by default for home shell.

## Design / strategy adoption summary

- Inputs: `TECHNICIAN_FIRST_MEASURE_SHEET` review direction, Opus strategy outcomes, and current accepted PCB-first shell context.
- Accepted strategy verdicts:
  - `PROCEED` from technician workflow review context.
  - `MODIFY_PROMPT_FIRST` for implementation entry.
  - Option C / Hybrid accepted for first implementation slice:
    - build Workbench Home frame now;
    - defer deep renderer/marker/pan/zoom/photo/layers/AI candidate authoring to future scoped passes.

## Accepted Option C first implementation slice

The first implementation slice must be:

1. Board/workbench-centered Home layout with visible central zone.
2. Primary `Lisa mõõtmine` / measurement action clearly dominant.
3. Secondary Add/Edit/Board/Reference actions grouped and compact.
4. Context/measurement support shown as informational, not primary list-driven workflow.
5. Existing route contracts preserved.
6. No V2 event model/schema/writer path changes in this scope.

## Graceful center degradation policy

- If board placements are present:
  - show existing read-only board/workbench context as center content.
  - keep interactions read-only.
- If placements are absent/sparse:
  - show calm board/workbench placeholder + projection/context summary.
  - avoid dead, empty, menu-only center.
  - keep visual intent as technician workbench.
- At no point should degraded state imply write capability.

## Route/key / integration-preservation policy

- Preserve existing action key semantics and names.
- `overview-measurement-record-button` and `overview-board-graph-button` contracts remain stable.
- Save Measurement must continue to open the accepted measure sheet behavior.
- Add Component and Edit Component routes/actions remain unchanged.
- Board Graph / Board Canvas routes remain reachable.
- Reference/Photo evidence routes remain reachable where currently available.
- Existing legacy redirect `/project/measurements/new -> /project/measure-sheet` remains covered in lock scope and should remain unchanged unless separately scoped.

## Future tool inertness policy

Future workbench tools may be shown only as inert:

- no `onPressed`
- no navigation route
- no writer call
- no event write/mutation

Candidate inert tools:

- Lisa kontuur
- Tuvasta foto abil
- background photo toggle
- opacity
- layers
- AI candidates
- trace colors

These must be visually marked as candidate / disabled / not-yet-confirmed.

## Allowed files / surfaces

### Governance (current pass)

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS.md`

### Exact future implementation target (for next pass)

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- route tests for unchanged behavior only (no new behavior contract except lock-defined shell shape)
- optional small presentation-only helper widgets only if strong convention fit.

## Forbidden files / surfaces

- writer service/runtime files
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `schemas/`
- V2 event model/schema mutations
- known-facts projection semantics
- materializer / validator behavior changes
- Project ZIP changes
- Board Canvas write/edit/authoring and rich renderer expansion
- Reference Images runtime changes
- AI/OCR/CV
- Visual Trace Shape Assist
- Photo Markup
- Repair Map
- `Muu ühik` / custom unit behavior
- sequence field additions
- route behavior changes outside existing compatibility
- runtime/tool/schema/test changes unrelated to this lock

## Required future tests

1. Workbench-first layout:
   - central board/workbench zone is dominant first paint;
   - `Lisa mõõtmine` remains primary.
2. Graceful degradation:
   - non-empty placement and sparse/empty placement states render distinct safe placeholder/board summary behavior.
3. Existing route/key preservation:
   - measure, add/edit, board graph, board canvas, and reference routes remain intact.
   - existing keys keep expected navigations.
4. Integration retention:
   - `board_graph_end_to_end_test.dart` remains green.
   - `projection_stale_banner_end_to_end_test.dart` remains green.
5. Zero-event guarantee:
   - rendering and navigation in the workbench-home shell write zero events.
   - no fallback writes during first-paint/home interactions.
6. Read-only board boundary:
   - no drag-to-create and no canvas-authored facts.
   - no `event_writer_service` UI write path.
7. Evidence rendering:
   - measurement list remains contextual, not the primary control plane.
8. Validation gate:
   - full `flutter test` suite required (focused tests alone are insufficient).
   - `py -3 tools\validate_all.py` required and green.
   - existing full-suite count baseline context preserved in scope.

## Board/workbench read-only boundary

- First-pass Workbench Home uses projection/workbench read-only context only.
- No new write affordance in Board/Canvas/workbench space.
- No drag, no AI-assisted candidate mutation, no canvas-generated facts.

## Event / write boundary preservation

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection cache.
- No new `sequence` field in V2 events in this scope lock or first implementation slice.
- No legacy `MeasurementEventWriter` reactivation through home-shell path.
- No route or service-level writer path changes in this lock.

## Validation

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Route decision

Current pass: `V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS`

Next pass: `V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_POST_AUDIT_PASS`

## Verdict candidate

PASS if docs-only scope lock is complete, allowed files match allowlist, and no forbidden surface is touched in this pass.

## scope drift check

- `docs/CURRENT_STATE.md`: current pass points to `V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS`, next to `V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_POST_AUDIT_PASS`.
- `docs/PASS_QUEUE.md`: same current/next values and added lock/post-audit rows.
- `docs/ACTIVE_SCOPE_LOCK.md`: scope lock state and forbiddens match this pass.
- `docs/AUDIT_INDEX.md` and `docs/WORK_INTAKE_INDEX.md`: both include Workbench Home lock entries.
- No runtime/test/tool/schema files were changed.

## safe_for_reaudit

YES

### exact explicit staging commands (if safe_for_reaudit == YES)

- `git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/WORK_INTAKE_INDEX.md docs/audit/V2_WORKBENCH_HOME_SHELL_SCOPE_LOCK_PASS.md`

