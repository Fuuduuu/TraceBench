# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_VIEWER_SHELL_PASS`

## Goal

Implement first read-only Flutter viewer shell for Project ZIP import/viewing.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/AGENTS.md
- lib/**
- test/**
- assets/samples/**
- pubspec.yaml
- analysis_options.yaml
- .gitignore
- docs/audit/FLUTTER_VIEWER_SHELL_PASS.md
- flutter platform dirs `android/**`, `ios/**` only if Flutter toolchain is available and `flutter create` succeeds

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
- measurement wizard
- new project wizard
- local-folder workflow as first-class
- schemas/**
- tools/**
- samples/**
- Python tests in `tests/**`
- existing sample files under `samples/**`
- real ZIP export implementation

## Verify

Required:
- py -3 tools\validate_all.py

Optional (if toolchain available):
- flutter --version
- flutter test

Optional:
- make doctor
- make validate
- make sample
- make test
