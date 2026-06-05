# CURRENT_STATE.md

Project: TraceBench AI / BoardFact  
Branch: `main`

- Current pass: `V1_1_TEST_AND_LINT_HYGIENE_CLOSEOUT_PASS`
- Next recommended pass: `V1_1_POST_TEST_AND_LINT_HYGIENE_ROUTE_REVIEW_PASS`
- Current-state maintenance trigger pointer: `docs/MEMORY_MAINTENANCE.md` owns the rule; this file remains below the trigger.

## Compact handoff

- V1 release candidate is fixed and verified:
  - tag `v1.0.0-rc1` exists locally and on `origin`.
  - V1 remains protected; V2 implementation is not active.
- V1.1 hardening is active:
  - Reference Images UX track is complete enough for V1.1.
  - Board Canvas read-only visual polish is complete enough for V1.1.
  - Project Creator Windows full-suite flake is fixed, closed out, and no longer an active NIT.
- Current compaction pass is docs-only:
  - `CURRENT_STATE.md` is intentionally bounded.
  - Older accepted-pass details remain in `docs/audit/*.md` and `docs/PASS_QUEUE.md`.
  - No audit history was pruned.

## Latest accepted baseline

- Reference Images remain Model B local sidecar only:
  - local `.tracebench_local/reference_images/` storage and `.tracebench_local/reference_images.json` ledger,
  - read-only viewer with safety copy,
  - complete V1.1 UX slices: copy/safety, states, metadata grouping, accessibility/focus, semantics fixup, smoke/QA, responsive layout,
  - outside Project ZIP, `events.jsonl`, `known_facts.json`, materializer, Board Canvas, AI/OCR/CV, and URL import.
- Board Canvas remains read-only:
  - visual polish is accepted/pushed,
  - `renderer writes: none` remains part of the UI boundary,
  - footprint rendering is display-only from existing template geometry,
  - pin pads do not infer pins, nets, identity, measurements, or faults,
  - no schema/model/materializer/Project ZIP changes,
  - no `board_graph.json` or `view_state.json`.
- Project Creator reliability fix is accepted/pushed:
  - production `ProjectCreator` remains untouched,
  - test fake now writes `known_facts.json` synchronously,
  - regression assertion confirms `known_facts.json` exists after successful create,
  - targeted project creator test passed (`7/7`),
  - full Flutter suite repeated passed (`5/5`),
  - `py -3 tools\validate_all.py` passed.

## Recent completed summary

- `PROJECT_CREATOR_TEST_FLAKE_FIX_CLOSEOUT_PASS`: completed and accepted.
- `V1_1_POST_TEST_RELIABILITY_ROUTE_REVIEW_PASS`: audit-only, no repo modifications; accepted input recommends this compaction pass because `CURRENT_STATE.md` had grown too long.
- `V1_1_CURRENT_STATE_COMPACTION_PASS`: accepted/pushed docs-only bounded compaction (CURRENT_STATE 205 → 86 lines; no history pruned).
- Memory-consolidation audit (audit-only): link-clean memory system with meta-drift findings F1–F6 (broken drift trigger, divergent read-order/conflict-order, stale cleanup pointer, registry omissions, stale `PROJECT_STATE.yml`).
- `V1_1_MEMORY_SYSTEM_RECONCILIATION_SCOPE_LOCK_PASS`: accepted/pushed docs-only lock; routes to `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS` (supersedes the post-compaction route review).
- `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS`: accepted/pushed docs-only implementation; reconciled read-order/conflict-order ownership, memory registry completeness, line-count maintenance trigger, non-stale cleanup pointer, and non-canonical `PROJECT_STATE.yml` treatment.
- `V1_1_MEMORY_SYSTEM_RECONCILIATION_POST_AUDIT_PASS`: accepted re-audit outcome `ACCEPT_AS_IS` after the small precedence/canonical-owner patch.
- `V1_1_MEMORY_SYSTEM_RECONCILIATION_CLOSEOUT_PASS`: accepted/pushed docs-only closeout.
- `V1_1_POST_MEMORY_RECONCILIATION_ROUTE_REVIEW_PASS`: audit-only; confirmed governance clean, found a `docs/AUDIT_INDEX.md` backtick-n table artifact, and recommended the test/lint/docs hygiene pass.
- `V1_1_TEST_AND_LINT_HYGIENE_SCOPE_LOCK_PASS`: accepted/pushed docs-only lock; `flutter analyze` = 52 issues/0 errors; locks one behavior-preserving pass (AUDIT_INDEX `` `n `` repair, measurement-write error-absence assertion, mechanical lint cleanup) with 4 judgment analyzer items + pumpAndSettle deferred; routes to `V1_1_TEST_AND_LINT_HYGIENE_PASS`.
- `V1_1_TEST_AND_LINT_HYGIENE_PASS`: accepted/pushed behavior-preserving hygiene implementation; repaired AUDIT_INDEX formatting, added measurement success error-absence assertion, added direct `path` dev dependency with lockfile consistency, and reduced analyzer output to 5 explicitly deferred residuals.
- `V1_1_TEST_AND_LINT_HYGIENE_POST_AUDIT_PASS`: accepted re-audit outcome `ACCEPT_AS_IS` after small-patch authorization for `board_graph_model.dart`, `home_screen.dart`, and `pubspec.lock` inclusion.

## Roadmap

- `TAG_V1_RC_FIRST`: complete.
- `V1_1_HARDENING`: active.
- `V2_EVENT_WRITING_ARCHITECTURE`: later and separately scoped.
- V2 does not start with photo overlay, transform, background photo helper, or Reference Images Board Canvas layering.

## Future candidates after route review

- Post test/lint hygiene route review.
- Import/export usage runbook.
- Commercial-readiness strategy lane.

These are candidates only. They are not started by this pass.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage/suspect are not proof or probability.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only and renderer writes nothing.

## Next recommended pass

`V1_1_POST_TEST_AND_LINT_HYGIENE_ROUTE_REVIEW_PASS`
