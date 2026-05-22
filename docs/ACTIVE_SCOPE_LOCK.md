# ACTIVE_SCOPE_LOCK.md

## Current pass

`SPRINT_0_WINDOWS_VALIDATION_DOCS_SYNC_PASS`

## Goal

Align Sprint 0 validation docs and Makefile with Windows-first stdlib baseline.

## Allowed surfaces

- AGENTS.md
- README.md
- Makefile
- pyproject.toml
- .gitignore
- .editorconfig
- .env.example
- docs/**
- schemas/**
- device_profiles/**
- samples/**
- tools/**
- tests/**

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
