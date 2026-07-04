# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

## Route status

Docs-only active-lock sync for the future placement draft canonical-bounds guard implementation.

The pushed scope-lock `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS` is now being converted into an exact implementation allowlist.

## Implementation pass armed

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No writer, unit-test, schema, validator, tool, project-open, router, sample, asset, events, `known_facts.json`, materializer, or `_incoming` files are armed.

## Live-code findings

- Board Canvas assembles `V2PlacementWriterRequest` immediately before the placement writer call in the Add Component / placement save path.
- The request uses selected placement context, optional local ghost anchor for `center_x` / `center_y`, local draft `width` / `height`, local draft rotation, template id, and project state.
- Existing guard copy covers missing selected component and missing local folder-backed project, but there is no focused pre-save guard for `board_normalized` center/size bounds.
- Add Component local draft dimension clamp allows values above normalized canonical bounds, so UI-local visual editing can produce `width > 1` / `height > 1` payload candidates.
- Existing widget tests already use a fake placement writer and request capture, so the future guard can be proven without changing writer/unit-test surfaces.
- Placement writer remains unchanged for this implementation lock: it keeps the explicit human-confirmed `component_visual_placement_confirmed` contract, existing project-directory and component checks, event-writer validation path, and rotation normalization.
- `tools/validate_events_jsonl.py` remains the canonical strict validator for `board_normalized` bounds.

## Canonical bounds to preserve

For `coordinate_space: board_normalized`:

- `center_x` must be within `0..1`.
- `center_y` must be within `0..1`.
- `width` must be numeric positive and `<= 1`.
- `height` must be numeric positive and `<= 1`.
- `rotation_deg` must remain normalized to `-180 <= rotation_deg < 180`.

## Future implementation requirement

The future implementation must block or guard `Salvesta` before writer call when the assembled `board_normalized` payload would be invalid. It must show clear user-facing Estonian copy and avoid exposing raw Python validator output for expected UI validation cases.

The implementation should answer in code/tests:

1. Where `center_x` / `center_y` / `width` / `height` are assembled before writer call.
2. Whether invalid bounds disable `Salvesta` or keep it clickable with guard copy.
3. Whether local preview/draft editing may visually exceed bounds while canonical save remains guarded.
4. Whether extents are checked only by payload fields or also by board-edge overhang.
5. Exact Estonian copy replacing raw validator failures.
6. Tests proving the writer is not invoked for invalid bounds.

## Required behavior to preserve

- Valid draft still saves and marks projection stale / refresh-needed.
- Invalid draft edits remain UI-local and write nothing.
- `Kustuta`, `Tühista`, draft edits, and navigation write nothing.
- `Salvesta` remains the only canonical placement write trigger.
- Validator/schema remains strict and unchanged.
- Writer/event contract remains unchanged.
- Rotation normalization remains unchanged.
- Project Open From Directory behavior remains unchanged.
- Board Canvas renderer/painter remains read-only.
- Flutter must not directly mutate `known_facts.json`.
- No component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, or AI-authored facts are created.

## Future tests expected

- `width > 1` blocks `Salvesta` before writer call.
- `height > 1` blocks `Salvesta` before writer call.
- `center_x < 0` or `center_x > 1` blocks `Salvesta` before writer call.
- `center_y < 0` or `center_y > 1` blocks `Salvesta` before writer call.
- Clear guard copy appears.
- Writer is not invoked for invalid draft.
- Valid draft still saves.
- Valid draft still marks projection stale / refresh-needed.
- Rotation normalization still works.
- Project Open From Directory still works.
- Draft edits / `Kustuta` / `Tühista` / navigation write nothing.
- Validator/schema remains unchanged.

## Manual smoke target for future implementation

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Smoke should verify: open folder-backed project, select R1/C1/U1, open `Lisa`, make draft too wide or outside canonical bounds, confirm `Salvesta` is disabled or shows clear guard, confirm no event appends, reduce draft into valid bounds, `Salvesta` appends one `component_visual_placement_confirmed`, UI shows projection-refresh truth copy, and `python tools/validate_all.py` passes.

## Boundary confirmation

This pass is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, or `_incoming`.

## Route safety reminders

- Do not use `git add .`.
- Do not use `git add -A`.
- Do not use `git commit -am`.
- Stage only exact files when staging is explicitly requested.
- Repo docs and verified git state outrank handoff text.