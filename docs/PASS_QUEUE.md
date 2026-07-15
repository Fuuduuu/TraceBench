# Pass Queue

## Current route

Current: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS`
Next: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_POST_AUDIT_PASS`

## Active implementation

Write authority is exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Add one compact `Projekt` rail action that opens an existing right-panel mode
and exposes exactly:

- BenchBeep Home -> `/`
- Foto tõendid -> `/project/photos`
- Viitepildid -> `/project/reference-images`
- Advanced graph -> `/project/graph`
- Sündmused -> `/project/events`
- Teadaolevad faktid -> `/project/known-facts`
- Raport -> `/project/report`

This is `UI_LOCAL / ZERO_WRITE` navigation. All existing routes and route
names, `/project/overview`, current component and measurement workflows,
focus mode, existing panel modes, Board Canvas visual dominance, and medium/
wide reachability remain preserved.

## Audit and map gate

Map disposition: `REVIEWED_NO_CHANGE`. If the implementation creates material
responsibility drift beyond the maintained map's existing zero-write GoRouter
dependency, stop and require a separately scoped map pass.

Human visual approval in medium and wide layouts is mandatory before Claude
implementation audit. The future packet must say
`USE ONLY AFTER MANUAL SMOKE PASS`.

No overview retirement, router/app edit, new route, standalone surface,
writer/project-state/projection write, workflow change, refactor, dependency,
asset, `_incoming`, or code-map edit is armed.

Sync evidence:
`docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_ACTIVE_LOCK_SYNC_PASS.md`.
