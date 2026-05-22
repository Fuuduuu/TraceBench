# ACTIVE_SCOPE_LOCK.md

## Current pass

`PRE_FLUTTER_VIEWER_DATA_CONTRACT_FIXUP_PASS`

## Goal

Fix pre-Flutter data contract and validation gaps before the read-only Flutter viewer implementation.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/PROJECT_STATE.yml
- docs/PROJECT_ZIP_SPEC.md
- schemas/known_facts.schema.json
- tools/validate_events_jsonl.py
- tools/materialize_known_facts.py
- tools/validate_project_zip.py
- tools/import_project_zip.py
- tools/export_project_zip.py
- samples/pelle_pv20_minimal/known_facts.json
- tests/test_validate_events_jsonl.py
- tests/test_materialize_known_facts.py
- tests/test_project_zip.py
- tests/test_schema_samples.py
- docs/audit/PRE_FLUTTER_VIEWER_DATA_CONTRACT_FIXUP_PASS.md

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
- photo-flow
- KiCad export

## Verify

Required:
- py -3 tools\validate_all.py

Optional:
- make doctor
- make validate
- make sample
- make test
