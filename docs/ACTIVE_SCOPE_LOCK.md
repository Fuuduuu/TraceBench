# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`

## Type

`CODEX / FLUTTER_UI_POLISH`

## Lane

Repo-local implementation pass. Runtime edits are limited to Board Canvas UI; tests are limited to Board Canvas widget tests; governance edits are limited to the active pass docs. Do not modify unscoped runtime, tools, schemas, samples, generated/platform files, dependencies, stage, commit, or push.

## Current goal

- Implement the locked Board Canvas UI-only auto-hide/collapse polish.
- Give the canvas more visual priority with reversible, discoverable, volatile local UI state.
- Preserve renderer behavior, canonical state, selection semantics, measurement semantics, and write paths.
- Preserve read-only boundary copy and `renderer writes: none`.
- Route next to Claude Code read-only implementation post-audit.

## Current accepted route before this pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS`

## Baseline

- Scope lock accepted/pushed: `e55b1f8` (`docs: lock board canvas ui auto-hide scope`).
- Top-chrome density implementation accepted/pushed: `462eab2` (`feat(board-canvas): compact top chrome density`).
- Top-chrome density route closed out: `669d9f5` (`docs: close out board canvas top-chrome density`).
- Board Canvas is accepted/pushed/manual-smoke PASS.
- Renderer remains read-only.
- `renderer writes: none` must remain true.

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
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS.md`

## Allowed implementation scope

- UI-only volatile auto-hide/collapse state for Board Canvas chrome.
- Inspector/sidebar hide/reveal or collapse affordance.
- Top control band auto-collapse/reduce prominence.
- Reveal-on-tap/focus/explicit restore button.
- Responsive UI behavior where chrome competes with canvas space.
- Compact safety/read-only copy only if meaning remains clear.
- Focused Board Canvas widget tests for:
  - controls are recoverable;
  - auto-hide/collapse does not write events/facts;
  - read-only boundary remains visible or recoverable;
  - `renderer writes: none` remains present;
  - existing selector/inspector behavior remains functionally equivalent.

## Implementation decision

Use deterministic explicit focus mode rather than timer-based auto-hide:

- A compact `Focus canvas` tooltip button enters local focus mode.
- Focus mode hides the Board Canvas top control band and inspector/sidebar.
- A visible `Show controls` restore strip remains in the UI.
- Restoring controls exits focus mode and restores the read-only inspector.
- Focus mode is private widget state only and is not persisted.

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
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics.
- No writer/schema/materializer/validator/projection/Project ZIP changes.
- No `events.jsonl` or `known_facts.json` write/mutation changes.
- No AI/OCR/CV/photo inference behavior.
- No broad app-wide theme/token/design-system migration.
- No generated/platform/dependency/pubspec changes.
- No persistence/cross-session memory.
- Do not remove the read-only boundary copy.
- Do not remove `renderer writes: none`.

Renderer must remain read-only and `renderer writes: none` must remain true.

## Required validation

- `dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git status --short --branch`

## Current route lock

Current pass: `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`

Next: `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
