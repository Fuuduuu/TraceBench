# ACTIVE_SCOPE_LOCK.md

## Current pass

`GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`

## Lane

`CODEX / DOCS_SYNC_QA_RUN`

## Next recommended pass

`V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS`

## Scope

Docs-only manual smoke record for the consolidated read-only technician-first Measure Sheet surface.

Record the user-performed Windows smoke result for:

- read-only Measure Sheet shell,
- Reference Values Panel,
- Guided Measurement Helper.

Smoke verdict: `PASS`.

Do not route directly to V2 implementation, real Save/Add/Edit, Activity Timeline implementation, Measure Momentum implementation, or polish by default.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/GUIDED_MEASUREMENT_FLOW_SMOKE_PASS.md`

## Forbidden surfaces

- No runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, Project ZIP logic/contract, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, source search, URL import, datasheet parser, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.
- No event-writing, provider/project-data mutation, persistence, canonical field creation, or canonical fact creation.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` mutation.
- No activity log implementation.
- No real Save Measurement, Add Component, Edit Component, Run AI, Detect, Upload, confirm, promote, apply, or source-search behavior.
- No diagnosis, suspect ranking, probability/confidence claim, net inference, identity confirmation, or source/reference/candidate promotion to measured/canonical.

## Recorded smoke result

- App launched: PASS.
- Project Overview navigation to Measure Sheet: PASS.
- Measure Sheet route opens: PASS.
- Read-only shell intact: PASS.
- Disabled/non-writing `Salvesta` button remains disabled: PASS.
- Reference Values Panel visible and display-only: PASS.
- Guided Measurement Helper card visible: PASS.
- Five neutral helper prompts visible: PASS.
- Forbidden copy absent: PASS.
- No write affordance: PASS.
- No event-writing implication: PASS.
- No green/success/verified styling: PASS.
- Helper looks like guidance, not conclusion: PASS.
- Narrow-window usable: PASS.
- Selected `Koht` / context visible: PASS.
- Blocking issues: none.

## Boundary preservation

- Human is the sensor. AI is the graph engine.
- AI/helper may suggest, organize, and surface gaps only.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference/source/candidate/note values remain non-canonical and must not look measured.
- Guided Measurement remains read-only and must not diagnose, rank, infer, or probabilize.
- Reference Values Panel remains display-only.
- Measure Sheet shell remains read-only.
- V2 event-writing remains deferred until explicitly scoped.

## Validation

- `py -3 tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
