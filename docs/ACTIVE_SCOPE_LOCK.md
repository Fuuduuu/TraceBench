# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_FLOW_SCOPE_LOCK_PASS`

## Goal

Document photo-flow event scope, payload rules, evidence boundaries, Project ZIP implications, and next-pass schema hardening plan before any implementation.

## Allowed surfaces

- docs/PHOTO_FLOW_SPEC.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/PHOTO_FLOW_SCOPE_LOCK_PASS.md

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

## Verify

Required:
- py -3 tools\validate_all.py

Optional:
- make doctor
- make validate
- make sample
- make test
