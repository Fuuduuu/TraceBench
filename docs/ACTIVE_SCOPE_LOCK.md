# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_EVENT_WRITE_MEASUREMENT_SCOPE_LOCK_PASS`

## Goal

Lock Flutter event-writing implementation scope for the first write pass to `measurement_recorded` only.

## Allowed surfaces

docs/CURRENT_STATE.md
docs/PASS_QUEUE.md
docs/ACTIVE_SCOPE_LOCK.md
docs/AUDIT_INDEX.md
docs/FLUTTER_EVENT_WRITE_SPEC.md
docs/FLUTTER_UI_SPEC.md
docs/audit/FLUTTER_EVENT_WRITE_SCOPE_LOCK_PASS.md
docs/audit/FLUTTER_EVENT_WRITE_MEASUREMENT_SCOPE_LOCK_PASS.md

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
- schema/tool/materializer semantic changes
- Flutter/Dart implementation
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- visual_trace → measured/electrical net
- photo-derived identity/measurement/net/fault facts

## Verify

- py -3 tools\validate_all.py
