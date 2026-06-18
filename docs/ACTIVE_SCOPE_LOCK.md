# Active Scope Lock

## Current pass

`V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`

## Type

`CODEX / FLUTTER_UI_POLISH`

## Lane

Repo-local implementation pass. Runtime edits are limited to Board Canvas layout shell UI, tests are limited to Board Canvas widget tests, and governance edits are limited to route/audit docs. Do not stage, commit, or push.

## Current goal

Implement the locked UI-only 3-zone Workbench / Board Canvas layout shell:

- left vertical rail;
- center read-only Board Canvas as dominant surface;
- right read-only contextual panel container.

This pass improves layout structure only. It does not add measurement-entry or write-flow behavior.

## Baseline

- `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`).
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is design-input-only, non-runtime, non-canonical, not copied into Flutter runtime, and not accepted as implementation.
- Board Canvas is accepted/pushed/manual-smoke PASS.
- Board Canvas focus/top-chrome behavior has user smoke evidence: "Muidu käik töötas smoke testis".
- Renderer remains read-only.
- `renderer writes: none` must remain true.

## Implementation summary

- Add a wide-layout keyed Workbench shell around Board Canvas.
- Add a left rail keyed `board_canvas_workbench_rail`.
- Reuse existing `Focus canvas` and inspector show/hide actions in the rail on wide layouts.
- Keep future rail tools clearly disabled/inert.
- Keep the existing selector and Safety / Evidence controls in the compact top band.
- Keep center canvas keyed as the dominant `board_canvas_workbench_canvas_zone`.
- Host existing read-only inspector/context content in keyed `board_canvas_context_panel`.
- Preserve narrow responsive fallback by keeping controls in the top band when the rail is not shown.

## Allowed implementation scope

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`

## Required tests

- Wide layout has three named zones.
- Center canvas remains dominant over rail/context panel.
- Renderer remains read-only.
- `renderer writes: none` remains visible or safely recoverable.
- Rail future tools remain inert.
- No events/facts are written.

## Strict forbidden scope

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

- `dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`
- `git diff --check`

## Current route lock

Current pass: `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`

Next: `V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
