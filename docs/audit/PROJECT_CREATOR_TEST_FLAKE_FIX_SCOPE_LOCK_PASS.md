# PROJECT_CREATOR_TEST_FLAKE_FIX_SCOPE_LOCK_PASS

PASS_ID: `PROJECT_CREATOR_TEST_FLAKE_FIX_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC / SCOPE_LOCK`
Mode: Docs-only scope lock. No code/test/tool/schema/materializer/sample/asset/tag changes.

## Inputs accepted

- `V1_1_POST_BOARD_CANVAS_POLISH_ROUTE_REVIEW_PASS` (AUDIT_ONLY) recommended fixing the recurring `project_creator_test.dart` Windows flake as the next pass (only confirmed correctness/CI-reliability defect; diagnosis already complete).
- Reference Images UX track and Board Canvas read-only visual polish track are accepted/pushed and complete for V1.1.

## Accepted root-cause diagnosis (test-only)

- The flake is **test-only**; production `ProjectCreator` is correct (it awaits its own writes).
- In `test/unit/project_creator_test.dart`, the fake process-runner's `behavior` callback is **synchronous** (`ProcessResult Function(...)`), but for the materializer branch it starts an **un-awaited** async write `_writeMaterializedKnownFacts(...)` (`Future<void>`) and returns `_ok('materialized')` immediately.
- `known_facts.json` is created **only** by that fire-and-forget write (the skeleton does not create it). Production then reads `known_facts.json` in `_loadCreatedProject` right after `await _pythonRunner.run(...)` resolves.
- Under full-suite parallel load the read can win the race → `known_facts.json` not yet present → `PathNotFoundException`/`FileSystemException`. Only the one test that exercises the materializer write path flakes; ~20% in the full suite, deterministic pass in isolation.

## Decision

- Lock `PROJECT_CREATOR_TEST_FLAKE_FIX_PASS` as the next implementation pass.
- Scope is a **test-only** fix that removes the read-before-write race. **Do not change production code.**

## Locked implementation to apply (next pass)

- Make the simulated materializer write complete **before** the fake `behavior` returns. Preferred minimal fix:
  - make `_writeMaterializedKnownFacts(...)` synchronous and use `File(path).writeAsStringSync(..., flush: true)`;
  - call it synchronously inside the materializer branch so the file exists/flushes before `_ok('materialized')` is returned.
  - (Equivalent alternative: change the `behavior` typedef to `Future<ProcessResult> Function(...)`, make the callback `async`, and `await` the write. Either removes the race; pick one, do not do both.)
- Add a regression assertion after `createProject` success: `File('$projectPath/known_facts.json').existsSync()` is `true` (so a future regression fails deterministically, not racily).
- Optional, only if trivial: best-effort hardening of the temp-dir teardown delete (wrap in try/catch) — only if it does not expand scope.
- Do **not** change `lib/shared/services/project_creator.dart` or any other production file.

## Allowed implementation files (next pass)

- `test/unit/project_creator_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_CREATOR_TEST_FLAKE_FIX_PASS.md`

## Forbidden surfaces (next pass)

- No production code changes; specifically no `lib/shared/services/project_creator.dart` change.
- No materializer changes; no schema changes; no tools changes; no sample/assets changes.
- No Project ZIP changes; no Board Canvas changes; no Reference Images changes.
- No V2 work; no broad test refactor; no unrelated flake/lint cleanup.
- No `board_graph.json` / `view_state.json`; no tag/release-object mutation.

## Required validation (next pass)

- `flutter test test/unit/project_creator_test.dart --reporter expanded` (7/7).
- `flutter test --reporter expanded` (full suite green).
- Repeat the full suite several times if practical (e.g., 3–5 runs) to confirm the flake no longer appears.
- `py -3 tools\validate_all.py` (PASS).

## Validation (this scope-lock pass)

- `git status --short --branch`
- `git diff --name-only`

## Next recommended pass

`PROJECT_CREATOR_TEST_FLAKE_FIX_PASS` (lane `TEST_FIX_PASS`; Codex implements the test-only fix after this lock is accepted/pushed; Claude Code post-audit with repeated reliability runs before acceptance).
