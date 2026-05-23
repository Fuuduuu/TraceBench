# ACTIVE_SCOPE_LOCK.md

## Current pass

`MEMORY_INTAKE_LIFECYCLE_CLOSEOUT_PASS`

## Goal

Ensure the new information intake lifecycle, active memory map, obsolete handling, and implicit memory rules are present before future Claude audit.

## Allowed surfaces

- AGENTS.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/MEMORY_PROTOCOL.md
- docs/TRUTH_INDEX.md
- docs/AUDIT_INDEX.md
- docs/audit/MEMORY_INTAKE_LIFECYCLE_CLOSEOUT_PASS.md

## Forbidden surfaces

- schemas/**
- tools/**
- tests/**
- samples/**
- assets/**
- lib/**
- test/**
- pubspec.yaml
- pubspec.lock
- docs/PROTECTED_SURFACES.md
- docs/PROJECT_MEMORY.md
- Project ZIP tooling/files
- any events.jsonl
- any known_facts.json
- board_graph.json
- view_state.json
- product behavior changes
- Flutter/Dart code changes
- schema/tool/materializer/validator semantic changes
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- cloud sync

## Verify

- py -3 tools\validate_all.py
