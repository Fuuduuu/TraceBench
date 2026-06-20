# Active Scope Lock

## Current pass

`V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS`

## Type

`CODEX / DOCS_SCOPE_LOCK`

## Lane

Docs-only protected-projection scope lock for read-only Workbench measurement badge overlay direction.

## Current goal

Record and close out the independently post-audited measurement-overlay scope-lock pass, while keeping route/provenance docs aligned and preserving no-write runtime boundaries.

## Baseline

- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_POST_AUDIT_PASS` is accepted/pushed as `467d5fe` (`docs: record workbench rail button polish impl post-audit`).
- `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS` is accepted/pushed as `349b0e9` (`feat(board-canvas): convert workbench rail to panel-mode buttons`) and retains `renderer writes: none`.
- `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS` is accepted/pushed as `8544a4b` (`docs: lock workbench measurement overlay scope`) and retains projection-only overlay direction.
- `TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS` is accepted/pushed as `94a1143` (`docs: refresh workbench architecture reference`).
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
- `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS.md`

## Conditional scope

- `docs/PASS_QUEUE_ARCHIVE.md` only if a pointer/header must be corrected.
- `docs/WORK_INTAKE_INDEX.md` only if repo convention requires route parking.

Neither conditional file is expected for this pass.

## Current route lock

Current pass: `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS`
Next: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS`

## Current scope summary

- This pass is docs-only and intentionally does not change runtime code, tests, tools, schemas, samples, generated artifacts, platform files, dependencies, or `_incoming` assets.
- Keep `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` aligned with the projection-only overlay direction and route state.
- Preserve the accepted Workbench / Board Canvas read-only runtime baseline.
- Preserve `docs/AUDIT_INDEX.md` as audit provenance.
- No runtime, protected-surface, model-routing, prompt, or canonical invariant semantic changes.
- Keep runtime measurement overlay direction read-only by default with deterministic, projection-only behavior and explicit `multi_measurement` handling.
- Explicitly defer both inline value/unit entry and Add Component flows.
- Next implementation pass may touch only narrow runtime/test surfaces needed for read-only overlay rendering (if repo convention requires implementation allowlist planning); no protected surfaces are pre-authorized in this pass.

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
- No `events.jsonl`, `known_facts.json`, schema, materializer, validator, or writer service/project-ZIP changes.
- No Add Component work is accepted in this scope.
- No `_incoming/` assets are treated as accepted runtime behavior.
- Codex writes scoped docs/code inside the active lock, Claude Code is the final repo-local audit gate before staging/commit/push unless repo convention explicitly says otherwise, and the user manually stages/commits/pushes with exact staging sets.
- No broad staging (`git add .` / `git add -A`) is allowed.
