# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_MEMORY_SYSTEM_RECONCILIATION_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for reconciling TraceBench memory/governance meta-docs after the memory-consolidation audit. Lock canonical ownership of read-order and conflict-order, registry completeness, the stale-cleanup pointer fix, the maintenance-trigger repair, and the `PROJECT_STATE.yml` treatment — without touching code, evidence semantics, or product boundaries.

## Accepted input

- The memory-consolidation audit (audit-only) found a link-clean but meta-drifted memory system (findings F1–F6).
- `V1_1_CURRENT_STATE_COMPACTION_PASS` is accepted/pushed (CURRENT_STATE 205 → 86 lines; no history pruned). The previously-queued `V1_1_POST_CURRENT_STATE_COMPACTION_ROUTE_REVIEW_PASS` is superseded by the memory audit.

## Allowed docs surfaces (this pass)

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_MEMORY_SYSTEM_RECONCILIATION_SCOPE_LOCK_PASS.md`

## Locked implementation surfaces (next pass `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS`)

- `docs/MEMORY_PROTOCOL.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/MEMORY_MAINTENANCE.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/PROJECT_STATE.yml` (F6 deprecation annotation / optional regeneration only)
- `docs/CURRENT_STATE.md` (small pointer / current-pass / countdown-label update only)
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS.md`

## Locked decisions (F1–F6)

- F2 read order: canonical owner `MEMORY_PROTOCOL.md §5`; `SOURCES_INDEX_CURRENT.md` becomes a pointer (no duplicate payload).
- F3 conflict order: canonical owner `MEMORY_REGISTRY.yml conflict_order`; `SOURCES_INDEX_CURRENT.md` becomes a pointer (no duplicate payload).
- F5 registry completeness: add `CURRENT_STATE.md`, `TRUTH_INDEX.md`, `MEMORY_PROTOCOL.md` to `MEMORY_REGISTRY.yml` (CURRENT_STATE mandatory as first-read file).
- F4 stale pointer: replace hard-coded `DOCS_DRIFT_MINI_CLEANUP_04_PASS` with a non-stale pointer ("latest `DOCS_DRIFT_MINI_CLEANUP_NN` in `AUDIT_INDEX.md`").
- **F1 maintenance trigger: LOCKED = Option B (line-count trigger).** Compact `CURRENT_STATE.md` when it exceeds ~120 lines, verifiable at every route review/closeout via `wc -l`. Redefine the legacy "Docs drift countdown" as deprecated/superseded; do not reintroduce a manually-decremented counter as the canonical mechanism.
- **F6 `PROJECT_STATE.yml`: LOCKED = explicitly deprecate/deprioritize** (docs-only header annotation; live state lives in CURRENT_STATE + PASS_QUEUE). Optional one-time regeneration via existing `tools/validate_project_state.py` only if the tool is not modified. No new state system; no deletion.

## Preserved core governance

- `CURRENT_STATE.md` live handoff; `PASS_QUEUE.md` route queue; `ACTIVE_SCOPE_LOCK.md` current scope; `AUDIT_INDEX.md` ledger; `docs/audit/**` append-only evidence (no pruning). `PROJECT_MEMORY.md` / `TRUTH_INDEX.md` / `PROTECTED_SURFACES.md` ownership unchanged.

## Forbidden surfaces (next pass)

- No code/test/tool/schema/materializer/sample/asset/generated-artifact/tag/release changes.
- No audit-history pruning; no broad docs rewrite; no product/evidence-semantics or hard-boundary meaning changes.
- No `board_graph.json` / `view_state.json`; no V2 / commercial / licensing work.

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
- `py -3 tools\validate_all.py`

## Next recommended pass

`V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS`
