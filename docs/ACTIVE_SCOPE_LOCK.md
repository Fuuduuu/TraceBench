# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_GRAPH_VIEW_SCOPE_LOCK_PASS`

## Goal

Lock the future read-only Flutter board graph view scope before implementation.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/FLUTTER_UI_SPEC.md
- docs/audit/FLUTTER_GRAPH_VIEW_SCOPE_LOCK_PASS.md

Do not broaden beyond these files in this pass.

## Forbidden surfaces

- `lib/**`
- `test/**`
- `pubspec.yaml`
- `pubspec.lock`
- `tools/**`
- `schemas/**`
- `samples/**`
- `assets/**`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/Project ZIP files
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE multimeter
- cloud sync
- visual_trace → electrical net promotion
- layout coordinates as canonical truth
- event semantics or evidence-floor policy changes
- Project ZIP contract changes

## Verify

- py -3 tools\validate_all.py
