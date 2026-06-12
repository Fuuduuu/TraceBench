# V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS

## Mode

`DOCS_SYNC / VISUAL_DESIGN_CAPTURE`

## Source status

| Item | Status |
|---|---|
| Source artifact | `_incoming/ui_redesign/TraceBench_UI_Redesign_Visual_Design_Pass_standalone.html` |
| Local availability | available |
| Raw artifact stored | not stored in this pass |
| Source capture result | converted to markdown capture with future-boundary notes |

## Executive summary

The failed smoke showed an interaction-model mismatch after consolidation, not only isolated bugs.
Technician-first visuals must move to a PCB-first overview, component-scoped actions, and a cleaner Add/Edit/Save flow shape before any write-runtime fixes.
This pass records the visual target only, with all canonical write/runtime changes deferred.

## Failed smoke lessons

- Manual smoke was `FAIL / PARTIAL`.
- Add Component was still framed as `Koht -> Väärtus -> Ühik`.
- Edit flow dead-ended with no components.
- Save Measurement exposed missing/non-integer sequence exception.
- Save UI duplicated unit controls.
- User-facing unit and action model was noisy and not technician-first.

## PCB-first UI principle

- Default Project Overview must be PCB/board-centric, not a long list of equal-weight actions.
- Component anchors drive the primary visual hierarchy.
- Keep initial visual state clean and calm.
- Proposed Overview shell:
  - one status card,
  - up to four primary actions (measure, add, edit, save),
  - secondary actions behind `Veel`.

## Project Overview visual direction

- Remove the long equal-weight button list from initial load.
- Keep project context, status, and board map visible by default.
- Progressively reveal less common actions.
- Use neutral copy and avoid AI-diagnostic tone.

## Component-context menu direction

- The action menu appears when a component is selected.
- Measure remains central but not as an always-on global control.
- Menu contents include:
  - Measure
  - Edit component
  - Notes / comment
  - Related rail or function
  - Technical details (progressive)
- Menu behavior should remain local, quick, and low-noise.

## Sparse component map rules

- Default component map is sparse and unintrusive.
- Labels/markings only for confirmed technician state by default.
- Unconfirmed markers are optional and removable from default view.
- Allow filters that show only confirmed markers when the technician needs focus.
- Example supported flow: isolate HDMI path/area.

## Add Component redesign direction

- Add Component must be component creation first, not measurement creation.
- Remove generic triplet framing from component creation:
  - type (required),
  - value (numeric where relevant),
  - unit (V, Ω, kΩ, µF, nF, A, none),
  - marking,
  - rail/function (`belongs-to`),
  - comment.
- Unknown is valid first-touch classification.
- Candidate/pre-fill fields are helper context only.

## Edit Component redesign direction

- Edit is restricted to existing components only.
- Empty-state must be explicit when no components exist:
  - show clear state,
  - provide direct path to add the first component.
- Replace dead dropdown with list-backed selector.
- Show pinned original identity read-only.
- Show changed-fields summary before save.

## Save Measurement redesign direction

- Avoid duplicated unit input pattern.
- Use one primary unit interaction:
  - unit chips for common modes,
  - `Muu ühik` for overflow cases.
- Preserve explicit non-blocking failure state behavior.
- `WI-060` sequence triage remains separate and visible; do not hide it inside this redesign.

## Technical details / progressive disclosure rules

- Technical fields belong in progressive disclosure.
- Honest error/empty/exception states stay visible and actionable.
- Raw implementation detail belongs under technical drawer only.
- Forbidden wording: do not imply verified/correct/detected/diagnosed where no human confirmation exists.

## Future component drawing and height idea

- Future pass idea: technician manually defines component shape, pin count, footprint, and optional height.
- Height should be optional, mainly for tall passives and cases where it adds visual value.
- Not implementation permission in this pass.

## Future onboarding and outline idea

- Capture repair item / PCB outline and size as a first-stage onboarding concept.
- Possible inputs:
  - phone photo + scale,
  - or manual outline draw with measured dimensions.
- Manual drawing mode should remain a future architecture item.

## Future photo-grid and AI draft idea

- Second-stage concept: grid-cell decomposition with close photos.
- AI can use overview + close photos only for draft visuals.
- AI draft markers must remain tentative and not canonical.
- Unrecognized AI markers can remain as unconfirmed candidates only.

## AI draft marker boundary

- Candidate markers from AI or photo are draft-only.
- Unclassified AI findings may show as unconfirmed “component candidate”.
- Human must confirm/deny each marker and each component before canonicalization.
- No AI/photo pixel becomes canonical fact by itself.

## Boundaries and forbidden implications

- Human is the sensor; AI is graph support.
- `visual_trace` cannot become `electrical_net` without measurement or accepted source.
- `visual_trace` and candidate hints remain hint/context classes, not facts.
- No runtime change in this pass:
  - `lib/`, `test/`, `tools/`
  - schemas / validator / materializer / writer service
  - Project ZIP
  - Board Canvas write/edit
  - Reference Images runtime
  - AI/OCR/CV
  - Photo Markup / Repair Map / Measure Momentum / Activity Timeline
  - Visual Trace Shape Assist

## Proposed implementation slicing

1. Visual scope lock (slice 0)
2. Overview + navigation slice
3. Add/Edit/Save shells as local read-only+local-state flows
4. Progressive disclosure + error-state slice
5. Write runtime slice (separate architecture lock)

## Deferred architecture items

- Save/Add/Edit write runtime
- Sequence-exception remediation
- Idempotent resubmit and re-measure history
- candidate-to-component promotion
- pin binding and known_facts mutation
- Project ZIP behavior changes
- `V2` event-writing scope changes for canonical persistence

## What should be retested after redesign

- Project Overview action hierarchy and calmness
- Add Component flow and required type/value/unit shape
- Edit Component empty-state and no-dead-dropdown behavior
- Save Measurement single unit interaction
- Error state copy and sequence-failure disclosure
- Stale projection banner and route continuity
- Narrow-window/mobile behavior
- Language audit for banned over-promising wording

## Result and route

- Source capture result is complete and routed.
- Current pass: `V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS`.
- Next recommended pass: `V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_POST_AUDIT_PASS`.
- safe_for_post_audit: `YES`.
