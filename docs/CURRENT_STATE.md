# Current State

Current pass: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS`
Next recommended pass:
`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_POST_AUDIT_PASS`

## Charter and accepted baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop
authority.

Accepted scope-lock baseline:
`7b795c49b26463ae535b0ea980524d85ff88fa5f`
(`docs: lock board canvas project navigation hub`). Claude returned
`ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, blockers none, and nits none for the
scope lock.

## Active objective and authority

The active implementation adds one compact `Projekt` rail action to the
existing Board Canvas right-panel system. Its panel exposes exactly seven
zero-write links: BenchBeep Home, photo evidence, reference images, advanced
graph, events, known facts, and report.

Active write authority is exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No runtime behavior was implemented by the active-lock sync.

Board Canvas map disposition remains `REVIEWED_NO_CHANGE`. The implementation
must inspect the maintained map's GoRouter dependency note and stop for a
separate map pass if the accepted diff creates material responsibility drift.

Human visual approval in representative medium and wide layouts is mandatory
before the Claude implementation audit. That implementation audit packet must
be marked `USE ONLY AFTER MANUAL SMOKE PASS`.

Sync evidence:
`docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_ACTIVE_LOCK_SYNC_PASS.md`.
