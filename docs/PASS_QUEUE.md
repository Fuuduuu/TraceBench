# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS`

## Next recommended pass

`CURRENT_STATE_HISTORY_TRIM_PASS`

## Current-state maintenance trigger pointer

Canonical owner: docs/MEMORY_MAINTENANCE.md. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | accepted/pushed as `dbe9271` (`docs: lock tracebench docs hygiene scope`) | Docs-only scope lock for targeted docs/governance hygiene cleanup after Pro docs-hygiene findings; no runtime changes; locks future narrow pass order and canonical owner routing (`TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` → `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS` → `TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS` → `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` → `CURRENT_STATE_HISTORY_TRIM_PASS` → `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`); user smoke evidence from `Kontrollisin, hetkel sobivad` is recorded as accepted behavior confirmation (no separate smoke pass). |
| TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `7c12aa7` (`docs: normalize audit index route bookkeeping`) | Docs-only pass for `docs/AUDIT_INDEX.md` semantics and route-bookkeeping normalization; docs-hygiene follow-up is `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS`. |
| TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `c70e23f` (`docs: archive completed pass-queue history`) | Docs-only docs-hygiene cleanup pass that archived completed `PASS_QUEUE` history and kept operational routing and sequencing focused. |
| TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `b60ae0c` (`docs: centralize core invariants owner in TRUTH_INDEX`) | Docs-only docs-hygiene pass that centralized core invariant ownership in `docs/TRUTH_INDEX.md` and reduced duplicate invariant blocks in operational docs. |
| TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS | CODEX / DOCS_HYGIENE | drafted / pending independent audit | Current docs-only refresh of `docs/MODEL_ROUTING.md` ownership and prompting role-reference guidance after queue archive and core invariant hygiene. |
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | CODEX / DOCS_PROTECTED_SCOPE_LOCK | future protected route | Docs-only protected scope-lock for inline measurement-entry panel; crosses from read-only UI into write-flow territory. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS | CODEX / FLUTTER_WRITE_FLOW_IMPLEMENTATION | future high-risk implementation | Inline value/unit/Save in right panel using accepted writer path only; requires strict audit and no renderer writes. |
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS | CODEX / FLUTTER_NAV_POLISH | future route | Route/navigation consolidation; keep `/project/measure-sheet` fallback/redirect and do not casually delete the standalone measure sheet route. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later | Optional theme scope only; do not mix with layout or write-flow work. |
| CURRENT_STATE_HISTORY_TRIM_PASS | DOCS_HYGIENE / ROUTE_REVIEW | planned | Planned trim of `docs/CURRENT_STATE.md` operational history once docs-hygiene owner refresh passes are done. |
| TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS | DOCS_HYGIENE / WORKFLOW | planned | Planned workbench architecture diagram/documentation refresh pass to align with the compacted pass queue and current runtime baseline. |
| V2_WORKBENCH_INTEGRATED_PANEL_SMOKE_PASS | CODEX / DOCS_MANUAL_QA_RECORD | future QA route | Manual Windows smoke after integrated panel/navigation work. |
