# PASS_QUEUE.md

PASS_QUEUE is the allowlist and status log. Every work item needs a PASS_ID before changes.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID matches allowed lane.
3. PASS_ID does not violate ACTIVE_SCOPE_LOCK.
4. If sensitive, run audit-only precheck first.

## Current pass

`PHOTO_EVENT_SCHEMA_HARDENING_PASS`

## Completed pass history

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| SPRINT_0_PROJECT_SKELETON_PASS | DOCS_SYNC / SCHEMA_PASS / TOOLS_PASS | completed | Create repo skeleton, docs, schemas, validators, sample. |
| EVENTS_SCHEMA_HARDENING_PASS | SCHEMA_PASS | completed | Add payload-specific schema defs, validator hardening, sample hardening, and materialization output evolution. |
| EVENTS_SCHEMA_HARDENING_FIXUP_PASS | SCHEMA_PASS | completed | Fix schema/sample drift and enforce V1 connected-net invalidation policy. |
| MODEL_ROUTING_PROTOCOL_PASS | DOCS_SYNC | completed | Define implementation vs deep-review routing and escalation defaults. |
| SPRINT_0_WINDOWS_VALIDATION_DOCS_SYNC_PASS | DOCS_SYNC | completed | Align Sprint 0 validation docs and Makefile with Windows-first stdlib baseline. |
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | completed | Realign documentation indexes and lock files after docs drift reached zero and required cleanup pass completed. |
| PELLE_PV20_SAMPLE_EXPANSION_PASS | SAMPLE_PASS | completed | Expand Pelle PV20 minimal sample with K2/K3 not_populated and Q2 pin_defined events. |
| PROJECT_ZIP_SKELETON_PASS | TOOLS_PASS | completed | Add minimal Project ZIP export/import/validation tooling and sample project ZIP files. |
| FLUTTER_UI_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Document Flutter UI read-only viewer scope and platform/contracts for future implementation. |
| PRE_FLUTTER_VIEWER_DATA_CONTRACT_FIXUP_PASS | TOOLS_PASS | completed | Harden event/schema/tooling validations for pre-Flutter viewer contract and Project ZIP safety/consistency. |
| REPAIR_ACTION_SAMPLE_TARGET_FIXUP_PASS | DOCS_SYNC | completed | Normalize repair action sample target to component/Q2 for replace_component didactic clarity. |
| FLUTTER_VIEWER_SHELL_PASS | FLUTTER_PASS | completed | Add first read-only Flutter Project ZIP viewer shell with bundled sample and import flow. |
| FLUTTER_VIEWER_SHELL_FIXUP_PASS | FLUTTER_PASS | completed | Fix GoRouter rebuild, beginner events access guard, and title/sample sync validation gaps. |
| PHOTO_FLOW_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock photo-flow event scope, boundaries, and schema-hardening sequence in docs. |
| PHOTO_EVENT_SCHEMA_HARDENING_PASS | SCHEMA_PASS | completed | Add photo flow schema defs, validator rules, materialization output, sample events, and photo-focused tests. |

## Planned / Recommended

| PASS_ID | Lane | Status |
|---|---|---|
| PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS | DOCS_SYNC | planned |
| FLUTTER_PHOTO_LIST_SCOPE_AUDIT_PASS | DOCS_SYNC | planned |

## Next recommended pass after this completion

| PASS_ID | Lane | Status |
|---|---|---|
| PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS | DOCS_SYNC | recommended |
| FLUTTER_VIEWER_SHELL_AUDIT_PASS | DOCS_SYNC | planned |

## Deferred / not active

- AI integration
- OCR/CV
- fault probability
- source search
- KiCad export
- cloud sync

## Docs drift countdown

Current countdown: 4
