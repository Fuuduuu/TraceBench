# Current State

Current pass: BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS
Next recommended pass: BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS

## First-read charter

`docs/POHIKIRI.md` is the tracked canonical product charter / first-read scope anchor.

If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Status

Docs-only scope amendment for the existing BenchBeep Home startup-page redesign implementation.

Verified baseline and frozen implementation state:

- `HEAD` and `origin/main` are `ace2750ad05d8c5df9ded4ffe7f9ef6a0ef68b5c` (`docs: lock benchbeep home startpage redesign`).
- The pre-existing unstaged implementation diff is exactly:
  - `lib/features/home/screens/benchbeep_home_screen.dart`
  - `lib/app/app.dart`
  - `test/widget/benchbeep_home_screen_test.dart`
  - `assets/brand/pcb_board.png`
- The cached diff is empty.
- The pre-pass implementation diff hash is `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.
- No current implementation, test, or asset file may change during this docs-only amendment; the same implementation diff hash is required after the pass.

## Blocked audit and accepted human gates

The latest Claude audit supplied by the human is recorded as:

- `AUDIT_VERDICT: BLOCKED`
- `SAFE_FOR_STAGING: NO`
- Reason: invisible production decoy widgets keep stale integration tests falsely green.

The human visual/Figma gate remains accepted and is not reopened by this test-integrity correction.

- `VISUAL-FIRST TECHNICIAN WORKBENCH` is a human-accepted English eyebrow and is not part of this correction.
- True fullscreen remains intentional.
- `lib/main.dart` remains excluded.

## Armed implementation correction

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` remains the next implementation pass and must:

- remove `benchbeep_legacy_viewer_test_anchor`
- remove the invisible `TraceBench Viewer` widget
- remove `compatibilityLabel` and the invisible `Ava projekt` decoy behavior
- add no `Opacity(0)`, `Offstage`, `ExcludeSemantics`, invisible, or test-only production compatibility anchor
- update all three stale integration tests to follow the real visible launcher workflow
- preserve the already accepted visual/Figma result and all project-loading behavior

## Expanded armed implementation allowlist

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

## Required integration-test workflow

Each of the three integration tests must:

1. assert real visible BenchBeep/Home launcher content initially
2. tap `Ava näidisprojekt`
3. tap the visible enabled `Jätka avatud projektiga` action
4. expect `Project overview`
5. preserve its existing destination assertions after `Project overview`

## Preserved behavior and boundaries

- Preserve ZIP, folder, sample, project-open, Workbench, exit, asset, and route behavior.
- Preserve the existing BenchBeep black/gold visual direction and runtime asset paths.
- Original design/provenance input remains input-only; no `_incoming` runtime dependency is permitted.
- No route, router, page, package, font, shared-theme, fullscreen, or `lib/main.dart` change.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics change unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Route

Current: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_TEST_INTEGRITY_SCOPE_AMENDMENT_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Canonical owner pointers

- Product charter / first-read scope anchor: `docs/POHIKIRI.md`
- Route state: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance ledger: `docs/AUDIT_INDEX.md`
- Stable project memory and facts: `docs/PROJECT_MEMORY.md`, `docs/TRUTH_INDEX.md`
- UI workflow policy: `docs/UI_WORKFLOWS.md`
- Protected surface rules: `docs/PROTECTED_SURFACES.md`
- Prompt/lifecycle/model-routing rules: `docs/PROMPTING_PROTOCOL.md`, `docs/PASS_LIFECYCLE.md`, `docs/MODEL_ROUTING.md`
