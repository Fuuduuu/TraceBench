# tracebench-docs-closeout

Reusable workflow for TraceBench docs closeout / smoke closeout / governance ledger updates.

## Route-ledger consistency check

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`

All three must agree before closeout is considered complete.

## Additional governance checks

- `AUDIT_INDEX.md` must not point to missing or untracked audit docs.
- `WORK_INTAKE_INDEX.md` status for this topic must not contradict `CURRENT_STATE/PASS_QUEUE`.
- closeout edits must not bundle unrelated dirty files.
- staged set must be explicit and pass-scoped.

## Required output

- closeout summary
- changed files
- dangling-pointer check
- route-doc consistency verdict
- `safe_for_reaudit`
- exact staging commands

## Suggested flow

1. confirm preconditions and route-doc consistency
2. update ledger/docs for the pass
3. check `git diff --name-only` / `git diff --check`
4. run explicit file-stage command and report it
