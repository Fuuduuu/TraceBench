# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_PHOTO_LIST_SCOPE_LOCK_PASS`

## Goal

Lock read-only Flutter photo list/view implementation scope.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/FLUTTER_UI_SPEC.md
- docs/audit/FLUTTER_PHOTO_LIST_SCOPE_LOCK_PASS.md

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
- product behavior changes
- Flutter/Dart implementation
- schema/tool/materializer behavior changes
- event-writing implementation
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- photo-derived identity/measurement/net/fault facts
- visual_trace -> measured/electrical net promotion
- cloud sync

## Verify

- py -3 tools\validate_all.py
