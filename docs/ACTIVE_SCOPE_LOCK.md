# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Goal

Mandatory docs-only cleanup after docs drift countdown reached zero.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/SOURCES_INDEX_CURRENT.md
- docs/MEMORY_REGISTRY.yml
- docs/PROJECT_STATE.yml
- docs/PROJECT_ZIP_SPEC.md
- docs/FLUTTER_UI_SPEC.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_PASS.md

## Forbidden surfaces

- apps/**
- mobile/**
- lib/**
- pubspec.yaml
- Flutter/Dart implementation
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
- measurement wizard
- new project wizard
- local-folder workflow as first-class
- schemas/**
- tools/**
- samples/**
- tests/**

## Verify

Required:
- py -3 tools\validate_all.py

Optional:
- make doctor
- make validate
- make sample
- make test
