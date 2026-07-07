# BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS

## Mode

Docs-only build-lock / implementation allowlist sync.

## Purpose

Arm a narrow implementation pass for Board Canvas right-panel component metadata editing.

This is the follow-up to `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` and routes directly to `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`.

## Baseline

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Verified HEAD before edits: `962a525 docs: close out board canvas right-panel creation flow`
- Remote alignment: `main...origin/main`
- Tracked diff before edits: clean
- Cached diff before edits: clean
- Route before edits: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- Active implementation lock before edits: none
- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` verified as implemented, pushed, and closed out.

Known untracked scratch remains ignored by this pass and was not staged.

## Route

Current: `BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS`

Next: `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`

## Live-code findings

- Board Canvas owns the right-panel/context-panel UI through `_WorkbenchContextPanelMode`, `contextPanel`, and `board_canvas_context_panel`.
- Board Canvas has typed UI-local `CanvasSelection`.
- `ComponentPlacementSelection` includes `componentId`.
- Board Canvas right-panel already has compact component identity creation.
- Existing creation flow writes `component_created` only through `V2AddComponentWriter` / `v2AddComponentWriterProvider`.
- Existing `V2EditComponentWriter` / `v2EditComponentWriterProvider` exists.
- Existing `V2EditComponentWriter` writes `component_updated` only.
- Existing `V2EditComponentWriter` requires:
  - known/existing component;
  - at least one `V2ComponentChange`;
  - `editReason`;
  - `clientOperationId`.
- Existing standalone `EditComponentScreen` uses `V2EditComponentWriter`, appends returned event to local `projectState.events`, and marks projection stale.
- `ComponentFact` exposes component metadata fields including `componentId`, `designator`, `type`, `package`, `pinCount`, `marking`, `status`, `installationStatus`, and `removedByEventId`.
- `tools/validate_events_jsonl.py` permits `component_updated` fields from `V2_COMPONENT_CREATED_ALLOWED_FIELDS - {component_id}`.
- No live-code evidence requires writer/schema/materializer/validator/router changes for a first Board Canvas right-panel metadata edit slice.

## Implementation pass armed

`BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If any additional file is required, the implementation pass must stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation intent

Add a first Visual First Board Canvas right-panel metadata edit flow for an existing selected component.

The future implementation must:
- show compact metadata edit controls for the selected component when a placed component is selected on Board Canvas;
- operate on the currently selected `ComponentPlacementSelection.componentId`;
- show compact guidance such as `Vali komponent plaadil` when no component is selected;
- write only `component_updated`;
- use the existing `V2EditComponentWriter` / `v2EditComponentWriterProvider`;
- write only on explicit human action such as `Salvesta muudatused`;
- update local `projectState.events` and mark projection stale like the existing standalone writer pattern;
- stay inside the Board Canvas right panel without route push to standalone Edit Component as the primary flow;
- avoid component identity creation, visual placement creation, and canvas placement/move/resize/rotate behavior.

Preferred first-slice fields:
- display label / name;
- component kind using writer-safe canonical values: `unknown`, `passive`, `ic`, `connector`, `regulator`.

Optional if simple and already safely represented in known facts:
- reference designator;
- package hint.

Do not add pin count, contacts, visual contact layout, placement, net, trace, electrical status, AI diagnosis, or repair fields.

Visible labels may be richer but must map back to canonical writer-safe values:
- `Generic / unclassified` -> `unknown`
- `Resistor / capacitor / diode / passive` -> `passive`
- `IC dual-side / quad-side / dense grid` -> `ic`
- `Connector / header` -> `connector`
- `Regulator / relay / module` -> `regulator`

No new canonical `componentKind` values may be introduced.

## Change construction requirements

The future implementation must:
- build `V2ComponentChange` entries only for changed non-empty fields;
- use `oldValueObserved` from current knownFacts / `ComponentFact` values;
- use `unknown` only where the existing writer/screen pattern already does that safely;
- use `changeKind: set` when old value is `unknown`, otherwise `replace`;
- keep `editReason` compact and deterministic, e.g. `board_canvas_right_panel_metadata_edit`;
- use deterministic `clientOperationId` from componentId plus changed fields/form key to support idempotent retries;
- prevent duplicate submit of the same successful form if practical.

## Canonical boundaries

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.
- events.jsonl remains canonical truth.
- known_facts.json remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Flutter must not directly mutate `projectState.knownFacts` for this metadata edit flow.
- Human is the sensor; AI is the graph engine.
- Board Canvas renderer/painter remains read-only.
- Explicit right-panel metadata edit action may write only `component_updated` through the accepted writer.

## Forbidden surfaces

No implementation is performed in this build-lock.

The next implementation pass must not edit:
- router files or route definitions;
- standalone Add/Edit/Measure screens;
- Project Overview;
- writer services;
- schemas;
- materializers, validators, or tools;
- `events.jsonl` / `known_facts.json` semantics;
- `_incoming`;
- assets;
- `pubspec.yaml` / `pubspec.lock`;
- splash/home/fullscreen/window-manager files;
- Board Graph files;
- contact/pin/pad/net/trace/measurement/electrical/AI/repair semantics.

## Visual First rule

Board Canvas plus the right-side panel/menu is the primary technician workflow surface.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. Do not duplicate those pages inside Board Canvas and do not route technicians out of Board Canvas as the primary workflow unless a future scoped pass explicitly changes that product rule.

Do not resurrect navigation-only gateway behavior, four-card mode selectors, table/form page transplants, or old workflow menus inside Board Canvas.

## Review status

DRAFTED / PENDING REVIEW.

SAFE_FOR_STAGING is not claimed by this build-lock draft. Reviewer must decide.