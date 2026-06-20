# PASS_QUEUE.md

PASS_QUEUE is the pass allowlist and sequencing ledger.

## Scope gate

1. PASS_ID exists here.
2. PASS lane is valid.
3. PASS does not violate `docs/ACTIVE_SCOPE_LOCK.md`.
4. If risk is high, run audit/precheck before implementation.

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_POST_AUDIT_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current-state maintenance trigger pointer

Canonical owner: docs/MEMORY_MAINTENANCE.md. This queue only points to the owner; do not re-arm the old manual countdown here.

## Planned / Recommended (bounded)

| PASS_ID | Lane | Status | Note |
|---|---|---|---|
| TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | accepted/pushed as `dbe9271` (`docs: lock tracebench docs hygiene scope`) | Docs-only scope lock for targeted docs/governance hygiene cleanup after Pro docs-hygiene findings; no runtime changes; locks future narrow pass order and canonical owner routing (`TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` → `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS` → `TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS` → `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` → `CURRENT_STATE_HISTORY_TRIM_PASS` → `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`); user smoke evidence from `Kontrollisin, hetkel sobivad` is recorded as accepted behavior confirmation (no separate smoke pass). |
| TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `7c12aa7` (`docs: normalize audit index route bookkeeping`) | Docs-only pass for `docs/AUDIT_INDEX.md` semantics and route-bookkeeping normalization; docs-hygiene follow-up is `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS`. |
| TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `c70e23f` (`docs: archive completed pass-queue history`) | Docs-only docs-hygiene cleanup pass that archived completed `PASS_QUEUE` history and kept operational routing and sequencing focused. |
| TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `b60ae0c` (`docs: centralize core invariants owner in TRUTH_INDEX`) | Docs-only docs-hygiene pass that centralized core invariant ownership in `docs/TRUTH_INDEX.md` and reduced duplicate invariant blocks in operational docs. |
| TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `a56721d` (`docs: centralize model-routing owner in MODEL_ROUTING`) | Docs-only refresh that confirmed `docs/MODEL_ROUTING.md` as helper/model role owner and kept prompt guidance reference-based. |
| V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS | CODEX / DOCS_PROTECTED_SCOPE_LOCK | future protected route | Docs-only protected scope-lock for inline measurement-entry panel; crosses from read-only UI into write-flow territory. |
| V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS | CODEX / FLUTTER_WRITE_FLOW_IMPLEMENTATION | future high-risk implementation | Inline value/unit/Save in right panel using accepted writer path only; requires strict audit and no renderer writes. |
| V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS | CODEX / FLUTTER_NAV_POLISH | future route | Route/navigation consolidation; keep `/project/measure-sheet` fallback/redirect and do not casually delete the standalone measure sheet route. |
| V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | optional later | Optional theme scope only; do not mix with layout or write-flow work. |
| CURRENT_STATE_HISTORY_TRIM_PASS | CODEX / DOCS_HYGIENE | accepted/pushed as `4af4ac6` (`docs: trim current-state into operational handoff`) | Current docs-only trim pass accepted/pushed; route to `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`. |
| TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS | DOCS_HYGIENE / WORKFLOW | accepted/pushed as `94a1143` (`docs: refresh workbench architecture reference`) | Workbench architecture diagram and reference refresh documenting current accepted 3-zone read-only Workbench model, inert future tools, and protected future write-flow boundaries. |
| V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | accepted/pushed as `8544a4b` (`docs: lock workbench measurement overlay scope`) | Narrow read-only Workbench measurement overlay scope lock. Existing projected measurements only, read-through badge overlay projection, selected-component visibility controls, and no runtime/event/schema/validator/materializer/projection/Project ZIP/write-flow edits. Route points to `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS`. |
| V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS | CODEX / DOCS_SCOPE_LOCK | accepted/pushed as `f1226d4` (`docs: record workbench measurement overlay scope-lock post-audit`) | Docs-only post-audit closeout; recorded independent audit acceptance (`ACCEPT_AS_IS`) and no runtime/test/protected-surface changes. |
| V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | accepted/pushed as `f832ee4` (`docs: activate workbench measurement overlay implementation lock`) | Docs-only implementation lock activation that recorded the pushed post-audit closeout and opened `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS` with a narrow Board Canvas runtime/test allowlist only. |
| V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS | CODEX / FLUTTER_PASS | accepted/pushed as `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`) | Narrow read-only Workbench measurement overlay implementation: existing projected `MeasurementFact` value+unit, explicit component association, existing `board_normalized` anchors, selected-component toggle, global Show All / Hide All, deterministic stacked badges, defensive stale/suspect/invalid UI treatment, volatile UI-only state, no persistence, Measure Sheet unchanged, Add Component deferred. |
| V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_POST_AUDIT_PASS | CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC | accepted/pushed as `300d2c2` (`docs: record workbench measurement overlay impl post-audit`) | Records Claude Code implementation audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`, validation evidence, accepted pushed implementation commit, and route to manual smoke. |
| V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS | CODEX / DOCS_MANUAL_QA_RECORD | completed docs-only manual smoke record | Records user-provided manual visual smoke `PASS_WITH_NIT` with non-blocking Project Overview Add Component nit; route returned to `NEEDS_USER_DECISION`. |
| V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS | CODEX / DOCS_PRODUCT_BOUNDARY_DECISION | completed docs-only product-boundary decision | Records terminology, geometry, rotation, interaction, and Confirm boundary decisions for Add Component Workbench flow before scope-lock handoff. |
| V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS | CODEX / DOCS_DESIGN_INPUT_CAPTURE | completed docs-only gap capture | Captures Add Component Footprint Builder HTML/CSS as `DESIGN_INPUT_ONLY`; runtime `NOT_ACCEPTED`; architecture `NOT_ACCEPTED`; canonical semantics `NONE`; route effect `GAP_CAPTURE_ONLY`; follow-up to `V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS` for boundary decisions. |
| V2_WORKBENCH_ADD_COMPONENT_FLOW_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | accepted/pushed as `118113e` (`docs: lock add component workbench flow scope`) | Lock accepted and closed; board-rail-first flow, rectangular-perimeter visual contacts, deferred confirm payload, and protected runtime semantics remain in force. |
| V2_WORKBENCH_ADD_COMPONENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS | CODEX / DOCS_SCOPE_LOCK | completed docs-only post-audit closeout | Independent lock closeout records accepted scope-lock commit, confirms boundaries, and routes to `NEEDS_USER_DECISION`. |
| V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_PASS | CODEX / DOCS_SCOPE_LOCK | accepted/pushed as `26ce000` (`docs: lock add component template-list ui slice scope`) | First Add Component UI slice: Board Canvas rail entry opens right contextual panel in template-list mode, local visual-contact template selection only, no builder/ghost/rotation/placement/Confirm in this pass. |
| V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_POST_AUDIT_PASS | CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC | current docs-only post-audit closeout | Closeout records accepted scope-lock commit, confirms lock boundaries (`renderer writes: none`, Board Canvas rail entry, right contextual template-list panel, local volatile selection only, geometry-first reduced starter taxonomy, rectangular-perimeter visual-contact templates, visual-contact/contact-marker/template-family wording, no ghost/placement/builder/rotation/Confirm/Edit Layout/Project Overview rewrite, no Measure Sheet and runtime/test/protected-surface changes), and routes to `NEEDS_USER_DECISION`. |
| V2_WORKBENCH_INTEGRATED_PANEL_SMOKE_PASS | CODEX / DOCS_MANUAL_QA_RECORD | future QA route | Manual Windows smoke after integrated panel/navigation work. |
