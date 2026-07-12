# Current State

Current pass: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
Next recommended pass: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Charter and baseline

`docs/POHIKIRI.md` is the canonical product charter. Conflicts stop for human decision.

Pushed baseline: `35314fc4de486b91c5730cb5fa99f12799674869` (`docs: lock memory routing and docs compaction`).

## Current docs-only compaction

This pass establishes effective project memory as:

```text
five default files + task-specific loading
```

Default read set:

1. `AGENTS.md`
2. `docs/POHIKIRI.md`
3. `docs/CURRENT_STATE.md`
4. `docs/PASS_QUEUE.md`
5. `docs/ACTIVE_SCOPE_LOCK.md`

All other memory, semantic, prompt/model, audit, source/design, map, protocol, spec, schema, archive, and implementation owners are task-specific / non-default.

The pass compacts active/stable docs, preserves unique durable truth through canonical pointers and historical audit/git owners, and corrects only evidence-backed audit-index drift. It changes no product/runtime semantics.

## Frozen Home implementation diff

The pre-existing unstaged Home diff remains exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

Binary diff hash: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

This pass must not change that file set or hash.

## Next Home implementation

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` remains armed for exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

The implementation must remove hidden production compatibility/test anchors, migrate all three integration tests to the real visible launcher workflow, preserve every scenario and destination assertion, and preserve ZIP/folder/sample/project-open/Workbench/exit/asset/route behavior.

## Boundaries

- No runtime, test, asset, schema, tool, route behavior, fullscreen, writer, event, fact, projection, Project ZIP, or protected semantic change.
- `docs/POHIKIRI.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/MODEL_ROUTING.md`, and `docs/MEMORY_MAINTENANCE.md` remain unchanged.
- Do not stage, commit, or push.

## Canonical pointers

- Active scope and exact allowlists: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue sequencing: `docs/PASS_QUEUE.md`
- Durable product/architecture memory: `docs/PROJECT_MEMORY.md` (on demand)
- Semantic owners: `docs/TRUTH_INDEX.md` (on demand)
- Audit lookup: `docs/AUDIT_INDEX.md` (on demand)
