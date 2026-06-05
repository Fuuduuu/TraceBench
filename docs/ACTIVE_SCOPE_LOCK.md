# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS`

## Goal

Docs-only memory/governance reconciliation after the accepted scope lock. Implement canonical ownership of read order and conflict order, registry completeness, stale cleanup pointer repair, line-count maintenance trigger, and non-canonical `PROJECT_STATE.yml` treatment without changing product/evidence semantics.

## Allowed docs surfaces

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

## Implemented decisions (F1-F6)

- F2 read order: canonical owner is `docs/MEMORY_PROTOCOL.md` §5; `docs/SOURCES_INDEX_CURRENT.md` points there.
- F3 conflict order: canonical owner is `docs/MEMORY_REGISTRY.yml` `rules.conflict_order`; `docs/SOURCES_INDEX_CURRENT.md` points there.
- F5 registry completeness: `docs/CURRENT_STATE.md`, `docs/TRUTH_INDEX.md`, and `docs/MEMORY_PROTOCOL.md` are represented in `docs/MEMORY_REGISTRY.yml`.
- F4 stale pointer: hard-coded `DOCS_DRIFT_MINI_CLEANUP_04_PASS` pointer is replaced with a non-stale `docs/AUDIT_INDEX.md` lookup pattern.
- F1 maintenance trigger: canonical trigger is `CURRENT_STATE.md` line count over approximately 120 lines; the old manual countdown is deprecated/superseded.
- F6 `PROJECT_STATE.yml`: explicitly deprecated/deprioritized as non-canonical; live state remains owned by `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.

## Forbidden surfaces

- No code changes.
- No test changes.
- No tools changes.
- No schemas.
- No materializer changes.
- No samples/assets.
- No generated artifacts.
- No tags/releases.
- No Project ZIP changes.
- No Board Canvas implementation changes.
- No Reference Images implementation changes.
- No product/evidence semantics changes.
- No V2 implementation.
- No commercial/licensing implementation.
- No audit-history pruning.
- No `board_graph.json`.
- No `view_state.json`.

## Hard boundaries preserved

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth; `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net; `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts; photo alignment is not identity/pin/net/measurement/fault proof; damage/suspect are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only and renderer writes nothing.

## Required validation

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools/validate_all.py`
- Verify no duplicate read-order/conflict-order payload remains.
- Verify no broken doc references introduced by this pass.
- Verify audit history was not pruned.

## Next recommended pass

`V1_1_MEMORY_SYSTEM_RECONCILIATION_POST_AUDIT_PASS`
