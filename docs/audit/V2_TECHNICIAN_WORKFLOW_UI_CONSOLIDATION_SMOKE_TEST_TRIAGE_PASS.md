# V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs triage and route decision. No runtime implementation, tests, writer service, schemas, validators, materializers, Project ZIP logic, Board Canvas, Reference Images, AI/OCR/CV, generated artifacts, platform files, tags, or releases are modified.

## Scope drift check

PASS. This pass records triage only and routes away from immediate fixes toward visual redesign capture/review. It does not implement UI fixes and does not reopen canonical event-writing behavior.

## Triage input

Manual Windows smoke result: `FAIL / PARTIAL`.

Already recorded smoke issues:

1. Add Component labels are semantically confusing because the generic `Koht -> Väärtus -> Ühik` framing over-applies measurement UI to component creation.
2. Edit Component opens but cannot be used when no components exist; the existing-component dropdown appears dead/unusable and no edit can be saved.
3. Save Measurement accepts values but fails with `MeasurementWriteException: Existing events contain missing or non-integer sequence`.
4. Measure Sheet unit UI is duplicated/confusing because unit appears both as dropdown and button/chip selection.
5. Boundary checks cannot be claimed PASS for this run.

## Triage decision

Do not route immediately to small bug fixes.

Rationale:

- The Add/Edit/Save smoke failures expose a broader interaction-model issue, not only isolated defects.
- The user wants broader visual UI redesign before implementation.
- Small patches now risk locking in the wrong UI model again.
- Visual design capture/review should establish the intended technician-first workbench before further Flutter implementation.

## New user UI direction recorded

### PCB-first Project Overview

- The Project Overview core should be the PCB board/schematic view.
- The initial screen should be visually clean.
- It should not start as a long button/action list.
- Components should be the main visible anchors.

### Component-context actions

- Clicking/tapping a component should open the local action menu.
- Measurement should appear after clicking/tapping a component.
- General settings/actions may also be accessible from the component/context menu.
- Measure remains central, but not as a permanently noisy global control.

### Clean default component map

- Component layout/schematic should be visually clean by default.
- Labels/markings should appear only when technician-confirmed.
- Filters may allow showing more information.
- Default UI should stay sparse until the user's eye adapts.

### Add/filter visibility

- Users can add/filter what they want to see.
- Default UI should not overwhelm with all layers and labels immediately.

### Component drawing/design idea

Future idea only:

- Allow technician to draw/design a component manually.
- Shape, number of pins/legs, and basic footprint could be defined manually.
- Optional component height may be recorded for physically taller components.
- Height is useful for capacitors and other tall components, but not needed for resistors, MOSFETs, etc.

### Onboarding / item outline

Future idea only:

- First screen could offer repair item outline/body contour setup.
- The outline and size could be created from a phone photo plus marker/reference scale.
- Manual drawing should also be considered for users who measure and draw the outline manually.

### Photo-grid decomposition

Future idea only:

- A second stage could divide the repair item / board into a grid.
- Each grid cell gets a corresponding close photo.
- This could improve the overall view by combining overview and close-up images.

### AI draft only

Future architecture only:

- AI may assemble a visual draft by comparing overview and close-up photos.
- AI may draw detected/possible components into the outline.
- If AI sees something but does not know what it is, it may place an unconfirmed component marker.
- AI output is always draft/unconfirmed.
- Human must confirm or deny each marker/component.
- Only confirmed markers/components become real/canonical.
- There should be a control to hide/remove all unconfirmed markers to view only confirmed components.
- Example use: user wants to inspect only HDMI-related path/area.

### Measurement after confirmation

- After components/markers are confirmed, measurement becomes more precise and contextual.

## Visual design artifact status

A standalone visual design HTML artifact exists in chat context:

`TraceBench UI Redesign - Visual Design Pass (standalone).html`

This pass does not capture the artifact contents into the repo. If Codex cannot access the chat artifact directly, the next pass must capture it from user-provided content. If capture is not possible, the fallback route is a fresh visual design pass.

## Deferred/future architecture items

The following are recorded as future design/architecture inputs only and are not implementation permission:

- PCB-first workbench overview.
- Component-context action menu.
- Sparse/default-confirmed component map with filters.
- Manual component drawing/design, including optional physical height.
- Outline/body-contour setup from photo plus marker/reference scale, with manual drawing option.
- Photo-grid decomposition for overview plus close-up image organization.
- AI visual draft/unconfirmed component-marker workflow.

Any AI/photo/grid/component-draft feature requires a separate future architecture/scope lock.

## Boundary preservation

- AI does not create canonical facts.
- Photo pixels are not facts.
- AI draft components are not real components until human confirmed.
- `visual_trace` is not a net.
- Component shape, height, footprint, template, photo, helper, candidate, and AI context are not electrical identity.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No writer-service behavior is changed.
- No validator, materializer, schema, Project ZIP, Board Canvas write/edit, Reference Images runtime, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist, asset/sample, generated artifact, platform, tag, or release surface is touched.

## Route decision

Current pass: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`.

Next recommended pass: `V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS`.

Fallback if the visual artifact cannot be captured yet: `V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_DESIGN_PASS`.

Do not route directly to small bugfix implementation, Add Component fix, Save Measurement sequence fix, or another Flutter implementation pass before visual redesign capture/review.

## Validation plan

Run:

1. `py -3 tools\validate_all.py`
2. `git diff --check`
3. `git status --short --branch`
4. `git diff --name-only`
