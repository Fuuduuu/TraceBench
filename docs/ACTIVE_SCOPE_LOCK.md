# Active Scope Lock

## Current pass

`TRACEBENCH_PRODUCT_IDENTITY_OWNER_SYNC_PASS`

## Type

CODEX / DOCS_SYNC

## Goal

Authorize the next docs-only product identity owner sync pass. The future pass may create one durable naming owner for BenchBeep / TraceBench / BoardFact identity, but this active-lock sync pass does not perform that identity cleanup.

## Baseline

- Latest accepted/pushed pass: `TRACEBENCH_ROUTE_LEDGER_RECOVERY_SYNC_PASS` at `c678b44` (`docs: recover TraceBench route ledger`).
- Attempted `TRACEBENCH_PRODUCT_IDENTITY_OWNER_SYNC_PASS` was blocked before edits because `docs/PASS_QUEUE.md` did not contain that pass and this active lock still named `TRACEBENCH_ROUTE_LEDGER_RECOVERY_SYNC_PASS`.
- This lock arms the future identity sync only; it does not mark the future identity sync accepted/pushed.

## Identity facts for the future pass

- `BenchBeep` = user-facing app/product name.
- `TraceBench` = repository/platform/project name.
- `BoardFact` = data-fact/subsystem name.
- `BoardFact` is not the primary app wordmark unless a specific UI surface explicitly earns that subsystem label.

## Allowed files

- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md`
- `README.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_PRODUCT_IDENTITY_OWNER_SYNC_PASS.md`

## Required future-pass stop condition

- If `docs/PROJECT_MEMORY.md` does not exist, the future identity sync pass must stop and report `BLOCKED` instead of inventing a new durable owner doc.

## Explicitly not changed

- Runtime files.
- Test files.
- Historical audit artifacts.
- Product features.
- Menu/runtime behavior.
- Logo polish or branding UI.
- Product identity sync in this active-lock sync pass.
- Missing `33d2f17` pointer sync.
- Memory/handoff refresh.
- Source/design runtime dependency.
- Protected data/write surfaces.
- Untracked scratch files.

## Boundary

- This lock authorizes only a docs-only identity owner sync.
- It records no accepted/pushed hash for the future identity sync.
- It does not authorize runtime/test/product behavior changes.
- It does not create a new scope-lock.
- It does not change product behavior.
- It does not edit runtime, tests, schemas, writer, materializer, validator, projection, Project ZIP, event, or fact files.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.
- No untracked scratch files are touched or staged.

## Route

- Current/armed pass: `TRACEBENCH_PRODUCT_IDENTITY_OWNER_SYNC_PASS`
- Route after accepted/pushed: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
