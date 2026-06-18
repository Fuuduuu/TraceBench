# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`

## Type

`CODEX / FLUTTER_UI_POLISH`

## Lane

Repo-local implementation pass. Do not stage, commit, or push.

## Current goal

- Compact the Board Canvas top app bar/header and selector/control row so the board canvas area feels more dominant.
- Keep the work UI-only and Board Canvas-only.
- Preserve all accepted read-only renderer behavior, including persistent `renderer writes: none`.

## Next recommended pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS`

## Baseline

- Scope lock accepted/pushed: `d6797fd` (`docs: lock board canvas top-chrome density scope`)
- Source/orientation refresh: `7269648` (`docs: refresh project source orientation`)
- Project Overview / Workbench layout-density closeout: `19fc1c9` (`docs: close out project overview layout density`)
- Board Canvas layout-density polish implementation: `4fe7ade` (`feat(board-canvas): polish layout density`)
- Board Canvas manual smoke: PASS with user wording "kõik on passed. ja töötab"
- Accepted Board Canvas state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety / Evidence controls, canvas status overlay, volatile inspector hide/show, and persistent `renderer writes: none`.

## Problem statement

Board Canvas top chrome and selector/control rows still consume too much vertical and horizontal space. User screenshot review identified two specific density issues:

- the top app bar/header with back button and "Board Canvas" title can be narrower/shorter;
- the row containing Placements, Safety / Evidence, and the collapse/expand control can be narrower and more compact.

No screenshot asset is added by this pass.

## File allowlist for this pass

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

No other runtime/test files are approved by this scope lock. If implementation genuinely requires a helper extraction or a different Board Canvas UI file, stop and update scope before editing.

## Allowed implementation scope

- Board Canvas app bar/header visual density.
- Board Canvas top title/back row height, padding, and spacing.
- Placement selector row visual density.
- Safety / Evidence collapsed control visual density.
- Collapse/show-hide control size, padding, spacing, and alignment.
- Visual-only layout polish that gives more space to the board canvas.
- UI-only responsive behavior if needed.
- Existing read-only labels/copy may be shortened only if meaning and safety boundary remain clear.
- Focused Board Canvas widget tests for compact chrome and read-only behavior.

## Strict non-goals / forbidden scope

- Renderer behavior changes.
- Board-normalized placement semantics changes.
- Selected placement semantics changes.
- Tap-to-select behavior changes.
- Pan/zoom/fit behavior changes.
- Measurement association/count logic changes.
- Measurement summary semantics changes.
- Visual trace geometry or interpretation changes.
- Photo-alignment semantics changes.
- New facts/events/coordinates/net/path/trace/probe/pin/pad semantics.
- Writer/schema/materializer/validator/projection/Project ZIP changes.
- `events.jsonl` or `known_facts.json` write/mutation changes.
- AI/OCR/CV/photo inference behavior.
- Broad app-wide theme/token/design-system migration.
- Generated/platform/dependency/pubspec changes.
- Runtime writes, authoring, save, edit, apply, confirm, or promote controls.
- Project Overview / Workbench layout changes.
- Reference Images, Save Measurement, Add Component, or Edit Component behavior changes.

Renderer must remain read-only and `renderer writes: none` must remain true.

## Implementation audit requirements

The implementation post-audit must verify:

- read-only renderer remains read-only;
- `renderer writes: none` remains visible/true;
- no event/fact/write surfaces changed;
- Board Canvas behavior remains functionally equivalent for placement rendering, selector/chip flow, inspector, tap-to-select, pan/zoom/fit, measurement badges/counts, measurement summary, visual-trace metadata, and photo-alignment readiness metadata;
- only visual density changed;
- tests cover compact top chrome/control-row behavior without brittle pixel-perfect assertions;
- no writer/schema/materializer/validator/projection/Project ZIP/fact/event surfaces changed.

## Required validation

- `dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current pass: `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`

Next: `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
