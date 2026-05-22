# ACTIVE_SCOPE_LOCK.md

## Current pass

`PELLE_PV20_SAMPLE_EXPANSION_PASS`

## Goal

Expand Pelle PV20 minimal sample with K2/K3 not_populated and Q2.2/Q2.3 pin_defined events.

## Allowed surfaces

- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- samples/pelle_pv20_minimal/events.jsonl
- samples/pelle_pv20_minimal/known_facts.json
- tests/test_materialize_known_facts.py
- tests/test_validate_events_jsonl.py
- docs/audit/PELLE_PV20_SAMPLE_EXPANSION_PASS.md

## Forbidden surfaces

- apps/**
- mobile/**
- backend/**
- services/ai/**
- services/cv/**
- cloud/**

## Out of scope

- Flutter UI
- OCR/CV
- AI integration
- fault probability
- source search
- KiCad export
- cloud sync

## Verify

Required:
- py -3 tools\\validate_all.py

Optional:
- make doctor
- make validate
- make sample
- make test
