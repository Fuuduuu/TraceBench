# ACTIVE_SCOPE_LOCK.md

## Current pass

`TOOLS_EMPTY_PROJECT_SUPPORT_PASS`

## Goal

Support empty project tooling requirements before starting New Project Wizard implementation.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_09_PASS.md
- docs/audit/FLUTTER_ZIP_EXPORT_FZ02_FIXUP_PASS.md
- docs/audit/FLUTTER_ZIP_EXPORT_POLISH_SCOPE_REVIEW_PASS.md
- docs/audit/USER_DECISION_NEXT_FEATURE_PASS.md
- docs/audit/TOOLS_EMPTY_PROJECT_SUPPORT_PASS.md
- tools/materialize_known_facts.py
- tests/test_materialize_known_facts.py
- tests/test_project_zip.py

## Forbidden surfaces

- schemas/**
- samples/**
- assets/**
- pubspec.yaml
- pubspec.lock
- events.jsonl
- known_facts.json
- board_graph.json
- view_state.json
- Project ZIP tooling/files outside `tools/materialize_known_facts.py`
- Dart-native known_facts materializer
- mobile export implementation
- ZIP contract expansion
- bundling Python runtime/packaging changes
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
- Flutter/UI implementation changes

## Scope decisions to lock

1. Primary V1 recommendation is Desktop/dev export direction; mobile export remains placeholder.
2. Flutter must not regenerate or mutate `known_facts.json` directly in V1.
3. Flutter must not add Dart-native materializer.
4. Flutter must not write `events.jsonl` beyond accepted `measurement_recorded` flow.
5. `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
6. `tools/materialize_known_facts.py` now supports empty `events.jsonl` by producing minimal valid `known_facts.json` to enable blank project workflows.
7. Security baseline from `PROJECT_ZIP_SECURITY_HARDENING_PASS` remains required:
   - symlinked files are rejected at export time,
   - absolute and traversal photo paths are rejected by validation.

## Validate

- py -3 tools\validate_all.py
