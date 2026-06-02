# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Goal

Fix stale governance source-index drift after the accepted diagrams closeout:

- replace embedded “current pass/closeout” duplication in `docs/SOURCES_INDEX_CURRENT.md`
- realign pass-routing and scope-lock docs after `TRACEBENCH_GOVERNANCE_DIAGRAMS_CLOSEOUT_PASS`
- preserve evidence-boundary and compactness guarantees
- route next to `V1_1_POST_GOVERNANCE_CLEANUP_NEXT_ROUTE_REVIEW_PASS`

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PASS_LIFECYCLE.md`
- `docs/ARCHITECTURE_BOUNDARIES.md`
- `docs/MODEL_ROUTING.md`
- `docs/audit/TRACEBENCH_GOVERNANCE_DIAGRAMS_SCOPE_LOCK_PASS.md`
- `docs/audit/TRACEBENCH_GOVERNANCE_DIAGRAMS_PASS.md`
- `docs/audit/TRACEBENCH_GOVERNANCE_DIAGRAMS_CLOSEOUT_PASS.md`

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

- docs-only cleanup scope:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/DOCS_DRIFT_MINI_CLEANUP_PASS.md`
  - `docs/SOURCES_INDEX_CURRENT.md`
  - existing governance diagrams (`docs/PASS_LIFECYCLE.md`, `docs/ARCHITECTURE_BOUNDARIES.md`, `docs/MODEL_ROUTING.md`) only as compact pointers

- Forbidden:
  - `schemas/**`, `tools/**`, `lib/**`, `test/**`, `assets/**`
  - `board_graph.json`
  - `view_state.json`
  - `events.jsonl`
  - `known_facts.json`
  - Project ZIP contract expansion
  - implementation behavior changes in this pass

## Next recommended pass

`V1_1_POST_GOVERNANCE_CLEANUP_NEXT_ROUTE_REVIEW_PASS`

## Closeout validations

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Validation commands for next pass

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
