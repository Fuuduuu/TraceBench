# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_ZIP_REPORT_SCOPE_LOCK_PASS`

## Goal

Lock combined Project ZIP + customer report hardening scope before implementation.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/PROJECT_ZIP_SPEC.md
- docs/audit/PROJECT_ZIP_REPORT_HARDENING_AUDIT_PASS.md
- docs/audit/PROJECT_ZIP_REPORT_SCOPE_LOCK_PASS.md

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
- Project ZIP tooling/files
- board_graph.json
- view_state.json
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
- visual_trace → measured/electrical net
- schema/tool/materializer changes
- Project ZIP contract changes

## Verify

- py -3 tools\validate_all.py
