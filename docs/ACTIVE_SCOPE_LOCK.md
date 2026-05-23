# ACTIVE_SCOPE_LOCK.md

## Current pass

`WORK_INTAKE_REVIEW_ALIGNMENT_FIXUP_PASS`

## Goal

Record WORK_INTAKE_REVIEW_PASS result and align current pass/state/scope-lock for work-intake routing.

## Allowed surfaces

- AGENTS.md
- docs/SCOPE_DRIFT_CHECK.md
- docs/PROMPTING_PROTOCOL.md
- docs/MODEL_ROUTING.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/SCOPE_DRIFT_CHECK_PROTOCOL_PASS.md
- docs/CURRENT_STATE.md
- docs/WORK_INTAKE_INDEX.md
- docs/DEFERRED_FEATURES.md
- docs/audit/WORK_INTAKE_REVIEW_PASS.md
- docs/audit/WORK_INTAKE_REVIEW_ALIGNMENT_FIXUP_PASS.md

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
