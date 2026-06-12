# Active Scope Lock

## Current pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_CLOSEOUT_PASS`

## Type

`DOCS_SYNC_CLOSEOUT`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Docs-only closeout for the accepted legacy measurement write-path retirement scope-lock.
No runtime, schema, validator, materializer, writer service, Project ZIP, or other protected-surface changes in this pass.

## Next recommended pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_CLOSEOUT_PASS.md`

## Closeout direction captured

- Scope lock pass is accepted as `ACCEPT_AS_IS` and this pass records closeout.
- legacy-measurement route-remediation implementation is now the next implementation-targeted pass.
- protected runtime/surface constraints remain unchanged until runtime implementation begins.

## Forbidden surfaces

- Scope lock intent is preserved for implementation transition.
- Event model/sequence semantics were not changed in this scope lock.
- `forbidden` and `allowlist` semantics remain from the locked scope-lock artifact:
  - `lib/**` and `test/**` changes remain forbidden except explicit future route-remediation allowlist.
  - no runtime behavior surface in `lib/`, `test/`, or protected runtime families is changed in this closeout.
- `do not add sequence to V2 events` and `do not change V2 event model` to satisfy legacy writer expectations.

## Route lock

Current: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`.
Next: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_POST_AUDIT_PASS`.
