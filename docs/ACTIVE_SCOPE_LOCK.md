# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS`

## Type

`CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC`

## Lane

Repo-local docs-only governance update. Do not modify runtime code, tests, tooling, schemas, samples, generated/platform files, stage, commit, or push.

## Current goal

- Record that `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS` was independently post-audited, accepted, committed, and pushed.
- Record Claude Code implementation post-audit verdict `ACCEPT_AS_IS` and `SAFE_FOR_COMMIT_PUSH: YES`.
- Preserve the accepted Board Canvas read-only renderer behavior, including persistent `renderer writes: none`.
- Close the Board Canvas top-chrome density route back to `NEEDS_USER_DECISION` after this docs-only bookkeeping pass is audited and accepted.

## Next recommended pass

`NEEDS_USER_DECISION`

## Baseline

- Scope lock accepted/pushed: `d6797fd` (`docs: lock board canvas top-chrome density scope`)
- Implementation accepted/pushed: `462eab2` (`feat(board-canvas): compact top chrome density`)
- Claude Code implementation post-audit: `ACCEPT_AS_IS`
- `SAFE_FOR_COMMIT_PUSH: YES`
- Validation before push:
  - `dart format` clean
  - `flutter test test/widget/board_canvas_screen_test.dart`: PASS (`62/62`)
  - `py -3 tools/validate_all.py`: PASS (`273`)
  - `git diff --check`: PASS; CRLF warnings only

## Accepted implementation summary

- Board Canvas AppBar compacted from 40px to 36px.
- Back/title row spacing tightened.
- Board Canvas body top padding reduced.
- Control-to-canvas gaps reduced.
- Placement and Safety / Evidence collapsed disclosures compacted into single-line ellipsis-safe rows.
- Control-card margins/gaps reduced.
- Inspector-toggle size, icon size, and padding reduced.
- Labels, selector disclosure behavior, inspector show/hide behavior, and `renderer writes: none` preserved.
- Renderer remains read-only.

## File allowlist for this pass

Governance only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS.md`

## Strict forbidden scope

- No `lib/` changes.
- No `test/` changes.
- No tools/schema/sample/generated/platform/pubspec changes.
- No Board Canvas runtime changes.
- No renderer behavior changes.
- No placement semantics, selection semantics, tap-to-select, pan/zoom/fit, or measurement logic changes.
- No visual_trace or photo-alignment semantic changes.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event changes.
- No staging, commit, or push.

Renderer must remain read-only and `renderer writes: none` must remain true.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current pass: `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS`

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
