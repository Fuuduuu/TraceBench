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
- `CURRENT_STATE.md` line count checked?

## Current-state compaction trigger

This file is the single canonical owner for the rule: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.

- Canonical maintenance trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Check the line count during route reviews and closeouts.
- If compaction is needed, route a bounded docs-only current-state compaction pass before another feature pass unless a higher-priority safety fix is already locked.
- The old manually decremented docs-drift countdown is deprecated/superseded and must not be re-armed as the canonical maintenance mechanism.
- For historical cleanup evidence, use the latest applicable `DOCS_DRIFT_MINI_CLEANUP_*` entry in `docs/AUDIT_INDEX.md`; do not hard-code a stale cleanup pass number.

## Deep cleanup

Archive before delete. No deletion in first cleanup pass.
