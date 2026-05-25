# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_10_PASS`

## Goal

Lock V1 scope for implementing Flutter New Project Wizard (blank project bootstrap) before any wizard implementation begins.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/FLUTTER_NEW_PROJECT_WIZARD_SPEC.md
- docs/audit/TOOLS_EMPTY_PROJECT_SUPPORT_PASS.md
- docs/audit/FLUTTER_NEW_PROJECT_WIZARD_SCOPE_LOCK_PASS.md
- docs/audit/USER_DECISION_NEXT_FEATURE_PASS.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_10_PASS.md

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
- additional Project ZIP tooling files outside existing accepted tooling contracts
- Dart-native known_facts materializer
- mobile export implementation
- ZIP contract expansion
- bundling Python runtime/packaging changes
- new project wizard UI implementation
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

1. V1 purpose is blank project bootstrap only:
   - create `manifest.json`, empty `events.jsonl`, placeholder `exports/customer_report.md`,
     and required metadata/version files.
2. `project_id` is generated in Dart and immutable by user in V1:
   - `^prj_[a-f0-9]{8}$`
3. Dart must not write evidence facts during wizard creation.
4. Flutter must not assemble or mutate `known_facts.json` directly in V1.
5. New project creation must invoke existing materializer path (`tools/materialize_known_facts.py`) to produce initial
   `known_facts.json` for empty events.
6. `events.jsonl` bootstrap remains empty in V1.
7. `ProjectExporter`, Project ZIP contract, and mobile export boundaries remain as previously locked; no new tool or contract expansion.
8. `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
9. Empty-project tooling support from `TOOLS_EMPTY_PROJECT_SUPPORT_PASS` is accepted and reused.

## Validate

- py -3 tools\validate_all.py
