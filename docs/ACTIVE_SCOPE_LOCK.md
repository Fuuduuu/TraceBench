# Active Scope Lock

## Route

Current: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS`
Next: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_POST_AUDIT_PASS`

Baseline: `7b795c49b26463ae535b0ea980524d85ff88fa5f`
(`docs: lock board canvas project navigation hub`).

The scope-lock Claude audit is accepted as `ACCEPT_AS_IS` with
`SAFE_FOR_STAGING: YES`, blockers none, and nits none.

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Active implementation write authority

`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS` may write exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No wildcard, optional file, new file, or automatic expansion is authorized.
If implementation requires a third file, stop with
`BLOCKED_ALLOWLIST_MISMATCH`.

## Locked navigation hub

Add one compact `Projekt` action to the existing Board Canvas rail. It opens an
existing right-panel mode, not a page, dialog, drawer, or second workbench.

Expose exactly:

- BenchBeep Home -> `/`
- Foto tõendid -> `/project/photos`
- Viitepildid -> `/project/reference-images`
- Advanced graph -> `/project/graph`
- Sündmused -> `/project/events`
- Teadaolevad faktid -> `/project/known-facts`
- Raport -> `/project/report`

All destinations are existing routes. Preserve every existing route and route
name. `/project/overview` remains reachable and is neither retired nor
redesigned.

Do not duplicate component create/edit, the integrated measurement workflow,
Board Canvas itself, or legacy components/measurements/pins/not-populated list
pages.

## Interaction and no-write contract

- Opening or closing the `Projekt` panel: `UI_LOCAL`.
- Rendering its content: `ZERO_WRITE`.
- Navigating through `GoRouter` to an existing route: `ZERO_WRITE`.

Preserve focus mode, every existing panel mode, medium and wide reachability,
and Board Canvas visual dominance. Do not call writers or mutate events, facts,
files, project state, or projection state.

## Code-map contract

Primary responsibility zones remain:

- Zone 1: screen orchestration and contextual-panel state.
- Zone 11: rail, focus, responsive chrome, and panel reachability.

Inspect selection/panel-state coupling, medium/wide reachability, focus mode,
current panel modes, and existing Measure Sheet navigation.

Map disposition: `REVIEWED_NO_CHANGE`. The implementation must inspect the
maintained map's GoRouter dependency note. Extending existing zero-write route
navigation without moving responsibility ownership does not require a map
change. If the seven destinations create material responsibility drift,
introduce a new owner, or invalidate documented Zone 1 or Zone 11 claims, stop
with `DECOMPOSE_REQUIRED`; the map is outside this allowlist and needs a
separate docs-only map pass.

## Acceptance and audit gate

The implementation must prove:

1. `Projekt` is reachable in representative medium and wide layouts.
2. It opens inside the existing right panel.
3. Exactly the seven locked actions reach their existing routes.
4. No route is added or renamed.
5. Focus mode and current panel modes remain stable.
6. No action writes events, facts, files, project state, or projection state.
7. Board Canvas remains visually dominant.
8. `/project/overview` is neither deleted nor redesigned.
9. Focused tests cover links, reachability, preserved modes, and no-write
   behavior.
10. Human visual approval is recorded for medium and wide layouts before the
    Claude implementation audit.

The implementation Claude packet must be marked
`USE ONLY AFTER MANUAL SMOKE PASS`.

## Preserved boundaries

No `app.dart` or `router.dart` edit, route addition/rename, overview retirement,
standalone page/dialog/drawer, writer/event/fact/file/project-state/projection
write, component or measurement workflow change, broad redesign, canonical
placement/coordinate/net/electrical change, refactor, extraction, dependency,
asset, package, `_incoming`, or code-map change is authorized.
