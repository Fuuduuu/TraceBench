# Active Scope Lock

## Current pass and route

Current: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

Docs-only memory-routing/documentation compaction. No runtime, test, asset, staging, commit, or push action is permitted.

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Exact current write allowlist

- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/MEMORY_PROTOCOL.md`
- `docs/FILE_MAP.md`
- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/UI_WORKFLOWS.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS.md`

No other file may change.

## Locked compaction requirements

- Default read set becomes exactly:
  1. `AGENTS.md`
  2. `docs/POHIKIRI.md`
  3. `docs/CURRENT_STATE.md`
  4. `docs/PASS_QUEUE.md`
  5. `docs/ACTIVE_SCOPE_LOCK.md`
- All other memory, semantic, prompt/model, audit, source/design, map, protocol, spec, schema, archive, and implementation-owner material becomes task-specific / non-default.
- Conflict order begins `AGENTS.md`, `docs/POHIKIRI.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`.
- `docs/PROJECT_MEMORY.md` contains durable product/architecture truth only.
- `docs/TRUTH_INDEX.md` contains semantic invariants and canonical-owner pointers only.
- `docs/SOURCES_INDEX_CURRENT.md` is on-demand provenance intake only.
- `docs/UI_WORKFLOWS.md` remains concise and points canonical data/AI boundaries to `docs/TRUTH_INDEX.md`.
- Active route docs remain compact.
- `docs/AUDIT_INDEX.md` changes only for directly verified status corrections and this pass row.
- Create no prompt-pattern, archive, new spec, or new source-index file.

## Frozen Home diff

Pushed baseline: `35314fc4de486b91c5730cb5fa99f12799674869`.

Pre-existing unstaged files:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

Required binary diff hash before/after: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

## Next armed Home implementation

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` may write exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

Required correction:

- remove `benchbeep_legacy_viewer_test_anchor` and the invisible `TraceBench Viewer` widget
- remove `compatibilityLabel` and invisible `Ava projekt` compatibility behavior
- add no hidden, invisible, offstage, excluded-semantics, opacity-zero, or test-only production anchor
- assert real visible BenchBeep/Home content initially in all three integration tests
- tap `Ava näidisprojekt`, then visible enabled `Jätka avatud projektiga`, then expect `Project overview`
- preserve each integration test's existing destination assertions
- preserve ZIP, folder, sample, project-open, Workbench, exit, asset, route, accepted visual/Figma, English-eyebrow, and fullscreen behavior
- keep `lib/main.dart` excluded

## Stop conditions

Stop if the work would:

- require a file outside the exact current allowlist
- remove unique durable truth without a surviving owner
- alter product/runtime/UI/writer/event/projection/schema/validator/materializer/Project ZIP/fullscreen/protected semantics
- edit `docs/POHIKIRI.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/MODEL_ROUTING.md`, or `docs/MEMORY_MAINTENANCE.md`
- edit `lib/**`, `test/**`, `tests/**`, `tools/**`, `schemas/**`, `assets/**`, `pubspec*`, `windows/**`, or `_incoming/**`
- change the frozen Home file set or hash
- weaken or delete a Home integration scenario

## Validation

- binary-safe Home diff hash comparison
- before/after line counts for changed docs
- `python tools/validate_all.py`
- `git diff --check`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git status --short --branch`
