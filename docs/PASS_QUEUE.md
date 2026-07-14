# Pass Queue

## Current route

Current: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current docs-only scope lock

This pass changes only the four operational route docs and
`docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS.md`. It locks a
compact `Projekt` rail action whose right-panel hub links only to existing
routes.

## Future implementation reservation

After this scope lock is independently audited, accepted, and pushed, the
active-lock sync may promote
`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS` with exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

These files are not current write authority. Implementation may not begin
before the active-lock sync is accepted and pushed.

The hub contains exactly:

- BenchBeep Home -> `/`
- Foto tõendid -> `/project/photos`
- Viitepildid -> `/project/reference-images`
- Advanced graph -> `/project/graph`
- Sündmused -> `/project/events`
- Teadaolevad faktid -> `/project/known-facts`
- Raport -> `/project/report`

## Queue boundary

No overview retirement, router/app edit, new route, standalone menu page,
component or measurement duplication, broad Board Canvas redesign, map edit,
writer/schema/projection change, refactor, dependency, or `_incoming` work is
armed.

Map disposition: `REVIEWED_NO_CHANGE`.

Scope evidence:
`docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS.md`.
