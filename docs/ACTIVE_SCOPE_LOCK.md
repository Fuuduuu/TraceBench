# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECTION_STALE_UI_LEDGER_FIXUP_PASS`

## Goal

Display-only stale projection warning behavior for derived views.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/PROJECTION_STALE_UI_PASS.md
- docs/audit/PROJECTION_STALE_UI_LEDGER_FIXUP_PASS.md

## Forbidden surfaces

- schemas/**
- tools/**
- samples/**
- assets/**
- pubspec.yaml
- pubspec.lock
- events.jsonl
- known_facts.json
- board_graph.json
- view_state.json
- Project ZIP tooling/files
- project behavior unrelated to stale projection banner display
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- visual_trace → measured/electrical net
- photo-derived identity/measurement/net/fault facts
- component_created/pin_defined/photo_added/damage_region_marked/suspect_region_marked/visual_trace_added/net_connection_confirmed/repair_action_recorded writing
- Dart-native known_facts materializer
- mobile export implementation
- ZIP contract expansion
- bundled Python/materializer implementation changes

## Validate

- py -3 tools\validate_all.py
- flutter test --reporter expanded
- dart format <changed Dart/test files>
