# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS`

## Goal

Close out photo-event schema hardening audit as docs-only validation and governance ledger sync.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS.md

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
- docs/PROJECT_MEMORY.md
- docs/PROTECTED_SURFACES.md
- docs/PHOTO_FLOW_SPEC.md
- docs/BOARD_GRAPH_SPEC.md
- docs/PROJECT_ZIP_SPEC.md
- docs/FLUTTER_UI_SPEC.md
- Project ZIP tooling/files
- any events.jsonl
- any known_facts.json
- board_graph.json
- view_state.json
- schema/validator/materializer behavior changes
- Flutter/Dart code changes
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE multimeter
- cloud sync
- visual_trace → measured electrical net
- photo-derived component identity/measurement/net facts

## Verify

- py -3 tools\validate_all.py
