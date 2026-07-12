# Active Scope Lock

## Current pass

`TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS`

## Route

Current: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
After compaction: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Current lock state

Docs-only route and scope lock. No documentation compaction, runtime/test/asset implementation, staging, commit, or push is permitted in this pass.

The active lock cannot override `docs/POHIKIRI.md`; conflicts stop for human decision.

## Current scope-lock write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS.md`

No other file may change in this scope-lock pass.

## Frozen Home implementation diff

Baseline `HEAD` and `origin/main`: `a789bd09c61f85fde3a28fb1de5b768d8e00866a` (`docs: expand home redesign test integrity scope`).

The pre-existing unstaged Home diff is exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

Binary diff hash: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

The same four-file set and hash are required after this scope-lock pass and after the compaction pass. The cached diff must remain empty.

## Armed compaction pass

`TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`

### Exact compaction write allowlist

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

If compaction requires any other file, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

### Locked compaction objective

- Make the default read set exactly:
  1. `AGENTS.md`
  2. `docs/POHIKIRI.md`
  3. `docs/CURRENT_STATE.md`
  4. `docs/PASS_QUEUE.md`
  5. `docs/ACTIVE_SCOPE_LOCK.md`
- Make stable memory, semantics, prompt/model, audit, source/design, map, spec, schema, and archive documents task-specific / non-default.
- Add `docs/POHIKIRI.md` directly after `AGENTS.md` in conflict order.
- Compact `docs/PROJECT_MEMORY.md` to durable truth only.
- Compact `docs/TRUTH_INDEX.md` to semantic boundaries and ownership pointers.
- Remove stale source-index restrictions without changing product or canonical semantics.
- Compact duplicated boundary prose in `docs/UI_WORKFLOWS.md`.
- Correct only stale `docs/AUDIT_INDEX.md` statuses verified by audit artifacts and git history.
- Keep active route docs compact.
- Create no prompt-pattern, archive, new spec, or new source-index document.
- Do not modify `docs/POHIKIRI.md`, `docs/PROMPTING_PROTOCOL.md`, or `docs/MODEL_ROUTING.md`.

### Compaction stop conditions

Stop if the work would:

- remove unique durable truth without a surviving owner
- move audit/pass history into active memory
- change product, event, writer, validator, materializer, projection, Project ZIP, UI, route, fullscreen, or protected semantics
- edit `lib/**`, `test/**`, `tests/**`, `tools/**`, `schemas/**`, `assets/**`, `pubspec*`, `windows/**`, or `_incoming/**`
- require a file outside the exact compaction allowlist
- change the frozen Home diff file set or hash

## Preserved Home implementation correction

After compaction, arm `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` with exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

The Home implementation must:

- remove hidden production test anchors, including the legacy viewer anchor and invisible compatibility copy
- update all three integration tests to the real visible launcher workflow
- preserve each integration scenario and its destination assertions
- preserve ZIP, folder, sample, project-open, Workbench, exit, asset, route, accepted visual/Figma, English-eyebrow, and fullscreen behavior
- keep `lib/main.dart` excluded

## Validation

For this scope-lock pass and the armed compaction pass:

- verify the frozen Home diff file set is unchanged
- verify the frozen Home binary diff hash is unchanged
- verify the cached diff is empty
- run `python tools/validate_all.py`
- run `git diff --check`
- run `git diff --name-status`
- run `git diff --cached --name-status`
- run `git status --short --branch`
