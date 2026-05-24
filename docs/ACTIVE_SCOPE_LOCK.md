# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_EVENT_WRITE_MEASUREMENT_PASS`

## Goal

Implement `FLUTTER_EVENT_WRITE_MEASUREMENT_PASS` with narrow `measurement_recorded`-only
write scope.

## Allowed surfaces

docs/CURRENT_STATE.md
docs/PASS_QUEUE.md
docs/ACTIVE_SCOPE_LOCK.md
docs/AUDIT_INDEX.md
docs/FLUTTER_EVENT_WRITE_SPEC.md
docs/FLUTTER_UI_SPEC.md
docs/audit/FLUTTER_EVENT_WRITE_SCOPE_LOCK_PASS.md
docs/audit/FLUTTER_EVENT_WRITE_MEASUREMENT_SCOPE_LOCK_PASS.md
lib/app/router.dart
lib/features/measurements/**
lib/features/project/screens/project_overview_screen.dart
lib/shared/event_write/**
lib/shared/models/**
test/unit/**
test/widget/**
test/integration/**
docs/audit/FLUTTER_EVENT_WRITE_MEASUREMENT_PASS.md

## Forbidden surfaces

- schemas/**
- tools/**
- samples/**
- assets/**
- events.jsonl
- known_facts.json
- board_graph.json
- view_state.json
- Project ZIP tooling/files
- project behavior unrelated to measurement write
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- visual_trace → measured/electrical net
- photo-derived identity/measurement/net/fault facts
- component_created/pin_defined/photo_added/suspect_region_marked/damage_region_marked visual_trace_added/net_connection_confirmed/repair_action_recorded writing
- event-writing beyond measurement_recorded
- FLUTTER_PHOTO_LIST_PASS scope or later UI behaviors

## Validate

- py -3 tools\validate_all.py
- C:\Users\Kasutaja\Desktop\flutter\flutter\bin\dart.bat format <changed Dart files>
- C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded
