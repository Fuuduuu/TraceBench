# V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS.
`CODEX / DOCS_SCOPE_LOCK` is the correct lane for this docs-only scope-lock pass before any implementation.

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock. No runtime, test, schema, validator/materializer, writer-service, tool, sample, generated, or platform changes in this pass.

## AGENTS/skills usage note

- Read `AGENTS.md` for repo routing, invariants, and protected-surface priorities.
- Confirmed these repo-local guidance entries exist and were considered:
  - `.agents/skills/tracebench-scope-lock/SKILL.md`
  - `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
  - `.agents/skills/tracebench-safe-staging/SKILL.md`
  - `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
- No MCP/plugin install, enablement, or dependency/toolchain change was requested or performed.

## Tool / plugin / download capability report

### Available local capabilities

- filesystem read/write: YES
- shell/PowerShell: YES
- git: YES
- local Python execution: YES
- Flutter/Dart tooling: available but unused in this scope lock
- plugin/MCP install, configure, download, or dependency/tool updates: NOT USED

### Constraint summary

- No runtime, schema, validator/materializer, tool, or test files were modified.
- No dependency/toolchain files were changed.
- No route behavior was executed/altered in this pass.

## Precondition result

- Branch is `main`.
- Governance files listed in this pass are writable and within allowlist.
- `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md` have been updated to current this pass.
- `docs/ACTIVE_SCOPE_LOCK.md` now points to `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS`.
- `docs/AUDIT_INDEX.md` and `docs/WORK_INTAKE_INDEX.md` were updated to include this scope lock.
- `docs/audit/V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS.md` is present and new.

## Current-code read-only findings

Read-only inspections were completed on the requested surfaces:

1. `lib/features/project/screens/project_overview_screen.dart`
   - Uses `context.go('/project/measure-sheet')` for both legacy `Lisa mõõtmine` and Measure Sheet CTA.
   - Primary overview CTAs are currently rendered as flat buttons in a non-hierarchical list.
   - Route actions for Add/Edit Component, Board Canvas, and Reference Images already exist.
   - Stale banner rendering is present via `ProjectionStaleBanner(isStale: projectState.isProjectionStale)`.
2. `test/widget/project_overview_screen_test.dart`
   - Has coverage for stale banner visibility, route visibility to `Measure Sheet`, Add/Edit Component, Board Canvas, and Reference Images.
   - Verifies `/project/measurements/new` redirects to `/project/measure-sheet`.
   - Verifies the legacy "Lisa mõõtmine" button navigates to Measure Sheet path.
3. `lib/features/board_canvas/screens/board_canvas_screen.dart`
   - Text explicitly states board canvas is read-only and placement workflow is deferred.
   - Existing rendering uses confirmed-known-facts-only data and explicit inspector text such as "does not create or confirm connectivity."
   - No file-local evidence of writer/event emission, drag-to-write, or AI-generated fact mutation was observed.
4. `lib/app/router.dart`
   - `/project/measurements/new` is redirected to `/project/measure-sheet`.
   - Existing project overview and flow routes are already present (`/project/measure-sheet`, components, board-canvas, reference-images).

## Design-review input summary

Using `PCB-First Project Overview Shell - Design Review.html` (directional only):

- `Current pass` must be `DOCS_SCOPE_LOCK` with no implementation.
- The shell direction was accepted (`PROCEED`) but narrowed to presentation-only PCB-first Project Overview shell first.
- The primary UX emphasis is Technician-first hierarchy with `Lisa mõõtmine` dominant.
- Save/Add/Edit and reference surfaces are secondary and must remain bounded to explicit, unchanged behavior.

## Accepted design direction

- Board/PCB visual context first.
- Primary action: `Lisa mõõtmine / Save Measurement`.
- Read-only board context as framing context.
- Project identity/status visible up-front.
- Stale projection banner only when stale.
- Recent measurement glance available.
- Add/Edit Component secondary.
- Reference/candidate/context values under disclosure, not primary.
- Import/export/project admin under `More`.

## Exact first implementation slice

Future implementation must begin with a presentation-only PCB-first shell slice:

1. render existing board-first overview frame from current projection/state;
2. keep Save Measurement CTA as dominant action;
3. place Add Component and Edit Component as secondary;
4. show project/board identity and stale projection state as data-driven display;
5. keep board/canvas/references as optional secondary disclosure;
6. retain all current routes and writer entry points unchanged.

## Allowed future implementation files/surfaces

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart` (or closest existing overview test)
- route tests only if needed for unchanged behavior assertions
- governance/docs files listed in allowlist

## Forbidden future touches

- `lib/features/measure_sheet/services/v2_save_measurement_writer.dart` and related writer runtime
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `schemas/`
- event schema/model changes
- writer/validator/materializer semantic changes
- `Project ZIP`
- Board Canvas authoring/write/edit behavior
- Reference Images runtime changes
- `AI/OCR/CV`
- Visual Trace Shape Assist
- Photo Markup
- Repair Map
- Add/Edit Component writer/event semantic changes
- Save Measurement writer behavior
- `sequence` addition to V2 events
- `pubspec.yaml`, `pubspec.lock`, dependency/config files
- generated files, samples, platform folders, and toolchain/package files
- analyzer/lint cleanup

## Required future tests

1. Project Overview renders PCB-first shell hierarchy:
   - dominant `Lisa mõõtmine` visual and interaction precedence.
   - project/board status visible.
   - Add/Edit actions visible but not dominant.
2. Existing Save Measurement route/action still opens existing measure-sheet behavior unchanged.
3. Existing Add Component route/action still opens existing behavior unchanged.
4. Existing Edit Component route/action still opens existing behavior unchanged.
5. Rendering/navigating within shell writes zero events.
6. Board Canvas remains read-only:
   - no writer call
   - no event mutation
   - no drag-to-create behavior
   - no canvas-authored facts.
7. Stale banner only appears when stale state exists.
8. Reference/candidate/context values remain display-only and not measured facts.
9. No `sequence` field in V2 measurement events.
10. No legacy `MeasurementEventWriter` reach from this flow.
11. No direct `event_writer_service` UI write path.
12. No AI/confidence/diagnosis/proof semantics in shell.
13. Existing full suite + `py -3 tools\validate_all.py` remain green baseline.

## Explicit non-goals

- No runtime implementation in this pass.
- No writer/event/schema/materializer/safety-surface changes.
- No Board Canvas write/edit.
- No `Reference Images` behavior change.
- No route behavior changes outside existing compatibility behavior.

## Board Canvas read-only boundary

Board Canvas usage in this pass is constrained to read-only projection presentation and
existing visual inspection only. The scope lock preserves existing read-only copy and
inspector text behavior and forbids new interactive write actions.

## Event/write boundary preservation

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No new V2 `sequence` field, writer path changes, event model changes, or legacy writer re-activation are allowed in this locked scope.
- Existing Save/Add/Edit explicitness and targeting behavior remains unchanged until a dedicated write-flow implementation pass.

## Validation

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- Required route-lock context read from current docs and allowlist files.

## Route decision

Current pass: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS`

Next pass: `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_POST_AUDIT_PASS`

## Verdict candidate

PASS if docs-only updates are limited to allowlisted docs, scope-lock boundaries are explicit, and no forbidden runtime/tool/schema/test/surface files are modified.

## safe_for_reaudit

YES

### exact explicit staging commands (if safe_for_reaudit == YES)

- `git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/WORK_INTAKE_INDEX.md docs/audit/V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_SCOPE_LOCK_PASS.md`
