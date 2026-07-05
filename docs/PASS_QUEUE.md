# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active pass is armed. `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` is closed out and route control is returned to the user.

## Recently closed sequence

| Order | PASS_ID | Result |
|---|---|---|
| 1 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS` | Pushed scope-lock for guarding invalid placement draft canonical bounds before writer call. |
| 2 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS` | Pushed active-lock sync arming the exact implementation allowlist. |
| 3 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Pushed implementation `90107a64ec277a8992ff9d509d1b8eee6fae2f19` (`fix: guard invalid placement draft bounds`). |
| 4 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_POST_AUDIT_PASS` | Docs-only closeout records Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`, manual smoke `PASS`, safe implementation set, behavior, and boundary confirmation. |

## Closed behavior summary

- Invalid `board_normalized` placement drafts are guarded before writer call.
- Clear Estonian UI guard copy replaces raw validator output for expected invalid draft cases.
- Writer is not invoked for invalid draft bounds.
- Valid draft still saves and marks projection stale / refresh-needed.
- Validator/schema, placement writer contract, rotation normalization, and Project Open From Directory behavior remain unchanged.
- `known_facts.json` is not directly mutated by Flutter.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.

## Known carryover nit

- Empty required draft label also disables `Salvesta`; future copy may make that clearer if desired.

## Scope gate rules

- One narrow pass at a time.
- Do not implement without an active implementation lock.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.