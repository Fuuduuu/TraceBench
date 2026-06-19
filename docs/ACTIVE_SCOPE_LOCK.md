# Active Scope Lock

## Current pass

`TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`

## Type

`CODEX / DOCS_HYGIENE`

## Lane

Docs-only architecture-reference refresh for accepted Workbench model documentation.

## Current goal

Refresh the canonical Workbench architecture reference and keep route/provenance docs aligned to the accepted 3-zone read-only Workbench model with explicit read-only/future boundaries.

## Baseline

- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS` runtime behavior is accepted/pushed as `349b0e9` (`feat(board-canvas): convert workbench rail to panel-mode buttons`) with `renderer writes: none`.
- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_POST_AUDIT_PASS` is accepted/pushed as `467d5fe` (`docs: record workbench rail button polish impl post-audit`).
- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` is accepted/pushed as `dbe9271` (`docs: lock tracebench docs hygiene scope`).
- `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` is accepted/pushed as `7c12aa7` (`docs: normalize audit index route bookkeeping`).
- `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS` is accepted/pushed as `c70e23f` (`docs: archive completed pass-queue history`).
- `TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS` is accepted/pushed as `b60ae0c` (`docs: centralize core invariants owner in TRUTH_INDEX`).
- `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` is accepted/pushed as `a56721d` (`docs: centralize model-routing owner in MODEL_ROUTING`).
- `CURRENT_STATE_HISTORY_TRIM_PASS` is accepted/pushed as `4af4ac6` (`docs: trim current-state into operational handoff`).

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/CURRENT_STATE_HISTORY_TRIM_PASS.md`
- `docs/audit/TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS.md`
- `docs/PROJECT_MEMORY.md`

## Conditional scope

- `docs/PASS_QUEUE_ARCHIVE.md` only if a pointer/header must be corrected.
- `docs/WORK_INTAKE_INDEX.md` only if repo convention requires route parking.

Neither conditional file is expected for this pass.

## Current route lock

Current pass: `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`
Next: `NEEDS_USER_DECISION`

## Current scope summary

- This pass is docs-only and intentionally does not change runtime code, tests, tools, schemas, samples, generated artifacts, platform files, dependencies, or `_incoming` assets.
- Keep `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` aligned with the current accepted Workbench architecture reference and route state.
- Preserve the accepted Workbench / Board Canvas read-only runtime baseline.
- Preserve `docs/AUDIT_INDEX.md` as audit provenance and `docs/PASS_QUEUE_ARCHIVE.md` as completed queue history.
- Do not change product semantics, protected-surface semantics, model-routing semantics, prompt semantics, or canonical invariant meaning.
- Keep architecture reference ownership in `docs/PROJECT_MEMORY.md` aligned with this pass.

## Baseline / owner mapping

- `CURRENT_STATE.md` owns compact route/current-state handoff.
- `PASS_QUEUE.md` owns pass sequencing and next recommendation.
- `ACTIVE_SCOPE_LOCK.md` owns the current active-docs lock.
- `AUDIT_INDEX.md` owns audit chain entries.
- `PASS_QUEUE_ARCHIVE.md` owns completed historical queue rows.
- `TRUTH_INDEX.md` owns core invariant references.
- `MODEL_ROUTING.md` owns helper/model role definitions.
- `PROMPTING_PROTOCOL.md` owns prompt shape and contract-by-reference guidance.
- `PROJECT_MEMORY.md` owns stable product and architecture memory.
- `PROTECTED_SURFACES.md` owns protected-surface boundaries.
- `MEMORY_PROTOCOL.md` owns intake/overwrite rules.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Scope carry-forward

- Board Canvas and all runtime behavior remain read-only.
- `renderer writes: none` remains present in accepted behavior context.
- No inline Workbench value/unit/Save or write-flow integration is accepted by this pass.
- No `_incoming/` assets are treated as accepted runtime behavior.
- Codex writes scoped docs/code inside the active lock, Claude Code is the final repo-local audit gate before staging/commit/push unless repo convention explicitly says otherwise, and the user manually stages/commits/pushes with exact staging sets.
- No broad staging (`git add .` / `git add -A`) is allowed.
