# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_CLOSEOUT_PASS`

## Next recommended pass

`BOARD_CANVAS_ALIGNMENT_READINESS_QA_PASS`

## Planned / Recommended

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Claude Code audit returned `PASS`; findings accepted and closed out in `PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_CLOSEOUT_PASS`. |
| PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Claude Code audit returned `PASS`; findings accepted and closed out in `PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_CLOSEOUT_PASS`. |
| PHOTO_ALIGNMENT_DART_MODEL_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Audit was completed and accepted via pushed closeout flow; do not route backward to this pass. |
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | completed | Drift reset completed and ledger/pass pointers aligned after Dart model closeout. |
| PHOTO_FLOW_SPEC_FIXUP_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Claude Code audit completed; verdict accepted in `PHOTO_FLOW_SPEC_FIXUP_CLOSEOUT_PASS`. |
| PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS | DOCS_SYNC | completed | Resolved PHOTO_FLOW_SPEC non-blocking nits: placeholder explicitness, board-canvas canonical owner pointer, section numbering continuity, and durable Project ZIP wording. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked readiness criteria and hard boundaries for any future board-canvas photo-alignment UI/helper work after the accepted data chain. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Claude Code verdict `PASS`; GPT Pro direction `PREFER_METADATA_ONLY_NEXT`; accepted safe V1 direction is `READINESS_PANEL_ONLY`. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked exact metadata-only readiness-panel boundaries: allowed fields/copy, project-level placement, transform-type wording, and explicit forbidden rendering/edit/event-writing behavior. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS | FLUTTER_PASS | completed | Implemented narrow read-only readiness/status panel metadata on board canvas with declared-type wording, reference-pair count only, required safety copy, and overflow-safe constrained layout; no geometry/overlay/transform/event-writing behavior. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Claude Code audit accepted panel scope and layout fix; non-blocking nits recorded for label casing and additional multi-alignment test coverage. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_CLOSEOUT_PASS | DOCS_SYNC | completed | Closeout records `PASS_WITH_NITS`, accepts scope-compliant implementation state, aligns ACTIVE_SCOPE_LOCK routing, and preserves all no-write/no-transform/no-overlay boundaries. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_PASS | QA_PASS / FLUTTER_TEST_PASS | completed | Narrow QA/polish follow-up completed: readiness-panel label casing normalized to `Reference pairs` and focused multi-alignment readiness-panel widget coverage added without scope expansion. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Claude Code audit returned `PASS`; follow-up remained narrow and scope-compliant with no product behavior expansion. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_CLOSEOUT_PASS | DOCS_SYNC | completed | Closeout records audit verdict `PASS`, accepts follow-up QA state, resolves prior nits, and aligns stale ACTIVE_SCOPE_LOCK pointer. |
| BOARD_CANVAS_ALIGNMENT_READINESS_QA_PASS | QA_PASS | recommended | Forward readiness QA pass to verify panel/read-only boundaries remain stable across broader board-canvas scenarios before any future alignment UI scope expansion. |

## Completed sequence (compact ledger)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_CLOSEOUT_PASS | DOCS_SYNC | completed | Closed out Claude Code audit result (`PASS`) for readiness-panel nits follow-up; accepted resolved nits, aligned scope lock pointers, and routed forward to readiness QA. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_AUDIT_PASS | AUDIT_ONLY | completed (`PASS`) | Audit confirmed follow-up stayed narrow: label casing normalized, multi-alignment test coverage added, no scope expansion or boundary regressions. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_NITS_FOLLOWUP_PASS | QA_PASS / FLUTTER_TEST_PASS | completed | Resolved non-blocking readiness-panel nits via narrow polish/test hardening only: normalized InspectorField label casing to `Reference pairs` and added multi-alignment panel coverage for stable ordering, metadata visibility, no raw coordinate display, and no forbidden actions. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Closed out readiness panel after Claude Code audit; accepted metadata-only panel behavior and overflow fix, recorded non-blocking nits, and routed forward to optional nits followup. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS | FLUTTER_PASS | completed | Added read-only project/photo-level photo-alignment readiness metadata panel using `KnownFacts.photoToBoardAlignments`, with required safety copy, count-only reference-point display, constrained overflow-safe layout, and no rendering/computation/edit/event-writing expansion. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock future readiness-panel implementation scope to metadata-only status display, forbid raw reference-point coordinates and any transform/render/edit paths, and route forward to implementation pass. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS | DOCS_SYNC | completed | Close out GPT Pro + Claude Code audit synthesis; accept `READINESS_PANEL_ONLY`, record allowed metadata and forbidden rendering/computation surfaces, and route to readiness-panel scope lock. |
| BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Locked what is ready vs not ready for board-canvas alignment UX, preserved no-write/no-transform/no-conversion boundaries, and routed forward to audit-only UI scope gating. |
| PHOTO_FLOW_SPEC_NITS_FOLLOWUP_PASS | DOCS_SYNC | completed | Polish follow-up for `PHOTO_FLOW_SPEC`: resolved all non-blocking closeout nits without expanding implementation scope. |
| PHOTO_FLOW_SPEC_FIXUP_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Close out Claude Code audit for `PHOTO_FLOW_SPEC_FIXUP_PASS`; accept spec-state alignment and boundary preservation, record non-blocking nits, and route forward to optional nits follow-up. |
| PHOTO_FLOW_SPEC_FIXUP_PASS | DOCS_SYNC | completed | Fix `PHOTO_FLOW_SPEC.md` stale pre-implementation sections to current accepted photo-alignment state; keep boundaries intact and route forward to `PHOTO_FLOW_SPEC_FIXUP_AUDIT_PASS`. |
| PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS`) | Close out Claude Code audit for materializer QA hardening; accept explicit no-side-effect assertions and direct schema-contract validation coverage, and confirm no production behavior changes. |
| PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS`) | Close out Claude Code audit for Dart-model QA hardening; accept test-only coverage additions, record unrelated widget-test flake as non-blocking, and route forward to the pending materializer QA audit. |
| PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS | QA_PASS / FLUTTER_TEST_PASS | completed | Harden Dart KnownFacts alignment tests only: add dedicated `notes`-absent parse/toJson omission test and multi-item `photo_to_board_alignments` parse/round-trip preservation test. |
| PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_PASS | QA_PASS / TOOLS_TEST_PASS | completed | Harden materializer projection tests only: explicit no-side-effect assertions for `damage_regions`/`suspect_regions` and direct known_facts schema-contract validation test for projected `photo_to_board_alignments` items. |
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | completed | Reset docs drift countdown and compactly align CURRENT_STATE/PASS_QUEUE/ACTIVE_SCOPE_LOCK/AUDIT_INDEX after Dart model closeout acceptance. |
| PHOTO_ALIGNMENT_DART_MODEL_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Close out Claude Code audit, accept Dart model parity state, record non-blocking nits, align scope-lock pointer, and route to docs-drift cleanup because countdown reached zero. |
| PHOTO_ALIGNMENT_DART_MODEL_PASS | FLUTTER_PASS | completed | Implement Dart KnownFacts support for `photo_to_board_alignments` with field/key parity, empty-list fallback, round-trip coverage, and no transform/coordinate-conversion/inference behavior. |
| PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock Dart KnownFacts model direction for `photo_to_board_alignments`, JSON key parity, missing-field defaults, no-transform/no-inference boundaries, and future implementation/test allowlist. |
| PHOTO_ALIGNMENT_MATERIALIZER_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Close out Claude Code audit, accept materializer projection state, record non-blocking test nits, and route next to Dart model scope lock. |
| PHOTO_ALIGNMENT_MATERIALIZER_PASS | TOOLS_PASS / SCHEMA_PASS | completed | Project accepted user `photo_to_board_alignment_confirmed` events into optional `known_facts.photo_to_board_alignments` with latest-per-alignment rule and no transform/geometry-conversion/side-effect expansion; add known_facts schema support and projection tests. |
| PROMPTING_AND_STATE_COMPACTION_PASS | DOCS_SYNC | completed | Compact CURRENT_STATE/PASS_QUEUE duplication and adopt hybrid prompt protocol with guarded templates and routing clarity. |
| PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock future materializer/known_facts projection direction and no-side-effect boundaries for alignment events. |
| PHOTO_ALIGNMENT_EVENT_SCHEMA_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Close out schema/validator audit and record deferred projection/runtime surfaces. |
| PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS | SCHEMA_PASS / VALIDATOR_FIX | completed | Add `photo_to_board_alignment_confirmed` schema + validator support with tests and valid sample. |
| PHOTO_ALIGNMENT_EVENT_SCHEMA_PRECHECK_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Precheck approved proceeding to schema implementation with boundary-preserving notes. |
| PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock canonical alignment event-family/schema direction before implementation. |
| PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock canonical-vs-volatile alignment policy and placeholder-event safety rules. |
| BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS | AUDIT_ONLY | completed (`NEEDS_SCOPE_FIRST`) | Alignment stack required scope-first sequencing before implementation. |
| BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_AUDIT_CLOSEOUT_PASS | DOCS_SYNC | completed | Final decision: defer photo alignment implementation; keep board-canvas evidence overlays deferred. |
| BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Close out visual_trace inspector metadata-only audits. |
| BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS | FLUTTER_PASS | completed | Add read-only visual_trace metadata summary (no geometry rendering). |
| BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock visual_trace support to metadata-only inspector/list direction. |
| BOARD_CANVAS_MEASUREMENT_SUMMARY_CLOSEOUT_PASS | DOCS_SYNC | completed (`PASS_WITH_NITS`) | Close out measurement summary audits; confirm strict read-only metadata boundaries. |
| BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS | FLUTTER_PASS | completed | Add read-only measurement summary metadata with strict association rules. |
| BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS | DOCS_SYNC | completed | Lock measurement support to metadata-only inspector/list direction. |
| BOARD_CANVAS_READONLY_RENDERER_QA_PASS | FLUTTER_PASS / QA_PASS | completed | Harden read-only renderer behavior and guard deferred evidence reads. |
| BOARD_CANVAS_READONLY_INSPECTOR_PASS | FLUTTER_PASS | completed | Add read-only inspector with non-canvas selection and no-write boundaries. |
| BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS | FLUTTER_PASS | completed | Render board-normalized component placements read-only with safe template fallback. |
| BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS | FLUTTER_PASS | completed | Add board-canvas shell route and read-only empty states (`renderer writes: none`). |

## Historical evidence owner

Detailed pass evidence remains in `docs/audit/*.md` and indexed by `docs/AUDIT_INDEX.md`.

## Docs drift countdown

Current countdown: `5`
