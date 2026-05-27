# PASS_QUEUE.md

PASS_QUEUE is the allowlist and status log. Every work item needs a PASS_ID before changes.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID matches allowed lane.
3. PASS_ID does not violate ACTIVE_SCOPE_LOCK.
4. If sensitive, run audit-only precheck first.

## Current pass

`VALIDATOR_REFERENCE_STATUS_NORMALIZATION_PASS`

## Completed pass history

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| VALIDATOR_REFERENCE_STATUS_NORMALIZATION_PASS | SCHEMA_PASS / VALIDATOR_FIX | completed | Normalize validator reference provenance to accepted-source semantics for component/photo/measurement/pin domain references while preserving audit-metadata reference behavior and placement visual boundary. |
| GLOBAL_EVENT_STATUS_SEMANTICS_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock global event.status policy and split sequencing after audit: accepted-only domain facts/reference direction, validator normalization first, materializer policy second, regression/fixture follow-up only if impact requires. |
| BOARD_PLACEMENT_REFERENCE_STATUS_FIX_PASS | SCHEMA_PASS / VALIDATOR_FIX | completed | Restrict placement provenance reference indexes to prior accepted `component_created` / `photo_added` for `component_visual_placement_confirmed`; add validator tests for rejected/draft create-events and non-creator component events. |
| BOARD_PLACEMENT_REFERENCE_STATUS_FIX_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock narrow validator-only follow-up so placement references must resolve only to prior accepted `component_created` / `photo_added`; defer broader status semantics to separate audit. |
| DOCS_DRIFT_MINI_CLEANUP_11_PASS | DOCS_SYNC | completed | Align CURRENT_STATE/PASS_QUEUE/ACTIVE_SCOPE_LOCK/AUDIT_INDEX/PROJECT_MEMORY/TRUTH_INDEX and board/placement docs after accepted placement schema+validator+projection work; preserve evidence boundaries and set conservative next routing. |
| BOARD_PLACEMENT_EVENT_PROJECTION_PASS | TOOLS_PASS / SCHEMA_PASS | completed | Add `component_visual_placements` known-facts schema + materializer projection for accepted human-confirmed placement events; keep projection visual-only with no electrical/net/measurement/fault side effects; add projection + ZIP mismatch tests. |
| BOARD_PLACEMENT_EVENT_SCHEMA_VALIDATOR_PASS | SCHEMA_PASS | completed | Add `component_visual_placement_confirmed` schema + validator support with strict user-only actor rule, coordinate/sizing constraints, reference checks, and side-effect-field rejection; no projection/materializer changes. |
| BOARD_PLACEMENT_EVENT_SCHEMA_SPLIT_ROUTING_PASS | DOCS_SYNC | completed | Record Pro verdict READY_WITH_IMPLEMENTATION_SPLIT and split broad placement schema work into validator-first pass then projection/materializer follow-up pass. |
| BOARD_PLACEMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock schema/validator/materializer direction for `component_visual_placement_confirmed`, including coordinate constraints, AI/system actor rejection expectations, and visual-only projection boundary. |
| BOARD_PLACEMENT_EVENT_MODEL_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock future placement canonical-event direction (`component_visual_placement_confirmed`), coordinate-space boundaries, and validation expectations without schema/tool/runtime changes. |
| BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_DESIGN_DOC_FIXUP_PASS | DOCS_SYNC | completed | Applied Pro-audit small doc fixups: helper-only photo boundary, coordinate-space clarification, package-only template naming cleanup, and explicit future confirmation-state split pointer. |
| BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_DESIGN_PASS | DOCS_SYNC / DESIGN_ONLY | completed | Formalized vector boardview + footprint library design with strict `unconfirmed_ai_proposal` boundary and evidence-safe export defaults. |
| PROJECTION_STALE_UI_CODE_AUDIT_PASS | AUDIT_ONLY | completed | Code review accepted with nits; layout/content-flow issue deferred to small fixup. |
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
| PROJECTION_STALE_UI_DESIGN_REVIEW | DOCS_SYNC | completed | Lock stale projection banner UX pattern before implementation. |
| PROJECTION_STALE_UI_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock stale projection UI behavior to display-only global warning scope. |
| PROJECTION_STALE_UI_PASS | FLUTTER_PASS | completed | Implement display-only stale projection banner on derived screens. |
| PROJECTION_STALE_UI_LEDGER_FIXUP_PASS | DOCS_SYNC | completed | Reconcile docs-ledger drift after stale UI acceptance. |
| PASS_QUEUE_REVIEW_04_DIRECTED_SELECTION_PASS | DOCS_SYNC | completed | Route stale UI completion directly toward export-refresh/ZIP export scope lock. |
| DOCS_DRIFT_MINI_CLEANUP_08_PASS | DOCS_SYNC | completed | Docs mini cleanup to record code-audit guidance and route to stale UI small fixup. |
| PROJECTION_STALE_UI_SMALL_FIXUP_PASS | FLUTTER_PASS | completed | Fixed AUI-01 content-flow placement for stale banner on board graph and customer report. |
| PROJECT_ZIP_SECURITY_HARDENING_PASS | TOOLS_PASS | completed | Harden ZIP export and validation for symlink/photo-path security without contract changes. |
| FLUTTER_ZIP_EXPORT_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock safe V1 Flutter ZIP export scope and implementation boundaries before implementation. |
| FLUTTER_ZIP_EXPORT_PASS | FLUTTER_PASS | completed | Implement desktop Project ZIP export handoff through ProjectExporter and CustomerReportScreen trigger. |
| FLUTTER_ZIP_EXPORT_LEDGER_ROUTING_FIXUP_PASS | DOCS_SYNC | completed | Reconcile PASS_QUEUE/CURRENT_STATE routing after FLUTTER_ZIP_EXPORT_PASS completion and route next to FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS. |
| FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS | AUDIT_ONLY | completed | Audit export handoff and boundaries; PASS_WITH_NITS, no required fixup. |
| DOCS_DRIFT_MINI_CLEANUP_09_PASS | DOCS_SYNC | completed | Record FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS PASS_WITH_NITS result and route next pass conservatively. |
| FLUTTER_ZIP_EXPORT_FZ02_FIXUP_PASS | FLUTTER_PASS | completed | Sanitize export failure messages while keeping raw diagnostic detail internal to ProjectExporter. |
| FLUTTER_ZIP_EXPORT_POLISH_SCOPE_REVIEW_PASS | DOCS_SYNC | completed | Formally close polish review by marking FZ-01 as V1 accepted risk and routing to user decision. |
| USER_DECISION_NEXT_FEATURE_PASS | DOCS_SYNC | completed | Select next milestone as `FLUTTER_NEW_PROJECT_WIZARD_SCOPE_AUDIT_PASS` after export handoff stabilization. |
| PROJECT_STATE_RELOAD_AFTER_EXPORT_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock implementation direction: refresh in-memory `ProjectState` only after successful desktop/dev export, nothing else. |
| PROJECT_STATE_RELOAD_AFTER_EXPORT_PASS | FLUTTER_PASS | completed | Reload in-memory `ProjectState` from local project directory on `ExportSuccess` only, without changing export tooling ownership boundaries. |
| MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_SCOPE_AUDIT_PASS | AUDIT_ONLY | completed | Audit confirmed duplicate `measurement_recorded` risk is UI-submit timing/state issue, not event-writer/schema/materializer issue. |
| MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock narrow UI-only guard scope for preventing duplicate save from rapid repeated taps. |
| MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_PASS | FLUTTER_PASS | completed | Add UI-only duplicate submit guard in Measurement Record screen using in-flight re-entry guard + last successful normalized form key block. |
| TOOLS_EMPTY_PROJECT_SUPPORT_PASS | TOOLS_PASS | completed | Support empty/new projects in materialization and export/validate/import tests; unblock new-project wizard scope lock. |
| FLUTTER_NEW_PROJECT_WIZARD_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock V1 New Project Wizard scope for blank-project creation and local-only project bootstrap. |
| DOCS_DRIFT_MINI_CLEANUP_10_PASS | DOCS_SYNC | completed | Docs drift cleanup after wizard scope-lock and routing cleanup before implementation. |
| FLUTTER_NEW_PROJECT_WIZARD_PASS | FLUTTER_PASS | completed | Implement V1 New Project Wizard with Python-materialized known facts and no evidence event creation. |

## Planned / Recommended

| PASS_ID | Lane | Status |
|---|---|---|
| MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS | TOOLS_PASS | recommended |


## Next recommended pass after this completion

| PASS_ID | Lane | Status |
|---|---|---|
| MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS | TOOLS_PASS | recommended |

`VALIDATOR_REFERENCE_STATUS_NORMALIZATION_PASS` is completed and aligns validator domain reference provenance with accepted-source policy while preserving audit-metadata reference behavior.
Next recommended pass is `MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS` to align materializer projection side effects with the same accepted-only policy direction.

## Deferred / not active

- AI integration
- OCR/CV
- fault probability
- source search
- KiCad export
- cloud sync

## Docs drift countdown

Current countdown: 5
