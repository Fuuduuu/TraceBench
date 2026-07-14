# Active Scope Lock

## Route

Current: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_ACTIVE_LOCK_SYNC_PASS`

Baseline: `a02d87ea1bd71f2eebfc5dfd79ef4b5f3b916c7e`
(`docs: close out board canvas project home route`).

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Current docs-only authority

This scope-lock pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_PROJECT_NAVIGATION_HUB_SCOPE_LOCK_PASS.md`

No runtime, test, map, router, app, tool, schema, asset, package, or `_incoming`
change is authorized. Do not stage, commit, or push from this pass.

## Human-locked navigation hub

Add one compact `Projekt` action to the existing Board Canvas rail. It opens a
right-panel navigation section, not a page, dialog, drawer, or second workbench.

Expose exactly:

- BenchBeep Home -> `/`
- Foto tõendid -> `/project/photos`
- Viitepildid -> `/project/reference-images`
- Advanced graph -> `/project/graph`
- Sündmused -> `/project/events`
- Teadaolevad faktid -> `/project/known-facts`
- Raport -> `/project/report`

All destinations are existing routes. No route may be added, renamed, or
reparented. `/project/overview` remains reachable but is not added to this hub;
its retirement requires a separate future scope lock.

Do not duplicate component create/edit, the integrated measurement workflow,
Board Canvas itself, or legacy components/measurements/pins/not-populated list
pages.

## Future implementation reservation — not active authority

The required active-lock sync may later promote
`BOARD_CANVAS_PROJECT_NAVIGATION_HUB_IMPL_PASS` with exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No wildcard, optional file, new file, or automatic expansion is authorized.
These two files are not writable under the current docs-only pass. The
implementation pass is not directly armed; the active-lock sync is mandatory
after this scope lock is audited, accepted, and pushed.

## Code-map contract

Primary responsibility zones:

- Zone 1: screen orchestration through `BoardCanvasScreen`,
  `_BoardCanvasScreenState`, `_WorkbenchContextPanelMode`, and the existing
  right-panel composition.
- Zone 11: rail, focus, and responsive chrome through `_WorkbenchToolRail`,
  `_WorkbenchPanelModeButton`, `_CanvasFocusButton`, and the existing medium/
  wide panel topology.

Inspect only:

- selection and contextual-panel state coupling;
- medium and wide reachability;
- focus mode and restore behavior;
- existing Measure Sheet navigation and every current panel mode.

Write class: `UI_LOCAL` panel selection plus `ZERO_WRITE` route navigation.
No canonical writer, event append, file write, project-state mutation, or
projection-state mutation is authorized.

Map disposition: `REVIEWED_NO_CHANGE`. The locked outcome adds content inside
the existing Zone 1 and Zone 11 responsibilities; it does not move or create a
responsibility owner. If implementation changes those documented
responsibilities or introduces material map drift, stop because the maintained
map is outside this allowlist and requires a separate docs-only map pass.

## Acceptance and audit gate

The future implementation must prove:

1. `Projekt` is reachable in medium and wide layouts.
2. It opens inside the existing right panel.
3. Every listed action reaches its existing route.
4. No route is added or renamed.
5. Focus mode and current panel modes remain stable.
6. No action writes events, facts, files, project state, or projection state.
7. Board Canvas remains visually dominant.
8. `/project/overview` is neither deleted nor redesigned.
9. Focused tests prove links and no-write behavior.
10. Human visual approval is recorded before Claude implementation audit.

The later implementation Claude packet must be marked
`USE ONLY AFTER MANUAL SMOKE PASS`. This docs-only scope lock may receive its
independent scope audit before implementation.

## Preserved boundaries

No overview retirement, router/app change, new route, standalone menu page,
writer/event/fact/schema/validator/materializer/projection/Project ZIP change,
component or measurement workflow change, broad redesign, canonical placement/
coordinate/net/electrical change, refactor, extraction, dependency, asset,
package, or `_incoming` work is authorized.
