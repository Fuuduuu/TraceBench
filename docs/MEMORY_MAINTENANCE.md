# MEMORY_MAINTENANCE.md

## Rule 1 — one fact, one home

Do not duplicate canonical facts across docs. If a fact already has a home, update that file or add a reference.

## Rule 2 — classify before adding docs

Every new doc/change must be one of:

- product_scope_decision
- active_scope_or_queue_change
- schema_or_data_model_decision
- pass_result_or_audit
- source_or_memory_classification
- cleanup_or_archive_planning
- temporary_analysis

## Rule 3 — index unplanned work first

Unplanned ideas go to:

- `docs/WORK_INTAKE_INDEX.md` for product/code ideas
- `docs/DEFERRED_FEATURES.md` for V1-out-of-scope features

Do not implement unplanned ideas directly.

## Micro-cleanup after every pass

- PASS_QUEUE updated?
- AUDIT_INDEX updated if audit file added?
- Active next step lives in one place?
- Duplicate facts introduced?
- Deferred ideas routed?
- Docs drift countdown decremented?

## Drift countdown

- Start at 5.
- Decrement after accepted pass.
- At 0, run `DOCS_DRIFT_MINI_CLEANUP_PASS` before another feature pass.
- Reset to 5 after cleanup.

## Deep cleanup

Archive before delete. No deletion in first cleanup pass.
