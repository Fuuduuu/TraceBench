# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS`

## Type

`CODEX / DOCS_MANUAL_QA_RECORD`

## Lane

Repo-local docs-only manual smoke record. Do not change runtime code, tests, tools, schemas, samples, generated/platform files, dependencies, Board Canvas behavior, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, stage, commit, or push.

## Current goal

- Record user manual smoke evidence for the accepted Board Canvas UI focus mode and compact top-chrome behavior.
- Interpret user wording narrowly as Board Canvas focus/top-chrome flow worked in manual smoke testing.
- Keep route at `NEEDS_USER_DECISION` after the smoke record.
- Clarify that the separate `_incoming/ui_redesign/2026-06-14_workbench_home` reference screenshot is not accepted as current runtime implementation.

## Current accepted route before this pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Baseline

- Board Canvas UI auto-hide implementation accepted/pushed: `dd69545` (`feat(board-canvas): add canvas focus mode`).
- Board Canvas UI auto-hide post-audit/closeout accepted/pushed: `5b72aba` (`docs: close out board canvas ui auto-hide`).
- Current accepted route should remain `NEEDS_USER_DECISION`.
- Renderer remains read-only.
- `renderer writes: none` remains true.

## Accepted Board Canvas UI behavior

- Compact top app bar/header.
- Compact Placement / Safety-Evidence / collapse-control row.
- Deterministic volatile `Focus canvas` mode.
- `Focus canvas` hides the top control band plus inspector/sidebar.
- `Show controls` restore strip remains visible.
- Controls and read-only details are recoverable.
- `renderer writes: none` remains visible.
- Renderer remains read-only.
- No persistence or cross-session memory.
- No timers.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event changes.

## Manual smoke evidence

User reported:

> "Muidu käik töötas smoke testis"

Narrow interpretation:

- Board Canvas focus/top-chrome flow worked in manual smoke testing.

Out-of-scope clarification:

- The separate `_incoming/ui_redesign/2026-06-14_workbench_home` reference screenshot is not recorded as accepted implementation in this pass.
- That redesign reference remains a separate future route-review/design-gap topic unless explicitly scoped later.

## File allowlist for this pass

Governance:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS.md`

## Allowed docs-only scope

- Record the smoke result as manual/user evidence.
- Keep route at `NEEDS_USER_DECISION` after the smoke record.
- Clarify that the future redesign reference remains separate and is not accepted as the current runtime target.

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
- No timers.
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

Current pass: `V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS`

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
