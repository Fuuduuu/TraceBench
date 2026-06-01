# PROMPT_PROTOCOL_GUARD_CLAUSES_PASS

## Goal

Add reusable implementation guard clauses to prevent recurrence of known failure patterns in future narrow implementation passes:

- test hangs/timeouts without bounded retry escalation,
- full-screen UI rewrites in polish slices,
- real `Image.file` / filesystem-heavy widget testing,
- unbounded async settling on async/animated screens,
- unmanaged UX slice growth.

## Scope

- Docs-only governance update.
- Allowed files:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/MODEL_ROUTING.md`
  - `docs/PROMPTING_PROTOCOL.md`
  - `docs/audit/PROMPT_PROTOCOL_GUARD_CLAUSES_PASS.md`

## Accepted changes

- Added reusable guard clauses in `docs/PROMPTING_PROTOCOL.md`:
  - stop-if-tests-hang rule (max 2 focused attempts, then triage/report),
  - no full screen/file rewrite without explicit scope,
  - no real image decode / no filesystem-heavy widget tests,
  - bounded waits instead of unbounded settle loops,
  - small-slice UX implementation requirement,
  - explicit model/tool routing reminder.
- Updated `docs/MODEL_ROUTING.md` with a no-self-approval constraint for high-risk passes and required routing sequence in handoff payloads.
- Updated governance state docs to set this as the current pass:
  - `docs/CURRENT_STATE.md` current/next routing updated,
  - `docs/PASS_QUEUE.md` current pass and next pass updated + row added,
  - `docs/ACTIVE_SCOPE_LOCK.md` current pass/goals/allowed docs set,
  - `docs/AUDIT_INDEX.md` ledger entry added.

## Output / routing

- Evidence boundaries remain unchanged (no code/tool/test/materializer/schema/Flutter/runtime/sample/contract change).
- Suggested next pass recorded as `TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS`.

## Status

- In progress for this pass.
