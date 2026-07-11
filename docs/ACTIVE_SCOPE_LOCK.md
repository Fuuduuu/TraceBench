# Active Scope Lock

## Current pass

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS`

## Next recommended pass

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Lock state

Docs-only scope amendment is active. The active lock cannot override `docs/POHIKIRI.md`; conflicts stop for human decision.

No runtime, test, or asset implementation is permitted in this amendment. Do not stage, commit, or push.

## Current docs pass write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS.md`

## Frozen pre-existing implementation diff

Baseline `HEAD` and `origin/main` are `ace2750ad05d8c5df9ded4ffe7f9ef6a0ef68b5c` (`docs: lock benchbeep home startpage redesign`).

The pre-existing unstaged implementation diff is exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

Its pre-pass binary diff hash is `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`. The cached diff is empty. None of these four files may change during this docs-only amendment, and the same hash is required after all docs edits.

## Blocked audit and accepted human gates

The latest Claude audit supplied by the human is recorded as:

- `AUDIT_VERDICT: BLOCKED`
- `SAFE_FOR_STAGING: NO`
- Reason: invisible production decoy widgets keep stale integration tests falsely green.

The human visual/Figma gate remains accepted. `VISUAL-FIRST TECHNICIAN WORKBENCH` is a human-accepted English eyebrow and is not part of this correction. True fullscreen remains intentional, and `lib/main.dart` stays excluded.

## Armed implementation pass

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Exact armed implementation write allowlist

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

If implementation needs any other file, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation correction

- Remove `benchbeep_legacy_viewer_test_anchor`.
- Remove the invisible `TraceBench Viewer` widget.
- Remove `compatibilityLabel` and the invisible `Ava projekt` decoy behavior.
- Add no `Opacity(0)`, `Offstage`, `ExcludeSemantics`, invisible, or test-only production compatibility anchor.
- Update all three integration tests to real visible behavior.
- Use real visible BenchBeep/Home content for the initial launcher assertion.
- Tap `Ava näidisprojekt`.
- Then tap the visible enabled `Jätka avatud projektiga` action.
- Expect `Project overview`.
- Preserve each test's existing destination assertions after `Project overview`.
- Preserve ZIP, folder, sample, project-open, Workbench, exit, asset, and route behavior.

## Stop conditions

Stop instead of implementing if the work requires:

- any file outside the exact seven-file armed implementation allowlist
- weakening or deleting an integration scenario
- accepting a hidden compatibility widget as test coverage
- a route, router, page, package, font, shared-theme, persistence, fullscreen, or `lib/main.dart` change
- a writer, schema, validator, materializer, tool, event, fact, projection, Project ZIP, sample, or Board Canvas change
- importing, copying, or runtime-referencing `_incoming` content

## Protected boundaries still in force

- `events.jsonl` remains canonical truth; `known_facts.json` remains projection/cache.
- AI/helper may not author canonical facts or events.
- Board Canvas and project truth surfaces remain unchanged.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Future implementation validation

- `dart format lib/features/home/screens/benchbeep_home_screen.dart lib/app/app.dart test/widget/benchbeep_home_screen_test.dart test/integration/pelle_sample_end_to_end_test.dart test/integration/board_graph_end_to_end_test.dart test/integration/photo_list_end_to_end_test.dart`
- `flutter test test/widget/benchbeep_home_screen_test.dart`
- `flutter test test/integration/pelle_sample_end_to_end_test.dart`
- `flutter test test/integration/board_graph_end_to_end_test.dart`
- `flutter test test/integration/photo_list_end_to_end_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Manual visual/Figma acceptance remains recorded; the test-integrity correction must not be used to claim a new manual visual pass.

## Route

Current: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`
