# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_ZIP_EXPORT_PASS`

## Goal

Lock safe V1 Flutter ZIP export scope before implementation.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- lib/shared/services/project_exporter.dart
- lib/features/report/screens/customer_report_screen.dart
- docs/PROJECT_ZIP_SPEC.md
- docs/FLUTTER_UI_SPEC.md
- docs/PROJECTION_REFRESH_SPEC.md
- test/unit/project_exporter_test.dart
- test/widget/customer_report_screen_test.dart
- docs/audit/PROJECT_ZIP_SECURITY_HARDENING_PASS.md
- docs/audit/FLUTTER_ZIP_EXPORT_SCOPE_LOCK_PASS.md
- docs/audit/FLUTTER_ZIP_EXPORT_PASS.md

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
- Dart-native known_facts materializer
- mobile export implementation
- ZIP contract expansion
- bundled Python/materializer implementation changes
- Flutter ZIP export implementation
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- visual_trace → electrical/net promotion
- photo-derived identity/measurement/net/fault facts
- additional artifact writes beyond project ZIP contract

## Scope decisions to lock

1. Primary V1 recommendation is Desktop/dev export direction; mobile export remains placeholder.
2. Flutter must not regenerate or mutate `known_facts.json` directly in V1.
3. Flutter must not add Dart-native materializer.
4. Flutter must not write `events.jsonl` beyond accepted `measurement_recorded` flow.
5. `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
6. Security baseline from `PROJECT_ZIP_SECURITY_HARDENING_PASS` remains required:
   - symlinked files are rejected at export time,
   - absolute and traversal photo paths are rejected by validation.

## Validate

- py -3 tools\validate_all.py
