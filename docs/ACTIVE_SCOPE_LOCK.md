# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROMPT_MEMORY_SYSTEM_FULL_AUDIT_FIXUP_PASS`

## Goal

Close out full prompt/memory governance system audit and fix stale ledger pointers.

## Allowed surfaces

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/PROMPT_MEMORY_SYSTEM_FULL_AUDIT_PASS.md
- docs/audit/PROMPT_MEMORY_SYSTEM_FULL_AUDIT_FIXUP_PASS.md

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
