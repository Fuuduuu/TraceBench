# Active Scope Lock

## Current pass

`BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS`

## Lock state

Docs-only build-lock active.

Implementation lock armed for `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS`.

## Current build-lock write set

Only these docs may be changed by this build-lock:
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS.md`

Do not edit runtime or tests in this build-lock.

## Armed implementation allowlist

The next implementation pass may write only:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If the implementation needs `v2_add_component_writer.dart`, schema, materializer, validator, tools, router, standalone Add/Edit/Measure screens, project state models, assets, `_incoming`, or any additional file, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation intent

Add a first Visual First Board Canvas right-panel component identity creation flow.

Required behavior:
- User can create component identity/existence from the Board Canvas right panel.
- The flow writes only `component_created`.
- The flow uses the existing `V2AddComponentWriter` / `v2AddComponentWriterProvider`.
- The write occurs only on explicit human action, such as `Loo komponent` or `Salvesta komponent`.
- The result updates local `projectState.events` and marks projection stale, matching the existing standalone writer pattern.
- The flow remains inside the Board Canvas right panel; no route push to standalone Add Component as the primary creation flow.
- The flow must not create visual placement or place the component on canvas.
- The flow must not create pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.

Minimum first-slice fields:
- component ID / `Koht`
- label / name
- compact component kind choice using existing allowed kinds: `unknown`, `passive`, `ic`, `connector`, `regulator`

Keep the UI compact and right-panel-native. Do not recreate a table/form page transplant.

## Visual First rule

Board Canvas plus the right-side panel/menu is the primary technician workflow surface.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. Do not duplicate those pages inside Board Canvas and do not route technicians out of Board Canvas as the primary workflow unless a future scoped pass explicitly changes that product rule.

Canonical split:
- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Forbidden surfaces

Do not change in this build-lock.

Do not change in the next implementation unless separately scoped:
- router files or route definitions
- splash/home/workbench/Add/Edit/Measure runtime outside the exact Board Canvas allowlist
- writer services
- schemas
- validators/materializers/tools
- canonical events/facts semantics
- `events.jsonl`
- `known_facts.json`
- `_incoming`
- `windows/` or native runner files

For the next implementation pass, Board Canvas runtime/test edits are allowed only through the exact two-file implementation allowlist above.

## Canonical boundaries

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- AI must not create canonical facts without explicit human confirmation.
- Visual drafts must not become pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- Exact-file staging only; broad staging is forbidden.
