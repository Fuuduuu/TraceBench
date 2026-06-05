# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_CREATOR_TEST_FLAKE_FIX_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for a **test-only** fix of the intermittent Windows full-suite flake in `test/unit/project_creator_test.dart`. Production `ProjectCreator` is correct and must not change.

## Accepted root cause (test-only)

The fake process-runner `behavior` is synchronous but starts an un-awaited async write of `known_facts.json` (`_writeMaterializedKnownFacts`) and returns immediately. `known_facts.json` is created only by that write; production reads it right after `run(...)` resolves. Under full-suite parallel load the read can precede the write → `PathNotFound` → intermittent failure of the one materializer test (~20%, passes isolated).

## Allowed docs surfaces (this pass)

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_CREATOR_TEST_FLAKE_FIX_SCOPE_LOCK_PASS.md`

## Locked implementation surfaces (next pass `PROJECT_CREATOR_TEST_FLAKE_FIX_PASS`)

- `test/unit/project_creator_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_CREATOR_TEST_FLAKE_FIX_PASS.md`

## Scope lock summary (what the next pass does)

- Make the fake materializer write complete before the fake `behavior` returns (preferred: synchronous `File(path).writeAsStringSync(..., flush: true)`; equivalent: async `behavior` that `await`s the write — pick one).
- Add a regression assertion after `createProject` success that `known_facts.json` exists.
- Optional only if trivial: best-effort temp-dir teardown hardening.
- No production change; the bug is entirely in the test fake.

## Forbidden surfaces (next pass)

- Production code of any kind; specifically `lib/shared/services/project_creator.dart`.
- Materializer, schema, tools, sample/assets, Project ZIP, Board Canvas, Reference Images.
- V2 work; broad test refactor; unrelated flake/lint cleanup.
- `board_graph.json` / `view_state.json`; tag/release-object mutation.

## Required validation (next pass)

- `flutter test test/unit/project_creator_test.dart --reporter expanded` (7/7).
- `flutter test --reporter expanded` (full suite green); repeat 3–5× if practical to confirm the flake is gone.
- `py -3 tools\validate_all.py` (PASS).

## Next recommended pass

`PROJECT_CREATOR_TEST_FLAKE_FIX_PASS`

## Validation (this scope-lock pass)

- `git status --short --branch`
- `git diff --name-only`
