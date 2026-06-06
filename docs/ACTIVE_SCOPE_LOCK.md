# ACTIVE_SCOPE_LOCK.md

## Current pass

`TRACEBENCH_IDEALAB_RESIDUAL_PRODUCT_GUARDRAILS_PASS`

## Lane

`CODEX / DOCS_SYNC_PRODUCT_GUARDRAILS`

## Next recommended pass

`V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`

## Scope

Docs-only product/governance capture for residual Ideelabor technician-first guardrails before the post-helper route review.

Record guardrails only. Do not start implementation, V2 architecture, activity log work, save behavior, unit-chip behavior, source search, AI behavior, or runtime UI changes.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md`
- `docs/SOURCES_INDEX_CURRENT.md` only if pointer/source alignment is needed
- `docs/audit/TRACEBENCH_IDEALAB_RESIDUAL_PRODUCT_GUARDRAILS_PASS.md`

## Forbidden surfaces

- No runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, Project ZIP logic/contract, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, source search, URL import, datasheet parser, generated artifacts, assets, samples, platform folders, tags, or release objects.
- No event-writing, provider/project-data mutation, persistence, canonical field creation, or canonical fact creation.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` mutation.
- No activity log implementation.
- No real Save Measurement, Add Component, Edit Component, Run AI, Detect, Upload, confirm, promote, or apply behavior.
- No diagnosis, suspect ranking, probability/confidence claim, net inference, identity confirmation, or source/reference/candidate promotion to measured/canonical.

## Guardrails to preserve

- Activity timeline, if later scoped, must be compact/toggleable, non-dominant, user-facing, non-canonical, separate from `events.jsonl`, and separate from debug logs.
- Future post-save momentum may show confirmation, keep selected `Koht`, and suggest the next pin/point only as workflow aid after V2 event-writing architecture unlocks real save.
- Production core UI must stay local/offline-capable and must not require mandatory external resources such as Google Fonts.
- Prototype `localStorage` persistence is demo-only and must not be copied into production evidence workflow.
- Primary quick units remain V / Ω / Diode / Beep; A/current measurement stays behind `Lisainfo` / `Tehnilised detailid` / advanced affordance by default unless separately scoped.
- Estonian user-facing copy should stay technician-first and avoid schema/event/debug jargon.
- `CURRENT_STATE.md` remains compact; full detail belongs in audit docs and durable product memory.

## Validation

- `py -3 tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
