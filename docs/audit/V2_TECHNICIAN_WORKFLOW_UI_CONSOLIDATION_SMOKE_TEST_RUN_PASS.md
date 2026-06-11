# V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for recording this repo-local docs-only QA run result. This pass records observed manual Windows smoke evidence and does not implement fixes.

## Scope drift check

PASS. This pass is docs-only. No runtime code, tests, writer service, schema, validator, materializer, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, assets, samples, generated files, platform files, tags, or releases are modified.

## Smoke environment used

Manual Windows GUI smoke was observed by the user against the local app context. Screenshots were provided in chat context.

The run did not produce successful all-flow evidence. This record does not claim PASS for exact writer append counts, event boundary checks, idempotency, or artifact boundary checks.

## Disposable project path

Not recorded in the provided evidence. Triage should identify the smoke project folder and inspect its `events.jsonl` before changing behavior.

## Save Measurement result

Result: FAIL.

Observed:

- Save Measurement / Lisa mõõtmine screen accepts entered values.
- Unit appears duplicated: dropdown plus unit buttons.
- Save button / save action does not successfully save.
- Error shown: `MeasurementWriteException: Existing events contain missing or non-integer sequence`.

Recorded interpretation:

- Save Measurement does not work in this smoke run.
- Do not claim `events.jsonl` append PASS.
- Do not claim idempotency PASS.
- Triage must inspect the smoke project `events.jsonl` and determine whether this is a setup/data issue or app/project-init/writer compatibility issue.

## Add Component result

Result: FAIL / PARTIAL.

Observed screen:

- Header: `Koht → Väärtus → Ühik → Lisa`.
- Fields shown:
  - `Koht / komponent`;
  - `Väärtus / nimi`;
  - `Ühik / liik`;
  - Reference designator hint;
  - Package hint;
  - Footprint hint;
  - Template ID hint;
  - Human note.

User finding:

- Labels are not appropriate for Add Component.
- Desired component-form fields should be closer to component type, numeric value, unit such as V/Ω, marking/text on the component in English, rail/function/belongs-to such as HDMI or 5V rail, and comment.
- The form is semantically confusing and over-applies the generic `Koht → Väärtus → Ühik` model.

Recorded interpretation:

- Add Component smoke cannot be accepted as PASS.
- Triage should refine component-specific form semantics while keeping hints non-canonical.

## Edit Component result

Result: FAIL.

Observed:

- Edit Component screen opens.
- Existing component dropdown / `Koht / olemasolev komponent` does not open or cannot be used.
- Project Overview showed all component counts as `0`.
- User could not select an existing component and could not save edits.

Recorded interpretation:

- This may be because Add Component did not create a component, so Edit has no existing component to select.
- The UI should show a clear empty state instead of an apparently dead dropdown.
- Edit Component smoke cannot be accepted as PASS.
- Triage must preserve the existing-component-only boundary.

## Measure Sheet UI result

Result: FAIL / PARTIAL.

Observed:

- Measure Sheet shows `Koht → Väärtus → Ühik → Salvesta`.
- Unit appears both as dropdown and button choices.
- Save action remains disabled or does not work as expected.

Recorded interpretation:

- Needs triage; not PASS.
- Triage should decide whether dropdown, unit buttons, or both should exist.

## Failure-path result

Result: PARTIAL.

Observed failure:

- Save Measurement produced a not-saved/error outcome: `MeasurementWriteException: Existing events contain missing or non-integer sequence`.

Not proven by provided evidence:

- `events.jsonl` unchanged after failure.
- `board_graph.json` / `view_state.json` unchanged after failure.

The failure is sufficient to route to triage, but it is not sufficient to claim boundary PASS.

## Boundary evidence status

Result: NOT ACCEPTED AS PASS.

Do not claim:

- writer/event boundary PASS;
- exact `events.jsonl` append count PASS;
- idempotency PASS;
- `known_facts.json` not-directly-rewritten PASS;
- `board_graph.json` absence PASS;
- `view_state.json` absence PASS;
- Project ZIP absence PASS.

Boundaries preserved by this run-record pass:

- No code or tests changed.
- No writer service changed.
- No schema/validator/materializer changed.
- No Project ZIP, Board Canvas, Reference Images, or AI/OCR/CV work opened.

## Overall smoke verdict

FAIL / PARTIAL.

No successful all-flow smoke evidence was obtained.

The correct next route is triage, not closeout.

## Triage targets

1. Add Component form semantics:
   - replace generic `Koht` / `Väärtus` / `Ühik` labels where inappropriate;
   - clarify component type, numeric value, unit, marking, rail/function/belongs-to, and comment distinctions;
   - ensure hints remain non-canonical.
2. Edit Component empty-state and selection:
   - distinguish “no components exist” from broken dropdown;
   - show clear empty state and route/action to Add Component where appropriate;
   - preserve existing-component-only boundary.
3. Save Measurement sequence failure:
   - inspect smoke project `events.jsonl`;
   - determine why writer reports missing or non-integer sequence;
   - distinguish setup/data issue from app/project-init/writer compatibility issue.
4. Save Measurement unit UI:
   - decide whether dropdown, unit buttons, or both should exist;
   - remove duplicated/confusing unit selection if needed.
5. Preserve canonical boundaries:
   - writer adapters unchanged unless a later scope lock explicitly allows investigation;
   - event construction semantics unchanged unless separately scoped;
   - no schema/validator/materializer changes in this RUN record pass.

## Route decision

Current pass: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`.

Next recommended pass: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`.