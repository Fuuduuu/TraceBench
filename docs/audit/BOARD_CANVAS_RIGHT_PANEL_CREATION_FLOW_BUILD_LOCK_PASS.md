# BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS

## Mode

Docs-only build-lock / implementation allowlist sync.

## Baseline

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Verified HEAD before edits: `792b273 docs: compact visual-first operational docs`
- Tracked diff before edits: clean
- Cached diff before edits: clean
- Route before edits: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`
- Active implementation lock before edits: none

Known untracked scratch remains ignored by this pass and was not staged.

## Route

Current: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS`

Next: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS`

## Live-code findings

- Board Canvas owns the current right-panel/context-panel UI through `_WorkbenchContextPanelMode`, `contextPanel`, and `board_canvas_context_panel`.
- Board Canvas already has typed UI-local selection via `CanvasSelection`, `EmptyCanvasSelection`, `ComponentPlacementSelection`, and `_selectedPlacementKey` compatibility behavior.
- Board Canvas `Lisa` / Add Component panel currently handles visual placement/local draft controls and calls `v2PlacementWriterProvider` for `component_visual_placement_confirmed`; it is not currently the component identity creation path.
- Standalone `AddComponentScreen` uses `v2AddComponentWriterProvider` / `V2AddComponentWriter` for component identity/existence creation.
- `AddComponentScreen` updates local `projectState.events` and sets `isProjectionStale: true` after a successful writer result.
- `V2AddComponentWriter` emits `component_created` only, with human actor, explicit user confirmation source, `client_operation_id`, and payload fields for component identity/existence plus optional hints.
- Existing live code did not show a need to arm schema, validator, materializer, router, standalone Add/Edit/Measure screens, writer service edits, project state model edits, assets, or `_incoming` for the first Board Canvas right-panel identity creation slice.

## Implementation pass armed

`BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If any additional file is required, the implementation pass must stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation intent

Add a first Visual First Board Canvas right-panel component identity creation flow.

The future implementation must:
- let the user create component identity/existence from the Board Canvas right panel;
- write only `component_created`;
- use the existing `V2AddComponentWriter` / `v2AddComponentWriterProvider`;
- write only on explicit human action such as `Loo komponent` or `Salvesta komponent`;
- update local `projectState.events` and mark projection stale like the existing standalone writer pattern;
- stay in the Board Canvas right panel without route push to standalone Add Component as the primary flow;
- avoid visual placement creation and avoid placing the new component on canvas.

Minimum first-slice fields:
- component ID / `Koht`;
- label / name;
- compact component kind choice with existing allowed kinds: `unknown`, `passive`, `ic`, `connector`, `regulator`.

## Canonical boundaries

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.
- events.jsonl remains canonical truth.
- known_facts.json remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human is the sensor; AI is the graph engine.
- Board Canvas renderer/painter remains read-only.

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
- Board Graph files.

## Review status

DRAFTED / PENDING REVIEW.

SAFE_FOR_STAGING is not claimed by this build-lock draft. Reviewer must decide.
