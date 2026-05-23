# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROMPT_MEMORY_GOVERNANCE_REVIEW_FIXUP_PASS`

## Goal

Close remaining prompt/memory governance ledger drift after `PROMPT_MEMORY_GOVERNANCE_RECONCILIATION_PASS`.

## Allowed surfaces

- AGENTS.md
- docs/CURRENT_STATE.md
- docs/PROMPTING_PROTOCOL.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/PROMPT_MEMORY_GOVERNANCE_REVIEW_FIXUP_PASS.md

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
- schema/tool/materializer/validator semantic changes

## Verify

- py -3 tools\validate_all.py
