# V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock.

## Type

`scope-lock`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Purpose

Lock the future technician-first UI consolidation scope after accepted V2 Save Measurement, Add Component, and Edit Component flows.

This pass does not implement UI changes. It only defines future implementation boundaries, allowed surfaces, forbidden surfaces, test requirements, and routing.

## Accepted baseline

The three core V2 UI write flows are accepted:

- Save Measurement creates only `measurement_recorded`.
- Add Component creates only `component_created`.
- Edit Component creates only `component_updated`.

Future UI consolidation must preserve canonical event-writing behavior unchanged.

## Scope locked for future implementation

Future implementation may polish and unify the user-facing workflow for Save Measurement, Add Component, and Edit Component.

Locked product direction:

- technician-first workbench, not spreadsheet-first;
- core flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`;
- default UI remains simple and fast;
- technical/provenance/schema/event details stay behind progressive disclosure;
- hints, candidates, templates, photos, and AI context remain visually subordinate and non-canonical;
- not-saved, success, stale-projection, empty-state, and narrow-layout behavior should be consistent.

## Future implementation allowlist

- Minimal Measure Sheet / component flow UI files required for visual/workflow consolidation.
- Shared UI widgets/components if already in the project or minimally introduced.
- Focused widget tests for Save/Add/Edit UI behavior and layout states.
- Governance/audit docs.

## Future forbidden surfaces

- Event writer service behavior.
- Save Measurement / Add Component / Edit Component event construction semantics.
- Validator/materializer/schema.
- Project ZIP.
- Activity Timeline.
- Measure Momentum.
- Board Canvas write/edit.
- Reference Images runtime.
- AI/OCR/CV.
- Photo Markup / Repair Map / Visual Trace Shape Assist.
- Assets/samples/platform/generated/tags/releases.

## Test requirements for future implementation

- Save/Add/Edit still call the writer exactly as before.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- Not-saved messages remain clear and consistent.
- Success states remain clear and non-diagnostic.
- Stale-projection state remains visible where relevant.
- Hints remain visually subordinate.
- No forbidden wording: verified/good/correct/detected/probability/diagnosis/fault ranking.
- Empty states guide the user without creating facts.
- Narrow layout remains usable.
- No Project ZIP / Board Canvas / Reference Images / AI write path appears.

## Boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output does not author canonical events or facts.
- Hints/candidates/templates/photos/AI context remain non-canonical unless a separately scoped human-confirmed write flow creates an accepted event.
- UI polish must not change canonical event-writing behavior.

## Route decision

Current pass: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS`.

Next recommended pass: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_POST_AUDIT_PASS`.

Do not route directly to implementation before post-audit acceptance.

## Validation

Validation commands for handoff:

- `py -3 tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
