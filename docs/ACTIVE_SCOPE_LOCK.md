# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS`

## Type

`DOCS_MANUAL_QA_RECORD`

## Lane

`CODEX / DOCS_MANUAL_QA_RECORD`

## Mode

Documentation/manual QA record only. Do not modify runtime code, tests, tooling, schemas, samples, Project ZIP logic, writer/materializer/validator/projection files, stage, commit, or push.

## Current goal

- Record the user-reported manual Board Canvas layout-density polish smoke result as PASS.
- Record exact user wording: "kõik on passed. ja töötab".
- Record the checklist summary without inventing screenshots or observations beyond user-reported context.
- Return route docs to:
  - Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS`
  - Next recommended: `NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Baseline

- Accepted closeout commit: `09cdeb7` (`docs: close out board canvas layout density polish`)
- Accepted implementation commit: `4fe7ade` (`feat(board-canvas): polish layout density`)
- Startup route context: closeout pass was pushed; route availability was `NEEDS_USER_DECISION` via next recommended route.
- User-reported smoke result: PASS

## File allowlist for this manual QA record pass

Docs only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS.md`

## Smoke record scope

Record the user-reported PASS checklist:

1. Board/canvas is noticeably larger.
2. Placement selector is collapsed/compact and opens normally.
3. Safety / Evidence is collapsed/compact and opens normally.
4. Inspector is visible.
5. Inspector hide/collapse works.
6. Inspector restore works and content returns.
7. Canvas becomes wider when inspector is hidden.
8. Tap-to-select works.
9. Chip/selector selection works.
10. Mouse wheel zoom works.
11. Pan works after zoom.
12. Fit/reset is discoverable/works.
13. Measurement badge/count remains visible.
14. Measurement summary remains visible.
15. Visual-trace metadata remains visible.
16. Photo-alignment readiness metadata-only panel remains visible.
17. Footer still shows `renderer writes: none`.
18. No authoring/write/save/edit controls appeared.

## Deferred / not implemented

- Auto-hide remains deferred.
- Project Overview / Workbench density remains a separate later pass.
- Multi-placement fixture remains deferred unless separately scoped.

## Strict non-goals / forbidden changes

- runtime code
- tests
- tooling
- schemas
- samples
- pubspec files
- Project ZIP logic
- writer/materializer/validator/projection files
- platform/generated files
- facts/events/coordinates
- placement/measurement/marker editing
- probe/pin/pad anchors
- net/path/trace inference
- visual_trace geometry
- photo/layers/AI/OCR/CV
- Save/Add/Edit behavior
- `known_facts` mutation
- `events.jsonl` mutation
- `sequence`
- `Muu ühik`
- screenshots or visual evidence claims not present in repo/context
- automated validation claims not actually run in this pass
- unrelated docs

## Required validation

- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS`

Next: `NEEDS_USER_DECISION`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
- This manual QA record does not reopen implementation or closeout work.
