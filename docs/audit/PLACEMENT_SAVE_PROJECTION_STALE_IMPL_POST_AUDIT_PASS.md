# PLACEMENT_SAVE_PROJECTION_STALE_IMPL_POST_AUDIT_PASS

## Mode
Docs-only implementation closeout.

## Baseline verification
- Route before closeout:
  - Current: `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`
  - Next: `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`
- Tracked diff and cached diff were clean before closeout.
- Branch was aligned with `origin/main`.
- Pushed implementation commit verified from live git log:
  - `e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8`
  - `fix: mark placement save projection stale`

## Route after closeout
- Current: `NEEDS_USER_DECISION`
- Next: `NEEDS_USER_DECISION`

## Implementation closed
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

## Implementation commit
`e69263a5fb9cbfef89f93a4ae8905ab4322e6aa8` (`fix: mark placement save projection stale`)

## Audit record
- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Manual smoke record
`PASS`

Manual smoke evidence:
- UI showed: "Visuaalne paigutus salvestatud. Projektsioon vajab värskendamist."
- `events.jsonl` line count increased: `8 -> 9`.
- Appended event: `evt_000009`.
- Appended event type: `component_visual_placement_confirmed`.
- `known_facts.json` hash stayed unchanged: `B068F7686E8C3666ADBF3C2519C56D5267DAF250BF7DFD2A6EA070C1C2E4690B`.
- `python tools/validate_all.py` passed in live verification.

## Behavior recorded
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

## Boundary confirmation
- No runtime edits in this closeout.
- No test edits in this closeout.
- No schema/tool/materializer/validator edits.
- No events.jsonl or known_facts.json edits.
- No samples/assets edits.
- No `_incoming` edits or staging.
- No staging, commit, or push by Codex.

## Validation
Completed for this docs-only closeout:
- `python tools/validate_all.py`: PASS, 285 tests OK.
- `git diff --check`: PASS.
- `Select-String -Path docs/AUDIT_INDEX.md -Pattern '\|\|'`: no matches.
