# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Goal

Finalize docs-only index/lock alignment after docs drift reached zero, before the next docs-driven schema-hardening planning pass.

## Allowed surfaces

- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_PASS.md
- docs/SOURCES_INDEX_CURRENT.md
- docs/MEMORY_REGISTRY.yml
- docs/PROJECT_STATE.yml

## Forbidden surfaces

- schemas/**
- tools/**
- tests/**
- samples/**
- lib/**
- assets/**
- pubspec.yaml
- flutter/ mobile/native platform dirs
- backend/**
- cloud/**
- services/**
- camera/OCR/CV
- AI/fault probability
- source search
- cloud/BLE
- event-writing implementation
- photo file handling implementation
- visual trace overlay implementation
- photo capture implementation
- existing sample file edits
- schema changes
- tooling changes
- test changes
- Flutter implementation
- runtime changes
- product direction changes
- feature expansion outside docs housekeeping

## Verify

Required:
- py -3 tools\validate_all.py

Optional:
- make doctor
- make validate
- make sample
- make test
