# V1 Release Candidate Scope (BoardFact)

## Purpose

Lock the V1 release-candidate boundary after release-readiness audit and drift cleanup.
This is a scope contract, not a feature implementation pass.

## V1 includes

- Event-backed Known Facts Builder.
- `events.jsonl` canonical event log.
- Event schema + validator enforcement.
- Accepted-only `known_facts` materializer projection.
- `known_facts` schema support.
- Dart KnownFacts read-only model support.
- Project ZIP import/export/validation local-first contract.
- Rejection of forbidden artifacts: `board_graph.json`, `view_state.json`.
- Read-only Board Canvas route/navigation.
- `board_normalized` component placement rendering.
- Placement selector.
- Read-only inspector.
- Read-only measurement metadata summary.
- Read-only `visual_trace` metadata summary.
- Read-only photo-alignment readiness metadata panel.
- Read-only boardview visual polish.
- Evidence-class tags as labels only:
  - `MEASURED`
  - `VISUAL`
  - `READINESS`
  - `UNKNOWN`
- Positive board-canvas smoke fixture.
- Positive manual smoke PASS evidence.
- Required chrome: `renderer writes: none`.

## V1 excluded / deferred

- Background photo helper.
- Transform / matrix computation.
- Photo-local evidence board rendering.
- `visual_trace` / damage / suspect canvas geometry.
- Measurement canvas overlay geometry.
- Event-writing UI.
- Edit / confirm / save / apply / promote / detect controls.
- AI proposal / detection / candidate UI.
- Project ZIP contract expansion.
- `board_graph.json`.
- `view_state.json`.
- Persisted view state.
- `visual_trace` -> net promotion.
- `template_id` / footprint family -> electrical identity promotion.
- Damage / suspect -> fault proof.
- Fault-probability labels as truth.

## Locked evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` is canonical truth.
- `known_facts.json` is materialized projection.
- Renderer/view writes nothing.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- `visual_trace` is not a net.
- Damage is not fault proof.
- Suspect is not probability.
- `template_id` is package/geometry metadata only, not identity.

## V1 RC acceptance checklist

- Tracked working tree clean.
- `py -3 tools\validate_all.py` PASS.
- Flutter full test suite PASS.
- `tests.test_asset_sample_sync` PASS.
- `tests.test_project_zip` PASS.
- `tests.test_materialize_known_facts` PASS.
- `tests.test_validate_events_jsonl` PASS.
- Positive board-canvas smoke fixture present and valid.
- Positive manual smoke PASS recorded.
- No `board_graph.json` / `view_state.json` in repository.
- No evidence-boundary weakening.
- Docs current/next routing aligned.
- Known non-blocking warnings documented.

## Accepted non-blocking nits for V1 RC

- Optional-photo warning for `photos/top_backlight_001.jpg`.
- `validate_all.py` does not auto-validate `board_canvas_positive_smoke`.
- Hardcoded board substrate color accepted for V1.
- No V1 git tag yet.
- Local untracked IDE/platform artifacts remain untracked.

## V1.1+ candidates (separate scope lock + audit required)

- Transform computation scope.
- Background photo helper scope.
- Photo-local evidence overlay scope.
- `visual_trace` / damage / suspect canvas geometry scope.
- Measurement canvas overlay scope.
- Event-writing UI scope.
- AI proposal/detection UI scope.
- `validate_all.py` automatic validation for positive smoke fixture.
- Release tag/artifact workflow.
