# Active Scope Lock

## Route

Current: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS`
Next: `NEEDS_USER_DECISION`

## Active authority

Only `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` is active. This
accepted-lock Lane A docs-only pass may write exactly:

- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS.md`

It may change only the single inaccurate `docs/FILE_MAP.md` archive owner-role
cell and the minimum truthful route, index, and audit records required by this
pass. The corrected meaning must state that the archive is the immutable
historical audit-ledger snapshot and that per-pass disposition registers live
in corresponding `docs/audit/*.md` artifacts.

`docs/archive/AUDIT_INDEX_ARCHIVE.md` remains the immutable historical ledger
snapshot. Per-pass disposition registers live in the corresponding
`docs/audit/*.md` artifacts. The repair must not edit the archive itself.

It must not edit the archive README, the existing scope-lock artifact, any
other audit artifact, the stale Board Canvas code-map anchor, Project Sources,
skill-inventory findings, runtime, schema, tool, test, Dart, Flutter, package,
asset, Project ZIP, `_incoming`, or protected semantics.

## Audit and release gate

This repair remains active until its exact six-file diff is independently
audited and accepted, then committed and pushed exactly by the human.
`NEEDS_USER_DECISION` is the non-executable next-route sentinel and grants no
write authority. No successor pass is reserved.
