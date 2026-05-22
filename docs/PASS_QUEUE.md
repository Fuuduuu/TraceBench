# PASS_QUEUE.md

PASS_QUEUE is the allowlist and status log. Every work item needs a PASS_ID before changes.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID matches allowed lane.
3. PASS_ID does not violate ACTIVE_SCOPE_LOCK.
4. If sensitive, run audit-only precheck first.

## Current pass

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| MODEL_ROUTING_PROTOCOL_PASS | DOCS_SYNC | completed | Define implementation vs deep-review routing and escalation defaults. |
| SPRINT_0_WINDOWS_VALIDATION_DOCS_SYNC_PASS | DOCS_SYNC | completed | Align Sprint 0 validation docs and Makefile with Windows-first stdlib baseline. |
| SPRINT_0_PROJECT_SKELETON_PASS | DOCS_SYNC / SCHEMA_PASS / TOOLS_PASS | completed | Create repo skeleton, docs, schemas, validators, sample. |

## Planned after Sprint 0

| PASS_ID | Lane | Status |
|---|---|---|
| EVENTS_SCHEMA_HARDENING_PASS | SCHEMA_PASS | planned |
| PELLE_PV20_SAMPLE_EXPANSION_PASS | SAMPLE_PASS | planned |
| PROJECT_ZIP_SKELETON_PASS | TOOLS_PASS | planned |
| FLUTTER_UI_SCOPE_LOCK_PASS | DOCS_SYNC | future |

## Deferred / not active

- AI integration
- OCR/CV
- fault probability
- source search
- KiCad export
- cloud sync

## Docs drift countdown

Current countdown: 2

