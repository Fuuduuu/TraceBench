# Pass lifecycle governance

This diagram is orientation only; canonical repo docs win.
Canonical pass state remains in `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.

## Pass lifecycle (compact)

```mermaid
flowchart TD
  Backlog["route / backlog decision"] --> Gate{"Scope lock needed?"}
  Gate -- "no" --> Pass["implementation / docs / test pass"]
  Gate -- "yes" --> ScopeLock["scope-lock pass (DOCS_SYNC)"]
  ScopeLock --> Pass
  Pass --> Audit["post-pass audit"]
  Audit -->|PASS| Closeout["docs-only closeout pass"]
  Audit -->|PASS_WITH_NITS| Guard["narrow fixup / scope-lock follow-up"]
  Guard --> Pass
  Audit -->|NEEDS_FIX| Fix["small implementation fix"]
  Fix --> Pass
  Audit -->|REJECT| Reroute["route re-review / stop"]
  Closeout --> Commit["user commit / push"]
  Commit --> Drift{"docs drift needed?"}
  Drift -->|"yes"| DriftPass["DOCS_DRIFT_MINI_CLEANUP_PASS"]
  Drift -->|"no"| NextRoute["next route review + next pass"]
```

## Audit-gate rules

- Every TraceBench Codex PASS_ID response ends with a clearly separated, paste-ready `CLAUDE_AUDIT_PACKET`.
- Visual/product-surface work requires manual smoke before Claude audit.
- Visual/manual-smoke packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.
- Claude audit must not approve a known-wrong visual draft.
- `Accepted` shorthand is valid only for clean `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and an exact expected staging set.
- Any nit, blocker, route/hash mismatch, unexpected file, protected-surface concern, or unclear staging set requires the relevant Claude audit details.
- Staging must be exact-file staging only; never `git add .`, never `git add -A`, and never broad-stage.

## Protected implementation active-lock sync

After a protected scope-lock is accepted/pushed, implementation may begin only when `docs/ACTIVE_SCOPE_LOCK.md` names the implementation pass and lists the exact runtime/test write allowlist.

If the active lock still names the docs-only scope-lock or does not list the runtime/test allowlist, route first to:

```text
<IMPLEMENTATION_PASS>_ACTIVE_LOCK_SYNC_PASS
```

That active-lock sync pass is docs-only and must not implement runtime behavior.

```mermaid
flowchart LR
  Notes["Repo docs win"] --> C1["docs/CURRENT_STATE.md"]
  Notes --> C2["docs/PASS_QUEUE.md"]
  Notes --> C3["docs/ACTIVE_SCOPE_LOCK.md"]
```

```mermaid
flowchart LR
  Q["queue/review history"] --> A["docs/AUDIT_INDEX.md"]
  Q --> H["docs/audit/*.md"]
```
