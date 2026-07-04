# ACTIVE_SCOPE_LOCK.md

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock

No active implementation or docs lock is armed.

## Released lock

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` is closed by `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_POST_AUDIT_PASS`.

Implementation commit recorded from live git log:

- `80f00408f2fa504e9cc941435b968644090175e7`
- `fix: clarify board canvas write status copy`

Audit result recorded:

- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set recorded:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Closed behavior boundary

- Board Canvas status/copy now distinguishes renderer/painter read-only behavior from explicit human-confirmed panel save capability.
- `Salvesta` canonical write path is unchanged.
- No new canonical write path was introduced.
- Placement writer contract is unchanged.
- Project Open From Directory behavior is unchanged.
- Rotation normalization is unchanged.
- Projection-stale policy is unchanged.
- `known_facts.json` remains projection/cache and is not directly mutated by Flutter.

## Carryover observation

A separate canonical-bounds issue remains out of scope: UI can still produce `board_normalized` payload values outside schema bounds, for example `width > 1` or center outside `0..1`. The validator correctly rejects invalid payloads.

Recommended future candidate, not routed:

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS`

## Default boundaries while route is idle

- No runtime edits without a new active implementation lock.
- No test edits without a new active implementation lock.
- No schema, tool, materializer, validator, writer, event, or projection changes without a protected scope-lock.
- No `_incoming` edits or staging.
- Do not stage, commit, or push unless explicitly asked.