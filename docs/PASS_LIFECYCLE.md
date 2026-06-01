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
