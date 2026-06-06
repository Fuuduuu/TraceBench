# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`

## Lane

`CODEX / DOCS_SYNC_ROUTE_RECORD`

## Next recommended pass

`GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`

## Scope

Docs-only route-review record for the read-only `V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS` result.

Record the Claude Code / Opus route-review `PASS`, confirm the read-only technician-first Measure Sheet layer is complete enough for live smoke, and route to `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`.

Do not route directly to V2, activity timeline implementation, measure momentum implementation, or polish unless a future smoke finds NITs.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS.md`

## Forbidden surfaces

- No runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, Project ZIP logic/contract, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, source search, URL import, datasheet parser, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.
- No event-writing, provider/project-data mutation, persistence, canonical field creation, or canonical fact creation.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` mutation.
- No activity log implementation.
- No real Save Measurement, Add Component, Edit Component, Run AI, Detect, Upload, confirm, promote, apply, or source-search behavior.
- No diagnosis, suspect ranking, probability/confidence claim, net inference, identity confirmation, or source/reference/candidate promotion to measured/canonical.

## Route-review decision

- `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`: SELECT. Consolidated manual Windows smoke should verify the full read-only Measure Sheet surface before the high-risk V2 architecture decision.
- `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`: likely next big track after smoke; requires GPT Pro architecture-first plus Claude Code / Opus audit.
- `ACTIVITY_TIMELINE_SCOPE_LOCK_PASS`: defer and pair with V2.
- `MEASURE_MOMENTUM_SCOPE_LOCK_PASS`: defer until V2 unlocks real save.
- `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_POLISH_SCOPE_LOCK_PASS`: only if smoke finds NITs.
- Tiny docs hygiene: not needed.

## Future smoke checklist

- App launches.
- Project Overview navigation works.
- Measure Sheet route opens.
- Read-only shell remains intact.
- Disabled/non-writing `Salvesta` button remains disabled.
- Reference Values Panel is visible and display-only.
- Guided Measurement Helper card is visible.
- Five neutral helper prompts are visible: next measurement, missing reading, gap/conflict re-check, source/reference boundary, and candidate boundary.
- Forbidden diagnosis/probability/verified/confirmed/good/correct/AI-found/app-detected/net-confirmed/component-identified copy is absent.
- No active Save/Add/Edit/Apply/Confirm or event-writing implication appears.
- Copy says writes nothing and human technician measures and decides.
- No green/success/verified styling appears for helper prompts.
- Helper looks like guidance, not conclusion.
- Narrow-window behavior remains usable.
- Selected `Koht` / context remains visible.

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
- V2 event-writing remains deferred until explicitly scoped.

## Validation

- `py -3 tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
