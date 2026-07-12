# Pass Queue

## Current route

Current: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS`

## Current docs-only scope lock

`BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS` records the human-approved Board Canvas component navigator direction, exact two-file future implementation allowlist, UI-local state boundaries, protected exclusions, dependency stops, and required test/validation gates.

Current write set is exactly the four route/ledger docs plus `docs/audit/BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_SCOPE_LOCK_PASS.md`. No runtime, test, asset, route, package, schema, writer, tool, or product behavior changes are authorized in this pass.

## Next implementation

`BOARD_CANVAS_COMPONENT_CATEGORY_NAVIGATOR_IMPL_PASS` implements one three-level contextual right-panel navigator, fixed technician categories, placed/unplaced component lists, measurement-aware ordering and visibility, coherent typed component/placement selection, hover previews, and the persistent `Peida mõõtmata` / `Näita mõõtmata` canvas control.

Future implementation write allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

See `docs/ACTIVE_SCOPE_LOCK.md` for the exact requirements and stop conditions. Do not route through `NEEDS_USER_DECISION` between this scope lock and implementation.

Do not stage, commit, or push from this docs pass.
