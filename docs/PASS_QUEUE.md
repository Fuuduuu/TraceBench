# PASS_QUEUE.md

PASS_QUEUE is the active pass allowlist and near-future sequencing ledger.

## Scope gate

1. PASS_ID exists here unless the route is `NEEDS_USER_DECISION`.
2. PASS lane is valid.
3. PASS does not violate docs/ACTIVE_SCOPE_LOCK.md when an active lock is armed.
4. If risk is high, run audit/precheck before implementation.
5. Completed pass history belongs in docs/AUDIT_INDEX.md, docs/audit/*.md, docs/PASS_QUEUE_ARCHIVE.md, and git history, not in this active queue.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

- docs/MEMORY_MAINTENANCE.md owns the rule to compact docs/CURRENT_STATE.md when it grows beyond the operational handoff threshold.
- Completed pass rows removed from this active queue are preserved in docs/PASS_QUEUE_ARCHIVE.md before removal when an archive update is scoped.
- Use docs/AUDIT_INDEX.md, docs/audit/, docs/PASS_QUEUE_ARCHIVE.md, and git history for completed pass provenance.

## Active / near-future queue

No active scoped pass. Current route is `NEEDS_USER_DECISION`.

## Planned follow-up sequence

| Phase | Future pass family | Purpose | Implementation authorization |
| --- | --- | --- | --- |
| P3 | placement editor + writer scope-lock | Lock Board Canvas right-panel / ghost draft as the official UI-local placement editor and define writer boundaries now that projection ordering/invalidation is resolved. | Docs only after user decision. |
| P4 | placement editor implementation active-lock sync | Arm exact future UI/writer implementation allowlist after accepted scope-lock. | Docs only. |
| P5 | UI-local placement editor shell | Add or refine local draft UI without canonical writes. | Runtime/test only after active lock. |
| P6 | placement writer implementation | Add dedicated V2 placement writer service and tests. | Protected implementation after explicit scope lock. |
| P7 | edit-placement flow | Scope and implement editing of confirmed visual placement separately. | Future protected scope. |
| P8 | visual-contact layout | Separate confirmed visual-contact event/projection/UI; not folded into placement. | Future protected scope. |
| P9 | AI marker conversion | Human-confirmed conversion of AI marker proposals through placement editor path. | Future protected scope. |

## Recent closeout context

| PASS_ID | Lane/Type | Status | Notes |
| --- | --- | --- | --- |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS | CODEX / DOCS_ACTIVE_LOCK_SYNC / protected implementation arm | accepted/pushed as `39df320` (`docs: arm placement projection ordering implementation`) | Armed exact implementation allowlist `tools/materialize_known_facts.py` and `tests/test_materialize_known_facts.py`; no implementation in sync. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS | CODEX / PROTECTED_IMPLEMENTATION / materializer projection semantics | accepted/pushed as `386b52369a44053ac947aed344864a1b74e54df1` (`fix: order placement projection by event stream`) | Implementation audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; safe staging set `tools/materialize_known_facts.py` and `tests/test_materialize_known_facts.py`; stream-order latest-wins and placement invalidation retraction implemented. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_POST_AUDIT_PASS | CODEX / DOCS_CLOSEOUT / implementation post-audit | completed docs-only closeout; route set to `NEEDS_USER_DECISION` | Records implementation audit, validation evidence, implementation summary, test coverage, boundary confirmation, and active-lock release. |
| PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK / protected projection semantics | accepted/pushed/audited as `5cbf3b5174d062e716aa0c31d73420716fff7964` (`docs: lock placement projection ordering`) | Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; locks stream-order latest-wins and placement invalidation retraction before writer/UI work. |
| TRACEBENCH_FILE_MAP_PASS | CODEX / DOCS_SYNC / file-map creation | accepted/pushed/audited as `dd0024450deb674dbb55d7ec71103f366f02a313` (`docs: add TraceBench file map`) | Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; safe staging set recorded in `docs/AUDIT_INDEX.md`; route remained `NEEDS_USER_DECISION`. |
