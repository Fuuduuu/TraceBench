# Pass Queue

## Current route

Current: `BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_SCREEN_CODE_MAP_PASS`

## Current docs-only scope lock

`BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS` may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS.md`

It locks the target, qualification evidence, content boundaries, three-file
future allowlist, and two-stage Claude audit lifecycle. It creates no map and
does not edit the index.

## Armed production-map pass

After this scope lock is independently audited, accepted, and pushed,
`BOARD_CANVAS_SCREEN_CODE_MAP_PASS` may write exactly:

- `docs/code_maps/lib/features/board_canvas/screens/board_canvas_screen.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_PASS.md`

The pass creates one production map and exactly one index row. It may inspect
`test/widget/board_canvas_screen_test.dart` and link its relevant tests, but it
must not create a test-file map.

## Map lifecycle

1. Draft the map and its one index row as `REVIEW_REQUIRED`.
2. Run the full read-only Claude map-to-code audit.
3. Continue only for `MAP_VERDICT: ACCEPT_AS_IS` or `ACCEPT_WITH_NITS` together
   with `SAFE_FOR_SNIPER_USE: YES`.
4. Record accepted audit evidence and synchronize map/index status to
   `MAINTAINED` inside the same three-file allowlist.
5. Run a short final read-only Claude diff audit before exact-file staging.

If the map audit is blocked or SNIPER safety is `NO`, retain
`REVIEW_REQUIRED`, do not stage, and return the blocker for human routing.

No later map, refactor, extraction, tooling, or implementation pass is armed.
