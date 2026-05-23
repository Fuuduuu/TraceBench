# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_ZIP_REPORT_HARDENING_PASS`

## Goal

Implement combined Project ZIP + customer report hardening scope.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- tools/export_project_zip.py
- tools/import_project_zip.py
- tools/validate_project_zip.py
- tests/test_project_zip.py
- docs/audit/PROJECT_ZIP_REPORT_HARDENING_AUDIT_PASS.md
- docs/audit/PROJECT_ZIP_REPORT_SCOPE_LOCK_PASS.md
- docs/audit/PROJECT_ZIP_REPORT_HARDENING_PASS.md

## Forbidden surfaces

- schemas/**
- tools/** (except listed allowed files)
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
- project ZIP contract expansion
- project behavior changes
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
- visual_trace → measured/electrical net
- schema/tool/materializer semantic changes

## Verify

- py -3 tools\validate_all.py
