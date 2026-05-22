# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_GRAPH_PROJECTION_SPEC_PASS`

## Goal

Document BoardGraphProjection architecture, layer taxonomy, filters, focus mode, renderer guidance, ZIP/cache boundaries, and future pass sequence for the board graph view.

## Allowed surfaces

- docs/BOARD_GRAPH_SPEC.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/BOARD_GRAPH_PROJECTION_SPEC_PASS.md

## Forbidden surfaces

- schemas
- tools
- tests
- samples
- Flutter implementation
- Python validator/materializer implementation
- photo file workflows
- AI/fault probability logic
- source search
- cloud sync / BLE workflows
- event-writing implementation

## Verify

Verify:

- py -3 tools\validate_all.py
- flutter test --timeout=30s --reporter expanded (only for existing Flutter pass validation, no graph-view code in this pass)
