# ACTIVE_SCOPE_LOCK.md

## Current pass

`FLUTTER_EVENT_WRITE_MEASUREMENT_LEDGER_FIXUP_PASS`

## Goal

Fix docs-ledger drift after accepted `FLUTTER_EVENT_WRITE_MEASUREMENT_PASS` and align
current-state/queue/ledger artifacts.

## Allowed surfaces

docs/CURRENT_STATE.md
docs/PASS_QUEUE.md
docs/ACTIVE_SCOPE_LOCK.md
docs/AUDIT_INDEX.md
docs/audit/FLUTTER_EVENT_WRITE_MEASUREMENT_PASS.md
docs/audit/FLUTTER_EVENT_WRITE_MEASUREMENT_LEDGER_FIXUP_PASS.md

## Forbidden surfaces

- schemas/**
- tools/**
- samples/**
- assets/**
- pubspec.yaml
- pubspec.lock
- events.jsonl
- known_facts.json
- board_graph.json
- view_state.json
- Project ZIP tooling/files
- project behavior unrelated to measurement write ledgers
- component editing UI
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview
- BLE/cloud
- visual_trace → measured/electrical net
- photo-derived identity/measurement/net/fault facts
- component_created/pin_defined/photo_added/damage_region_marked/suspect_region_marked/visual_trace_added/net_connection_confirmed/repair_action_recorded writing
- event-writing beyond measurement_recorded
- FLUTTER event UI behavior not in scope

## Validate

- py -3 tools\validate_all.py
