# TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS

PASS_ID: TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS
Lane: DOCS_SYNC
Mode: Docs-only scope lock. Do not create diagrams yet.

## Goal

Lock the next documentation diagrams that will reduce governance prompt/protocol bloat while keeping boundaries and sequencing from the repo docs.

## Decision record

- GPT Pro / governance-audit recommendation recorded:
  - low-staleness Mermaid diagrams are useful for recurring boundaries and routing.
- This pass is docs-only and implementation-free.
- No diagrams were created in this pass.

## Locked diagram set for next implementation pass

1. Pass lifecycle diagram
2. Evidence-boundary diagram
3. Tool/model routing diagram

## Locked implementation pass

- Next implementation pass: `TRACEBENCH_GOVERNANCE_DIAGRAMS_PASS`

## Diagram file-location lock

- `docs/PASS_LIFECYCLE.md` for the pass lifecycle diagram
- `docs/ARCHITECTURE_BOUNDARIES.md` for the evidence-boundary diagram
- `docs/MODEL_ROUTING.md` for tool/model routing (embed section or section anchor)

## Allowed files for this scope-lock pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS.md`
- optional only if strictly needed: `docs/SOURCES_INDEX_CURRENT.md`

## Forbidden content confirmed

- no current pass-chain as a live diagram state ledger
- no stale or timeline-first diagram strategy for V1→V1.1→V2
- no diagram statements implying:
  - AI produces canonical facts
  - reference images enter canonical pipelines (`events.jsonl`, `known_facts.json`, materializer, Board Canvas/evidence claims)
  - `board_graph.json` or `view_state.json` acceptance
  - transform/photo-overlay/background-photo-helper is now permitted
- no unscoped architecture growth or implementation rewriting

## Boundary lock and routing

- evidence boundaries remain unchanged
- `TraceBench_Project_Source_Guide.md` remains source-orientation only, not a live pass ledger
- `board_graph.json` and `view_state.json` remain forbidden

## Validation performed

- `py -3 tools\validate_all.py` executed in previous summary pass and remains required baseline for this docs-only lock

## Recommended next pass

- `TRACEBENCH_GOVERNANCE_DIAGRAMS_PASS`
