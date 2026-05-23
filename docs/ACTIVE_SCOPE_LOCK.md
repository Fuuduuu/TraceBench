# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_02_PASS`

## Goal

Run docs drift mini cleanup after countdown reached zero.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/PROJECT_MEMORY.md
- docs/PROTECTED_SURFACES.md
- docs/MODEL_ROUTING.md
- docs/BOARD_GRAPH_SPEC.md
- docs/PROJECT_ZIP_SPEC.md
- docs/FLUTTER_UI_SPEC.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_02_PASS.md

## Forbidden surfaces

- schemas/**
- tools/**
- tests/**
- samples/**
- assets/**
- lib/**
- test/**
- pubspec.yaml
- pubspec.lock
- Project ZIP tooling/files
- any events.jsonl
- any known_facts.json
- board_graph.json
- view_state.json
- event-writing implementation
- component editing UI
- Flutter/Dart code changes
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE multimeter
- cloud sync
- visual_trace → measured electrical net
- layout coordinates as canonical truth
- schema connected-net invalidation behavior changes
- event envelope semantic changes

## Verify

- py -3 tools\validate_all.py
- flutter test --reporter expanded
