# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_SCOPE_LOCK_PASS`

## Type

`CODEX / DOCS_SCOPE_LOCK`

## Lane

Repo-local docs-only scope lock. Do not modify runtime code, tests, tooling, schemas, samples, generated/platform files, stage, commit, or push.

## Current goal

- Lock a future UI-only Board Canvas chrome auto-hide/collapse implementation scope.
- Make the Board Canvas area feel more dominant by allowing selected chrome to become more space-efficient.
- Keep all behavior, canonical semantics, renderer read-only boundaries, and write boundaries unchanged.
- Route the next implementation pass to `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`.

## Current accepted route before this pass

`NEEDS_USER_DECISION`

## Next recommended pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`

## Baseline

- Latest pushed closeout: `669d9f5` (`docs: close out board canvas top-chrome density`).
- `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS` is accepted/pushed.
- `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS` is accepted/pushed as `462eab2` (`feat(board-canvas): compact top chrome density`).
- Claude Code implementation post-audit verdict for the top-chrome implementation: `ACCEPT_AS_IS`.
- Board Canvas is accepted/pushed/manual-smoke PASS.
- Top-chrome density polish is accepted/pushed/closed out.
- Renderer remains read-only.
- `renderer writes: none` must remain true.

## Problem and rationale

Board Canvas density work is accepted, but the next safe UI-only polish option is to make the remaining chrome less dominant when the technician is focused on the canvas. A future implementation may add explicit, reversible, discoverable auto-hide/collapse behavior for Board Canvas chrome so the board surface gains visual priority without changing rendering, selection, measurement, placement, evidence, fact, event, or write semantics.

This pass only defines the lock. It does not implement auto-hide behavior.

## Future implementation target

`V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`

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
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS.md`

A local Board Canvas UI helper may be touched only if repo inspection proves it already belongs to this exact Board Canvas screen surface; the implementation audit must explain why.

## Allowed future implementation scope

- Volatile local UI auto-hide/collapse for the Board Canvas inspector/sidebar.
- Volatile local UI auto-hide/collapse for the Board Canvas top control band.
- Explicit restore/show controls for hidden or collapsed chrome.
- Size, padding, spacing, alignment, and density polish needed to support the auto-hide/collapse UI.
- Compact safety/read-only copy only where the safety meaning remains clear.
- UI-only responsive density adjustments for mobile/tablet/wide layouts.
- Focused Board Canvas widget tests for:
  - no `events.jsonl` or `known_facts.json` writes;
  - recoverability of hidden/collapsed chrome;
  - read-only boundary visibility or recoverability;
  - behavior equivalence for existing selector, inspector, tap-to-select, pan/zoom/fit, and measurement display flows.

## Strict design requirements

- Auto-hide/collapse must be reversible and discoverable.
- Hidden chrome must not create trapped UI state.
- Safety/read-only meaning must not be permanently hidden.
- State must be volatile local UI state only unless a separate future pass explicitly accepts persistence.
- Prefer explicit and safe interactions over aggressive timers.
- Avoid flaky timer-based behavior and brittle timer-based tests.
- Do not make the UI cryptic just to save pixels.

## Strict forbidden scope

- No renderer behavior changes.
- No board-normalized placement semantics changes.
- No selected placement semantics changes.
- No tap-to-select behavior changes.
- No pan/zoom/fit behavior changes.
- No measurement association/count logic changes.
- No measurement summary semantics changes.
- No visual_trace geometry or interpretation changes.
- No photo-alignment semantics changes.
- No new facts/events/coordinates/net/path/trace/probe/pin/pad semantics.
- No writer/schema/materializer/validator/projection/Project ZIP changes.
- No `events.jsonl` or `known_facts.json` write/mutation changes.
- No AI/OCR/CV/photo inference behavior.
- No broad app-wide theme/token/design-system migration.
- No generated/platform/dependency/pubspec changes.
- No auto-hide persistence or cross-session memory.
- No runtime writes, authoring, save, edit, apply, confirm, or promote controls.
- No Project Overview / Workbench layout changes.

Renderer must remain read-only and `renderer writes: none` must remain true.

## Required implementation audit checks

- Verify the change is UI-only.
- Verify no event/fact/write surfaces changed.
- Verify renderer behavior remains read-only.
- Verify `renderer writes: none` remains true and visible or recoverable.
- Verify hidden/collapsed controls are recoverable.
- Verify safety/read-only boundary copy is preserved or recoverable.
- Verify existing placement selector, inspector show/hide, tap-to-select, pan/zoom/fit, measurement summary, visual_trace metadata, and photo-alignment metadata behavior remain equivalent.
- Verify tests are not flaky or timer-brittle.

## Required validation for this docs-only scope lock

- `py -3 tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Expected validation for the future implementation

- `dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current pass: `V2_BOARD_CANVAS_UI_AUTO_HIDE_SCOPE_LOCK_PASS`

Next: `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
