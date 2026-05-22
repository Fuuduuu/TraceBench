# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_VIEWER_SHELL_FIXUP_PASS`

## Goal

Stabilize Flutter viewer shell after audit findings:

- keep route/widget guard deterministic,
- avoid beginner access to raw event data in Events view,
- keep changes limited to bug-fix recovery.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- lib/app/app.dart
- lib/app/router.dart
- lib/features/events/screens/events_viewer_screen.dart
- lib/features/project/screens/project_overview_screen.dart
- test/widget/events_viewer_screen_test.dart
- test/widget/project_overview_screen_test.dart
- test/widget/measurement_list_screen_test.dart
- test/unit/project_loader_zip_test.dart
- tests/test_asset_sample_sync.py
- docs/audit/FLUTTER_VIEWER_SHELL_PASS.md
- docs/audit/FLUTTER_VIEWER_SHELL_FIXUP_PASS.md

## Forbidden surfaces

- apps/**
- backend/**
- cloud/**
- services/ai/**
- services/cv/**
- OCR/CV
- AI API calls
- fault probability
- source search
- BLE multimeter
- event writing from UI
- real ZIP export implementation
- new project wizard
- measurement wizard
- local-folder workflow as first-class path
- schemas/**
- tools/**
- samples/**
- assets/**
- pubspec.yaml / pubspec.lock changes in this recovery pass
- Python tests in `tests/**` (except added sync test)

## Verify

Required:
- flutter test --timeout=30s --reporter expanded
- py -3 tools\validate_all.py

Optional:
- flutter --version
- make doctor
- make validate
- make sample
- make test
