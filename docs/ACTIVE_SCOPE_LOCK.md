# ACTIVE_SCOPE_LOCK.md

## Current pass

`GUIDED_MEASUREMENT_FLOW_IMPL_CLOSEOUT_PASS`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Next recommended pass

`V1_1_POST_GUIDED_MEASUREMENT_FLOW_ROUTE_REVIEW_PASS`

## Scope

Docs-only closeout for accepted/pushed `GUIDED_MEASUREMENT_FLOW_IMPL_PASS` and Claude Code / Opus post-audit `ACCEPT_AS_IS`.

Record the read-only Guided Measurement helper implementation as accepted, record validation, preserve helper/evidence boundaries, and route to read-only post-helper route review.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/GUIDED_MEASUREMENT_FLOW_IMPL_CLOSEOUT_PASS.md`

## Forbidden surfaces

- No runtime code, tests, schemas, validators, tools, materializer behavior, Project ZIP logic/contract, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, source search, URL import, datasheet parser, generated artifacts, assets, samples, platform folders, tags, or release objects.
- No event-writing, provider/project-data mutation, persistence, canonical field creation, or canonical fact creation.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` mutation.
- No real Save Measurement, Add Component, Edit Component, Run AI, Detect, Upload, confirm, promote, or apply behavior.
- No diagnosis, suspect ranking, probability/confidence claim, net inference, identity confirmation, or source/reference/candidate promotion to measured/canonical.

## Boundary preservation

- Human is the sensor. AI/helper is an organizer, not a fact creator.
- Guided Measurement helper remains read-only and writes nothing.
- The helper has no callbacks that mutate project data, no provider mutation, no persistence path, and no event-writing behavior.
- The helper creates no canonical facts and does not mutate `known_facts.json`.
- The helper does not change materializer output or Project ZIP contract.
- The helper does not become Board Canvas evidence and does not use Reference Images sidecar as evidence/source.
- The helper does not use AI/OCR/CV, source search, URL import, datasheet parser, or localStorage.
- The helper does not diagnose faults, rank suspects, infer nets, confirm identity, or produce probability/likelihood/confidence/fault-probability claims.
- The helper does not promote reference/source/candidate/note values to measured/canonical.
- V2 event-writing architecture remains deferred.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
