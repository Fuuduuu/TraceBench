# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active pass is armed. The route is released after `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_POST_AUDIT_PASS`.

## Recently closed

| PASS_ID | Result |
|---|---|
| `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Accepted, pushed, and audited as `80f00408f2fa504e9cc941435b968644090175e7` (`fix: clarify board canvas write status copy`). |
| `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_POST_AUDIT_PASS` | Docs-only closeout records `AUDIT_VERDICT: ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, manual smoke `NOT_REQUIRED`, and releases route to `NEEDS_USER_DECISION`. |

## Recommended candidate, not routed

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS`

Reason: manual visual smoke exposed a separate canonical-bounds issue where UI can still produce `board_normalized` payload values outside schema bounds, for example `width > 1` or center outside `0..1`. Validator rejection is correct; a future protected pass should decide the draft guard behavior.

## Scope gate rules

- One narrow pass at a time.
- Do not implement without an active lock.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Planned follow-up sequence / P-roadmap

No route is armed. Candidate work must start with a new scope-lock pass from `NEEDS_USER_DECISION`.

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.