# Active Scope Lock

## Current pass

`TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS`

## Type

`CODEX / DOCS_HYGIENE`

## Lane

Docs-only model-routing and prompting-role ownership refresh for reference-based helper/model guidance.

## Current goal

Confirm `docs/MODEL_ROUTING.md` as canonical helper/model role owner and keep prompt guidance in `docs/PROMPTING_PROTOCOL.md` reference-based without changing pass workflow.

## Baseline

- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_POST_AUDIT_PASS` is accepted/pushed as `467d5fe` (`docs: record workbench rail button polish impl post-audit`).
- `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` is accepted/pushed as `7c12aa7` (`docs: normalize audit index route bookkeeping`).
- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` is accepted/pushed as `dbe9271` (`docs: lock tracebench docs hygiene scope`).
- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` returned routing to `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS`.
- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS` runtime behavior is accepted (`349b0e9`, `feat(board-canvas): convert workbench rail to panel-mode buttons`) with `renderer writes: none`.
- `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS` is accepted/pushed as `c70e23f` (`docs: archive completed pass-queue history`).
- `TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS` is accepted/pushed as `b60ae0c` (`docs: centralize core invariants owner in TRUTH_INDEX`).
- `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` is the current docs-only model-routing ownership refresh track.

## Allowed governance scope

- `AGENTS.md`
- `docs/MODEL_ROUTING.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS.md`

## Current route lock

Current pass: `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS`
Next: `CURRENT_STATE_HISTORY_TRIM_PASS`

## Current scope summary

- This pass is docs-only and intentionally does not change runtime code, tests, tools, schemas, samples, generated artifacts, or `_incoming` assets.
- Confirm `docs/MODEL_ROUTING.md` as canonical helper/model role owner.
- Keep `docs/PROMPTING_PROTOCOL.md` focused on prompt shape and contract-by-reference guidance instead of duplicated role blocks.
- Keep `PASS_QUEUE`, routing, and lock docs focused to route and scope state, with only short route-safety reminders.
- Preserve `docs/AUDIT_INDEX.md` as audit history and `docs/PASS_QUEUE.md` as operational sequence.
- Preserve `renderer writes: none` as a current runtime acceptance invariant (no change).

## Baseline / baseline owner mapping

- `CURRENT_STATE.md` owns route/current pass state.
- `PASS_QUEUE.md` owns sequencing and recommendations.
- `ACTIVE_SCOPE_LOCK.md` owns the current active-docs lock.
- `AUDIT_INDEX.md` owns audit chain entries.
- `PROTECTED_SURFACES.md` owns protected-surface boundaries.
- `TRUTH_INDEX.md` owns truth/invariant table ownership.
- `MEMORY_PROTOCOL.md` owns intake/overwrite rules.
- `MODEL_ROUTING.md` owns helper/model role and route-gate ownership.
- `PROMPTING_PROTOCOL.md` owns prompt shape and contract-by-reference guidance.
- `PROJECT_MEMORY.md` owns Workbench architectural diagram direction.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Scope carry-forward

- Board Canvas and all runtime behavior remains read-only.
- `renderer writes: none` remains present in accepted behavior context.
- No `_incoming/` assets are treated as accepted runtime behavior.
- Codex writes scoped docs/code, Claude Code is the final repo-local audit gate before staging/commit/push unless repo convention explicitly says otherwise, and the user manually stages/commits/pushes with exact staging sets.
- No broad staging (`git add .` / `git add -A`) is allowed.
