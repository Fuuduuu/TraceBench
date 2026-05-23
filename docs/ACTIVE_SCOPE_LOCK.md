# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_04_PASS`

## Goal

Run docs drift mini cleanup and reconcile queue/current-state/memory routing drift.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/MEMORY_PROTOCOL.md
- docs/audit/NEXT_PASS_SELECTION_AUDIT_PASS.md
- docs/audit/NEXT_PASS_SELECTION_AUDIT_FIXUP_PASS.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_04_PASS.md
- docs/WORK_INTAKE_INDEX.md
- docs/DEFERRED_FEATURES.md
- docs/PROJECT_MEMORY.md
- docs/TRUTH_INDEX.md
- docs/PROMPTING_PROTOCOL.md
- docs/PROTECTED_SURFACES.md

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
- events.jsonl
- known_facts.json
- board_graph.json
- view_state.json
- Project ZIP tooling/files
- product behavior changes
- Flutter/Dart implementation
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- photo import/file picker
- photo-derived identity/measurement/net/fault facts
- visual_trace → measured/electrical net promotion
- schema/tool/materializer changes
- Project ZIP contract changes

## Verify

- py -3 tools\validate_all.py
