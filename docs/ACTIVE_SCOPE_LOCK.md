# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Goal

Perform mandatory docs-only mini-cleanup after docs drift reached zero.

## Allowed surfaces

- docs/**
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/SOURCES_INDEX_CURRENT.md
- docs/MEMORY_REGISTRY.yml
- docs/PROJECT_STATE.yml
- docs/MODEL_ROUTING.md
- docs/MEMORY_MAINTENANCE.md
- docs/PROMPTING_PROTOCOL.md
- docs/PROTECTED_SURFACES.md
- docs/PROJECT_MEMORY.md
- docs/audit/

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
