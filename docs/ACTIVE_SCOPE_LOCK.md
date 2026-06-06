# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS`
- Lane: `CODEX / DOCS_SYNC_ROUTE_RECORD`
- Mode: docs-only route-review record and compact routing update
- Next recommended pass: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`

## Goal

Record the accepted read-only route review after `GUIDED_MEASUREMENT_FLOW_SMOKE_PASS`, advance governance routing to V2 event-writing architecture scope lock, and fold in a small `CURRENT_STATE.md` compaction.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V1_1_POST_GUIDED_MEASUREMENT_FLOW_SMOKE_ROUTE_REVIEW_PASS.md`

## Read-only context

- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/MEMORY_PROTOCOL.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/MEMORY_MAINTENANCE.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/MODEL_ROUTING.md`
- relevant accepted guided-measurement and Ideelabor audit docs

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Accepted route-review decision

- `MODEL_ROUTING_CHECK`: PASS.
- Startup state: clean tracked tree; expected local untracked paths only.
- Governance route: self-loop-free.
- Guided Measurement smoke: accepted PASS.
- Read-only technician layer: complete enough to open V2 architecture scope lock.
- `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`: SELECT.
- `ACTIVITY_TIMELINE_SCOPE_LOCK_PASS`: defer with/after V2.
- `MEASURE_MOMENTUM_SCOPE_LOCK_PASS`: defer until V2 unlocks real save behavior.
- `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_POLISH_SCOPE_LOCK_PASS`: skip unless future NITs appear.
- Docs hygiene: fold light `CURRENT_STATE.md` compaction into this pass.

## V2 architecture scope-lock notes

The next architecture prompt should cover, at minimum:

- event schema/shape for new event types,
- append-only and immutable event semantics,
- correction-by-new-event,
- IDs and `origin_event_id` strategy,
- idempotency and double-submit guard,
- re-materialization / re-projection flow,
- validator extension,
- Project ZIP export/import implications,
- v1.0/v1.1 back-compat,
- human-authored events only,
- AI never authors canonical events/facts,
- `known_facts.json` remains projection,
- no `board_graph.json`,
- no `view_state.json`,
- no auto-promotion from visual_trace/template/photo/damage/suspect/reference/candidate into canonical facts.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage/suspect/source/research/reference/candidate/note values are not proof or probability.
- Guided Measurement remains read-only and must not diagnose, rank, infer, probabilize, confirm identity, or create canonical facts.

## Validation

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
