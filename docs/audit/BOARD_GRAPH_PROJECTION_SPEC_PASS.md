# BOARD_GRAPH_PROJECTION_SPEC_PASS

Status: completed  
Lane: DOCS_SYNC

## Scope and decisions

- Documented `BoardGraphProjection` as in-memory projection from `known_facts.json`.
- Documented that `board_graph.json` is not stored in Project ZIP.
- Documented V1 auto-layout based graph renderer strategy.
- Documented projection node/edge model, layer taxonomy, filters, and focus-mode query semantics.
- Documented adjacency index design and cache-boundary rules.

## Files changed

- `docs/BOARD_GRAPH_SPEC.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`

## Key constraints captured

- No schema/tool/Python changes in this pass.
- No Dart/Flutter implementation changes in this pass.
- Renderer remains read-only and does not create/modify facts.
- Visual trace remains annotation/evidence-only and never promotes to measured electrical graph.

## Next pass recommendation

- `BOARD_GRAPH_MATERIALIZER_PASS` (TOOLS_PASS) — projection helpers/indexing support where needed.

## Validation

- `py -3 tools\validate_all.py`
