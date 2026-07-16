# Pass Queue

## Current route

Current: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS`

## Current docs-only scope lock

The current pass may change exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_SCOPE_LOCK_PASS.md`

It locks lifecycle and scope only. It creates no code map or index row and has
no Dart, runtime, or test authority.

## Armed map pass

After this scope lock is independently audited, accepted, committed, and pushed,
`BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS` may write exactly:

- `docs/code_maps/test/widget/board_canvas_screen_test.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_PASS.md`

No fourth, wildcard, optional, source, test, or production-map file is
authorized. No active-lock sync is required because the next pass remains Lane
A docs-only map creation with no Dart authority.

The test map is independently qualified as
`AUTO — >3000 lines + 3+ test families`. It must describe accepted committed
state, use stable symbols/helpers/harnesses/named test families rather than
line anchors, contain at most 12 zones, target 120–220 lines, and remain
descriptive and non-authorizing.

Lifecycle: draft the map and one actual index row as `REVIEW_REQUIRED`; obtain
Claude `MAP_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS` and
`SAFE_FOR_SNIPER_USE: YES`; synchronize both statuses to `MAINTAINED`; run the
short final Claude audit; then the human may stage exactly the accepted three
files. A blocked map verdict or `SAFE_FOR_SNIPER_USE: NO` forbids staging.

The production Board Canvas map and both Dart source/test files remain
unchanged. Test refactoring, splitting, harness repair, Windows file-lock
hardening, generators, linters, watchers, hooks, CI gates, and implementation
work remain outside the queue.
