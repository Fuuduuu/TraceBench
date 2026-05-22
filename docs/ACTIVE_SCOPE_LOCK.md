# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_ZIP_SKELETON_PASS`

## Goal

Implement minimal Project ZIP export/import/validation tools.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PROJECT_ZIP_SPEC.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/PROJECT_ZIP_SKELETON_PASS.md
- tools/export_project_zip.py
- tools/import_project_zip.py
- tools/validate_project_zip.py
- tools/validate_all.py
- tests/test_project_zip.py
- samples/pelle_pv20_minimal/manifest.json
- samples/pelle_pv20_minimal/exports/customer_report.md
- samples/pelle_pv20_minimal/metadata/schema_versions.json

## Forbidden surfaces

- apps/**
- mobile/**
- backend/**
- services/ai/**
- services/cv/**
- cloud/**

## Out of scope

- Flutter UI
- OCR/CV
- AI integration
- fault probability
- source search
- KiCad export
- cloud sync

## Verify

Required:
- py -3 tools\\validate_all.py

Optional:
- make doctor
- make validate
- make sample
- make test
