# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_GRAPH_MATERIALIZER_PASS`

## Goal

Extend known_facts materialization for deterministic graph projection inputs and invariants.

## Allowed surfaces

- docs/BOARD_GRAPH_SPEC.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/BOARD_GRAPH_MATERIALIZER_PASS.md

## Forbidden surfaces

- schemas
- samples
- Flutter implementation
- Python event/schema changes
- Project ZIP tooling
- Dart tests (`test/**`) and Flutter tooling
- board_graph.json / view_state.json generation
- camera/OCR/CV
- AI/fault probability
- source search
- event-writing implementation

## Verify

- py -3 tools\validate_all.py
