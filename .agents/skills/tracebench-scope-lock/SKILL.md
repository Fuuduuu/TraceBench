# tracebench-scope-lock

Reusable workflow for TraceBench docs-only scope-lock passes.

## When to use

Use when prompt contains `SCOPE_LOCK_PASS` / `scope lock`.

## Required reads

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/PROMPTING_PROTOCOL.md`
- relevant open audit docs for the target route

## Required output

- `MODEL_ROUTING_CHECK`
- tool/plugin/download capability report
- allowed files
- forbidden surfaces
- validation plan
- scope drift check
- next recommended pass

## Rules

- no runtime implementation in scope-lock unless explicitly permitted by an allowlist
- no protected surface changes without explicit pass-level scope and post-audit
- no commits in-lock
- maintain one-pass narrowness
- stop if route-docs are inconsistent

## Suggested workflow

1. verify preconditions and git consistency
2. update `docs/ACTIVE_SCOPE_LOCK.md`, `docs/PASS_QUEUE.md`, and supporting governance rows if needed
3. include only lock-scoped file changes
4. run required validation commands
5. emit closeout-style summary with next-pass recommendation
