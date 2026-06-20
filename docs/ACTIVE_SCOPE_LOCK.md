# Active Scope Lock

## Current pass

`V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS`

## Type

`CODEX / FLUTTER_PASS`

## Lane

Narrow Workbench / Board Canvas read-only measurement overlay implementation.

## Current goal

Implement optional read-only measurement overlay badges in the accepted Workbench / Board Canvas UI, using only existing projected measurements, existing explicit component association, and existing `board_normalized` component visual anchors.

## Baseline

- `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS` is accepted/pushed as `f1226d4` (`docs: record workbench measurement overlay scope-lock post-audit`) and made no runtime/test/protected-surface changes.
- `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS` is accepted/pushed as `8544a4b` (`docs: lock workbench measurement overlay scope`) and locks the projection-only overlay direction.
- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_POST_AUDIT_PASS` is accepted/pushed as `467d5fe` (`docs: record workbench rail button polish impl post-audit`).
- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS` is accepted/pushed as `349b0e9` (`feat(board-canvas): convert workbench rail to panel-mode buttons`) and retains `renderer writes: none`.
- `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS` is accepted/pushed as `94a1143` (`docs: refresh workbench architecture reference`).

## Implementation allowlist

The implementation pass may touch only these files:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No helper/model/painter split file is pre-authorized. If implementation requires any additional runtime, model, helper, routing, service, widget, or test file, stop and request a new scope decision.

## Current route lock

Current pass: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS`
Next: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_POST_AUDIT_PASS`

## Locked implementation direction

- Existing projected measurements only.
- Existing `knownFacts.measurements` / `MeasurementFact` data only.
- Existing explicit component association only, using `measurementEndpointMatchesComponent(endpoint, componentId)` where the endpoint equals `componentId` or starts with `$componentId.`.
- Existing component visual placements only.
- Visual anchors must already be component placements with `coordinateSpace == 'board_normalized'`.
- Selected-component individual measurement overlay on/off.
- Global Show/Hide All.
- One scalar value plus unit per badge.
- Multiple eligible measurements must not aggregate or compute derived values; prefer deterministic stacked badges.
- Existing projected values are surfaced verbatim.
- Existing `validityStatus` may be consumed only as UI metadata; stale/invalid/suspect readings must not appear fresh or authoritative.
- Overlay visibility is volatile UI-only state.
- State resets on navigation, reload, or project reopen.
- `renderer writes: none` remains visible/true.
- Measure Sheet remains unchanged.
- Add Component remains deferred.

## Forbidden surfaces

- Value entry.
- Unit editing.
- Save behavior.
- Correction/delete behavior.
- Inline measurement entry.
- Measurement authoring.
- New event types.
- Writer calls or writer changes.
- Schema changes.
- Validator changes.
- Materializer changes.
- Projection contract changes.
- Project ZIP changes.
- `events.jsonl` edits.
- `known_facts.json` edits.
- `view_state.json`, preferences, or overlay visibility persistence.
- Canonical visibility events.
- New coordinate semantics.
- New target semantics.
- New measurement association semantics.
- Pin, net, trace, path, probe, pad, or target behavior changes.
- OCR/CV/photo-derived facts.
- Proximity or inference-based association.
- Automatic component matching.
- Measure Sheet removal, redirect, consolidation, or `/project/measure-sheet` deletion.
- Board Canvas renderer write behavior.
- Add Component button/list/drag/rotate/pin/Confirm implementation.
- `component_created` work.
- Generated, platform, dependency, sample, `_incoming`, or scratch artifact changes.

## Required validation

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `dart format <changed dart files>`
- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`

## Scope carry-forward

- Board Canvas remains read-only.
- `renderer writes: none` remains present in accepted behavior context.
- No inline Workbench value/unit/Save or write-flow integration is accepted by this pass.
- No `events.jsonl`, `known_facts.json`, schema, materializer, validator, writer service, or Project ZIP changes are accepted by this pass.
- No Add Component work is accepted in this scope.
- No `_incoming/` assets are treated as accepted runtime behavior.
- Codex writes scoped code/tests inside the active lock, Claude Code is the final repo-local audit gate before staging/commit/push unless repo convention explicitly says otherwise, and the user manually stages/commits/pushes with exact staging sets.
- No broad staging (`git add .` / `git add -A`) is allowed.
