# ACTIVE_SCOPE_LOCK.md

## Current pass

`TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for a future local-first, non-canonical sourced values / research sidecar. This pass defines safe boundaries for source/reference/research/candidate values that may guide repair technicians but must not become canonical facts unless a human later confirms through a separately scoped measurement/event-writing workflow.

## Allowed files

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/CURRENT_STATE.md`
- `docs/audit/TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS.md`

## Allowed scope-lock actions

- Define the future sourced/reference/research/candidate-value sidecar concept as local-first and non-canonical.
- Lock sourced/reference/research/candidate values below local human measurements in visual hierarchy.
- Lock that these values may guide technician decisions but are not measurements, nets, component facts, diagnoses, probabilities, or Board Canvas evidence.
- Preserve technician-first direction: `Koht -> Väärtus -> Ühik -> Salvesta`.
- Preserve existing WORK_INTAKE items WI-006, WI-007, and WI-008.
- Preserve deferred implementation boundaries for OCR/CV, AI integration, source search, next-best-measurement, cloud sync, event writing, and prototype-to-production shortcuts.
- Record future pass split without starting implementation.

## Sourced values / research sidecar boundaries

Allowed future conceptual content only:

- local research notes
- user-entered source values
- datasheet-derived reference values
- service-note values
- board marking notes
- technician prior-knowledge notes
- candidate values to help decide what to measure next
- possible future reference-values panel that visually distinguishes measured, reference, candidate, and note values

Mandatory boundaries:

- Research/source/reference/candidate values are non-canonical.
- They are not measurements.
- They are not confirmed component facts.
- They are not nets.
- They are not fault diagnoses.
- They are not probability claims.
- They must visually rank below local human measurements.
- They must not look measured.
- They may guide the technician, but must not mutate `events.jsonl`.
- They must not mutate `known_facts.json`.
- They must not affect materializer output.
- They must not become Board Canvas evidence rendering.
- They must not change Project ZIP contract.
- They must not be used by AI/OCR/CV.
- Any future promotion path requires a separately scoped human-confirmed measurement/event-writing workflow.

## AI / helper boundary

Allowed future helper direction:

- suggest next measurements,
- organize accepted context,
- surface gaps/conflicts,
- summarize confirmed facts.

Forbidden helper drift:

- create canonical facts,
- diagnose faults,
- infer nets,
- confirm component identity,
- produce probability-style fault claims.

## BoardFact Measure Sheet prototype rule

The prototype `BoardFact Measure Sheet example.html` is visual/product workflow input only, not production source. Before any UX design or implementation pass that tries to reproduce it, require the user to provide HTML, CSS, JS, screenshots or screen recording if available, and whether behavior should be preserved or only visual direction.

## Forbidden surfaces

- No implementation code.
- No tests.
- No Flutter runtime changes.
- No tools, validators, schemas, or materializer changes.
- No samples, assets, platform folders, generated artifacts, tags, or release-object changes.
- No Project ZIP inclusion/exclusion behavior change.
- No Board Canvas runtime change.
- No Reference Images runtime change.
- No runtime sidecar implementation.
- No event-writing implementation or architecture beyond boundary statements.
- No `events.jsonl` or `known_facts.json` change.
- No `board_graph.json` or `view_state.json`.
- No datasheet parser, URL downloader, web scraper, AI source search, OCR/CV, public upload, cloud sync, resource-pack implementation, or licensing/commercial implementation.
- No real Save Measurement / Add Component / Edit Component before `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`.
- No prototype-to-production shortcut from `BoardFact Measure Sheet example.html`.
- No fault diagnosis, net inference, component identity confirmation, or probability-style fault claims.
- No promotion of damage/suspect/source/research into proof.
- No treating photo pixels or photo alignment as facts.

## Future pass split recorded

1. `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS` - display distinction between measured, reference, candidate, and note values.
2. `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS` - Claude Design / UX critique; requires full prototype bundle first.
3. `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS` - safe helper suggestions, missing measurements, and conflicts; no diagnosis or fact creation.
4. `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS` - required before real Save Measurement / Add Component / Edit Component behavior.
5. `QUICK_MEASUREMENT_SHEET_IMPLEMENTATION_PASS` - only after V2 event-writing architecture and UX design are accepted.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- Confirm no non-doc files changed.
- Confirm no implementation started.
- Confirm no current/next route conflict.
- Confirm `AUDIT_INDEX.md` contains the new pass row.

## Next recommended pass

`TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_POST_AUDIT_PASS`
