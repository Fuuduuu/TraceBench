# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_GRAPH_MATERIALIZER_PASS`

## Goal

Extend known_facts materialization for deterministic graph projection inputs and invariants.

## Allowed surfaces

- tools/materialize_known_facts.py
- schemas/known_facts.schema.json
- samples/pelle_pv20_minimal/known_facts.json
- assets/samples/pelle_pv20_minimal/known_facts.json
- tests/test_graph_projection.py
- tests/test_materialize_known_facts.py
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/BOARD_GRAPH_MATERIALIZER_PASS.md

Do not broaden beyond these files in this pass.

## Forbidden surfaces

- `schemas/events.schema.json`
- `samples/pelle_pv20_minimal/events.jsonl`
- `tools/validate_events_jsonl.py`
- `tools/validate_project_zip.py`
- `tools/export_project_zip.py`
- `tools/import_project_zip.py`
- `lib/**` and Flutter implementation
- `test/**` and Dart tests
- `pubspec.yaml` and `pubspec.lock`
- `board_graph.json` or `view_state.json` generation
- Project ZIP tooling or contract changes
- event-writing implementation
- visual_trace → electrical net promotion
- layout coordinates as canonical truth
- AI diagnostics/fault probability
- source search
- camera/OCR/CV
- BLE/cloud/KiCad/boardview workflows

## Verify

- py -3 tools\validate_all.py
