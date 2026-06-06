# ACTIVE_SCOPE_LOCK.md

## Current pass

`GUIDED_MEASUREMENT_FLOW_IMPL_PASS`

## Lane

`CODEX / FLUTTER_PASS`

## Next recommended pass

`GUIDED_MEASUREMENT_FLOW_IMPL_POST_AUDIT_PASS`

## Scope

Implement the accepted read-only Guided Measurement helper inside the existing Measure Sheet surface.

The helper may only suggest neutral next checks, show missing-reading prompts, surface gaps/conflicts between already-recorded human measurements, and remind that a human technician measures and decides.

## Write allowlist

- `lib/features/measure_sheet/**`
- `test/widget/measure_sheet_screen_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/GUIDED_MEASUREMENT_FLOW_IMPL_PASS.md`

## Forbidden surfaces

- No schemas, validators, tools, materializer behavior, Project ZIP logic/contract, assets, samples, generated artifacts, platform folders, tags, or release objects.
- No Board Canvas runtime changes.
- No Reference Images runtime or sidecar behavior changes.
- No AI/OCR/CV, source search, URL import, datasheet parser, or localStorage.
- No event-writing, provider/project-data mutation, persistence, canonical field creation, or canonical fact creation.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` mutation.
- No real Save Measurement, Add Component, Edit Component, Run AI, Detect, Upload, confirm, promote, or apply control.
- No diagnosis, suspect ranking, probability/confidence claim, net inference, identity confirmation, or source/reference/candidate promotion to measured/canonical.

## Implementation boundaries

- Human is the sensor. AI/helper is an organizer, not a fact creator.
- The Measure Sheet remains read-only/display-only.
- The Reference Values Panel remains display-only and non-canonical.
- Helper copy must remain neutral: next checks, missing readings, and gap/conflict prompts only.
- Reference/source/candidate/note values may guide measurement but must not become measured/canonical.
- No green/success styling may imply good, verified, correct, diagnosed, or confirmed.
- V2 event-writing architecture remains deferred.

## Required tests

- Helper suggestions render as read-only.
- Next-measurement prompts are neutral.
- Missing-reading prompts do not diagnose.
- Gap/conflict prompts do not rank faults or probabilities.
- The helper states it does not create canonical facts or change project data.
- Forbidden inference copy remains absent from rendered UI.
- Source-boundary guard rejects writer/storage/AI/probability/diagnosis tokens.
- Analyzer baseline must not regress beyond the 5 documented deferred residuals.

## Validation

- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat analyze`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test\widget\measure_sheet_screen_test.dart --reporter expanded`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
