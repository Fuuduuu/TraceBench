# ACTIVE_SCOPE_LOCK.md

## Current pass

`ACTIVE_SCOPE_LOCK_LEDGER_FIXUP_PASS`

## Goal

Fix ACTIVE_SCOPE_LOCK docs-ledger drift after COMPONENT_EDIT_EVENT_MODEL_LEDGER_FIXUP_PASS.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/ACTIVE_SCOPE_LOCK_LEDGER_FIXUP_PASS.md

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
- event-writing implementation
- component editing UI
- Flutter/Dart code changes
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE multimeter
- cloud sync
- schema connected-net invalidation behavior changes
- event envelope semantic changes

## Verify

- py -3 tools\validate_all.py
- flutter test --reporter expanded
