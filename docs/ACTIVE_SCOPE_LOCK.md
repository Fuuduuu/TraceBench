# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_TAP_TO_SELECT_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Documentation closeout only for the accepted Board Canvas tap-to-select implementation.

## Current goal

- Record `V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS` as implemented, audited, accepted, committed, and pushed.
- Preserve the accepted UI-only behavior summary and validation evidence.
- Return route docs to `NEEDS_USER_DECISION`.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only route/evidence closeout; no runtime, test, tooling, staging, commit, or push changes in this pass.
- latest pass handled: `V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS`
- accepted baseline: `3e61d48` (`feat(board-canvas): add tap to select`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_CLOSEOUT_PASS.md`

## Accepted implementation outcome

- Tap/click on an already-rendered board-normalized placement selects it.
- Selection updates only volatile UI state.
- Existing `_PlacementEntry`, `selectedKey`, and inspector flow are reused.
- Existing chip selector behavior remains intact.
- Pan/zoom/fit behavior remains intact.
- Read-only / zero-event behavior remains intact.
- Hit testing remains transient and UI-only.
- Hit-test results are not stored as events, facts, coordinates, measurements, placements, markers, traces, nets, view-state files, or Project ZIP content.

## Forbidden touches

- runtime files
- test files
- tooling files
- component creation
- placement creation/editing
- marker editing/dragging/authoring
- measurement creation/editing
- probe/pin/pad authoring
- board coordinate authoring
- new fact/event/measurement semantics
- new association rule
- net/path/trace inference
- visual_trace geometry
- trace-color editing
- background photo rendering
- photo-local to board transform
- contour/layers
- AI/OCR/CV
- Save Measurement behavior changes
- Add Component behavior changes
- Edit Component behavior changes
- writer service changes
- `MeasurementEventWriter` changes
- event schema/model changes
- validator changes
- materializer changes
- projection contract changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path changes
- `sequence` field
- custom unit / `Muu ühik`
- dependency/toolchain/generated/platform changes
- broad Board Canvas redesign
- platform/sample/assets (`assets/samples/pelle_pv20_minimal/metadata/`)
- `_incoming/`

## Current route lock

Current: `V2_BOARD_CANVAS_TAP_TO_SELECT_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Exact focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_CLOSEOUT_PASS.md`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth and tap selection does not write it.
- `known_facts.json` remains projection/cache and tap selection does not mutate it.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
