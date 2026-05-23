# ACTIVE_SCOPE_LOCK.md

## Current pass

`MEMORY_SYSTEM_PROTOCOL_PASS`

## Goal

Tighten memory ownership and anti-drift rules so future prompts can load stable context compactly.

## Allowed surfaces

- AGENTS.md
- docs/CURRENT_STATE.md
- docs/MEMORY_PROTOCOL.md
- docs/PROJECT_MEMORY.md
- docs/TRUTH_INDEX.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/MEMORY_SYSTEM_PROTOCOL_PASS.md

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
- schema/validator/materializer behavior changes
- Flutter/Dart code changes
- event-writing implementation
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE multimeter
- cloud sync
- visual_trace → measured electrical net
- photo-derived component identity/measurement/net facts

## Verify

- py -3 tools\validate_all.py
