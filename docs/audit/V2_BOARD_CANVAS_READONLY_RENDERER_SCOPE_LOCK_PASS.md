# V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS.
`CODEX / DOCS_SCOPE_LOCK` is the correct lane for this docs-only scope-lock before the first V2 Board Canvas implementation pass.

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
- plugin/MCP/package downloads/installs/configurations: not used

## Current route lock

Current: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS`  
Next: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_POST_AUDIT_PASS`

## Design references

Local reference files were used only as visual direction:
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\TraceBench_UI_Redesign_Visual_Design_Pass_standalone.html`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\Technician Workbench Home - Design Review (standalone).html`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\workbench.css`

No visual assets from `_incoming/` are copied into runtime.

## Proposed implementation pass ID

`V2_BOARD_CANVAS_READONLY_RENDERER_PASS`

## Exact allowed implementation runtime files

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- No other runtime files are allowed in this locked implementation slice.

## Exact allowed test files

- `test/widget/board_canvas_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/projection_stale_banner_end_to_end_test.dart`

## Exact forbidden files / surfaces

- `tools/event_writer_service.py`
- `lib/features/project/services/` event/write services
- `lib/domain/models/events` and any event-schema files
- `validator/`, `materializer/`, `schemas/`
- `tools/` runtime hardening scripts used for write/validation behavior changes in scope
- `Project ZIP` export/import paths and zip contract changes
- `AI/OCR/CV` and photo-markup/probe tooling
- Repair Map / Visual Trace Shape Assist runtime behavior
- `sequence` additions or V2 event-model changes
- any `MeasurementEventWriter` route activation in this slice
- Add/Edit Component behavior
- measurement save semantics
- custom unit / `Muu ühik` controls
- background photo helper layer
- pan/zoom/fit tool features
- measurement markers and measurement placement editor behavior
- photo/contour/layer/AI tools and trace-color editing

## Required tests for this locked slice

- `flutter test test/widget/project_overview_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `flutter test test/integration/board_graph_end_to_end_test.dart`
- `flutter test test/integration/projection_stale_banner_end_to_end_test.dart`
- `py -3 tools\validate_all.py`
- `flutter test` (full suite) required for implementation pass acceptance

## Required zero-event / read-only assertions

The implementation target must guarantee:

1. no write path is exercised by the new read-only board renderer slice;
2. renderer interactions do not create `events.jsonl` writes;
3. no `known_facts.json` persistence mutation is introduced by this pass;
4. no Project ZIP update is triggered;
5. no `MeasurementEventWriter` or legacy write path is reached from renderer shell interactions;
6. no `sequence` is added to any V2 event.

## Consumption of projection / cache data without fact promotion

- The renderer consumes only existing runtime models used by Board Canvas today (accepted projection / cache state), shown as visual summary only.
- Geometry/placement/text may be shown only when already present in current state.
- Empty/invalid source state yields a graceful read-only empty state message.
- Renderer must not infer:
  - electrical identity from visuals,
  - measurement semantics from render artifacts,
  - canonical net graph facts from candidate/trace layers.

## Deferred work

Deferred after this slice:

- renderer interaction/edit affordances (drag, rotate, resize, selection mutations),
- background photo rendering and alignment controls,
- contour/layer stack controls,
- AI candidates, candidate-merge/edit tooling,
- trace color editing and map-level interaction logic,
- any project-authoring or materialized fact generation behavior.

## Validation

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Route decision

Current pass: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS`  
Next pass: `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_POST_AUDIT_PASS`

## scope drift check

- `docs/CURRENT_STATE.md` now points to this pass and next post-audit.
- `docs/PASS_QUEUE.md` now marks this pass as current and route-next as post-audit.
- `docs/ACTIVE_SCOPE_LOCK.md` now contains the exact V2 Board Canvas read-only renderer lock scope and forbiddens.
- `docs/AUDIT_INDEX.md` now contains a current entry for this pass.
- No runtime/test/schema/tool files changed in this docs-only scope lock.

## safe_for_reaudit

YES
