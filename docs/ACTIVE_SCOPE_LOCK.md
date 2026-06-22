# Active Scope Lock

## Current pass

`V2_WORKBENCH_BOARD_CANVAS_DASHED_LINE_CLEANUP_DOCS_SYNC_PASS`

## Type

CODEX / DOCS_SYNC

## Goal

Synchronize governance state so live routing/provenance no longer reports `_drawDashedLine` as deferred; record that commit `99967a2` (`refactor: remove orphaned _drawDashedLine dead code`) resolves the earlier lint/QA nit.

## Baseline

- Current route before this pass: `NEEDS_USER_DECISION`
- Latest accepted implementation commit: `673c486` (`feat: propagate add component template shape and defaults`)
- `_drawDashedLine` deferred note was introduced in the historical closeout context of
  `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_SHAPE_AND_DEFAULTS_IMPL_POST_AUDIT_PASS`.
- Latest accepted docs-only cleanup for this nit is now in `99967a2`.

## Status labels to record

- `ROUTE_EFFECT: DOCS_SYNC`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_A`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_BOARD_CANVAS_DASHED_LINE_CLEANUP_DOCS_SYNC_PASS.md`

## Preserve boundary

- This pass is docs-only.
- No runtime files are edited.
- No test files are edited.
- No `schema/writer/materializer/validator/projection/Project ZIP/event/fact` changes.
- No `renderer writes` behavior changes.
- `_drawDashedLine` is historical-only stale-nit context in this pass.

## Route

- Current pass: `V2_WORKBENCH_BOARD_CANVAS_DASHED_LINE_CLEANUP_DOCS_SYNC_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
