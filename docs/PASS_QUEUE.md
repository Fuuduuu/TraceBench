# PASS_QUEUE.md

PASS_QUEUE is the allowlist and status log. Every work item needs a PASS_ID before changes.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID matches allowed lane.
3. PASS_ID does not violate ACTIVE_SCOPE_LOCK.
4. If sensitive, run audit-only precheck first.

## Current pass

`PROJECTION_STALE_UI_SCOPE_LOCK_PASS`

## Completed pass history

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| USER_DECISION_PASS | DOCS_SYNC / DECISION_ONLY | completed | Projection refresh policy decision selected (POLICY_D export-time refresh). |
| PASS_QUEUE_REVIEW_03_PASS | DOCS_SYNC | completed | Queue-review and routing validation after measurement-write ledger fixup. |
| WORK_INTAKE_SELECTION_PASS | DOCS_SYNC | completed | Review remaining planned/deferred work and route the next safe pass. |
| WORK_INTAKE_REVIEW_PASS | DOCS_SYNC | completed (NEEDS_SMALL_FIXUP) | Work-intake review found no safe implementation-ready candidate; deferred work is blocked and implementation remains pending. |
| WORK_INTAKE_REVIEW_ALIGNMENT_FIXUP_PASS | DOCS_SYNC | completed | Record review audit and align current pass/state/lock for work-intake intake routing. |
| WORK_INTAKE_DEEP_REVIEW_PASS | DOCS_SYNC | completed | Deep work-intake review determined event-writing requires separate scope-lock before implementation. |
| PROJECT_ZIP_REPORT_HARDENING_AUDIT_PASS | DOCS_SYNC | completed | Audit pass accepted; combined ZIP + report hardening scope chosen. |
| PROJECT_ZIP_REPORT_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Scope lock for combined ZIP + customer report hardening. |
| DOCS_DRIFT_MINI_CLEANUP_05_PASS | DOCS_SYNC | completed | Governance-only docs drift cleanup after scope-lock and queue countdown reset. |
| SCOPE_DRIFT_CHECK_PROTOCOL_PASS | DOCS_SYNC | completed | Add canonical scope drift check protocol and wire it into prompt/model/routing gates. |
| PASS_QUEUE_REVIEW_PASS | DOCS_SYNC | completed | Review queue/state consistency and select next valid planned pass. |
| NEXT_PASS_SELECTION_AUDIT_PASS | DOCS_SYNC | completed | Queue review and pass-routing confirmation after queue queue review. |
| NEXT_PASS_SELECTION_AUDIT_FIXUP_PASS | DOCS_SYNC | completed | Close queue/current-state/memory-protocol drift and align countdown/next recommendation. |
| DOCS_DRIFT_MINI_CLEANUP_04_PASS | DOCS_SYNC | completed | Run governance mini cleanup after countdown reached zero and align routing/next-pass target. |
| FLUTTER_PHOTO_LIST_PASS | FLUTTER_PASS | completed | Add read-only photo evidence route and list UI with tests. |
| FLUTTER_PHOTO_LIST_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock read-only photo list/view implementation scope. |
| FLUTTER_PHOTO_LIST_LEDGER_FIXUP_PASS | DOCS_SYNC | completed | Reconcile ledger drift after FLUTTER_PHOTO_LIST_PASS acceptance. |
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
| DOCS_DRIFT_MINI_CLEANUP_02_PASS | DOCS_SYNC | completed | Run docs mini cleanup after countdown reached 0. |
| PHOTO_EVENT_SCHEMA_HARDENING_AUDIT_PASS | DOCS_SYNC | completed | Close out photo-event schema hardening audit and consistency check as docs-ledger-only. |
| PROMPTING_PROTOCOL_COMPRESSION_PASS | DOCS_SYNC | completed | Compress prompting protocol and standardize sniper prompt format. |
| MEMORY_SYSTEM_PROTOCOL_PASS | DOCS_SYNC | completed | Add compact memory ownership protocol and anti-drift rules. |
| PROMPT_MEMORY_GOVERNANCE_RECONCILIATION_PASS | DOCS_SYNC | completed | Reconcile prompt/memory governance drift and index required audit evidence. |
| PROMPT_MEMORY_GOVERNANCE_REVIEW_FIXUP_PASS | DOCS_SYNC | completed | Finalize prompt/memory governance ledger reconciliation and compactness consistency. |
| MEMORY_CONTENT_DEDUP_CLEANUP_PASS | DOCS_SYNC | completed | Remove stale duplicated/misplaced memory/governance text and deduplicate audit/index entries. |
| MEMORY_INTAKE_LIFECYCLE_CLOSEOUT_PASS | DOCS_SYNC | completed | Ensure new information intake lifecycle, active memory map, obsolete handling, and implicit memory rules are present. |
| PROMPT_MEMORY_SYSTEM_FULL_AUDIT_PASS | DOCS_SYNC | completed | Full prompt/memory governance audit (audit-only) reported NEEDS_SMALL_FIXUP: stable architecture found; stale current-pass pointers detected. |
| PROMPT_MEMORY_SYSTEM_FULL_AUDIT_FIXUP_PASS | DOCS_SYNC | completed | Close out full prompt/memory audit and fix stale current-pass pointers in scope lock, queue, and state. |
| DOCS_DRIFT_MINI_CLEANUP_03_PASS | DOCS_SYNC | completed | Narrow governance mini cleanup to reset drift countdown and reconcile active pass pointers. |
| PROJECT_ZIP_REPORT_HARDENING_PASS | TOOLS_PASS | completed | Reject forbidden V1 ZIP artifacts, add report boundary and optional-photo warning hardening coverage. |
| PROJECT_ZIP_REPORT_LEDGER_FIXUP_PASS | DOCS_SYNC | completed | Ledger alignment after hardening pass acceptance; next recommendation updated. |
| PASS_QUEUE_REVIEW_02_PASS | DOCS_SYNC | completed | Queue review confirms no safe implementation candidate; next pass moved to work-intake deep review. |
| FLUTTER_EVENT_WRITE_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock Flutter event-writing architecture, first writable subset, and implementation preconditions. |
| DOCS_DRIFT_MINI_CLEANUP_06_PASS | DOCS_SYNC | completed | Run docs drift mini cleanup after countdown reached zero and align event-write scope-lock routing. |
| FLUTTER_EVENT_WRITE_MEASUREMENT_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock first implementation measurement event write scope: `measurement_recorded` only. |
| FLUTTER_EVENT_WRITE_MEASUREMENT_PASS | FLUTTER_PASS | completed | Implement measurement_recorded-only event append flow and stale projection boundary behavior. |
| FLUTTER_EVENT_WRITE_MEASUREMENT_LEDGER_FIXUP_PASS | DOCS_SYNC | completed | Reconcile ledger state after accepted measurement write pass and refresh next recommendation. |
| PROJECTION_REFRESH_AFTER_EVENT_WRITE_AUDIT_PASS | DOCS_SYNC | completed | Audit that accepted POLICY_D refresh flow after local event writes. |
| PROJECTION_REFRESH_POLICY_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock V1 projection refresh policy: export-time refresh + global stale indicator. |
| DOCS_DRIFT_MINI_CLEANUP_07_PASS | DOCS_SYNC | completed | Docs-only mini cleanup for drift reset and routing/state pointer alignment. |
| PROJECTION_STALE_UI_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock stale projection UI behavior to display-only global warning scope. |

## Planned / Recommended

| PASS_ID | Lane | Status |
|---|---|---|


## Next recommended pass after this completion

| PASS_ID | Lane | Status |
|---|---|---|
| PROJECTION_STALE_UI_PASS | FLUTTER_PASS | recommended |

Select the next planned work item from queue routing:
Route to `PROJECTION_STALE_UI_PASS` for stale projection banner implementation.

## Deferred / not active

- AI integration
- OCR/CV
- fault probability
- source search
- KiCad export
- cloud sync

## Docs drift countdown

Current countdown: 4
