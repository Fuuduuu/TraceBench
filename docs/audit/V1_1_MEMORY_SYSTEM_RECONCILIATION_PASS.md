# V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS

PASS_ID: `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS`
Lane: `DOCS_SYNC`
Mode: Docs-only implementation. No code, tests, tools, schemas, materializers, samples, assets, generated artifacts, tags, release objects, product semantics, or evidence semantics changed.

## MODEL_ROUTING_CHECK

PASS. Codex is the correct tool/model for this repo-local docs/governance implementation. Claude Code / Opus is required afterward for post-audit.

## Scope drift check

PASS. Changes are limited to the locked docs/governance allowlist:

- `docs/MEMORY_PROTOCOL.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/MEMORY_MAINTENANCE.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/PROJECT_STATE.yml`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS.md`

No audit history was pruned.

## Implementation summary

- Advanced from the accepted scope lock into `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS`.
- Reconciled canonical read-order ownership.
- Reconciled canonical conflict-order ownership.
- Completed missing memory-registry entries for core first-read/context docs.
- Replaced the stale hard-coded cleanup `_04` pointer with a non-stale audit-index lookup pattern.
- Deprecated/superseded the broken manual docs-drift countdown discipline.
- Added the line-count trigger: compact `CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Explicitly deprecated/deprioritized `PROJECT_STATE.yml` as non-canonical.
- Kept `CURRENT_STATE.md`, `PASS_QUEUE.md`, `ACTIVE_SCOPE_LOCK.md`, and `AUDIT_INDEX.md` aligned.

## Read-order reconciliation

- Canonical owner remains `docs/MEMORY_PROTOCOL.md` §5.
- `docs/SOURCES_INDEX_CURRENT.md` now points to that owner instead of duplicating an ordered read-list payload.

## Conflict-order reconciliation

- Canonical owner is `docs/MEMORY_REGISTRY.yml` at `rules.conflict_order`.
- `docs/SOURCES_INDEX_CURRENT.md` now points to that owner instead of duplicating an ordered conflict-list payload.
- `rules.conflict_order` now includes audit and archive layers:
  - `docs/audit/*`
  - `docs/archive/**`

## Registry completeness

`docs/MEMORY_REGISTRY.yml` now includes entries for:

- `docs/CURRENT_STATE.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_PROTOCOL.md`

These are represented in the first-read/context and canonical-truth layers as appropriate.

## Maintenance-trigger summary

- Canonical trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- The old manually decremented docs-drift countdown is deprecated/superseded and must not be re-armed as canonical.
- Historical cleanup evidence should be found by the latest applicable `DOCS_DRIFT_MINI_CLEANUP_*` entry in `docs/AUDIT_INDEX.md`, not by hard-coded stale pass numbers.

## PROJECT_STATE.yml treatment

- `docs/PROJECT_STATE.yml` is explicitly deprecated/deprioritized as non-canonical.
- Live state remains owned by:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
- The file was not deleted and no new state system was introduced.

## Evidence-boundary confirmation

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- No product/evidence semantics changed.
- No V2 implementation started.

## Validation

- `git status --short --branch`: PASS; tracked changes are docs-only and unrelated local untracked paths remain unchanged.
- `git diff --name-only`: PASS; changed tracked files are limited to the allowed docs/governance surfaces.
- `py -3 tools/validate_all.py`: PASS; 236 tests passed.
- duplicate read-order payload check: PASS; `docs/SOURCES_INDEX_CURRENT.md` points to `docs/MEMORY_PROTOCOL.md` §5 instead of carrying an ordered read-order copy.
- duplicate conflict-order payload check: PASS; `docs/SOURCES_INDEX_CURRENT.md` points to `docs/MEMORY_REGISTRY.yml` `rules.conflict_order` instead of carrying an ordered conflict-order copy.
- doc-reference check: PASS; referenced canonical docs and this audit file exist.
- audit-history pruning check: PASS; no audit history was pruned.
- `CURRENT_STATE.md` line-count trigger check: PASS; current length is below the approximately 120-line compaction trigger.

## Post-audit small patch

Addressed `V1_1_MEMORY_SYSTEM_RECONCILIATION_POST_AUDIT_PASS` `NEEDS_SMALL_PATCH` findings:

- Restored data-contract precedence in `docs/MEMORY_REGISTRY.yml` `rules.conflict_order` so `schemas/*.json` and `docs/DATA_MODEL.md` rank above routing/handoff docs including `docs/ACTIVE_SCOPE_LOCK.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- Kept `docs/MEMORY_REGISTRY.yml` as the canonical conflict-order owner and kept `docs/SOURCES_INDEX_CURRENT.md` as a pointer instead of duplicating the ordered payload.
- Clarified that `docs/MEMORY_MAINTENANCE.md` is the single canonical owner for the `CURRENT_STATE.md` line-count compaction rule.
- Reworded `docs/PASS_QUEUE.md` and `docs/CURRENT_STATE.md` to point to the canonical maintenance owner instead of presenting the trigger as canonical there.
## Next recommended pass

`V1_1_MEMORY_SYSTEM_RECONCILIATION_POST_AUDIT_PASS`
