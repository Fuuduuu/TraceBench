# ACTIVE_SCOPE_LOCK.md

## Current pass

`GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS`

## Lane

`CODEX / DOCS_SYNC_SCOPE_LOCK`

## Next recommended pass

`GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS`

## Scope

Docs-only scope lock for a future Guided Measurement Flow helper.

Lock a read-only helper that may suggest next measurements, show missing readings, surface gaps/conflicts, and organize neutral next-step prompts for the technician. This pass does not implement UI, tests, runtime behavior, event-writing, AI/OCR/CV, source search, schemas, tools, materializer behavior, Project ZIP behavior, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- No implementation code or tests in this pass.
- No Flutter runtime, runtime UI, Save Measurement runtime, Add Component runtime, Edit Component runtime, event-writing, canonical fact creation, canonical field creation, provider/project-data mutation, persistence, or file writes.
- No schemas, validators, tools, materializer behavior, Project ZIP logic/contract, Board Canvas runtime, Reference Images runtime or sidecar behavior.
- No AI/OCR/CV, source search, URL import, datasheet parser, localStorage, generated artifacts, assets, samples, platform folders, tags, or release objects.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` mutation.

## Implementation boundaries

- Future helper is read-only and writes nothing.
- Human is the sensor. AI/helper is an organizer, not a fact creator.
- Allowed future helper behavior: suggest next measurements from existing projection gaps, show missing measurements/readings for already-known selected components/pins/contexts, surface gaps/conflicts between already-recorded human measurements, organize read-only next-step prompts, and explain that a human technician must measure and decide.
- Allowed future phrasing direction includes `Mõõda järgmisena...`, `Lugem puudub...`, `Valitud kohas puudub mõõdetud väärtus...`, `Kaks lugemit erinevad...`, `Kontrolli uuesti...`, `Viide / Allikas on kontekst, mitte mõõtmine...`, and `Kandidaat on oletuslik kontekst, mitte tõend...`.
- Forbidden future phrasing includes `Fault is...`, `Likely fault...`, `Probability...`, `Confidence...`, `This net is...`, `Component confirmed...`, `AI detected...`, `Verified...`, `Good/correct/korras`, and `This proves...`.
- No green/success styling may imply verified, good, correct, diagnosed, or confirmed.
- Reference/source/candidate/note values may guide measurement but must not be promoted to measured/canonical.
- V2 event-writing architecture remains deferred.

## Future implementation allowlist

If selected later, `GUIDED_MEASUREMENT_FLOW_IMPL_PASS` should be limited to:

- `lib/features/measure_sheet/**`
- `test/widget/measure_sheet_screen_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/GUIDED_MEASUREMENT_FLOW_IMPL_PASS.md`

Any need to touch schemas, tools, materializer, Project ZIP, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL/source-search, assets/samples, platform folders, generated artifacts, or event-writing must stop and require a new protected-surface scope lock.

## Future test requirements

- Helper suggestions are read-only.
- Next-measurement prompts are neutral.
- Missing-measurement prompts do not diagnose.
- Gaps/conflicts do not rank faults or probabilities.
- No canonical fact creation.
- No event/known_facts writes.
- Forbidden inference copy remains absent.
- Source-boundary negative guard rejects writer/storage/AI/probability/diagnosis tokens.
- Analyzer baseline must not regress beyond the 5 documented deferred residuals.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
