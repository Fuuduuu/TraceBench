# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS_ID lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_PASS`

## Next recommended pass

`PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_AUDIT_PASS`

## Planned / Recommended

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| PHOTO_ALIGNMENT_DART_MODEL_QA_TEST_HARDENING_AUDIT_PASS | AUDIT_ONLY | recommended | Audit-only confirmation that Dart-model QA hardening remains test-only and preserves model/runtime boundaries. |
| PHOTO_ALIGNMENT_MATERIALIZER_QA_TEST_HARDENING_AUDIT_PASS | AUDIT_ONLY | recommended | Audit-only confirmation that the new QA hardening remains test-only and preserves materializer/projection boundaries. |
| PHOTO_ALIGNMENT_DART_MODEL_AUDIT_PASS | AUDIT_ONLY | completed (`PASS_WITH_NITS`) | Audit was completed and accepted via pushed closeout flow; do not route backward to this pass. |
| DOCS_DRIFT_MINI_CLEANUP_PASS | DOCS_SYNC | completed | Drift reset completed and ledger/pass pointers aligned after Dart model closeout. |
| PHOTO_FLOW_SPEC_AUDIT_PASS | AUDIT_ONLY | optional | Governance-first reconciliation if sequencing/risk requires it. |

## Completed sequence (compact ledger)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
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
