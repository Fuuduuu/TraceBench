# Pass lifecycle governance

## Ordinary low-risk work

One compact task boundary -> implementation and focused tests -> human visual
review where applicable -> one independent diff review -> exact human commit.

The boundary can live in the human request/review output: goal, exact paths,
protected exclusions and validation. No separate scope-lock, map-maintenance,
verdict-copy or closeout pass is required for each small UI/docs change.

Update directly relevant maps with the same authorized change when semantic
ownership actually drifts. Review source and map together; do not start an
automatic standalone maintenance programme.

## Protected data and canonical behavior

Use an explicit protected scope with permitted writes, invariants, exact paths,
regression/recovery checks and independent review. Introducing/changing event
semantics, writers/materializer behavior, migrations, persisted compatibility
or Project ZIP requires a formal protected scope lock before implementation.

When a formal scope lock is used, its future implementation ID/allowlist must
already be exact. Independent acceptance and the human's exact commit/push
activate that work; no routine active-lock-sync child is needed.
Invoking an unchanged accepted contract still requires a bounded task and
protected tests, but not automatically another preparatory docs project.

## Review and recording

Do not self-attest visual PASS. A known-wrong UI does not pass implementation
review. Use the actual app and relevant human workflow, not a misleading preview.

Ordinary independent review evidence may stay in the thread/PR/review output.
If the human requests a formal artifact/ledger contract, use AUDIT_CONTRACT.
Bounded mechanical verdict recording can complete the same task; it does not
need another independent audit unless content outside the approved coordinates
changes. Existing artifacts/verdicts remain immutable historical evidence.

One meaningful fix/review cycle handles findings. Do not create a new PASS_ID
just to copy a verdict or announce completion. Update a current pointer only
when the task actually changes route/authority; keep product work the priority.

## Owners

- AGENTS owns task-entry behavior and data safety.
- PROMPTING_PROTOCOL owns risk classification and prompt shape.
- AUDIT_CONTRACT owns independent review and formal record rules.
- CODE_MAP_STANDARD owns map qualification and same-task drift handling.
- CURRENT_STATE owns product priorities; PASS_QUEUE/ACTIVE_SCOPE_LOCK agree
  on the active task and distinguish next priority from executable authority.
