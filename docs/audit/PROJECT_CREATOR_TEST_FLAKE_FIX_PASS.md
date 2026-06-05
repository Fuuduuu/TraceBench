# PROJECT_CREATOR_TEST_FLAKE_FIX_PASS

PASS_ID: `PROJECT_CREATOR_TEST_FLAKE_FIX_PASS`
Lane: `TEST_FIX / V1_1_RELIABILITY_PASS`
Mode: Narrow test-only implementation. No production code changes.

## MODEL_ROUTING_CHECK

PASS. Codex is the correct tool/model for this repo-local test-only implementation. Claude Code / Opus remains required afterward for post-audit and repeated reliability validation.

## Scope drift check

PASS. Changes are limited to:

- `test/unit/project_creator_test.dart`
- governance docs for pass routing and audit record

No production, tool, schema, materializer, sample, asset, Project ZIP, Board Canvas, Reference Images, generated artifact, tag, or release object surface is changed.

## Root cause fixed

The flake was caused by the test fake, not production `ProjectCreator`.

`_writeMaterializedKnownFacts(...)` previously returned `Future<void>` and was called from a synchronous fake process-runner behavior without awaiting it. The fake runner returned success before `known_facts.json` was guaranteed to exist, so production could read the file before the fake write completed under full-suite load.

## Implementation summary

- Changed `_writeMaterializedKnownFacts(...)` to synchronous `void`.
- Replaced async `writeAsString(...)` with `writeAsStringSync(..., flush: true)`.
- Kept the materializer fake call site synchronous.
- Added a regression assertion after successful `createProject` that `known_facts.json` exists.

## Regression assertion

The project-creation success test now checks:

- `known_facts.json` exists after `ProjectCreator.createProject(...)` returns `ProjectCreationSuccess`.

This makes future fake-materializer regressions deterministic instead of timing-dependent.

## Validation

- `flutter test test/unit/project_creator_test.dart --reporter expanded`: PASS (`7/7`)
- `flutter test --reporter expanded`: PASS
- repeated full-suite runs: PASS (`3` full-suite runs completed; final run reported `All tests passed`, `195` tests)
- `py -3 tools\validate_all.py`: PASS (`236` Python unittest tests; expected optional missing-photo warnings only)

## Forbidden-surface confirmation

- No production code changed.
- No `lib/shared/services/project_creator.dart` change.
- No materializer, schema, tools, samples, assets, Project ZIP, Board Canvas, Reference Images, V2, generated artifact, tag, or release-object change.
- `board_graph.json` and `view_state.json` remain forbidden artifacts.

## Next recommended pass

`PROJECT_CREATOR_TEST_FLAKE_FIX_POST_AUDIT_PASS`
