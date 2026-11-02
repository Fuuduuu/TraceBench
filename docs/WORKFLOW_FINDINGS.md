# BenchBeep workflow findings

Updated: 2026-11-02. Accepted implementation baseline: `b188be3aeb186eb20c2cf879a8e1f453c32853ae`.

This register preserves all 16 findings from the independent Claude End-to-End
Workflow Architecture Audit, as supplied by the human on 2026-10-31. No verified
repository path to the full audit report was supplied; `Audit BB-xx` below refers
to that finding inventory. Source links identify owners, not independent proof
that every reported defect has been reproduced. Initial register creation did
not reproduce BB-02 through BB-16; subsequent implementation and regression
evidence is recorded in the affected entries.

Priorities are the reported audit priorities. In particular, BB-13's data-integrity
risk still needs reassessment. An entry does not authorize implementation.
`FIXED` requires independent acceptance and a recorded fix commit; an uncommitted
patch remains `IN_PROGRESS`. Unlinked regression coverage is not claimed absent.

## BB-01 — Wrong measurement target after Navigator selection

- Priority: **P0**
- Responsible module: [Board Canvas selection and measurement composition](../lib/features/board_canvas/screens/board_canvas_screen.dart), with the existing [IntegratedMeasurePanel](../lib/features/board_canvas/widgets/integrated_measure_panel.dart) writer handoff unchanged.
- Finding type: defect.
- Reproduction/evidence: Audit BB-01; Navigator selects C2, then opening Mõõtmine substitutes first-visible R1. The pre-fix widget regression recorded a writer request for R1 while expecting C2.
- Status: **FIXED** — independently accepted P0 correction committed at `21a6c7d`; its seven widget regressions are retained.
- Regression test: [Board Canvas tests](../test/widget/board_canvas_screen_test.dart), group `P0 measurement target selection`; `Navigator C2 saves against C2 instead of first visible R1`, zero/one/multiple eligible placement cases, explicit placement preservation and empty-selection fallback. The seven accepted P0 widget cases are retained; standalone routing tests also protect the extracted policy.
- Fix commit: `21a6c7d7f0f67da65aab59add948075fb780f0b5`.

- Retained policy/risk: Empty canonical selection still resolves to the first visible placement when Measurement opens. That fallback does not prove technician intent and is deliberately unchanged.

## BB-02 — Candidate may move when its context panel opens during pointer-down

- Priority: **P1**
- Responsible module: [CandidateDragSession](../lib/features/component_candidates/logic/candidate_drag_session.dart) pure transaction decisions and [ComponentCandidateEditor](../lib/features/component_candidates/widgets/component_candidate_editor.dart) render-transform/preview adapter; Canvas retains panel and sidecar lifecycle.
- Finding type: defect.
- Reproduction/evidence: Audit BB-02; the human supplied a real Windows VM-pointer reproduction with a 163–176 logical-pixel jump and local draft write. Targeted RED tests reproduce changed normalized position and persistence after a two-pixel move across the actual context-panel reflow; GREEN retains the original document and sidecar. The interaction extraction was subsequently accepted and committed at `b188be3`; the current routing patch has its own human-smoke gate.
- Status: **FIXED** — independently accepted Candidate Interaction extraction committed at `b188be3`.
- Regression test: [Standalone session tests](../test/unit/candidate_drag_session_test.dart), [editor pointer transaction tests](../test/widget/component_candidate_editor_test.dart), and [Canvas tests](../test/widget/board_canvas_screen_test.dart): `BB-02 panel-opening wobble never persists a real sidecar` and `candidate cancelled drag never persists a real sidecar`. Covers reflow, click/wobble, valid drag, scale, ownership, cancellation and interrupted end.
- Fix commit: `b188be3aeb186eb20c2cf879a8e1f453c32853ae`.

## BB-03 — Candidate-to-confirmed-component workflow absent

- Priority: **P1**
- Responsible module: Product integration between [ComponentCandidateEditor](../lib/features/component_candidates/widgets/component_candidate_editor.dart), [Component Identity](../lib/features/board_canvas/widgets/component_identity_panel.dart) and the [Placement workflow](../lib/features/board_canvas/widgets/board_canvas_placement_panel.dart).
- Finding type: deferred feature.
- Reproduction/evidence: Audit BB-03; editable visual candidates do not provide a candidate-to-confirmed-component workflow. Local candidates are not canonical components or placements.
- Status: **DEFERRED** — requires separate product authorization and persistent geometry-compatibility decisions. Do not implement through this register or the P0 patch.
- Regression test: No confirmation regression linked; the feature remains deferred.
- Fix commit: Not applicable while deferred.

## BB-04 — Candidate click in Measurement clears target

- Priority: **P2**
- Responsible module: [CanvasRoutingState](../lib/features/board_canvas/logic/canvas_selection_routing.dart) empty-click/Measurement policy and [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) hit routing; Measurement retains its writer/draft ownership.
- Finding type: defect.
- Reproduction/evidence: Audit BB-04; mouse and touch RED cases clear an explicit Measurement target after an empty click. The patch preserves target and typed draft for empty/inert-candidate clicks; an intentional different-placement click still changes target.
- Status: **IN_PROGRESS** — routing correction implemented; pending independent acceptance and commit.
- Regression test: Standalone routing test `BB-04 empty and inert candidate clicks retain exact measurement intent`; [Canvas tests](../test/widget/board_canvas_screen_test.dart), group `Canvas interaction routing BB-04/05/06`, mouse/touch target-and-draft cases also verify the explicit R2 save request.
- Fix commit: Not yet available; this routing patch is uncommitted.

## BB-05 — Placement click in Lisa may create a candidate

- Priority: **P2**
- Responsible module: [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) candidate/confirmed-placement hit precedence, with mode decisions in [CanvasRoutingState](../lib/features/board_canvas/logic/canvas_selection_routing.dart).
- Finding type: defect.
- Reproduction/evidence: Audit BB-05; mouse and touch RED cases lose the confirmed-placement selection in Lisa. Inside visual Lisa only, candidate hits take precedence, then existing confirmed placements open Inspector; only eligible empty authoring space adds a candidate. Outside visual Lisa, confirmed placements retain priority over overlapping candidates, including a zero-sidecar-write drag.
- Status: **IN_PROGRESS** — routing correction implemented; pending independent acceptance and commit.
- Regression test: [Canvas tests](../test/widget/board_canvas_screen_test.dart), group `Canvas interaction routing BB-04/05/06`: mouse/touch placement/no-sidecar-write, overlapping candidate/exclusive selection and one empty-space addition through the real local store.
- Fix commit: Not yet available; this routing patch is uncommitted.

## BB-06 — Invisible add behavior in compact/focus modes

- Priority: **P2**
- Responsible module: [CanvasRoutingState](../lib/features/board_canvas/logic/canvas_selection_routing.dart) authoring policy and [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) actual responsive/focus visibility.
- Finding type: UX issue.
- Reproduction/evidence: Audit BB-06; RED focus/compact cases create and persist a candidate despite hidden controls. Candidate creation now requires visible Lisa authoring controls; existing candidate selection/drag remain available and restoring controls re-enables add.
- Status: **IN_PROGRESS** — routing correction implemented; pending independent acceptance and commit.
- Regression test: [Canvas tests](../test/widget/board_canvas_screen_test.dart), `BB-06 $hidden hides Add but preserves candidate selection and drag`; standalone routing policy cases cover every mode with visible/hidden controls. Compact editing controls/retry remain a separate unresolved UX gap.
- Fix commit: Not yet available; this routing patch is uncommitted.

## BB-07 — Empty Component Navigator lacks guidance

- Priority: **P2**
- Responsible module: [ComponentNavigator](../lib/features/board_canvas/widgets/component_navigator.dart) empty-state presentation.
- Finding type: UX issue.
- Reproduction/evidence: Audit BB-07; an empty Component Navigator does not give sufficient next-action guidance.
- Status: **OPEN** — audit-reported; no fix in this patch.
- Regression test: No dedicated finding regression linked yet.
- Fix commit: Not recorded.

## BB-08 — Candidate and placement may remain selected together

- Priority: **P2**
- Responsible module: [Canvas selection routing](../lib/features/board_canvas/logic/canvas_selection_routing.dart) exclusivity decisions; [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) applies candidate-controller effects without changing candidate documents.
- Finding type: defect.
- Reproduction/evidence: Audit BB-08; candidate and placement selection may remain active simultaneously.
- Status: **FIXED** — independently accepted Canvas Selection & Mode Routing extraction committed at `8887d65`.
- Regression test: [Canvas integration tests](../test/widget/board_canvas_screen_test.dart), `BB-08 canonical and candidate selection are mutually exclusive`; [standalone routing tests](../test/unit/canvas_selection_routing_test.dart) cover both intent directions.
- Fix commit: `8887d652dbbccfdff64387653548f6d34b6d48dd`.

## BB-09 — Navigator does not consistently follow Canvas selection

- Priority: **P2**
- Responsible module: [Canvas selection routing](../lib/features/board_canvas/logic/canvas_selection_routing.dart) Navigator-entry policy and [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) selected-component/category adapter; Navigator presentation remains separate.
- Finding type: UX issue.
- Reproduction/evidence: Audit BB-09; Canvas selection is not consistently reflected in Navigator context.
- Status: **FIXED** — independently accepted Canvas Selection & Mode Routing extraction committed at `8887d65`.
- Regression test: [Canvas integration tests](../test/widget/board_canvas_screen_test.dart), `BB-09 Navigator follows Canvas selection across categories` and `BB-09 opening Navigator retains the exact Canvas placement`; [standalone routing tests](../test/unit/canvas_selection_routing_test.dart) pin selection preservation.
- Fix commit: `8887d652dbbccfdff64387653548f6d34b6d48dd`.

## BB-10 — Canonical placement target can be lost

- Priority: **P2**
- Responsible module: [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) `_placementSaveTarget` resolution and target handoff to the existing [Placement workflow](../lib/features/board_canvas/widgets/board_canvas_placement_panel.dart).
- Finding type: defect.
- Reproduction/evidence: Audit BB-10; the canonical placement target can be lost during the workflow. This is distinct from BB-01's measurement-mode target substitution.
- Status: **OPEN** — audit-reported; no fix in this patch.
- Regression test: No dedicated finding regression linked yet; BB-01 tests do not establish Placement-write correctness.
- Fix commit: Not recorded.

## BB-11 — Hide-unmeasured filter unexpectedly switches mode

- Priority: **P2**
- Responsible module: [Canvas selection routing](../lib/features/board_canvas/logic/canvas_selection_routing.dart) `afterFilter`; [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) retains filter visibility, preview and widget composition.
- Finding type: UX issue.
- Reproduction/evidence: Audit BB-11; changing the hide-unmeasured filter unexpectedly switches the active mode.
- Status: **FIXED** — independently accepted Canvas Selection & Mode Routing extraction committed at `8887d65`.
- Regression test: [Canvas integration tests](../test/widget/board_canvas_screen_test.dart), `BB-11 filtering a measurement target keeps mode and blocks saving`; [standalone routing tests](../test/unit/canvas_selection_routing_test.dart) cover every context mode.
- Fix commit: `8887d652dbbccfdff64387653548f6d34b6d48dd`.

## BB-12 — Passive component categorized as unknown

- Priority: **P2**
- Responsible module: [ComponentNavigator](../lib/features/board_canvas/widgets/component_navigator.dart) `componentCategoryFor` presentation classifier; canonical component-type vocabulary is a separate contract.
- Finding type: UX issue.
- Reproduction/evidence: Audit BB-12; a component with type `passive` is categorized as unknown in Navigator.
- Status: **OPEN** — audit-reported; no classification or vocabulary change in this patch.
- Regression test: No dedicated finding regression linked yet.
- Fix commit: Not recorded.

## BB-13 — Repeated Placement Save may append another event

- Priority: **P3** — reported priority; reassess data-integrity risk before accepting this ranking.
- Responsible module: [Placement workflow](../lib/features/board_canvas/widgets/board_canvas_placement_panel.dart) repeat-save and operation-identity behavior, coupled to the existing [Placement writer](../lib/features/components/services/v2_placement_writer.dart).
- Finding type: architecture debt.
- Reproduction/evidence: Audit BB-13; repeated Placement Save may append another event. The impact and intended repeat-save semantics require reassessment; this register does not declare the behavior safe or authorize writer changes.
- Status: **OPEN** — data-integrity risk/severity reassessment pending; no fix in this patch.
- Regression test: No dedicated finding regression linked yet. Existing `Placement P0 characterization` in [Board Canvas tests](../test/widget/board_canvas_screen_test.dart) is related coverage, not acceptance of repeat-save safety.
- Fix commit: Not recorded.

## BB-14 — Candidate drag center snaps to pointer

- Priority: **P3**
- Responsible module: [CandidateDragSession](../lib/features/component_candidates/logic/candidate_drag_session.dart) center translation and [ComponentCandidateEditor](../lib/features/component_candidates/widgets/component_candidate_editor.dart) current-transform displacement adapter.
- Finding type: defect.
- Reproduction/evidence: Audit BB-14; dragging a candidate snaps its center to the pointer.
- Status: **FIXED** — independently accepted grab-offset correction committed at `b188be3`.
- Regression test: [Editor tests](../test/widget/component_candidate_editor_test.dart), `BB-14 drag retains the grab offset and commits once on up`, scaled-surface and changed-origin cases; [standalone session tests](../test/unit/candidate_drag_session_test.dart) verify center translation without snapping.
- Fix commit: `b188be3aeb186eb20c2cf879a8e1f453c32853ae`.

## BB-15 — Outdated UI tooltips and test descriptions

- Priority: **P3**
- Responsible module: [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) workflow copy and [Board Canvas test descriptions](../test/widget/board_canvas_screen_test.dart).
- Finding type: UX issue.
- Reproduction/evidence: Audit BB-15; some UI tooltips and test descriptions no longer describe the current workflow accurately. Exact copy changes remain to be scoped.
- Status: **OPEN** — audit-reported; no copy or test-description repairs in this patch.
- Regression test: No dedicated finding regression linked yet.
- Fix commit: Not recorded.

## BB-16 — `_coerceSelection` mutates state during build

- Priority: **P3**
- Responsible module: [Canvas selection routing](../lib/features/board_canvas/logic/canvas_selection_routing.dart) pure `reconcile`; [Board Canvas](../lib/features/board_canvas/screens/board_canvas_screen.dart) applies decisions in project-provider listeners and user callbacks.
- Finding type: architecture debt.
- Reproduction/evidence: Audit BB-16; `_coerceSelection` mutates selection/context state when called during build.
- Status: **FIXED** — independently accepted Canvas Selection & Mode Routing extraction committed at `8887d65`. Other pre-existing build-time lifecycle work remains outside BB-16.
- Regression test: [Standalone routing tests](../test/unit/canvas_selection_routing_test.dart), `pure reconciliation`; [Canvas tests](../test/widget/board_canvas_screen_test.dart), `BB-16 user intent rejects a non-Board placement before build`, `BB-16 projection reconciliation remains stable across rebuilds` and source-owner guard requiring pure selection logic and no `_coerceSelection`.
- Fix commit: `8887d652dbbccfdff64387653548f6d34b6d48dd`.
