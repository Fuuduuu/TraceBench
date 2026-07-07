# Active Scope Lock

## Current pass

`BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`

## Lock state

Docs-only build-lock active.

Implementation lock armed for `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`.

## Current build-lock write set

Only these docs may be changed by this build-lock:
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS.md`

Do not edit runtime or tests in this build-lock.

## Armed implementation allowlist

The next implementation pass may write only:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If the implementation needs `v2_edit_component_writer.dart`, schemas, materializers, validators, tools, router files, standalone Add/Edit/Measure screens, project state models, assets, `_incoming`, or any additional file, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation intent

Add a first Visual First Board Canvas right-panel component metadata edit flow for an existing selected component.

Required behavior:
- When a placed component is selected on Board Canvas, the right panel may show compact metadata edit controls for that selected component.
- Metadata edit must operate on the currently selected `ComponentPlacementSelection.componentId`.
- If no component is selected, show compact guidance such as `Vali komponent plaadil`.
- The flow writes only `component_updated`.
- The flow uses the existing `V2EditComponentWriter` / `v2EditComponentWriterProvider`.
- The write occurs only on explicit human action, such as `Salvesta muudatused`.
- The result updates local `projectState.events` and marks projection stale, matching the existing standalone writer pattern.
- The flow remains inside the Board Canvas right panel.
- The flow must not route to standalone Edit Component as the primary edit flow.
- The flow must not create component identity.
- The flow must not create visual placement.
- The flow must not place, move, resize, or rotate a component on canvas.
- The flow must not create pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- The flow must not directly mutate `known_facts.json`.
- The flow must not directly mutate `projectState.knownFacts`; known_facts remains projection/cache and may be stale after the write.

Preferred first-slice fields:
- display label / name
- component kind using writer-safe canonical values: `unknown`, `passive`, `ic`, `connector`, `regulator`

Optional only if simple and already safely represented in known facts:
- reference designator
- package hint

Do not add pin count, contacts, visual contact layout, placement, net, trace, electrical status, AI diagnosis, or repair fields.

Visible labels may be richer but must map back to canonical writer-safe values:
- `Generic / unclassified` -> `unknown`
- `Resistor / capacitor / diode / passive` -> `passive`
- `IC dual-side / quad-side / dense grid` -> `ic`
- `Connector / header` -> `connector`
- `Regulator / relay / module` -> `regulator`

Do not introduce new canonical `componentKind` values.

## Change construction requirements

The future implementation must:
- build `V2ComponentChange` entries only for changed non-empty fields;
- use `oldValueObserved` from current knownFacts / `ComponentFact` values;
- use `unknown` only where the existing writer/screen pattern already does that safely;
- use `changeKind: set` when old value is `unknown`, otherwise `replace`;
- keep `editReason` compact and deterministic, e.g. `board_canvas_right_panel_metadata_edit`;
- use deterministic `clientOperationId` from componentId plus changed fields/form key to support idempotent retries;
- prevent duplicate submit of the same successful form if practical.

## Visual First rule

Board Canvas plus the right-side panel/menu is the primary technician workflow surface.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. Do not duplicate those pages inside Board Canvas and do not route technicians out of Board Canvas as the primary workflow unless a future scoped pass explicitly changes that product rule.

Do not resurrect navigation-only gateway behavior, four-card mode selectors, table/form page transplants, or old workflow menus inside Board Canvas.

Canonical split:
- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Forbidden surfaces

Do not change in this build-lock.

Do not change in the next implementation unless separately scoped:
- router files or route definitions
- standalone Add/Edit/Measure screens
- Project Overview
- writer services
- schemas
- materializers, validators, or tools
- canonical events/facts semantics
- `events.jsonl`
- `known_facts.json`
- `_incoming`
- assets
- `pubspec.yaml` / `pubspec.lock`
- splash/home/fullscreen/window-manager files
- Board Graph files
- contact/pin/pad/net/trace/measurement/electrical/AI/repair semantics

For the next implementation pass, Board Canvas runtime/test edits are allowed only through the exact two-file implementation allowlist above.

## Canonical boundaries

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- AI must not create canonical facts without explicit human confirmation.
- UI drafts must not become facts without explicit scoped writer action.
- Board Canvas renderer/painter remains read-only.
- Explicit right-panel metadata edit action may write only `component_updated` through the accepted writer.
- Exact-file staging only; broad staging is forbidden.