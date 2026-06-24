# Active Scope Lock

## Current pass

`TRACEBENCH_ROUTE_LEDGER_RECOVERY_SYNC_PASS`

## Type

CODEX / DOCS_SYNC_RECOVERY

## Goal

Reconcile live route/ledger docs with git evidence that `TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS` is accepted/pushed at `d4f6f7d` (`docs: sync prompt audit gate`) and route onward to `NEEDS_USER_DECISION` without runtime/test/product changes.

## Baseline

- `main` and `origin/main` are at `d4f6f7d` (`docs: sync prompt audit gate`).
- No tracked diff and no staged diff before this recovery pass.
- Live route docs still had stale current pointers to `TRACEBENCH_OPERATIONAL_HANDOFF_COMPACTION_PASS`, `V2_BENCHBEEP_MENU_SYSTEM_IMPL_POST_AUDIT_PASS`, and prompt-audit candidate wording.
- The prompt-audit artifact's own pre-commit staging state is historical and is not rewritten by this recovery pass.

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_ROUTE_LEDGER_RECOVERY_SYNC_PASS.md`

## Explicitly not changed

- Runtime files.
- Test files.
- Historical audit artifacts, including `docs/audit/TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS.md`.
- Product identity work.
- Missing `33d2f17` pointer sync.
- Product/menu runtime work.
- New scope-locks.
- Source/design runtime dependency.
- Protected data/write surfaces.
- Untracked scratch files.

## Accepted prompt/audit policy preserved

- Codex pass responses require a clearly separated `CLAUDE_AUDIT_PACKET`.
- Visual/product-surface work requires manual smoke before Claude audit and packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.
- `Accepted` shorthand is strict and requires clean `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and exact expected staging set.
- Protected implementation requires active-lock sync before runtime/test work when the active lock does not name the implementation pass and exact allowlist.
- Exact staging only; never `git add .`, never `git add -A`, and never broad staging.

## Boundary

- This recovery sync changes live route/ledger docs only.
- It records no accepted/pushed hash for itself.
- It does not arm implementation.
- It does not create a new scope-lock.
- It does not change product behavior.
- It does not edit runtime, tests, schemas, writer, materializer, validator, projection, Project ZIP, event, or fact files.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `TRACEBENCH_ROUTE_LEDGER_RECOVERY_SYNC_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
