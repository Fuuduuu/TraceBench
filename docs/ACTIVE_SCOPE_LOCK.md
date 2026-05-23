# ACTIVE_SCOPE_LOCK.md

## Current pass

`SCOPE_DRIFT_CHECK_PROTOCOL_PASS`

## Goal

Add and formalize canonical scope drift check protocol for governance and implementation gating.

## Allowed surfaces

- AGENTS.md
- docs/SCOPE_DRIFT_CHECK.md
- docs/PROMPTING_PROTOCOL.md
- docs/MODEL_ROUTING.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/SCOPE_DRIFT_CHECK_PROTOCOL_PASS.md

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
- events.jsonl
- known_facts.json
- board_graph.json
- view_state.json
- Project ZIP tooling/files
- product behavior changes
- Flutter/Dart implementation
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- photo import/file picker
- photo-derived identity/measurement/net/fault facts
- visual_trace → measured/electrical net promotion
- schema/tool/materializer changes
- Project ZIP contract changes

## Verify

- py -3 tools\validate_all.py
