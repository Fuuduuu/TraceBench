# V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only QA plan. The later smoke run should be manual on Windows against the local app, real Python writer, real project folder, and real `events.jsonl`.

## Purpose

Create a precise manual Windows smoke-test plan for the accepted V2 Technician Workflow UI Consolidation.

This pass does not execute the smoke test.

## Accepted baseline

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS` is implemented, post-audited, accepted, committed, pushed, and closed out.

Accepted UI result:

- Save Measurement, Add Component, and Edit Component visible workflows were consolidated.
- Technician-first flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`.
- Success messages are shorter and clearer: `Salvestatud.`, `Lisatud.`, `Muudetud.`.
- Stale-projection messages are more consistent.
- Writer/event technical details are behind progressive disclosure.
- Hints/candidates/templates/photos/AI context remain visually subordinate and non-canonical.
- Writer adapters unchanged.
- Event construction semantics unchanged.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- No validator/materializer/schema/Project ZIP/Board Canvas/Reference Images/AI/OCR/CV changes.

Route review result: `V2_POST_UI_CONSOLIDATION_ROUTE_REVIEW_PASS` recommended a manual smoke-test plan before any cleanup or new feature track.

## Preconditions

- Windows desktop environment is available.
- TraceBench repository is available at `C:\Users\Kasutaja\Desktop\TraceBench`.
- Flutter desktop app can be launched locally.
- Python writer path is available through the app's normal writer-service integration.
- Use a disposable local project folder outside tracked repo samples.
- Do not use a repo sample directory as the writable smoke target.
- Do not commit, push, tag, or modify release objects during the smoke run.

## Test project setup

Create or choose a disposable project folder before the run pass. Recommended location:

```powershell
$SmokeRoot = Join-Path $env:USERPROFILE 'Desktop\TraceBench_ui_consolidation_smoke'
$Project = Join-Path $SmokeRoot 'ui_consolidation_project'
New-Item -ItemType Directory -Force $SmokeRoot | Out-Null
```

Use the app's normal project creation/loading flow to create or load the smoke project at `$Project`.

Before each write-flow check, identify:

- project directory path;
- `events.jsonl` path;
- whether `known_facts.json` exists;
- absence of `board_graph.json` and `view_state.json`.

## Required Windows commands

Run from PowerShell with `$Project` set to the loaded smoke project directory.

Capture baseline state immediately before each valid submit:

```powershell
$Events = Join-Path $Project 'events.jsonl'
$KnownFacts = Join-Path $Project 'known_facts.json'
$BoardGraph = Join-Path $Project 'board_graph.json'
$ViewState = Join-Path $Project 'view_state.json'
$BeforeLines = @(Get-Content $Events | Where-Object { $_.Trim() })
$BeforeCount = $BeforeLines.Count
$BeforeEventsHash = (Get-FileHash $Events -Algorithm SHA256).Hash
$BeforeKnownFactsHash = if (Test-Path $KnownFacts) { (Get-FileHash $KnownFacts -Algorithm SHA256).Hash } else { '<missing>' }
$BeforeBoardGraphExists = Test-Path $BoardGraph
$BeforeViewStateExists = Test-Path $ViewState
```

Capture after state after the app reports success:

```powershell
$AfterLines = @(Get-Content $Events | Where-Object { $_.Trim() })
$AfterCount = $AfterLines.Count
$AfterEventsHash = (Get-FileHash $Events -Algorithm SHA256).Hash
$AfterKnownFactsHash = if (Test-Path $KnownFacts) { (Get-FileHash $KnownFacts -Algorithm SHA256).Hash } else { '<missing>' }
$AfterBoardGraphExists = Test-Path $BoardGraph
$AfterViewStateExists = Test-Path $ViewState
$LastEvent = $AfterLines[-1] | ConvertFrom-Json
$LastEvent | ConvertTo-Json -Depth 30
```

Expected per successful non-idempotent submit:

```powershell
$AfterCount -eq ($BeforeCount + 1)
$AfterBoardGraphExists -eq $false
$AfterViewStateExists -eq $false
$AfterKnownFactsHash -eq $BeforeKnownFactsHash
```

Expected per idempotent resubmit:

```powershell
$AfterCount -eq $BeforeCount
```

## Save Measurement checklist

1. Launch the app and load the disposable project.
2. From Project Overview, open Save Measurement / Measure Sheet.
3. Confirm technician-first copy renders: `Koht → Väärtus → Ühik → Salvesta`.
4. Confirm the save action is disabled until required human-entered location/value/unit inputs exist.
5. Enter a manual measurement using smoke-safe values, for example:
   - `Koht`: a real selectable point, pin, or point-to-point target in the project;
   - `Väärtus`: `0.1`;
   - `Ühik`: `Ω` or the current UI's equivalent ohm unit.
6. Capture baseline state with the commands above.
7. Submit once.
8. Confirm success copy appears only after writer success: `Salvestatud.`.
9. Confirm stale-projection message appears: `Projection stale until refresh.`.
10. Confirm `events.jsonl` gained exactly one event.
11. Confirm the appended event has `event_type = measurement_recorded`.
12. Confirm the event preserves:
    - `actor.type = human`;
    - `source.type = explicit_user_confirmation`;
    - `confirmation.confirmed = true`.
13. Confirm idempotent resubmit does not append another event and shows the idempotent variant.
14. Confirm `Tehnilised detailid` is collapsed by default.
15. Expand `Tehnilised detailid` and confirm writer copy plus `Event type: measurement_recorded`.
16. Confirm no forbidden wording appears: `verified`, `good`, `correct`, `detected`, `probability`, `diagnosis`, `fault ranking`.
17. Confirm narrow layout remains usable.

## Add Component checklist

1. Launch the app and load the disposable project.
2. From Project Overview, open Add Component.
3. Confirm technician-first copy renders: `Koht → Väärtus → Ühik → Lisa`.
4. Confirm the add action is disabled until required human-entered component fields and confirmation exist.
5. Enter smoke-safe values, for example:
   - component/location field: `SMK_ADD_001`;
   - display/name field: `Smoke component 001`;
   - type/package/unit-like field: `resistor` or the current UI's neutral component type value.
6. Confirm any template/package/helper context remains visually subordinate and does not appear as confirmed identity proof.
7. Capture baseline state with the commands above.
8. Submit once.
9. Confirm success copy appears only after writer success: `Lisatud.`.
10. Confirm stale-projection message appears: `Projection stale until refresh.`.
11. Confirm `events.jsonl` gained exactly one event.
12. Confirm the appended event has `event_type = component_created`.
13. Confirm the event preserves:
    - `actor.type = human`;
    - `source.type = explicit_user_confirmation`;
    - `confirmation.confirmed = true`.
14. Confirm idempotent resubmit does not append another event and shows the idempotent variant.
15. Confirm `Tehnilised detailid` is collapsed by default.
16. Expand `Tehnilised detailid` and confirm writer copy plus `Event type: component_created`.
17. Confirm no forbidden wording appears: `verified`, `good`, `correct`, `detected`, `probability`, `diagnosis`, `fault ranking`.
18. Confirm narrow layout remains usable.

## Edit Component checklist

1. Launch the app and load the disposable project.
2. Ensure an existing component is available. The component added in the Add Component smoke check may be used after the app can select it.
3. From Project Overview, open Edit Component.
4. Confirm technician-first copy renders: `Koht → Väärtus → Ühik → Muuda`.
5. Confirm the edit action is disabled until an existing component is selected and human-confirmed changes exist.
6. Select an existing component and enter a smoke-safe edit, for example:
   - existing component: `SMK_ADD_001`;
   - updated display/name field: `Smoke component 001 edited`;
   - reason/context field: `manual UI consolidation smoke`.
7. Confirm any template/package/helper context remains visually subordinate and does not appear as confirmed identity proof.
8. Capture baseline state with the commands above.
9. Submit once.
10. Confirm success copy appears only after writer success: `Muudetud.`.
11. Confirm stale-projection message appears: `Projection stale until refresh.`.
12. Confirm `events.jsonl` gained exactly one event.
13. Confirm the appended event has `event_type = component_updated`.
14. Confirm the event targets an existing component and does not create a new component.
15. Confirm the event preserves:
    - `actor.type = human`;
    - `source.type = explicit_user_confirmation`;
    - `confirmation.confirmed = true`.
16. Confirm idempotent resubmit does not append another event and shows the idempotent variant.
17. Confirm `Tehnilised detailid` is collapsed by default.
18. Expand `Tehnilised detailid` and confirm writer copy plus `Event type: component_updated`.
19. Confirm no forbidden wording appears: `verified`, `good`, `correct`, `detected`, `probability`, `diagnosis`, `fault ranking`.
20. Confirm narrow layout remains usable.

## Failure-path checklist

Run at least one failure-path check for each flow without changing runtime code.

Recommended non-invasive failure path: attempt the flow with no loaded project folder or an invalid/missing project path if the UI exposes that state naturally.

For each flow:

1. Capture baseline `events.jsonl` state if an events file exists.
2. Attempt submit with the missing/invalid project state.
3. Confirm a clear not-saved message appears.
4. Confirm no success message appears.
5. Confirm `events.jsonl` is unchanged.
6. Confirm `board_graph.json` and `view_state.json` are not created.
7. Confirm the UI does not suggest that a fact was saved, verified, diagnosed, or inferred.

If Python-unavailable testing is chosen instead, keep it reversible and document exactly how Python availability was restored. Do not make system-wide Python changes without an explicit run-pass decision.

## Boundary checklist

For every successful and failed flow:

- Only `events.jsonl` is appended by the write flow.
- `known_facts.json` is not directly rewritten by the UI flow.
- `board_graph.json` is not created.
- `view_state.json` is not created.
- Project ZIP is not written.
- Save Measurement creates only `measurement_recorded`.
- Add Component creates only `component_created`.
- Edit Component creates only `component_updated`.
- No direct Flutter append to `events.jsonl` is observed; the write completes only through the accepted writer service.
- Hints, candidates, templates, photos, and AI context remain hint/context only and non-canonical.

## Expected evidence to paste into the RUN pass

For each flow, paste:

- screenshot or notes showing the target screen was reached from Project Overview;
- visible technician-first copy;
- disabled action state before required inputs;
- success or not-saved copy;
- stale-projection message after success;
- `Tehnilised detailid` collapsed-by-default observation;
- expanded `Tehnilised detailid` writer copy and event type;
- before/after event counts;
- last appended event JSON excerpt with `event_type`, `actor.type`, `source.type`, `confirmation.confirmed`, and target fields;
- idempotent resubmit before/after count;
- forbidden-wording scan result;
- boundary artifact checks for `known_facts.json`, `board_graph.json`, `view_state.json`, and Project ZIP.

## PASS criteria

The smoke run should pass only if all of the following are true:

- All three flows are reachable from Project Overview.
- All three technician-first copy strings render.
- Each action is disabled until required human input and confirmation exist.
- Each successful submit shows the expected success copy only after writer success.
- Each successful submit appends exactly one event of the expected type.
- Every written event preserves human actor, explicit user confirmation source, and confirmed confirmation fields.
- Idempotent resubmit does not duplicate local or file-backed events.
- Failure paths show not-saved outcomes and leave `events.jsonl` unchanged.
- Technical details are collapsed by default and disclose writer/event type only after expansion.
- No forbidden wording appears.
- Boundary artifacts remain absent or unchanged as specified.

## FAIL criteria

Fail the smoke run if any of the following occurs:

- A flow is not reachable from Project Overview.
- A valid submit writes the wrong event type.
- A valid submit appends more than one event.
- A failure path appends to `events.jsonl`.
- `actor.type`, `source.type`, or `confirmation.confirmed` are missing or wrong.
- UI claims verification, correctness, diagnosis, probability, or fault ranking.
- `known_facts.json` is directly rewritten by the UI flow.
- `board_graph.json` or `view_state.json` is created.
- Project ZIP output is written.
- Hints/candidates/templates/photos/AI context appears as canonical fact or identity proof.

## Cleanup/reset notes

- Keep the disposable smoke project until the RUN pass evidence is recorded.
- If rerunning, copy or archive the previous `events.jsonl` before another attempt.
- Do not reset repository state to clean the smoke project; the project should live outside tracked repo sample folders.
- If a Python-unavailable failure check was performed, restore normal Python availability before ending the RUN pass.

## Route decision

Current pass: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS`.

Next recommended pass: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_POST_AUDIT_PASS`.

Do not route directly to the smoke run until this plan is post-audited and committed.