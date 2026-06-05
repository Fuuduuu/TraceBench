# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_CREATOR_TEST_FLAKE_FIX_CLOSEOUT_PASS`

## Goal

Docs-only closeout for the accepted test-only fix of the intermittent Windows full-suite flake in `test/unit/project_creator_test.dart`. Record the accepted implementation and Claude Code / Opus post-audit result without modifying code, tests, tools, schemas, materializers, samples, assets, generated artifacts, tags, or release objects.

## Accepted implementation being closed out

- `PROJECT_CREATOR_TEST_FLAKE_FIX_PASS` is accepted/pushed.
- Production `ProjectCreator` was not changed.
- `_writeMaterializedKnownFacts(...)` was made synchronous in the test fake.
- Async `writeAsString(...)` was replaced with `writeAsStringSync(..., flush: true)`.
- The fake materializer runner path remains synchronous.
- The fake runner can no longer return before `known_facts.json` is written.
- A post-success regression assertion confirms `known_facts.json` exists.

## Accepted post-audit result

- `PROJECT_CREATOR_TEST_FLAKE_FIX_POST_AUDIT_PASS`: `ACCEPT_AS_IS`.
- Scope drift: PASS.
- Targeted project creator test: PASS (`7/7`).
- Full Flutter suite repeated: PASS (`5/5` runs).
- `py -3 tools\validate_all.py`: PASS.
- Forbidden surfaces clean.

## Allowed docs surfaces (this pass)

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_CREATOR_TEST_FLAKE_FIX_CLOSEOUT_PASS.md`

## Forbidden surfaces (this pass)

- No code changes.
- No test changes.
- No tools, schemas, materializer behavior, samples, assets, generated artifacts, tags, or release objects.
- No analyzer cleanup.
- No measurement write assertion fix.
- No docs compaction.
- No commercial/licensing work.
- No V2 implementation.
- No production `ProjectCreator` changes.
- No `board_graph.json` or `view_state.json`.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical event truth.
- `known_facts.json` remains the materialized projection.
- Renderer/view writes nothing unless separately scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- No canonical fact, event-writing, Board Canvas, Reference Images, Project ZIP, schema, or materializer boundary changes are in scope.

## Required validation (this pass)

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools\validate_all.py`

## Next recommended pass

`V1_1_POST_TEST_RELIABILITY_ROUTE_REVIEW_PASS`
