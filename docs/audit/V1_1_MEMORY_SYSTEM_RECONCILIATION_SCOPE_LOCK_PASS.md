# V1_1_MEMORY_SYSTEM_RECONCILIATION_SCOPE_LOCK_PASS

PASS_ID: `V1_1_MEMORY_SYSTEM_RECONCILIATION_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC / SCOPE_LOCK`
Mode: Docs-only scope lock. No code/test/tool/schema/materializer/sample/asset/tag changes.

## Inputs accepted

- Claude memory-consolidation audit (audit-only) found the docs-based governance memory is well-architected and link-clean (no dangling references), but has meta-level drift.
- `V1_1_CURRENT_STATE_COMPACTION_PASS` is accepted/pushed and already resolved the CURRENT_STATE bloat (205 → 86 lines), preserving hard boundaries and pruning no audit history. The previously-queued `V1_1_POST_CURRENT_STATE_COMPACTION_ROUTE_REVIEW_PASS` is superseded by the memory audit, which served as the deeper review and produced findings F1–F6.

## Accepted findings to reconcile

- **F1** — `MEMORY_MAINTENANCE.md` drift countdown / self-maintenance loop is broken: it says the countdown should decrement after accepted passes and trigger cleanup at 0, but it stayed at `5` across ~10+ accepted passes (the trigger never fired; this is why CURRENT_STATE bloated).
- **F2** — divergent read-order lists: `MEMORY_PROTOCOL.md §5` first-read path vs `SOURCES_INDEX_CURRENT.md` "AI read order" differ in first file and members.
- **F3** — duplicate conflict-order lists: `MEMORY_REGISTRY.yml` (7 entries) vs `SOURCES_INDEX_CURRENT.md` (9 entries).
- **F4** — stale pointer: `MEMORY_MAINTENANCE.md` names `DOCS_DRIFT_MINI_CLEANUP_04_PASS` as latest; actual latest is `_13` (`_02`–`_13` exist).
- **F5** — `MEMORY_REGISTRY.yml` omits core docs `CURRENT_STATE.md`, `TRUTH_INDEX.md`, `MEMORY_PROTOCOL.md`.
- **F6** — `PROJECT_STATE.yml` is a stale, explicitly non-canonical snapshot (`current_pass` ~20 passes behind, `repo: unknown`).

## Decision

- Lock `V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS` as the next implementation pass.
- Scope is **docs-only** reconciliation of governance/memory meta-docs. No product/evidence/schema/tool change.

## Locked decision boundaries (F1–F6)

- **F2 — read order:** canonical owner is **`MEMORY_PROTOCOL.md` §5** (first-read path). `SOURCES_INDEX_CURRENT.md` "AI read order" becomes a **pointer** to it (no duplicated list payload). Reconcile any content difference into the single owner.
- **F3 — conflict order:** canonical owner is **`MEMORY_REGISTRY.yml` `conflict_order`**. `SOURCES_INDEX_CURRENT.md` "Conflict order" becomes a **pointer** to it (no duplicated list payload). The owner keeps the complete ordering (incl. `docs/audit/*.md` and `docs/archive/**`).
- **F5 — registry completeness:** add `CURRENT_STATE.md`, `TRUTH_INDEX.md`, and `MEMORY_PROTOCOL.md` to the appropriate `MEMORY_REGISTRY.yml` layers (e.g., active handoff / source_index), or document a deliberate omission inline. CURRENT_STATE must appear because it is the #1 first-read file.
- **F4 — stale pointer:** replace the `DOCS_DRIFT_MINI_CLEANUP_04_PASS` reference in `MEMORY_MAINTENANCE.md` with a **non-stale pointer pattern** (point to "latest `DOCS_DRIFT_MINI_CLEANUP_NN` in `AUDIT_INDEX.md`" rather than a hard-coded number).
- **F1 — maintenance trigger:** **LOCKED = Option B (line-count / bounded-handoff trigger).** Replace the per-pass decrement-countdown discipline (which failed precisely because it relied on manual bookkeeping nobody performed) with a **self-evident, verifiable** rule: *compact `CURRENT_STATE.md` when it exceeds ~120 lines*, checkable at every route review and closeout via `wc -l docs/CURRENT_STATE.md`. `MEMORY_MAINTENANCE.md` is updated to define this as the canonical trigger; the legacy "Docs drift countdown" field in `CURRENT_STATE.md`/`PASS_QUEUE.md` is redefined as **deprecated/superseded** by the line-count trigger (the impl pass may keep the field as a labeled-deprecated marker or remove it, but must not reintroduce a manually-decremented counter as the canonical mechanism). Rationale: a check anyone can run beats a counter everyone forgets.
- **F6 — `PROJECT_STATE.yml`:** **LOCKED = explicitly deprecate/deprioritize** as a non-maintained, non-canonical snapshot. Add a docs-only header annotation stating it is not maintained per-pass and that live state lives in `CURRENT_STATE.md` (handoff) + `PASS_QUEUE.md` (routing). Optional, non-required: a one-time regeneration via the existing `tools/validate_project_state.py` is permitted **only if it does not modify the tool**. Do not invent a new state system; do not delete history.

## Preserved core governance (unchanged ownership)

- `CURRENT_STATE.md` remains the live handoff.
- `PASS_QUEUE.md` remains the route/sequencing queue owner.
- `ACTIVE_SCOPE_LOCK.md` remains the current allowed/forbidden scope owner.
- `AUDIT_INDEX.md` remains the audit ledger.
- `docs/audit/**` remains append-only evidence history (no pruning).
- `PROJECT_MEMORY.md` / `TRUTH_INDEX.md` / `PROTECTED_SURFACES.md` ownership semantics are unchanged.

## Allowed implementation files (next pass)

- `docs/MEMORY_PROTOCOL.md`
- `docs/MEMORY_REGISTRY.yml`
- `docs/MEMORY_MAINTENANCE.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/PROJECT_STATE.yml` (only for the F6 deprecation annotation / optional regeneration)
- `docs/CURRENT_STATE.md` (only a small pointer / current-pass / countdown-label update)
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS.md`

## Forbidden surfaces (next pass)

- No code/test/tool/schema/materializer/sample/asset/generated-artifact/tag/release changes (tools execution for optional `PROJECT_STATE.yml` regeneration must not modify the tool).
- No audit-history pruning.
- No broad docs rewrite (bounded reconciliation only).
- No product/evidence-semantics changes; no hard-boundary meaning changes.
- No `board_graph.json` / `view_state.json`.
- No V2 / commercial / licensing work.

## Required validation (next pass)

- `git status --short --branch`; `git diff --name-only` (docs-only).
- `py -3 tools\validate_all.py` (PASS).
- Verify no broken links for referenced docs.
- Verify no duplicate read-order / conflict-order payload remains (single owner each; others are pointers).
- Verify current/next route alignment across `CURRENT_STATE.md` / `PASS_QUEUE.md` / `ACTIVE_SCOPE_LOCK.md`.
- Verify no audit history was pruned.

## Validation (this scope-lock pass)

- `git status --short --branch`
- `git diff --name-only`
- `py -3 tools\validate_all.py`

## Next recommended pass

`V1_1_MEMORY_SYSTEM_RECONCILIATION_PASS` (DOCS_SYNC; Codex implements the locked reconciliation after this lock is accepted/pushed; Claude Code review for ownership/link integrity).
