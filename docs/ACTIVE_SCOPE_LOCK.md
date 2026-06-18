# Active Scope Lock

## Current pass

`V2_WORKBENCH_TOOL_RAIL_IMPL_PASS`

## Type

`CODEX / FLUTTER_UI_POLISH`

## Lane

CODEX implementation pass for UI-only Workbench left rail refinement. Runtime code/tests are editable.
Governance docs are limited to `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_PASS.md`.
Do not stage, commit, or push in this pass.

## Current goal

Refine the left workbench rail inside the existing wide Board Canvas Workbench shell:

- improve left-rail structure, labels, grouping, spacing, and spacing density;
- keep existing safe actions/routes only;
- keep future tools disabled/inert and visually clear;
- keep Focus canvas / Show controls behavior recoverable;
- keep inspector toggle equivalent;
- preserve read-only semantics, focus mode flow, and `renderer writes: none`.

No runtime behavior changes beyond layout-density/UI affordance polish are in-scope.

## Baseline

- `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`).
- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` is accepted/pushed as `3936cc2` (`feat(board-canvas): add workbench 3-zone layout shell`).
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is design-input-only and not accepted as implementation.
- Board Canvas read-only boundaries and focus/top-chrome behavior were accepted in prior passes.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_PASS.md`

## Runtime/test scope

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Required checks

- `git diff --check`
- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`

- Wide layout has three named zones.
- Center canvas remains dominant over rail/context panel.
- Renderer remains read-only.
- `renderer writes: none` remains visible or recoverable.
- Rail future tools remain inert.
- Focus-mode and inspector toggles remain available in narrow/wide behavior.

## Strict forbidden implementation scope

- No inline measurement entry.
- No right-panel Save button.
- No new write path.
- No writer/schema/materializer/validator/projection/Project ZIP changes.
- No `events.jsonl` or `known_facts.json` write/mutation changes.
- No routing/navigation consolidation.
- No deletion of `/project/measure-sheet`.
- No component/fact/event/coordinate/net/path/trace/probe/pin/pad semantic changes.
- No renderer behavior changes.
- No board-normalized placement semantics changes.
- No selected placement semantics changes.
- No tap-to-select behavior changes except preserving existing UI selection.
- No pan/zoom/fit behavior changes.
- No measurement association/count logic changes.
- No visual_trace geometry or interpretation changes.
- No photo-alignment semantics changes.
- No AI/OCR/CV/photo inference behavior.
- No broad app-wide dark theme or token/design-system migration.
- No generated/platform/dependency/pubspec changes.
- No copying `_incoming` HTML/CSS/assets into runtime.
- Renderer must remain read-only.
- `renderer writes: none` must remain true.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Current route lock

Current pass: `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS`

Next: `V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
