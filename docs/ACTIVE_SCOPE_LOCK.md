# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_03_PASS`

## Goal

Run docs drift mini cleanup after countdown reached 0 and align governance current-pass pointers.

## Allowed surfaces

- AGENTS.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/PROJECT_MEMORY.md
- docs/MEMORY_PROTOCOL.md
- docs/TRUTH_INDEX.md
- docs/PROMPTING_PROTOCOL.md
- docs/PROTECTED_SURFACES.md
- docs/audit/DOCS_DRIFT_MINI_CLEANUP_03_PASS.md

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
