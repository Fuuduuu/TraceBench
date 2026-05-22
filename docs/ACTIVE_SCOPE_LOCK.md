# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_GRAPH_VIEW_PASS`

## Goal

Implement the read-only Flutter board graph view derived from in-memory `known_facts.json` projection.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/FLUTTER_GRAPH_VIEW_PASS.md
- lib/app/router.dart
- lib/features/project/screens/project_overview_screen.dart
- lib/shared/models/known_facts.dart
- lib/features/board_graph/**
- test/unit/known_facts_parsing_test.dart
- test/unit/board_graph_projection_test.dart
- test/widget/project_overview_screen_test.dart
- test/widget/board_graph_screen_test.dart
- test/integration/board_graph_end_to_end_test.dart
- test/integration/pelle_sample_end_to_end_test.dart

## Forbidden surfaces

- `tools/**`
- `schemas/**`
- `samples/**`
- `assets/**`
- `pubspec.yaml`
- `pubspec.lock`
- any Project ZIP tooling/files
- any `events.jsonl`
- any `known_facts.json`
- `board_graph.json`
- `view_state.json`
- event-writing implementation
- component editing UI
- visual_trace → electrical net promotion
- layout coordinates as canonical truth
- event semantics or evidence-floor policy changes
- Project ZIP contract changes
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview workflows
- BLE multimeter
- cloud sync

## Verify

- py -3 tools\validate_all.py
