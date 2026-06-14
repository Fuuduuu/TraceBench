# V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS.
`CODEX / DOCS_SCOPE_LOCK` is the correct lane for this docs-only scope lock before the first read-only Board Canvas pan/zoom/fit implementation pass.

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock. No runtime, tests, schema, validator/materializer, writer-service, Project ZIP, AI/OCR/CV, generated artifact, platform, or protected-surface changes are allowed in this pass.

## AGENTS/skills usage note

- Read and followed `AGENTS.md`, `docs/AUDIT_CONTRACT.md`, and `docs/CODEX_TOOLING_POLICY.md`.
- Repo-local guidance used:
  - `.agents/skills/tracebench-scope-lock/SKILL.md`
  - `.agents/skills/tracebench-flutter-widget-pass/SKILL.md`
  - `.agents/skills/tracebench-safe-staging/SKILL.md`
  - `.agents/skills/tracebench-v2-event-boundary/SKILL.md`
- No MCP/plugin installs, enablements, downloads, dependency updates, or toolchain changes were performed.

## Tool / plugin / download capability report

- filesystem: available
- PowerShell/shell: available
- git: available
- Flutter/Dart tooling: available but unused for this pass
- plugin/MCP/package downloads/installs/configuration changes: not used

## Current route lock

Current: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS`  
Next: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_POST_AUDIT_PASS`

## Design references

Local reference files were used only as visual direction:
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\TraceBench_UI_Redesign_Visual_Design_Pass_standalone.html`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\Technician Workbench Home - Design Review (standalone).html`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\workbench.css`

No visual assets from `_incoming/` are copied into runtime.

## Proposed implementation pass ID

`V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`

## Exact allowed implementation runtime files

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Optional (only if justified by route/chrome work needed for the Workbench Home embedded board-zone):
  - `lib/features/project/screens/project_overview_screen.dart`

## Exact allowed test files

- `test/widget/board_canvas_screen_test.dart`
- Optional (only if project-overview affordances are modified):
  - `test/widget/project_overview_screen_test.dart`

## Exact forbidden files / surfaces

- `tools/event_writer_service.py`
- `writer/service/` and event schema/model surfaces
- `validator/`, `materializer/`, `schemas/`
- `lib/features/component_editor` component create/edit/update/edit flows
- Add/Edit Component behavior
- Save Measurement behavior
- measurement marker placement/editor
- background photo rendering/alignment
- contour/layer stack
- AI/OCR/CV candidates
- photo markup / probe tooling
- Repair Map
- Visual Trace Shape Assist runtime behavior
- any `sequence` field addition
- `Project ZIP` import/export
- dependency/toolchain lockfile or package updates
- platform or sample/assets (`assets/samples/pelle_pv20_minimal/metadata/`)
- `_incoming/`
- non-authorized runtime test suites outside the explicit allowlist

## Scope-lock-required tests and assertions

For the corresponding implementation pass, the locked slice must preserve zero-event/read-only behavior:

1. `pan/zoom/fit` gestures or controls must not write to `events.jsonl`.
2. `known_facts.json` must not mutate in this pass.
3. No `Project ZIP` update is introduced.
4. `MeasurementEventWriter` and legacy write paths remain unreachable through renderer interactions.
5. No `sequence` field impact is introduced in V2 events.
6. No canonical fact creation is introduced.
7. No `visual_trace` net inference behavior is introduced.
8. No photo-pixel-based facting behavior is introduced.

## Deferred work

- measurement markers and marker placement editor
- background photo rendering and alignment behavior
- contour/layers/AI/OCR/CV tooling
- trace-color editing
- Edit/drag/rotate/resize/selection mutation
- Add/Edit Component behavior
- Save Measurement changes
- custom unit / `Muu ühik`
- writer/schema/validator/materializer changes
- Project ZIP changes

## Validation

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Scope-lock summary

- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS` locks the first V2 Board Canvas navigation slice to **view-transform-only pan/zoom/fit** over existing rendered board geometry.
- Behavior and boundaries remain read-only; no persistence or canonicalization changes are introduced in scope.
- Route stays on `NEEDS_USER_DECISION`-approved flow transitions, with explicit deferrals to later slices.

## Route decision

Current: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS`  
Next: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_POST_AUDIT_PASS`

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS.md`

## scope drift check

- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` share aligned current/next route values.
- No runtime/test/schema/tool files changed in this docs-only pass lock.
- `docs/AUDIT_INDEX.md` now includes the in-progress Board Canvas pan/zoom/fit scope-lock row pointing at this audit doc.

## final verdict

PASS.

## safe_for_reaudit

YES

## expected staging command

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS.md`
