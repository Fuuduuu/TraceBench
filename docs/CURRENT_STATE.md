# Current State

Current pass: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS`
Next recommended pass: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS`

## Charter and accepted baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop
authority.

The code-map prompting integration closeout is accepted, pushed, and audited
as `90432065e6702ff9199c7917b3f55fbe6f72e466`
(`docs: close out code map prompting integration`). Claude returned
`ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`; blockers none; nits none.

## Current scope lock

This Lane A docs-only pass locks the creation and audit lifecycle for the
independently qualifying test map of
`test/widget/board_canvas_screen_test.dart`.

Accepted committed-state evidence is concrete: the target has 10,413 physical
lines and 153 tests across independently meaningful families. It qualifies as
`AUTO — >3000 lines + 3+ test families`. No target map or index row exists;
`CODE_MAP_INDEX.md` still lists only the maintained production Board Canvas
map.

After this scope lock is independently audited, accepted, committed, and
pushed, the future map pass may create exactly the deterministic test-map file,
one actual-map index row, and its map-pass audit artifact. Map and index begin
at `REVIEW_REQUIRED`; only an accepted Claude map audit with
`SAFE_FOR_SNIPER_USE: YES` permits synchronized `MAINTAINED` metadata, followed
by a short final Claude audit before exact human staging.

No map, index row, Dart, runtime, or test change is made in this scope lock.
The maintained production map remains unchanged and independent. While the
required test map is absent, relevant Dart work stops as
`BLOCKED_CODE_MAP_REQUIRED`; once drafted but `REVIEW_REQUIRED`, stale, or
unverifiable, it stops as `BLOCKED_CODE_MAP_STALE`. Only a verified
`MAINTAINED` map clears the map gate.

Scope-lock evidence:
`docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS.md`.
