# Active Scope Lock

## Current pass

`TRACEBENCH_POST_MISSING_POINTER_ROUTE_SYNC_PASS`

## Type

CODEX / DOCS_SYNC_ROUTE_CLEANUP

## Goal

Clean up live route docs after `TRACEBENCH_AUDIT_INDEX_MISSING_POINTER_SYNC_PASS` was accepted/pushed at `bb88226` (`docs: add missing audit index pointer`) and route back to `NEEDS_USER_DECISION` without runtime/test/product changes.

## Baseline

- Latest accepted/pushed pass: `TRACEBENCH_AUDIT_INDEX_MISSING_POINTER_SYNC_PASS` at `bb88226` (`docs: add missing audit index pointer`).
- Current route before this pass: `NEEDS_USER_DECISION`.
- Working tree started with leftover tracked route-doc changes in `docs/ACTIVE_SCOPE_LOCK.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md` from `TRACEBENCH_AUDIT_INDEX_MISSING_POINTER_SYNC_PASS`.
- Those stale route-doc changes must not be staged as-is because the missing-pointer sync is already accepted/pushed.
- The missing `33d2f17` AUDIT_INDEX pointer sync is closed.

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_POST_MISSING_POINTER_ROUTE_SYNC_PASS.md`

## Explicitly not changed

- Runtime files.
- Test files.
- Historical audit artifacts.
- Product features.
- Product/runtime behavior.
- Product identity cleanup.
- Source/design runtime dependency.
- Protected data/write surfaces.
- Untracked scratch files.

## Boundary

- This sync is docs-only route cleanup.
- It records no accepted/pushed hash for this uncommitted cleanup pass.
- It does not create a new product route.
- It does not expand the active lock for runtime work.
- It does not change product behavior.
- It does not edit runtime, tests, schemas, writer, materializer, validator, projection, Project ZIP, event, or fact files.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `TRACEBENCH_POST_MISSING_POINTER_ROUTE_SYNC_PASS`
- Route after accepted/pushed: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
