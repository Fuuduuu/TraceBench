# PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS

AUDIT_STATUS: DRAFTED
AUDIT_VERDICT: PENDING_REPO_LOCAL_AUDIT
SAFE_FOR_STAGING: PENDING

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW

## Lane and mode

- Lane: docs-only active-lock sync for protected writer implementation.
- Mode: implementation allowlist arming.
- Runtime implementation: none.
- Test implementation: none.

## Baseline verification

- Expected pre-pass route verified: `NEEDS_USER_DECISION` / `NEEDS_USER_DECISION`.
- Latest closeout commit verified: `ed45dbcf` (`docs: close out add component panel local draft controls`).
- Tracked/cached diff was clean before this sync.
- `main` was aligned with `origin/main`.
- Existing untracked scratch artifacts were left untouched.

## Scope-lock source

Accepted writer/Confirm contract source: `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`.

- Writer target: `lib/features/components/services/v2_placement_writer.dart`.
- Canonical event type: `component_visual_placement_confirmed` only.
- Confirm/Salvesta requires explicit human action.
- Board Canvas renderer/painter remains read-only.

## Implementation pass armed

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

## Implementation allowlist

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/unit/v2_placement_writer_test.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, writer, schema, tool, materializer, validator, router, event, known-facts, sample, fixture, asset, or `_incoming` path is armed.

## Implementation goal

Implement the protected placement writer and explicit Board Canvas Confirm/Salvesta hookup for human-confirmed visual placement.

Future implementation may:

- create/use the V2 placement writer service
- wire Board Canvas `Salvesta` as an explicit human Confirm action
- emit exactly one event type: `component_visual_placement_confirmed`
- use V2/human envelope semantics with explicit user confirmation and `client_operation_id`
- write placement envelope fields only
- keep renderer/painter read-only

## Required boundaries

- Explicit human Confirm only.
- Writer emits only `component_visual_placement_confirmed`.
- No component identity creation.
- No pin/contact/pad/net/electrical facts.
- No measurements, visual contact layout, AI-authored canonical facts, or repair conclusions.
- Board Canvas renderer remains read-only.
- `Salvesta` may become wired only in `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`, not here.

## Forbidden surfaces for this sync

- No runtime edits in this sync.
- No test edits in this sync.
- No writer implementation in this sync.
- No schema edits.
- No tools/materializer/validator/router edits.
- No `events.jsonl` / `known_facts.json` edits.
- No sample/project fixture edits.
- No `_incoming` edits.
- No `_incoming` staging.
- No broad docs cleanup.
- Do not stage, commit, or push.

## Route state

Route set to:

- Current: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

## Validation checklist

- `git status --short --branch`
- `git log --oneline --decorate -5`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit instructions

Read-only audit. Do not edit, stage, commit, or push.

Expected diff is limited to this docs-only allowlist:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Verify that this pass only arms `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` and the exact implementation allowlist:

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/unit/v2_placement_writer_test.dart`
- `test/widget/board_canvas_screen_test.dart`

Focused checklist:

- Current route is `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Next route is `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`.
- Writer event type remains only `component_visual_placement_confirmed`.
- Explicit human Confirm remains required.
- No identity/contact/pin/pad/net/electrical/AI fact creation is armed.
- Board Canvas renderer remains read-only.
- `Salvesta` is not wired by this sync pass.
- No runtime/test/writer/schema/tool/materializer/validator/router/events/known_facts/sample/_incoming edits were made in this sync.

Verdict format:

- `AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED`
- `SAFE_FOR_STAGING: YES / NO`
- `SAFE_STAGING_SET: exact file list only if accepted`
