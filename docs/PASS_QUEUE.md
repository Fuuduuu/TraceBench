# Pass Queue

## Current route

Current: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## First-read charter

Read `docs/POHIKIRI.md` before route, implementation, or audit decisions. If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human.

## Current docs-only amendment

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS` records the latest Claude audit supplied by the human:

- `AUDIT_VERDICT: BLOCKED`
- `SAFE_FOR_STAGING: NO`
- Reason: invisible production decoy widgets keep stale integration tests falsely green.

This amendment performs no runtime, test, or asset implementation. It freezes the existing unstaged four-file implementation diff at hash `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`, requires an empty cached diff, and expands only the next implementation pass allowlist.

The human visual/Figma gate remains accepted. `VISUAL-FIRST TECHNICIAN WORKBENCH` is a human-accepted English eyebrow and is outside this correction. True fullscreen remains intentional, and `lib/main.dart` remains excluded.

## Next implementation intent

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` must remove the hidden production compatibility anchors and align the three stale integration tests to the real visible launcher workflow.

The implementation must:

- remove `benchbeep_legacy_viewer_test_anchor`
- remove the invisible `TraceBench Viewer` widget
- remove `compatibilityLabel` and the invisible `Ava projekt` decoy behavior
- add no `Opacity(0)`, `Offstage`, `ExcludeSemantics`, invisible, or test-only production compatibility anchor
- update all three integration tests to assert real visible BenchBeep/Home content initially
- tap `Ava näidisprojekt`
- then tap the visible enabled `Jätka avatud projektiga` action
- expect `Project overview`
- preserve each test's existing destination assertions after `Project overview`

## Exact expanded implementation allowlist

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

If implementation needs any other file, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Preserved behavior and boundaries

- Preserve ZIP, folder, sample, project-open, Workbench, exit, asset, and route behavior.
- Do not weaken or delete any integration scenario.
- Do not accept hidden compatibility widgets as test coverage.
- Do not change routes, router, packages, fonts, shared theme, `lib/main.dart`, writers, schemas, events, facts, projections, Project ZIP semantics, or Board Canvas.
- Do not stage, commit, or push from this docs-only amendment.
