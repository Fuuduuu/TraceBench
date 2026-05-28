# PASS_QUEUE.md

PASS_QUEUE is the allowlist and status log. Every work item needs a PASS_ID before changes.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID matches allowed lane.
3. PASS_ID does not violate ACTIVE_SCOPE_LOCK.
4. If sensitive, run audit-only precheck first.

## Current pass

`PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS`

## Completed pass history

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS | SCHEMA_PASS / VALIDATOR_FIX | completed | Implement narrow schema + validator support for canonical `photo_to_board_alignment_confirmed`: schema enum/mapping/strict payload contract, validator actor/source-photo/coordinate/point/transform/forbidden-field checks, new valid schema sample, and validator regression tests; materializer/known_facts/UI/ZIP remain deferred. |
| PHOTO_ALIGNMENT_EVENT_SCHEMA_PRECHECK_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Precheck audit from user/context approved proceeding directly to schema implementation with boundary-preserving nits. |
| PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock future photo-alignment event-schema direction without implementation: canonical family direction is `photo_to_board_alignment_confirmed`, placeholders remain deferred/unsafe for writers, payload/actor/coordinate/transform boundary rules are locked, and next routing is risk-first precheck audit. |
| PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock photo-alignment data-model direction after `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS` (`NEEDS_SCOPE_FIRST`): placeholders remain unsafe for writer usage, canonical-vs-volatile policy is fixed, candidate canonical event direction is documented, and implementation is deferred behind schema/validator/materializer/model scope locks. |
| BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS | AUDIT_ONLY | completed (`NEEDS_SCOPE_FIRST`) | Audit confirms alignment infrastructure remains placeholder-only and requires scope-first sequencing before any schema/validator/materializer/model/runtime implementation. |
| BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out dual visual-trace inspector audits (`PASS_WITH_NITS` + `PASS_WITH_NITS`), accept read-only metadata-only implementation, record non-blocking guard-test nits, fix ACTIVE_SCOPE_LOCK stale pointer, and route next to photo-evidence alignment scope audit (not geometry implementation). |
| BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_AUDIT_PASS | AUDIT_ONLY | completed (PASS_WITH_NITS) | Audit confirms visual-trace summary stayed metadata-only with strict association and no geometry/net/write-path drift; non-blocking nits recorded. |
| BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS | FLUTTER_PASS | completed | Add read-only visual_trace metadata summary to board-canvas inspector/list using strict selected-component association rules only; preserve metadata-only/no-geometry/no-net-inference boundaries and keep all no-write constraints. |
| BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock future board-canvas visual_trace support to read-only inspector/list metadata only; forbid visual-trace canvas geometry rendering, photo-alignment implementation, background photo helper, and net/connectivity inference from visual evidence; route next to `BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS`. |
| BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_AUDIT_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out Pro + Claude photo-evidence alignment audits: record high-risk alignment boundary and absent infra, set final decision `DEFER_PHOTO_ALIGNMENT_IMPLEMENTATION`, keep visual evidence overlays deferred, and route next to visual-trace inspector scope lock (metadata-only direction). |
| BOARD_CANVAS_MEASUREMENT_SUMMARY_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out dual measurement-summary audits (`PASS_WITH_NITS` + `PASS_WITH_NITS`), accept read-only metadata implementation, record non-blocking test/guard nits, and route next conservatively toward photo-evidence alignment scope audit. |
| BOARD_CANVAS_MEASUREMENT_SUMMARY_AUDIT_PASS | AUDIT_ONLY | completed (PASS_WITH_NITS) | Audit confirms measurement summary stayed read-only metadata only with strict association rule and no overlay/inference/write-path drift; non-blocking nits recorded. |
| BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS | FLUTTER_PASS | completed | Add read-only board-canvas measurement summary metadata in inspector/list area only, with strict component association (`componentId` exact / `componentId.` prefix), verbatim value display, stale labeling, and no-overlay/no-inference/no-write boundaries. |
| BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock future board-canvas measurements to read-only inspector/list metadata only; forbid measurement canvas overlays, coordinate/anchor inference, and net/proximity inference; preserve no-write boundaries; route next to `BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS`. |
| BOARD_CANVAS_READONLY_RENDERER_QA_PASS | FLUTTER_PASS / QA_PASS | completed | Harden accepted read-only board-canvas renderer: deterministic `shouldRepaint` logical-input comparison, preserve typed template sizing path (no template map serialization), strengthen placement size/fallback/read-only/evidence-deferral guard tests, and preserve no-write boundaries. |
| BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_AUDIT_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out Codex+Claude visual/evidence scope audits with shared verdict `DEFER_VISUAL_EVIDENCE`: no safe board-canvas evidence overlay path yet; measurements remain metadata-only candidate; photo-local evidence requires dedicated alignment audit; route next to renderer QA. |
| BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS | AUDIT_ONLY | completed (DEFER_VISUAL_EVIDENCE) | Audit confirms visual_trace/damage/suspect/measurement overlays are not safe on board canvas yet due coordinate/model gaps and evidence-boundary risk; defer implementation. |
| BOARD_CANVAS_READONLY_INSPECTOR_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out inspector audit after `PASS_WITH_NITS`: confirm read-only scope compliance, preserve no-write/no-AI/no-edit boundaries, record non-blocking Windows temp-file lock flake classification, and route next to visual-trace/evidence scope audit. |
| BOARD_CANVAS_READONLY_INSPECTOR_AUDIT_PASS | AUDIT_ONLY | completed (PASS_WITH_NITS) | Audit confirms inspector stayed strictly read-only and within locked scope; no blocker, no code fix required before next scope audit. |
| BOARD_CANVAS_READONLY_INSPECTOR_PASS | FLUTTER_PASS | completed | Implement read-only board canvas inspector/details panel with non-canvas selection control, local volatile selection state, identity-safety warning copy, and strict no-write/no-AI/no-edit boundaries. |
| BOARD_CANVAS_READONLY_INSPECTOR_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock next implementation scope to a read-only inspector/details panel for existing board-canvas placements/components only, with non-canvas selection first, strict no-write/no-AI/no-edit boundaries, and no schema/tool/registry/projection changes. |
| DOCS_DRIFT_MINI_CLEANUP_13_PASS | DOCS_SYNC | completed | Docs/governance cleanup after full codebase audit and accepted board-canvas placement rendering: refresh stale scope-lock pointer, align queue/state routing, clean audit-index ambiguity, preserve evidence boundaries, and route next to inspector scope-lock (not direct implementation). |
| CODEBASE_CLEANUP_AND_EFFICIENCY_AUDIT_PASS | AUDIT_ONLY | completed (PASS_WITH_NITS) | Full codebase audit found no blocker, all validation suites passed, read-only/evidence boundaries held, and non-blocking cleanup candidates were recorded for later narrow passes. |
| BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS | FLUTTER_PASS | completed | Implement narrow read-only board canvas placement rendering for `board_normalized` `componentVisualPlacements` using KnownFacts + VectorFootprintLibrary metadata, with safe template fallback, preserved shell chrome/empty states, and strict no-write/no-AI/no-inspector boundaries. |
| BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock next renderer implementation scope to read-only component visual placement rendering only: `board_normalized` placements only, `photo_local` deferred, template-safe fallback required, strict no-write/no-AI/no-edit boundaries preserved, and next routing fixed to `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS`. |
| BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS | FLUTTER_PASS | completed | Implement minimal read-only board canvas shell: add route/screen, empty-state-only UI, exact status chrome `renderer writes: none`, and no-edit/no-AI/no-export/no-rendering guard tests. |
| BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_FIXUP_PASS | DOCS_SYNC | completed | Apply Claude `PASS_WITH_NITS` renderer-readiness fixups: lock shell-first implementation, defer CustomPainter/placement/evidence overlays, forbid photo_local board rendering before coordinate mapping audit, and add dedicated read-only renderer spec. |
| BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock V1 board canvas renderer as strict read-only projection consumer after KnownFacts Dart placement parity: no writes, no event/editor/AI flows, no raw known_facts parsing, no background photo helper layer in first renderer, and split implementation routing to shell -> placement rendering -> inspector -> evidence-scope audit -> QA. |
| KNOWN_FACTS_DART_PLACEMENT_PARITY_PASS | FLUTTER_PASS | completed | Add Dart KnownFacts parity for `component_visual_placements` via `ComponentVisualPlacementFact` + `KnownFacts.componentVisualPlacements`, missing-field empty default, toJson parity, and unit tests; add optional component removal parity fields (`installation_status`, `removed_by_event_id`) already emitted by projection; no renderer/schema/tool/materializer changes. |
| KNOWN_FACTS_DART_PLACEMENT_PARITY_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Record Pro verdict `NEEDS_DART_MODEL_PARITY_FIRST`; lock KnownFacts Dart `component_visual_placements` parity as renderer precondition; forbid renderer/raw JSON parsing work; route next to `KNOWN_FACTS_DART_PLACEMENT_PARITY_PASS`. |
| MEASUREMENT_EVENT_ID_COMPAT_FIX_PASS | FLUTTER_PASS / VALIDATOR_COMPAT | completed | Update Dart measurement writer default event-id generation to schema/validator-compatible `^evt_[0-9]{6}$` values using sequence-based IDs; preserve event semantics, keep schema/validator unchanged, and add unit regressions for default/non-`evt_flutter_*` behavior and unique multi-append IDs. |
| MEASUREMENT_EVENT_ID_COMPAT_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock narrow compatibility fix scope for measurement writer event_id mismatch (`evt_flutter_*` vs `^evt_[0-9]{6}$`), with schema/validator format as source of truth and no migration/schema/validator changes allowed in the fix pass. |
| DOCS_DRIFT_MINI_CLEANUP_12_PASS | DOCS_SYNC | completed | Required docs drift cleanup after registry audit closeout: align queue/state/lock/index and stale spec routing; preserve evidence boundaries; route next to renderer scope-lock only. |
| VECTOR_FOOTPRINT_LIBRARY_REGISTRY_AUDIT_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out `VECTOR_FOOTPRINT_LIBRARY_REGISTRY_AUDIT_PASS` from Pro+Claude second-review result with final verdict `PASS_WITH_NITS`; confirm registry skeleton remains metadata/model/const-only and route next by docs-drift policy. |
| VECTOR_FOOTPRINT_LIBRARY_REGISTRY_AUDIT_PASS | AUDIT_ONLY | completed (PASS_WITH_NITS) | Closed by second-review evidence and recorded through `VECTOR_FOOTPRINT_LIBRARY_REGISTRY_AUDIT_CLOSEOUT_PASS`; no additional code/test/schema/tool changes required. |
| VECTOR_FOOTPRINT_LIBRARY_REGISTRY_SKELETON_PASS | FLUTTER_PASS | completed | Implement minimal internal Dart const footprint library skeleton (`lib/shared/footprints/**`) with immutable metadata models, locked V1 template registry, and unit tests; no renderer/UI/schema/tool/ZIP/event-writing changes. |
| VECTOR_FOOTPRINT_LIBRARY_IMPLEMENTATION_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock first implementation boundary after `VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_02_PASS`: choose minimal internal registry-first implementation (`VECTOR_FOOTPRINT_LIBRARY_REGISTRY_SKELETON_PASS`), align unknown fallback V1 list, preserve evidence boundaries, and keep renderer/UI/AI proposal persistence deferred. |
| VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_02_PASS | AUDIT_ONLY | completed (PASS_WITH_NITS) | Re-audit after fixups confirms spec is implementation-ready; remaining nit was high-level unknown fallback list alignment. |
| VECTOR_FOOTPRINT_LIBRARY_SPEC_FIXUP_PASS | DOCS_SYNC | completed | Apply doc hardening from spec audit: identity-leakage guardrails for human-facing fields, explicit unknown fallback templates, locked template-local coordinate convention, tighter field semantics, pin-anchor non-fact boundary, variant relationship constraints, and expanded implementation-readiness tests. |
| VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS | DOCS_SYNC | completed | Add formal parametric vector footprint/template specification (`docs/VECTOR_FOOTPRINT_LIBRARY_SPEC.md`) with required fields, pin-anchor and variant models, locked V1 template set, deferred families, naming guardrails, renderer-consumption boundaries, AI-proposal boundaries, and future test expectations. |
| VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock internal parametric vector footprint/template library scope boundary before renderer/UI implementation; preserve package-vs-identity, AI-proposal, visual/electrical, and ownership boundaries; route next to `VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS`. |
| QUEUE_REVIEW_AFTER_STATUS_SEMANTICS_PASS | DOCS_SYNC / AUDIT_ONLY | completed | Queue/state/lock review after status-semantics closeout; stale routing removed; next safe routing set to `VECTOR_FOOTPRINT_LIBRARY_SCOPE_LOCK_PASS` before renderer/UI implementation. |
| STATUS_SEMANTICS_REGRESSION_CLOSEOUT_PASS | DOCS_SYNC | completed | Record Pro `PASS_WITH_NITS` status-semantics end-to-end audit result and close queued regression work without additional full audit rerun; no code fix required. |
| STATUS_SEMANTICS_REGRESSION_PASS | TOOLS_PASS / QA_PASS | completed | Satisfied by Pro `STATUS_SEMANTICS_END_TO_END_AUDIT_PASS` verdict (`PASS_WITH_NITS`) and closeout reconciliation. |
| MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS | TOOLS_PASS | completed | Materializer now enforces accepted-only domain projection policy and accepted-only project_id fallback semantics without schema/validator/ZIP/runtime changes. |
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
| PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS | DOCS_SYNC | recommended |
| PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS | DOCS_SYNC | later |
| PHOTO_FLOW_SPEC_AUDIT_PASS | AUDIT_ONLY | optional governance-first reconciliation |


## Next recommended pass after this completion

| PASS_ID | Lane | Status |
|---|---|---|
| PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS | DOCS_SYNC | recommended |
| PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS | DOCS_SYNC | later |
| PHOTO_FLOW_SPEC_AUDIT_PASS | AUDIT_ONLY | optional governance-first reconciliation |

`PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS` is completed.
Schema + validator support for canonical alignment event is now implemented.
Next recommended pass is `PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`.

## Recorded future cleanup candidates (not active)

- `KNOWN_FACTS_DART_POLISH_PASS`:
  - `KnownFacts.componentPinIndex` dedup efficiency and `valid_from_event_id` doc-note parity polish.
- `TOOLS_CLEANUP_PASS`:
  - validator fallback-event-type list dedup and materializer `footprint_not_populated` list-dedup efficiency polish.
- `MEASUREMENT_WRITER_POLISH_PASS`:
  - theoretical fallback uniqueness nit hardening in writer last-resort ID loop.

## Deferred / not active

- AI integration
- OCR/CV
- fault probability
- source search
- KiCad export
- cloud sync

## Docs drift countdown

Current countdown: 5

## PASS UPDATE: BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_AUDIT_CLOSEOUT_PASS (completed)
- Lane: `DOCS_SYNC`
- Status: closeout completed with final verdict `DEFER_VISUAL_EVIDENCE`.
- Shared Codex+Claude findings recorded:
  - visual_trace/damage/suspect data are photo-local and unsafe for board-canvas overlay without accepted mapping,
  - measurements have no board/canvas coordinates and are unsafe for geometric overlay.
- Decision:
  - no evidence canvas overlay implementation now,
  - measurements are future read-only metadata candidate only.
- Routing:
  - next recommended pass `BOARD_CANVAS_READONLY_RENDERER_QA_PASS`,
  - defer photo-local evidence rendering until `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS`.

## PASS UPDATE: BOARD_CANVAS_READONLY_RENDERER_QA_PASS (completed)
- Lane: `FLUTTER_PASS / QA_PASS`
- Status: completed.
- QA hardening completed:
  - painter no longer repaints solely because placement entry list identity changes,
  - deterministic logical comparison added for repaint-relevant render inputs,
  - source guard confirms no `template.toMap(...)` sizing path in board-canvas source.
- Test hardening completed:
  - scale-mode and width+height-mode placement rendering path coverage,
  - missing sizing fallback coverage,
  - missing/unknown template fallback rendering coverage,
  - unknown fallback template render safety coverage,
  - deferred-evidence read guards (`visualTraces`/`measurements`/`damageRegions`/`suspectRegions`/`nets` absent from board-canvas source reads).
- Boundaries preserved:
  - no event writing,
  - no canonical fact mutation,
  - no `board_graph.json` / `view_state.json`,
  - no visual/evidence overlay scope expansion.
- Routing:
  - next recommended pass `BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS`.

## PASS UPDATE: BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS (completed)
- Lane: `DOCS_SYNC`
- Status: completed.
- Scope lock decision:
  - measurements are future read-only inspector/list metadata only for board canvas,
  - measurement canvas overlays remain forbidden.
- Strict association rule for future implementation is locked:
  - include measurement only when endpoint is exact `componentId` or starts with `componentId + "."`.
  - loose prefix matching is forbidden (`Q2` must not match `Q20`).
- Explicitly forbidden:
  - coordinate/anchor inference from `from`/`to` strings,
  - proximity/net inference from measurement summaries,
  - measurement-driven net promotion beyond existing known-facts net data.
- Boundaries preserved:
  - no event writes,
  - no known-facts mutation,
  - no `board_graph.json` / `view_state.json`,
  - no Project ZIP contract change.
- Routing:
  - next recommended pass `BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS`.
## Completed (2026-05-28)
- `BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS` (FLUTTER_PASS) — completed.
  - Added read-only measurement summary metadata in board canvas inspector for selected component only.
  - Enforced strict association rules: exact `componentId` or `componentId.<pin>`; no loose prefix match.
  - Preserved no-overlay/no-inference/no-write boundaries.

## Next recommended pass
- `PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS` (DOCS_SYNC)
  - Lock accepted-only projection behavior for alignment events before touching materializer implementation.
- `PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS` (DOCS_SYNC, later)
  - Lock Dart projection model additions only after materializer scope is locked.

## PASS UPDATE: BOARD_CANVAS_MEASUREMENT_SUMMARY_CLOSEOUT_PASS (completed)
- Lane: `DOCS_SYNC`
- Dual audits recorded:
  - Codex `PASS_WITH_NITS`
  - Claude second-review `PASS_WITH_NITS`
- Accepted:
  - read-only measurement summary metadata only
  - strict association rule
  - verbatim measurement value/unit/reading display
  - stale labeling
  - required safe copy
- Confirmed preserved boundaries:
  - no measurement canvas overlay
  - no coordinate/anchor inference
  - no measurement->net inference
  - no event-writing path
  - no known-facts mutation
  - no `board_graph.json` / `view_state.json`
  - no Project ZIP contract change
- Non-blocking nits recorded:
  - source-scan/string guards are useful but brittle under refactor
  - text-only forbidden-action checks may miss icon-only affordances
  - optional future negatives: `AQ2`/`Q2A` endpoint mismatch checks
  - optional future reading-only display-path test (`value == null`)

## PASS UPDATE: BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_AUDIT_CLOSEOUT_PASS (completed)
- Lane: `DOCS_SYNC`
- Final decision: `DEFER_PHOTO_ALIGNMENT_IMPLEMENTATION`.
- Pro audit closeout conclusions recorded:
  - photo-local -> board-normalized alignment remains high-risk,
  - canonical alignment, if ever allowed, must be human-confirmed and event-backed,
  - no hidden UI transform state, AI auto-fit transform, or `view_state.json` may become truth.
- Claude repo-local conclusions recorded:
  - repository is ready for scope/audit decisions,
  - alignment implementation infrastructure is absent (placeholder event names only; no accepted schema/validator/materializer/model/test stack).
- Classification recorded:
  - visual_trace/damage/suspect geometry remain photo-context evidence and deferred from board-canvas geometry rendering,
  - measurement summary remains safely implemented as read-only metadata,
  - board-normalized component placements remain safely implemented.
- Routing:
  - next recommended pass `BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS`.
  - `PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS` was the required next scope-lock after alignment-risk decision and is now completed.

## PASS UPDATE: BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS (completed)
- Lane: `DOCS_SYNC`
- Locked next implementation direction: `BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS`.
- Locked boundaries:
  - `visual_trace` support is inspector/list metadata only,
  - no visual_trace canvas geometry/polylines,
  - no photo-local to board transform/alignment,
  - no background photo helper,
  - no connectivity/net promotion or inference from visual traces.
- Required strict association for future implementation:
  - `fromComponent == componentId`
  - `toComponent == componentId`
  - `fromPin` starts with `componentId + "."`
  - `toPin` starts with `componentId + "."`
- Preserved boundaries:
  - no event writing,
  - no known-facts mutation,
  - no `board_graph.json` / `view_state.json`,
  - no Project ZIP contract change.

## PASS UPDATE: BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS (completed)
- Lane: `FLUTTER_PASS`
- Status: completed.
- Added visual-trace summary as read-only inspector/list metadata only for selected component/placement context.
- Strict association rule implemented:
  - `trace.fromComponent == componentId`
  - `trace.toComponent == componentId`
  - `trace.fromPin` starts with `componentId + "."`
  - `trace.toPin` starts with `componentId + "."`
  - no loose prefix matching (`Q2` does not match `Q20`).
- Required safe copy added:
  - `Visual trace — read-only metadata`
  - `Visual trace is not a confirmed electrical net`
  - `Photo-local evidence; no board coordinate available`
  - `Does not create or confirm connectivity`
- Preserved renderer/evidence boundaries:
  - no visual-trace canvas polyline/geometry,
  - no `from_point` / `to_point` usage,
  - no photo-alignment transform,
  - no net/connectivity inference,
  - no event-writing path,
  - no known-facts mutation,
  - no `board_graph.json` / `view_state.json`.
- Routing:
  - next recommended pass `BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_AUDIT_PASS`.

## PASS UPDATE: BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_CLOSEOUT_PASS (completed)
- Lane: `DOCS_SYNC`
- Codex and Claude audits recorded with verdicts `PASS_WITH_NITS` and `PASS_WITH_NITS`.
- Accepted:
  - read-only visual-trace metadata summary implementation,
  - strict association rules,
  - required safe copy,
  - no visual-trace geometry rendering,
  - no net/connectivity inference,
  - no event-writing/canonical-mutation path.
- Non-blocking nits recorded:
  - source-string guards are useful but brittle under refactors,
  - text-only action-label checks may miss icon-only affordances,
  - optional `AQ2`/`Q2A` negative tests can be added later.
  - ACTIVE_SCOPE_LOCK stale pointer corrected in this closeout.
- Routing:
  - next recommended pass `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS`.

## PASS UPDATE: PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS (completed)
- Lane: `DOCS_SYNC`
- Audit input recorded:
  - `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS` verdict `NEEDS_SCOPE_FIRST`.
- Locked decisions:
  - `photo_reference_points_set` and `photo_layer_aligned` are placeholder-only and unsafe for writer usage until formalized by accepted schema/validator/materializer/tests scope locks.
  - canonical alignment (if it affects board-canvas evidence positioning/report/export/repeatable project state) must be event-backed, human-confirmed, and materialized.
  - volatile/session alignment may only exist as explicit non-canonical preview and must not persist/materialize/export/report or survive reload.
  - candidate future canonical event direction is documented as `photo_to_board_alignment_confirmed` (`photo_local -> board_normalized`, strict actor/photo-reference/space constraints).
- Boundaries preserved:
  - no alignment implementation,
  - no schema/tool/model/runtime changes in this pass,
  - no `board_graph.json` / `view_state.json`,
  - no renderer write path,
  - no visual_trace -> net or damage/suspect -> fault promotion.
- Routing:
  - next recommended pass `PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS`,
  - optional governance-first alternative: `PHOTO_FLOW_SPEC_AUDIT_PASS`.

## PASS UPDATE: PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS (completed)
- Lane: `DOCS_SYNC`
- Event-family decision is locked:
  - canonical future event direction: `photo_to_board_alignment_confirmed`,
  - `photo_reference_points_set` and `photo_layer_aligned` remain reserved/deferred placeholders and unsafe for writer usage until formalized.
- Future payload direction is locked (schema implementation deferred):
  - required: `alignment_id`, `source_photo_id`, `board_side`, `coordinate_space_from`, `coordinate_space_to`, `reference_points_photo`, `reference_points_board`, `transform_type`, `alignment_quality_label`,
  - optional: `notes`,
  - hard rules: `coordinate_space_from=photo_local`, `coordinate_space_to=board_normalized`, reject `graph_layout`, avoid canonical numeric `confidence_score`.
- Future structure/rule direction is locked:
  - equal photo/board reference-point list lengths,
  - transform-specific minimum point counts (`similarity >= 2`, `affine >= 3`),
  - no hidden point inference, no AI canonicalization of points.
- Future actor/status direction is locked:
  - canonical alignment requires `actor.type=user`,
  - AI actor rejected,
  - `system/import` rejected unless separately scoped,
  - `source_photo_id` must reference prior accepted `photo_added`,
  - accepted status required for materialization.
- Boundary lock:
  - no payload fields that imply identity/net/measurement/fault/proposal confirmation.
- Routing:
  - next recommended pass `PHOTO_ALIGNMENT_EVENT_SCHEMA_PRECHECK_AUDIT_PASS`,
  - schema implementation (`PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS`) is precheck-gated.

## PASS UPDATE: PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS (completed)
- Lane: `SCHEMA_PASS / VALIDATOR_FIX`
- Precheck input recorded: `PHOTO_ALIGNMENT_EVENT_SCHEMA_PRECHECK_AUDIT_PASS` verdict `PASS_WITH_NITS` from user/context.
- Implemented:
  - `schemas/events.schema.json`:
    - new event_type `photo_to_board_alignment_confirmed`,
    - conditional payload mapping,
    - strict payload definition (`additionalProperties: false`).
  - `tools/validate_events_jsonl.py`:
    - validator path for `photo_to_board_alignment_confirmed`,
    - actor/user gate,
    - source-photo accepted/prior and forward-reference checks,
    - coordinate-space + `graph_layout` rejection,
    - reference-point domain/length checks,
    - transform minimum-pair checks (`similarity`, `affine`),
    - forbidden alignment payload field rejection,
    - unique `alignment_id` checks.
  - `schemas/samples/valid_photo_to_board_alignment_confirmed.json` added.
  - `tests/test_validate_events_jsonl.py` alignment tests added (happy path + rejection matrix).
- Explicitly unchanged:
  - no materializer projection,
  - no known_facts schema/model projection,
  - no Project ZIP contract changes,
  - no board-canvas/runtime UI behavior.
- Routing:
  - next recommended pass `PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`.
