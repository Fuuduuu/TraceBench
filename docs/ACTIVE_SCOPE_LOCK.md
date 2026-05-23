# ACTIVE_SCOPE_LOCK.md

## Current pass

`MEMORY_CONTENT_DEDUP_CLEANUP_PASS`

## Goal

Deduplicate and compactify memory governance docs after protocol cleanup, without changing product behavior.

## Allowed surfaces

- AGENTS.md
- docs/PROJECT_MEMORY.md
- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/PROMPTING_PROTOCOL.md
- docs/audit/MEMORY_CONTENT_DEDUP_CLEANUP_PASS.md

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
