# PASS_QUEUE

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Queue state
No active pass is armed. Awaiting user decision for the next narrow route.

| Order | Pass ID | Status | Notes |
| --- | --- | --- | --- |
| 1 | `NEEDS_USER_DECISION` | current | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` is closed and route is released. |

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

Manual smoke evidence:
- UI showed: "Visuaalne paigutus salvestatud. Projektsioon vajab värskendamist."
- `events.jsonl` line count increased: `8 -> 9`.
- Appended event: `evt_000009`.
- Appended event type: `component_visual_placement_confirmed`.
- `known_facts.json` hash stayed unchanged: `B068F7686E8C3666ADBF3C2519C56D5267DAF250BF7DFD2A6EA070C1C2E4690B`.
- `python tools/validate_all.py` passed in live verification.

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

## Current-state maintenance trigger
Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together whenever the current or next pass changes.

## Routing provenance
| Pass ID | Provenance |
| --- | --- |
| `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_POST_AUDIT_PASS` | Docs-only closeout after pushed implementation `e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8`; records Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`, manual smoke `PASS`, and route reset to `NEEDS_USER_DECISION`. |
| `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Pushed implementation `e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8`; marks placement save projection stale and keeps known_facts as projection/cache. |
| `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS` | Pushed docs-only active-lock sync `8c12921`; armed exact two-file Board Canvas implementation allowlist. |
| `PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS` | Pushed docs-only scope-lock `789fae7`; recorded the post-save projection-stale truthfulness gap. |
