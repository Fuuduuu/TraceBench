# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_UI_SCOPE_LOCK_PASS`

## Goal

Document Flutter UI architecture and read-only Project ZIP viewer scope.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/FLUTTER_UI_SPEC.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/FLUTTER_UI_SCOPE_LOCK_PASS.md

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

## Additional constraints

- no Flutter implementation in this pass
- no event write-path introduction in this pass
- no local-folder workflow as primary UI path in this pass

## Verify

Required:
- py -3 tools\\validate_all.py

Optional:
- make doctor
- make validate
- make sample
- make test
