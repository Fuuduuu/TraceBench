# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_ZIP_EXPORT_FZ02_FIXUP_PASS`

## Goal

Fix FZ-02 user-facing export failure messaging for FLUTTER_ZIP_EXPORT scope, and route to polish review.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_09_PASS.md
- docs/audit/FLUTTER_ZIP_EXPORT_FZ02_FIXUP_PASS.md

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
