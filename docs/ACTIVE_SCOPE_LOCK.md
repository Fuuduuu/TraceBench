# ACTIVE_SCOPE_LOCK.md

## Current pass

`TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS`

## Goal

Lock the low-staleness governance diagram plan before any Mermaid artifacts are created.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `tools/**`
- `schemas/**`
- `lib/**`
- `test/**`
- `assets/**`
- `board_graph.json`
- `view_state.json`
- `events.jsonl`
- `known_facts.json`
- materializer/schema/tool expansion
- project surface re-implementation in this pass
- prompt-chain or roadmap as primary first-class diagram content
- diagrams implying AI creates canonical facts
- diagrams implying reference images belong in `events.jsonl`, `known_facts.json`, materializer, Board Canvas evidence, or Project ZIP
- implementation of diagrams outside governance docs

## Scope boundary (lock)

- This is a docs-only scope lock.
- Next implementation pass: `TRACEBENCH_GOVERNANCE_DIAGRAMS_PASS`.
- Locked diagram set for next pass:
  - pass lifecycle
  - evidence-boundary
  - tool/model routing
- Preferred implementation locations:
  - `docs/PASS_LIFECYCLE.md` (new)
  - `docs/ARCHITECTURE_BOUNDARIES.md` (new)
  - `docs/MODEL_ROUTING.md` (small Mermaid section or reference anchor)
- `TraceBench_Project_Source_Guide.md` remains a source-orientation companion document, not a live pass ledger.
- Evidence policy remains unchanged:
  - AI does not set canonical facts.
  - `events.jsonl` remains canonical.
  - `known_facts.json` remains materialized projection only.
  - UI/renderer remains read-only.
  - `board_graph.json` and `view_state.json` remain forbidden.
- Forbidden diagram content for this pass:
  - stale pass chain as governance truth
  - V1/V1.1/V2 timeline as the first diagram shape
  - transform/alignment/photo-overlay/board-canvas reference-image workflow in this initial diagram batch.

## Next recommended pass

`TRACEBENCH_GOVERNANCE_DIAGRAMS_PASS`

## Closeout validations

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Validation commands for next pass

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
