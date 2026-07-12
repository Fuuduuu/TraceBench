# Current State

Current pass: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
After compaction: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## First-read charter

`docs/POHIKIRI.md` remains the canonical product charter and first-read scope anchor. If a task conflicts with it, stop and ask the human.

## Status

This is a docs-only route and scope lock. It authorizes one bounded memory-routing and documentation-compaction pass; no compaction is performed here.

The earlier direct compaction attempt was blocked before edits because its PASS_ID and write surface were not named or authorized in the live route/scope docs. This scope lock resolves that routing prerequisite without changing runtime, tests, assets, product semantics, or the later Home correction.

Verified baseline:

- `HEAD` and `origin/main`: `a789bd09c61f85fde3a28fb1de5b768d8e00866a` (`docs: expand home redesign test integrity scope`)
- cached diff: empty
- no leftover documentation changes from the blocked attempt

## Frozen Home implementation diff

The existing unstaged Home implementation diff remains exactly:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

Binary diff hash: `7f4f129a9fbdbc6b22882a59dc25f8e271136d13`.

This file set and hash must remain unchanged during both this scope-lock pass and the compaction pass.

## Armed compaction

`TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS` is armed with the exact write allowlist and stop conditions in `docs/ACTIVE_SCOPE_LOCK.md`.

Its bounded outcome is:

1. make the default read path exactly `AGENTS.md`, `docs/POHIKIRI.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md`
2. make all stable memory, semantics, prompt/model, audit, source/design, map, spec, schema, and archive documents task-specific / non-default
3. compact active memory and duplicated governance text without deleting unique durable truth
4. correct only audit-index statuses supported by audit artifacts and git history
5. create no prompt-pattern or archive documents

## Preserved Home correction

Immediately after compaction, route to `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`.

The exact seven-file Home allowlist, hidden-production-anchor removal, visible-launcher integration-test workflow, and preserved ZIP/folder/sample/project-open/Workbench/exit/asset/route behavior remain locked in `docs/ACTIVE_SCOPE_LOCK.md`.

## Route

Current: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
Then: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Canonical pointers

- Active allowlists and stop conditions: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue sequencing: `docs/PASS_QUEUE.md`
- Audit provenance: `docs/AUDIT_INDEX.md`
- Product charter: `docs/POHIKIRI.md`
