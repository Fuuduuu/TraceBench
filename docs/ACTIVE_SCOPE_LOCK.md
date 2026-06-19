# Active Scope Lock

## Current pass

`TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS`

## Type

`CODEX / DOCS_HYGIENE`

## Lane

Docs-only governance-hygiene normalization for docs/audit route bookkeeping.

## Current goal

Normalize `docs/AUDIT_INDEX.md` semantics and route bookkeeping for docs-hygiene sequencing.

## Baseline

- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_POST_AUDIT_PASS` is accepted/pushed as `467d5fe` (`docs: record workbench rail button polish impl post-audit`).
- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` is accepted/pushed as `dbe9271` (`docs: lock tracebench docs hygiene scope`).
- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` returned routing to `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS`.
- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS` runtime behavior is accepted (`349b0e9`, `feat(board-canvas): convert workbench rail to panel-mode buttons`) with `renderer writes: none`.
- `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` is the requested target for this current docs-only normalization track.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md` (if future route parking is needed)
- `docs/audit/TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS.md`

## Current route lock

Current pass: `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS`
Next: `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS`

## Current scope summary

- This pass is docs-only and intentionally does not change runtime code, tests, tools, schemas, samples, generated artifacts, or `_incoming` assets.
- Pro-audit findings are recorded as future governance cleanup direction only:
  - `PASS_QUEUE` is currently overloaded as both active pass ledger and history.
  - `AUDIT_INDEX` needs normalization of historical/handoff indirections.
  - Core invariants are duplicated across governance docs and need consolidation.
  - `MODEL_ROUTING` and `PROMPTING_PROTOCOL` references should become more canonical/pointer-based.
  - Workbench 3-zone direction should be preserved as canonical architecture reference.
  - Future cleanup is split into narrow, sequenced docs-only passes.

## Baseline / baseline owner mapping

- `CURRENT_STATE.md` owns route/current pass state.
- `PASS_QUEUE.md` owns sequencing and recommendations.
- `ACTIVE_SCOPE_LOCK.md` owns the current active-docs lock.
- `AUDIT_INDEX.md` owns audit chain entries.
- `PROTECTED_SURFACES.md` owns protected-surface boundaries.
- `TRUTH_INDEX.md` owns truth/invariant table ownership.
- `MEMORY_PROTOCOL.md` owns intake/overwrite rules.
- `MODEL_ROUTING.md` and `PROMPTING_PROTOCOL.md` own helper/model and prompt routing ownership.
- `PROJECT_MEMORY.md` owns Workbench architectural diagram direction.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Scope carry-forward

- Board Canvas and all runtime behavior remains read-only.
- `renderer writes: none` remains present in accepted behavior context.
- No `_incoming/` assets are treated as accepted runtime behavior.
