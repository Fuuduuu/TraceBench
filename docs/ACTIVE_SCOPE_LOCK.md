# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Lock state

No active implementation lock is armed.

`BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` is closed and pushed as `4390255c51609396977a16f60b14c2b6bee50d8c feat: add board canvas right-panel component creation`.

The prior implementation allowlist is released:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Do not treat this released allowlist as authorization for future edits. Any future implementation pass must be separately scoped and armed.

## Closed implementation summary

Board Canvas right-panel component identity creation is now implemented.

Recorded behavior:
- Creation is available from the Board Canvas right panel.
- Creation uses existing `V2AddComponentWriter` / `v2AddComponentWriterProvider`.
- Creation writes only `component_created`.
- Creation is explicit human action only via `Loo komponent`.
- Successful create appends returned event to local `projectState.events` if not already present.
- Successful create marks projection stale.
- Flow does not route to the standalone Add Component page.
- Flow does not create visual placement or place the component on canvas.
- Flow does not create pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- Visible rich labels from design input map only to writer-safe canonical `componentKind` values: `unknown`, `passive`, `ic`, `connector`, `regulator`.
- No new canonical `componentKind` values were introduced.

Review status:
- `NON_CLAUDE_REVIEW: ACCEPTED_RISK`.
- Claude audit was not supplied for this pass.
- Reviewer path: GPT/Pro review plus local validation plus manual smoke plus user-approved push.
- GPT/Pro verdict before staging: `ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.

## Visual First rule

Board Canvas plus the right-side panel/menu is the primary technician workflow surface.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. Do not duplicate those pages inside Board Canvas and do not route technicians out of Board Canvas as the primary workflow unless a future scoped pass explicitly changes that product rule.

Canonical split:
- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Forbidden surfaces

No implementation is authorized by the current route.

Do not change without a new active lock:
- router files or route definitions
- splash/home/workbench/Add/Edit/Measure runtime
- writer services
- schemas
- validators/materializers/tools
- canonical events/facts semantics
- `events.jsonl`
- `known_facts.json`
- `_incoming`
- `windows/` or native runner files

## Canonical boundaries

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- AI must not create canonical facts without explicit human confirmation.
- Visual drafts must not become pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- Exact-file staging only; broad staging is forbidden.