# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS`

## Type

`DOCS_SYNC / SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Repo-local docs-only scope lock. Do not modify runtime code, tests, tooling, schemas, samples, generated/platform files, stage, commit, or push.

## Current goal

- Lock a narrow future Board Canvas UI-only density polish pass focused only on the top chrome/header and selector/control row.
- Record user screenshot-review evidence that the top app bar/header and the row containing Placement, Safety / Evidence, and collapse/expand controls still consume too much space.
- Preserve all accepted Board Canvas read-only renderer behavior, including `renderer writes: none`.
- Route the future implementation to `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`.

## Next recommended pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`

## Baseline

- Current accepted route before this lock: `NEEDS_USER_DECISION`
- Source-orientation refresh: `7269648` (`docs: refresh project source orientation`)
- Project Overview / Workbench layout-density closeout: `19fc1c9` (`docs: close out project overview layout density`)
- Board Canvas layout-density polish implementation: `4fe7ade` (`feat(board-canvas): polish layout density`)
- Board Canvas manual smoke: PASS with user wording "kõik on passed. ja töötab"
- Board Canvas accepted state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety / Evidence controls, canvas status overlay, volatile inspector hide/show, and persistent `renderer writes: none`.

## Problem statement

Board Canvas top chrome and selector/control rows still consume too much vertical and horizontal space. User screenshot review identified two specific density issues:

- the top app bar/header with back button and "Board Canvas" title can be narrower/shorter;
- the row containing Placements, Safety / Evidence, and the collapse/expand control can be narrower and more compact.

No screenshot asset is added by this docs-only pass.

## File allowlist for this docs-only pass

Governance only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS.md`

## Future implementation target

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`

## Future implementation allowlist

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`

Tests:

- `test/widget/board_canvas_screen_test.dart`

Governance:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS.md`

No other runtime/test files are pre-approved by this scope lock. If implementation genuinely requires a helper extraction or a different Board Canvas UI file, stop and update scope before editing.

## Allowed future implementation scope

- Board Canvas app bar/header visual density.
- Board Canvas top title/back row height, padding, and spacing.
- Placement selector row visual density.
- Safety / Evidence collapsed control visual density.
- Collapse/show-hide control size, padding, spacing, and alignment.
- Visual-only layout polish that gives more space to the board canvas.
- Responsive behavior if needed, as long as it is UI-only.
- Existing read-only labels/copy may be shortened only if meaning and safety boundary remain clear.

## Strict non-goals / forbidden future scope

- Renderer behavior changes
- board-normalized placement semantics changes
- selected placement semantics changes
- tap-to-select behavior changes
- pan/zoom/fit behavior changes
- measurement association/count logic changes
- measurement summary semantics changes
- visual_trace geometry or interpretation changes
- photo-alignment semantics changes
- new facts/events/coordinates/net/path/trace/probe/pin/pad semantics
- writer/schema/materializer/validator/projection/Project ZIP changes
- `events.jsonl` or `known_facts.json` write/mutation changes
- AI/OCR/CV/photo inference behavior
- broad app-wide theme/token/design-system migration
- generated/platform/dependency/pubspec changes
- runtime writes, authoring, save, edit, apply, confirm, or promote controls
- Project Overview / Workbench layout changes
- Reference Images, Save Measurement, Add Component, or Edit Component behavior changes

Renderer must remain read-only and `renderer writes: none` must remain true.

## Future implementation audit requirements

The implementation post-audit must verify:

- read-only renderer remains read-only;
- `renderer writes: none` remains visible/true;
- no event/fact/write surfaces changed;
- Board Canvas behavior remains functionally equivalent for placement rendering, selector/chip flow, inspector, tap-to-select, pan/zoom/fit, measurement badges/counts, measurement summary, visual-trace metadata, and photo-alignment readiness metadata;
- only visual density changed;
- tests cover compact top chrome/control-row behavior without brittle pixel-perfect assertions;
- no writer/schema/materializer/validator/projection/Project ZIP/fact/event surfaces changed.

## Required validation

Scope-lock validation:

- `py -3 tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

Future implementation validation:

- `dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current pass: `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS`

Next: `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
- This docs-only pass does not implement runtime UI changes.
