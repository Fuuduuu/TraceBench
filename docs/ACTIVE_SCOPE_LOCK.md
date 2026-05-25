# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_NEW_PROJECT_WIZARD_PASS`

## Goal

Implement V1 Flutter New Project Wizard for blank local project bootstrap with Python-owned known-facts materialization.

## Allowed surfaces

- lib/shared/services/python_runner.dart
- lib/shared/services/project_creator.dart
- lib/shared/services/project_exporter.dart
- lib/features/project/screens/new_project_wizard_screen.dart
- lib/features/project/screens/home_screen.dart
- lib/app/router.dart
- test/unit/python_runner_test.dart
- test/unit/project_creator_test.dart
- test/widget/new_project_wizard_screen_test.dart
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/CURRENT_STATE.md
- docs/AUDIT_INDEX.md
- docs/audit/FLUTTER_NEW_PROJECT_WIZARD_PASS.md

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
- additional Project ZIP tooling files outside existing accepted tooling contracts
- Dart-native known_facts materializer
- mobile export implementation
- ZIP contract expansion
- bundling Python runtime/packaging changes
- project_created event introduction
- component_created / pin_defined / measurement_recorded / net / photo / repair_action creation from wizard bootstrap
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

1. Wizard creates only project-level bootstrap files/folders and no evidence events.
2. `project_id` is generated in Dart as `^prj_[a-f0-9]{8}$` and is not user-editable.
3. `events.jsonl` stays empty after creation; no `project_created` event is written.
4. `known_facts.json` is generated only via Python materializer call.
5. successful wizard state must keep `isProjectionStale == false`.
6. mobile behavior stays placeholder in V1.
7. Project ZIP contract remains unchanged; no `board_graph.json` / `view_state.json`.

## Validate

- py -3 tools\validate_all.py
