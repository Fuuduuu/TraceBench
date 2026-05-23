# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_PHOTO_LIST_PASS`

## Goal

Implement read-only Flutter photo evidence list/view for V1.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- lib/app/router.dart
- lib/features/project/screens/project_overview_screen.dart
- lib/features/photos/**
- lib/shared/models/known_facts.dart (only if a minimal parse gap appears)
- test/unit/known_facts_parsing_test.dart
- test/widget/project_overview_screen_test.dart
- test/widget/photo_list_screen_test.dart
- test/integration/photo_list_end_to_end_test.dart
- docs/audit/FLUTTER_PHOTO_LIST_PASS.md

## Forbidden surfaces

- schemas/**
- tools/**
- samples/**
- assets/**
- lib/shared/models/known_facts.dart (no behavior/schema changes)
- pubspec.yaml
- pubspec.lock
- Project ZIP tooling/files
- any events.jsonl
- any known_facts.json
- board_graph.json
- view_state.json
- product behavior changes
- event-writing implementation
- component editing UI
- photo import / file picker
- annotation editing
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- photo-derived identity/measurement/net/fault facts
- visual_trace -> measured/electrical net promotion
- schema/tool/materializer behavior changes
- Project ZIP contract changes

## Verify

- py -3 tools\validate_all.py
