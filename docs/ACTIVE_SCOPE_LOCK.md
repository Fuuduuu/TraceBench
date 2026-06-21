# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_PROTECTED_SCOPE_LOCK

## Goal

Authorize the next implementation scope for Add Component local ghost preview without runtime changes in this pass:
- local-only canvas ghost preview after accepted visual-contact builder state,
- no canonical placement or persistence,
- no Confirm/write,
- no placement/rotation runtime,
- no shared/protected surface changes.

## Baseline

- Current route before this pass: `TRACEBENCH_ACCEPTED_SHORTHAND_DOCS_SYNC_PASS`.
- Latest accepted Add Component runtime baseline: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_ACTIVE_PANEL_POLISH_PASS`.
- `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_SCOPE_LOCK_PASS` remains parked as recovered route context.

## Status labels to record

- `ROUTE_EFFECT: DOCS_PROTECTED_SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_PASS`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_SCOPE_LOCK_PASS.md`

## Preserve boundary

This pass is docs-only and is a protected implementation-scope activation:

- No runtime code/tests are modified.
- No `schema/writer/materializer/validator/projection/event/fact/Project ZIP` changes.
- No Add Component placement runtime.
- No rotation draft or placement/drag/click-to-place behavior.
- No Confirm/write or Edit Layout in this pass.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_SCOPE_LOCK_PASS`.
- Next route: `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_PASS`.

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```

## Stop conditions

- Stop if any runtime/editorial file outside `docs/` changes.
- Stop and report if this pass claims an accepted/pushed hash for this uncommitted lock pass.
- Stop if this pass asserts runtime changes to protected surfaces or placement semantics.

## STOP_IF

- This lock pass is accepted only if `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_IMPL_PASS` is kept as implementation-only.
- Click-to-place is deferred in this boundary.
- Drag-to-place is deferred.
- Rotation draft is deferred.
- Any draft coordinate must be local UI memory only and explicitly non-canonical.
