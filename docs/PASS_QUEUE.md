# Pass Queue

## Current route

Current: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_SCOPE_LOCK_PASS`
Next: `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS`

## Current pass

Draft one Lane B docs-only protected-surface scope lock for the atomic board
outline V2 event foundation. Current write authority is exactly the five paths
named in `docs/ACTIVE_SCOPE_LOCK.md`; runtime, schemas, tools, tests, Dart,
Flutter, wizard, Project ZIP, samples, assets, and `_incoming` are not writable.

## Reserved next pass

`BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_PASS` is one atomic `TOOLS_PASS` with
the exact ten-file allowlist in `docs/ACTIVE_SCOPE_LOCK.md`. Its authority is
reserved, not active, until this exact scope-lock diff is independently
accepted and exactly staged, committed, and pushed by the human with no later
route or baseline drift.

No active-lock-sync, verdict-copy, recovery, reconciliation, or closeout pass
is inserted between the accepted scope lock and its implementation. Later
Dart/wizard integration, Canvas editing, and all candidate-persistence work
remain separately scoped and unarmed.
