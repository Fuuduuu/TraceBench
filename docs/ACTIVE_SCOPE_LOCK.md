# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS`

## Type

`DOCS_SYNC / QA_RUN`

## Lane

`CODEX / DOCS_SYNC / QA_RUN`

## Mode

Documentation and QA evidence only for manual Windows/desktop Board Canvas interaction smoke after tap-to-select.

## Current goal

- Create a docs-only manual smoke QA record for the combined Board Canvas interaction surface.
- Record the smoke checklist and actual manual result status without inventing observations.
- Preserve runtime, test, tooling, schema, writer, materializer, validator, projection, and Project ZIP boundaries.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_SYNC / QA_RUN`
- lane: `CODEX / DOCS_SYNC / QA_RUN`
- mode: docs-only QA evidence; no runtime, test, tooling, staging, commit, or push changes in this pass.
- latest accepted baseline: `5a34980` (`docs: add tap to select closeout audit`)
- previous manual smoke status: `PARTIAL / BLOCKED_NO_PLACEMENTS`
- rerun manual smoke status: `PASS_WITH_NITS`

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS.md`

## Smoke target

Manual Windows/desktop smoke was first attempted on an opened project that verified only the empty-state path because no confirmed board-normalized placements were present.

Initial observed empty-state path:

- Board Canvas route/screen opens.
- Empty state displays `No confirmed visual placements yet.`
- Secondary copy displays `Board canvas is read-only in V1. Placement workflow is a future step.`
- Footer displays `renderer writes: none`.
- No placement chips or canvas placements are available.

Rerun with `board_canvas_positive_smoke` is recorded as `PASS_WITH_NITS`.

Rerun observed:

- Project overview shows `board_canvas_smoke_fixture` / `board_canvas_positive_smoke`.
- Read-only projection reports `1 placement(s) found`.
- Board Canvas opens with rendered board-normalized placement `SMP001`.
- Placement selector shows `SMP001 (SMP001)`.
- Board canvas renders the placement and measurement badge `M`.
- Inspector opens/updates for `SMP001`.
- Measurement badge safety copy is visible.
- Measurement summary card is visible and shows measurement `M1001`, continuity, `From SMP001.1`, `To TP1`, and value `0.1 ohm`.
- Visual trace metadata card is visible and read-only.
- Photo alignment readiness metadata-only panel is visible.
- Footer `renderer writes: none` remains visible.
- No authoring/write controls were observed on Board Canvas.

Not fully validated in rerun:

- multi-placement tap switching was not testable because the sample has one rendered placement;
- fit/reset was not found and was not validated;
- post-fit tap alignment was not validated.

Nits / limitations:

- pan was only visibly usable after mouse-wheel zoom;
- canvas visible size/viewport appearance changed after zoom;
- fit/reset discoverability issue.

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

Current: `V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS`

Next: `NEEDS_USER_DECISION`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth and this QA pass must not write it.
- `known_facts.json` remains projection/cache and this QA pass must not mutate it.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
- Manual smoke rerun with `board_canvas_positive_smoke` is recorded as `PASS_WITH_NITS`; remaining limitations require user decision before any new scope.
