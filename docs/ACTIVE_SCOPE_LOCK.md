# Active Scope Lock

## Current pass

`V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`

## Type

`CODEX / DOCS_SCOPE_LOCK`

## Lane

Repo-local docs-only scope lock. Do not change runtime code, tests, tools, schemas, samples, generated/platform files, dependencies, Board Canvas behavior, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, `_incoming` artifacts, stage, commit, or push.

## Current goal

Lock the future `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` implementation scope for the first integrated Workbench redesign step: a UI-only 3-zone Board Canvas / Workbench layout shell.

## Problem statement

The accepted Board Canvas and Workbench density passes improved chrome and available canvas space, but the integrated technician workbench target still needs a governed shell that makes the board canvas the dominant work surface while creating explicit homes for actions and context.

The first implementation must be only layout structure:

- left rail placeholder or existing action/navigation surface;
- center read-only Board Canvas area as the dominant surface;
- right contextual panel container.

It must not open the future measurement-entry/write-flow surface.

## Current baseline

- `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS` is accepted/pushed as `422416f` (`docs: capture workbench home redesign design gap`).
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is registered as design-input-only.
- Board Canvas is accepted/pushed/manual-smoke PASS.
- Board Canvas focus/top-chrome behavior has user smoke evidence: "Muidu käik töötas smoke testis".
- Board Canvas remains read-only unless separately scoped.
- Renderer remains read-only.
- `renderer writes: none` must remain true.

## Design-input reference boundary

The local `_incoming/ui_redesign/2026-06-14_workbench_home/` material is reference input only:

- non-runtime;
- non-canonical;
- no HTML/CSS/mockup code copy into Flutter runtime;
- no image or asset copy into runtime;
- not accepted as implementation;
- `_incoming/` remains untracked scratch/reference input.

Implementation may follow the governed direction, not the mockup code.

## Next implementation pass

`V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`

## Expected future implementation surfaces

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- A local Board Canvas UI helper/widget file only if repo inspection proves it already belongs to this exact screen surface and the implementation audit explains why it is necessary.

Tests:

- `test/widget/board_canvas_screen_test.dart`

Governance:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`

## Allowed future implementation scope

- Board Canvas / Workbench 3-zone layout shell.
- Left vertical rail using existing actions/routes only.
- Future or disabled tool placeholders only if clearly disabled/inert.
- Center existing read-only renderer/canvas as the dominant surface.
- Right contextual panel container.
- Existing read-only inspector/context content may be hosted in the right panel.
- Responsive fallback for narrower screens if needed.
- UI-only visual/layout rearrangement.
- Focused widget tests for:
  - three zones on wide layout;
  - center canvas dominance;
  - renderer read-only boundary;
  - `renderer writes: none` visible or safely recoverable;
  - rail future tools inert;
  - no events/facts written.

## Strict forbidden future implementation scope

- No inline measurement entry.
- No Save button in the right panel.
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

## Future write-flow separation

Inline measurement entry belongs to later protected work:

- `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`
- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`

This layout pass must not add value/unit entry, Save controls, writer adapters, event creation, projection changes, or any renderer write behavior. Standalone `/project/measure-sheet` remains fallback/redirect unless route consolidation is separately scoped.

## Implementation audit requirements

The future implementation post-audit must verify:

- UI-only 3-zone shell behavior.
- No event/fact/write surfaces changed.
- Renderer remains read-only.
- `renderer writes: none` remains true and visible or safely recoverable.
- Rail placeholders are disabled/inert.
- Right panel remains read-only only.
- Existing Board Canvas selection/tap-to-select/pan/zoom/fit/placement/measurement-summary behavior is preserved.
- Tests avoid brittle pixel-perfect mockup copying.
- No `_incoming` HTML/CSS/assets were copied into runtime.

## File allowlist for this docs-only pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS.md`

## Forbidden scope for this docs-only pass

- No `lib/` changes.
- No `test/` changes.
- No tools/schema/sample/generated/platform/pubspec changes.
- No runtime behavior changes.
- No `_incoming` file changes.
- No staging, commit, or push.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git status --short --branch`

## Current route lock

Current pass: `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`

Next: `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
