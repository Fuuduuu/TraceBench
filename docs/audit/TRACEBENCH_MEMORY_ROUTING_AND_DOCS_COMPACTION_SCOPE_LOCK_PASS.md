# TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS

## Pass contract

- PASS_ID: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS`
- Lane: `A`
- Type/mode: `DOCS_SYNC` / docs-only route and scope lock
- Status: `DRAFTED / PENDING CLAUDE AUDIT`
- No documentation compaction in this pass.
- No runtime, test, asset, staging, commit, or push action.

## Charter and baseline

`docs/POHIKIRI.md` remains the first-read product charter and scope anchor.

Gate evidence before edits:

- `HEAD` and `origin/main`: `a789bd09c61f85fde3a28fb1de5b768d8e00866a` (`docs: expand home redesign test integrity scope`)
- cached diff: empty
- tracked unstaged diff: exactly the four frozen Home implementation files
- no leftover documentation changes from the blocked direct compaction attempt
- `git diff --check`: exit 0 with line-ending warnings only

## Blocked direct attempt recorded

The direct `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS` attempt stopped before edits because its PASS_ID and requested write surface were not named or authorized in the live route/scope docs.

That stop preserved repo-docs-first authority. This pass supplies the missing bounded route and scope lock; it does not perform the compaction itself.

## Current scope-lock write set

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS.md`

## Frozen Home implementation evidence

Files before this scope-lock pass:

- `assets/brand/pcb_board.png`
- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

Binary diff hash before: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

Files after: the same four-file set listed above.

Binary diff hash after: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

The same four-file set/hash is required throughout the scope lock and compaction passes.

## Armed compaction write set

`TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS` may write exactly:

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

## Locked compaction outcome

- Default read set becomes exactly `AGENTS.md`, `docs/POHIKIRI.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md`.
- All other stable memory, semantic, prompt/model, audit, source/design, map, spec, schema, and archive owners become task-specific / non-default.
- Conflict order places `docs/POHIKIRI.md` immediately after `AGENTS.md`.
- `PROJECT_MEMORY` becomes durable truth only.
- `TRUTH_INDEX` becomes a compact semantic-boundary and ownership index.
- Stale source-index restrictions and duplicate UI-workflow boundary prose are removed or replaced with canonical pointers.
- Only verified stale audit-index statuses may be corrected.
- Active route docs remain compact.
- No prompt-pattern, archive, new spec, or new source-index file is created.

## Preserved downstream Home correction

After compaction, route immediately to `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` with exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`

The implementation must remove hidden production test anchors, migrate all three integration tests to the visible launcher workflow, preserve every integration scenario, and preserve ZIP/folder/sample/project-open/Workbench/exit/asset/route behavior.

## Protected boundaries

- No actual compaction occurs in this scope-lock pass.
- `AGENTS.md`, memory/truth/source/map/UI workflow docs, `docs/POHIKIRI.md`, `docs/PROMPTING_PROTOCOL.md`, and `docs/MODEL_ROUTING.md` remain untouched here.
- No runtime, test, asset, package, route, fullscreen, writer, schema, event, fact, projection, Project ZIP, Board Canvas, or `_incoming` change.
- Nothing is staged, committed, or pushed.

## Route

`TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS`
-> `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
-> `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Validation

- Home diff file set/hash after: PASS; unchanged four-file set and `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`
- cached diff: PASS; empty
- `python tools/validate_all.py`: PASS; 285 tests
- `git diff --check`: PASS; line-ending warnings only
- exact changed-file scope: PASS; four tracked route/index docs plus the new scope-lock audit artifact, alongside the untouched pre-existing four-file Home diff

## Safe staging set

Only if a read-only audit accepts this pass:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS.md`

Until audit acceptance: `SAFE_FOR_STAGING: NO`.
