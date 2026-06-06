# ACTIVE_SCOPE_LOCK.md

## Current pass

`V1_1_POST_MEASURE_SHEET_READONLY_SHELL_ROUTE_REVIEW_PASS`

## Lane

`CODEX / DOCS_SYNC_ROUTE_RECORD`

## Next recommended pass

`REFERENCE_VALUES_PANEL_IMPL_PASS`

## Scope

Docs-only route-review record for `V1_1_POST_MEASURE_SHEET_READONLY_SHELL_ROUTE_REVIEW_PASS`.

Record Claude Code / Opus route-review verdict `PASS`, preserve the accepted read-only Measure Sheet shell smoke result, and advance governance routing to `REFERENCE_VALUES_PANEL_IMPL_PASS` as the next selected display-only implementation track.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V1_1_POST_MEASURE_SHEET_READONLY_SHELL_ROUTE_REVIEW_PASS.md`

## Forbidden surfaces

- Runtime code and Flutter implementation files.
- Tests.
- Schemas, validators, tools, and materializer behavior.
- Project ZIP logic or contract.
- Board Canvas runtime or write/edit behavior.
- Reference Images runtime.
- AI/OCR/CV, source search, URL import, datasheet parser, or localStorage behavior.
- `events.jsonl`, `known_facts.json`, generated artifacts, assets, samples, platform folders, tags, or release objects.
- Real Measure Sheet Save Measurement, Add Component, Edit Component, event-writing, canonical fact creation, or persistence.

## Route decision

Selected next pass: `REFERENCE_VALUES_PANEL_IMPL_PASS`.

Reasons:

- Reference Values Panel scope is already locked, post-audited, and closed out.
- It is the highest-value, lowest-risk ready-now display-only implementation track.
- Guided Measurement remains deferred until the display layer is solid.
- V2 event-writing remains premature and protected-surface adjacent.

## Boundary risks to carry forward

- Future panel must be display-only and write nothing.
- It must read existing known-facts projection only and derive display labels only.
- It must not mutate `events.jsonl`, `known_facts.json`, `board_graph.json`, `view_state.json`, materializer output, Project ZIP contract, or Board Canvas evidence/write paths.
- Measured values must remain visually dominant.
- Reference/source, candidate, and note values must remain subordinate and labeled non-canonical.
- No green/verified/confirmed/correct/diagnosed styling.
- No AI fault diagnosis, fault probability, net inference, component identity confirmation, or probability-style claims.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`