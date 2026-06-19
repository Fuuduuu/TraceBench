# Current State

## Current pass

`TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest accepted docs-hygiene baseline pass: `CURRENT_STATE_HISTORY_TRIM_PASS` at `4af4ac6` (`docs: trim current-state into operational handoff`).
- Current pass purpose: refresh canonical Workbench architecture reference and runtime summary artifacts without code/test/tool/schema/sample/runtime changes.

## Accepted docs-hygiene baseline

The current docs-hygiene sequence is accepted through:

- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` → `dbe9271` (`docs: lock tracebench docs hygiene scope`)
- `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` → `7c12aa7` (`docs: normalize audit index route bookkeeping`)
- `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS` → `c70e23f` (`docs: archive completed pass-queue history`)
- `TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS` → `b60ae0c` (`docs: centralize core invariants owner in TRUTH_INDEX`)
- `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` → `a56721d` (`docs: centralize model-routing owner in MODEL_ROUTING`)
- `CURRENT_STATE_HISTORY_TRIM_PASS` → `4af4ac6` (`docs: trim current-state into operational handoff`)

## Accepted runtime baseline

- Workbench remains a 3-zone UI:
  - Left rail
  - Dominant read-only Board Canvas center
  - Right contextual panel
- Left rail is panel-mode: `Inspector`, `Placements`, `Safety`, with `Trace` and `Repair map` visible but disabled/inert.
- Focus action remains a canvas-corner action (`Focus canvas` / control recovery path) with fit/recenter/zoom as canvas-side controls.
- `Placements` and `Safety` switch read-only contextual panel modes.
- Component selection updates the Inspector/read-only panel mode.
- Empty-canvas tap may only clear local UI selection/panel state.
- Board Canvas renderer is read-only, with `renderer writes: none`.
- `Known-facts`/legacy visual evidence and metadata remains read-only as currently scoped.

## Not accepted in this route

- No inline value/unit/Save write-flow is accepted in this route.
- No runtime/model/runtime, writer/materializer/validator, schema, tests, tools, sample, generated, platform, or `_incoming` behavior changes.
- `renderer writes: none` remains.

## Canonical owners

- Core invariants: `docs/TRUTH_INDEX.md`
- Stable product truth and architecture memory: `docs/PROJECT_MEMORY.md`
- Stable Workbench architecture reference for this pass: `docs/PROJECT_MEMORY.md` (new section added here)
- Helper/model role ownership: `docs/MODEL_ROUTING.md`
- Prompt shape and contract-by-reference guidance: `docs/PROMPTING_PROTOCOL.md`
- Current/next pass sequencing: `docs/PASS_QUEUE.md`
- Completed queue history: `docs/PASS_QUEUE_ARCHIVE.md`
- Active surface allowlist: `docs/ACTIVE_SCOPE_LOCK.md`
- Provenance and pass evidence: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`
- Memory/intake rules: `docs/MEMORY_PROTOCOL.md`
- Protected-surface boundaries: `docs/PROTECTED_SURFACES.md`

## Current scope

- This pass is docs-only and only refreshes the canonical Workbench architecture reference in memory docs plus route/provenance lock files.
- Allowed route docs are defined in `docs/ACTIVE_SCOPE_LOCK.md`.

## Validation baseline

- `git diff --check`
- `py -3 tools/validate_all.py`

## Pointers

- Current pass / next route: `docs/PASS_QUEUE.md`
- Active allowed/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Audit provenance: `docs/AUDIT_INDEX.md`
