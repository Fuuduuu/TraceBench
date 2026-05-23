# PASS_QUEUE.md

PASS_QUEUE is the allowlist and status log. Every work item needs a PASS_ID before changes.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID matches allowed lane.
3. PASS_ID does not violate ACTIVE_SCOPE_LOCK.
4. If sensitive, run audit-only precheck first.

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_02_PASS`

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
| BOARD_GRAPH_PROJECTION_SPEC_PASS | DOCS_SYNC | completed | Document BoardGraphProjection projection architecture, filters, focus-mode query, and renderer scope boundaries. |
| BOARD_GRAPH_MATERIALIZER_PASS | TOOLS_PASS | completed | Add component update/patched materialization, optional component_pin_index output, and graph invariant warnings. |
| BOARD_GRAPH_MATERIALIZER_DOCS_LEDGER_FIXUP_PASS | DOCS_SYNC | completed | Reconcile ACTIVE_SCOPE_LOCK and audit file lists after BOARD_GRAPH_MATERIALIZER_PASS. |
| FLUTTER_GRAPH_VIEW_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock future read-only Flutter board graph view scope before implementation. |
| FLUTTER_GRAPH_VIEW_PASS | FLUTTER_PASS | completed | Add read-only Flutter board graph route, projector/layout, and projection tests. |
| FLUTTER_GRAPH_VIEW_VALIDATION_FIXUP_PASS | FLUTTER_PASS | completed | Fix formatting, test hangs, and projection index correctness for board graph validation. |
| COMPONENT_EDIT_EVENT_MODEL_PASS | SCHEMA_PASS | completed | Add remove_component repair action semantics and invariants for component removal path. |
| COMPONENT_EDIT_EVENT_MODEL_LEDGER_FIXUP_PASS | DOCS_SYNC | completed | Reconcile component edit event model docs ledger drift and cooldown governance. |
| ACTIVE_SCOPE_LOCK_LEDGER_FIXUP_PASS | DOCS_SYNC | completed | Fix ACTIVE_SCOPE_LOCK docs-ledger-only drift. |
| DOCS_DRIFT_MINI_CLEANUP_02_PASS | DOCS_SYNC | completed | Run docs drift mini cleanup after countdown reached 0. |

## Planned / Recommended

| PASS_ID | Lane | Status |
|---|---|---|
| PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS | DOCS_SYNC | recommended |
| FLUTTER_PHOTO_LIST_SCOPE_AUDIT_PASS | DOCS_SYNC | planned |

## Next recommended pass after this completion

| PASS_ID | Lane | Status |
|---|---|---|
| PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS | DOCS_SYNC | recommended |

## Deferred / not active

- AI integration
- OCR/CV
- fault probability
- source search
- KiCad export
- cloud sync

## Docs drift countdown

Current countdown: 5
