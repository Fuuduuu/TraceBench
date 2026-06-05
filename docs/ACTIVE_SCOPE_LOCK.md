# ACTIVE_SCOPE_LOCK.md

## Current pass

- Current pass: `TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_CLOSEOUT_PASS`
- Lane: `DOCS_SYNC`
- Mode: Docs-only closeout.
- Next recommended pass: `TRACEBENCH_POST_SOURCED_VALUES_SCOPE_ROUTE_REVIEW_PASS`

## Goal

Record the accepted and pushed `TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_PASS`, its Claude Code / Opus post-audit result, the small `CURRENT_STATE.md` self-loop fix, and the preserved non-canonical sourced-values / research-sidecar boundaries.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/TRACEBENCH_SOURCED_VALUES_AND_RESEARCH_SIDECAR_SCOPE_LOCK_CLOSEOUT_PASS.md`

## Forbidden surfaces

- No runtime code, Flutter runtime, tests, tools, schemas, validators, materializer, samples, assets, generated artifacts, tags, or release objects.
- No Project ZIP contract changes.
- No Board Canvas runtime changes.
- No Reference Images runtime changes.
- No AI/OCR/CV, URL import, source search, or event-writing implementation.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` changes.

## Evidence and product boundaries

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical event truth.
- `known_facts.json` remains a materialized projection.
- Sourced/reference/research/candidate values remain non-canonical sidecar concepts unless separately scoped and human-confirmed.
- They are not measurements, confirmed component facts, nets, diagnoses, probability claims, or Board Canvas evidence.
- Reference/research values may guide a technician but must visually rank below local human measurements and must not mutate canonical facts.

## Closeout notes

- The scope-lock pass was accepted/pushed.
- Claude Code / Opus post-audit returned `NEEDS_SMALL_PATCH` for a routing self-loop in `CURRENT_STATE.md` only.
- The two-line `CURRENT_STATE.md` route fix was applied and revalidated with `py -3 tools\validate_all.py`: PASS.
- Closeout routes to `TRACEBENCH_POST_SOURCED_VALUES_SCOPE_ROUTE_REVIEW_PASS` before implementation work.