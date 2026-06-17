# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Documentation closeout only. Do not modify runtime code, tests, tooling, schemas, samples, Project ZIP logic, writer/materializer/validator/projection files, stage, commit, or push.

## Current goal

- Record `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS` as implemented, audited, accepted, committed, and pushed.
- Record the accepted implementation commit `4fe7ade` (`feat(board-canvas): polish layout density`).
- Record accepted validation and Claude Code post-audit evidence.
- Return route docs to:
  - Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_CLOSEOUT_PASS`
  - Next recommended: `NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Baseline

- Scope-lock commit: `a7f58f5` (`docs: lock board canvas layout density polish`)
- Accepted implementation commit: `4fe7ade` (`feat(board-canvas): polish layout density`)
- Claude Code post-audit: `ACCEPT_AS_IS` / no required fixes
- Accepted implementation staging set: exactly 7 files

## File allowlist for this closeout pass

Docs only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_CLOSEOUT_PASS.md`

## Closeout scope

Record that the accepted Board Canvas-only implementation:

1. Compacted AppBar/footer/padding.
2. Kept Placement selector collapsed/compact.
3. Kept Safety / Evidence compact/collapsed and accessible.
4. Moved status into a canvas overlay.
5. Added volatile inspector hide/show to give canvas more space.
6. Preserved Board Canvas read-only behavior.
7. Preserved tap-to-select.
8. Preserved chip selector behavior.
9. Preserved pan/zoom/fit.
10. Preserved measurement badge/count.
11. Preserved measurement summary.
12. Preserved visual-trace metadata.
13. Preserved photo-alignment readiness metadata-only.
14. Preserved `renderer writes: none`.

## Deferred / not implemented

- Auto-hide remains deferred.
- Project Overview / Workbench density remains a separate later pass.
- Multi-placement fixture remains deferred.
- Manual smoke rerun remains deferred.

## Strict non-goals / forbidden changes

- Project Overview / Workbench runtime
- facts/events/coordinates
- placement/measurement/marker editing
- probe/pin/pad anchors
- net/path/trace inference
- visual_trace geometry
- photo/layers/AI/OCR/CV
- Save/Add/Edit behavior
- writer/schema/materializer/validator/projection changes
- Project ZIP
- `known_facts` mutation
- `events.jsonl` mutation
- `sequence`
- `Muu ühik`
- dependency/tooling/platform files
- runtime code
- tests
- tooling
- schemas
- samples
- pubspec files
- unrelated docs

## Required validation

- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
- Layout-density polish did not change reset semantics, pan/zoom semantics, tap-to-select semantics, selection semantics, event/fact behavior, or Project ZIP behavior.
