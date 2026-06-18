# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS`

## Type

`CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC`

## Lane

Repo-local docs-only governance update. Do not change runtime code, tests, tools, schemas, samples, generated/platform files, dependencies, Board Canvas behavior, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, stage, commit, or push.

## Current goal

- Record that `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS` was independently post-audited, accepted, committed, and pushed.
- Record Claude Code implementation post-audit verdict `ACCEPT_AS_IS`.
- Record `SAFE_FOR_COMMIT_PUSH: YES`.
- Preserve accepted implementation facts and route next to `NEEDS_USER_DECISION`.

## Current accepted route before this pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Baseline

- Scope lock accepted/pushed: `e55b1f8` (`docs: lock board canvas ui auto-hide scope`).
- Implementation accepted/pushed: `dd69545` (`feat(board-canvas): add canvas focus mode`).
- Claude Code implementation post-audit verdict: `ACCEPT_AS_IS`.
- `SAFE_FOR_COMMIT_PUSH: YES`.
- Validation before push:
  - `dart format` clean.
  - `flutter test test/widget/board_canvas_screen_test.dart` PASS (`63/63`).
  - `py -3 tools/validate_all.py` PASS (`273`).
  - `git diff --check` PASS, CRLF warnings only.

## Accepted implementation summary

- Board Canvas gained deterministic, volatile, UI-only focus mode.
- A compact `Focus canvas` button hides the top control band and inspector/sidebar.
- A visible `Show controls` restore strip always remains.
- Hidden chrome is recoverable; no hidden-state trap.
- State is private widget state only.
- No persistence or cross-session memory was added.
- No timers or timer-based auto-hide behavior were added.
- `renderer writes: none` remains visible in focus mode.
- Renderer remains read-only.
- Selection, tap-to-select, pan/zoom/fit, measurement metadata, visual_trace, and photo-alignment behavior remain unchanged.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event surfaces changed.

## File allowlist for this pass

Governance:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS.md`

## Allowed docs-only scope

- Update governance docs to mark the implementation as accepted/pushed/post-audited.
- Add the post-audit bookkeeping audit artifact.
- Route next according to repo convention.
- Prefer `NEEDS_USER_DECISION` because this closes the Board Canvas UI auto-hide route.

## Strict forbidden scope

- No `lib/` changes.
- No `test/` changes.
- No tools/schema/sample/generated/platform/pubspec changes.
- No Board Canvas runtime changes.
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
- No staging, commit, or push.

Renderer remains read-only and `renderer writes: none` remains true.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git status --short --branch`

## Current route lock

Current pass: `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS`

Next: `NEEDS_USER_DECISION`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
