# ACTIVE_SCOPE_LOCK

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Mode
No active implementation or docs lock.

## Lock status
Released. `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` is closed.

## Write allowlist for this pass
No active write allowlist. A future pass must define a new explicit allowlist before edits.

## Latest closed implementation
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

Pushed implementation commit:
`e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8` (`fix: mark placement save projection stale`)

Claude audit:
- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Manual smoke:
- `PASS`

## Closed behavior record
- After successful placement save, UI truthfully indicates projection needs refresh.
- Flutter does not directly mutate `known_facts.json`.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Board Canvas renderer/painter remains read-only.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.
- Project Open From Directory behavior is unchanged.
- Placement rotation normalization behavior is unchanged.

## Known carryover debt
- Top badge "Ainult vaatamine · kirjutusi pole" remains status/copy debt because explicit panel save now exists.
- `Muuda` no-op / `Tühista` reset behavior remains future UI-polish debt.

## Standing protected boundaries
Future work must re-arm a new active scope lock before editing runtime, tests, schema, tools, events, known_facts, materializer, validator, router, Project ZIP, samples, or `_incoming`.
