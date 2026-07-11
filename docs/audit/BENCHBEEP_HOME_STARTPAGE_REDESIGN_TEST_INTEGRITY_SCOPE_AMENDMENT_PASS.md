# BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS

## Pass contract

- PASS_ID: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS`
- Lane: `A`
- Type/mode: `DOCS_SYNC` / docs-only scope amendment
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- No runtime, test, or asset implementation.
- Do not stage, commit, or push.

## Charter and baseline

`docs/POHIKIRI.md` remains the first-read product charter and scope anchor.

Gate evidence before docs edits:

- `HEAD` and `origin/main`: `ace2750ad05d8c5df9ded4ffe7f9ef6a0ef68b5c` (`docs: lock benchbeep home startpage redesign`)
- expected pre-existing unstaged implementation diff:
  - `lib/features/home/screens/benchbeep_home_screen.dart`
  - `lib/app/app.dart`
  - `test/widget/benchbeep_home_screen_test.dart`
  - `assets/brand/pcb_board.png`
- cached diff: empty
- pre-pass implementation diff hash: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`
- post-pass implementation diff hash: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`

The four-file implementation diff is frozen for this docs-only amendment. No implementation, test, or asset file may change.

## Blocked audit recorded

The latest Claude audit supplied by the human is recorded exactly as:

- `AUDIT_VERDICT: BLOCKED`
- `SAFE_FOR_STAGING: NO`
- Reason: invisible production decoy widgets keep stale integration tests falsely green.

This pass does not reinterpret the blocked verdict as acceptance and does not authorize staging.

## Accepted human gates preserved

- The human visual/Figma gate remains accepted.
- The English eyebrow `VISUAL-FIRST TECHNICIAN WORKBENCH` is human-accepted and is not part of this correction.
- True fullscreen remains intentional.
- `lib/main.dart` stays excluded.
- This docs amendment does not claim a new manual visual pass.

## Live-code and test findings

- Home contains the hidden production key `benchbeep_legacy_viewer_test_anchor` and an invisible `TraceBench Viewer` widget.
- Home uses `compatibilityLabel` to expose an invisible `Ava projekt` decoy.
- The focused Home widget test only proves those decoys are not hit-testable; it does not remove them from production.
- `pelle_sample_end_to_end_test.dart`, `board_graph_end_to_end_test.dart`, and `photo_list_end_to_end_test.dart` still use the hidden legacy launcher copy/action instead of the real visible workflow.
- Hidden compatibility widgets are not acceptable test coverage.

## Current docs write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS.md`

## Expanded implementation allowlist

The next `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` is armed to write exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

No other implementation, test, asset, route, package, or shared-theme file is authorized.

## Locked correction requirements

The next implementation pass must:

1. remove `benchbeep_legacy_viewer_test_anchor`
2. remove the invisible `TraceBench Viewer` widget
3. remove `compatibilityLabel` and the invisible `Ava projekt` decoy behavior
4. add no `Opacity(0)`, `Offstage`, `ExcludeSemantics`, invisible, or test-only production compatibility anchor
5. update all three integration tests to real visible behavior
6. use real visible BenchBeep/Home content for the initial launcher assertion
7. tap `Ava näidisprojekt`
8. then tap the visible enabled `Jätka avatud projektiga` action
9. expect `Project overview`
10. preserve each test's existing destination assertions after `Project overview`

## Preserved behavior and boundaries

- Preserve ZIP, folder, sample, project-open, Workbench, exit, asset, and route behavior.
- Do not weaken or delete any integration scenario.
- Do not change routes, router, packages, fonts, shared theme, `lib/main.dart`, writers, schemas, events, facts, projections, Project ZIP semantics, or Board Canvas.
- Do not import or runtime-reference `_incoming` content.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Route after

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS`
-> `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Validation contract

- Confirm the frozen four-file implementation diff hash remains `7f4f129a9fbdbc6b22882a59dc25f8e271136d13` after all docs edits.
- Run `python tools/validate_all.py`.
- Run `git diff --check`.
- Run `git diff --name-status`.
- Run `git diff --cached --name-status` and require an empty cached diff.
- Run `git status --short --branch`.

## Audit disposition

This amendment is `DRAFTED / PENDING CLAUDE AUDIT`.

If Claude accepts this docs-only amendment, the only safe staging set is:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS.md`

Until that audit acceptance, `SAFE_FOR_STAGING: NO` remains in force.
