# Current State

## Current pass

`CURRENT_STATE_HISTORY_TRIM_PASS`

## Next recommended pass

`TRACEBENCH_WORKBENCH_ARCHITECTURE_DIAGRAM_REFRESH_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest accepted pushed pass: `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` at `a56721d` (`docs: centralize model-routing owner in MODEL_ROUTING`).
- Current pass purpose: trim this file back to an operational route handoff without deleting provenance history.

## Accepted docs-hygiene baseline

The current docs-hygiene sequence is accepted through:

- `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS` -> `dbe9271`
- `TRACEBENCH_AUDIT_INDEX_NORMALIZATION_PASS` -> `7c12aa7`
- `TRACEBENCH_PASS_QUEUE_ARCHIVE_PASS` -> `c70e23f`
- `TRACEBENCH_CORE_INVARIANTS_OWNER_REFRESH_PASS` -> `b60ae0c`
- `TRACEBENCH_MODEL_ROUTING_OWNER_REFRESH_PASS` -> `a56721d`

Completed route history is preserved in `docs/AUDIT_INDEX.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and `docs/audit/*.md`.

## Accepted runtime baseline

- Workbench remains a 3-zone UI with a dominant read-only Board Canvas center, left rail panel-mode buttons, and a right contextual panel.
- Latest Workbench rail-button runtime polish is accepted/pushed as `349b0e9` (`feat(board-canvas): convert workbench rail to panel-mode buttons`), with post-audit closeout accepted/pushed as `467d5fe`.
- Current accepted rail modes are `Inspector`, `Placements`, and `Safety`; `Focus canvas` / `Show controls` remain canvas-side controls.
- `Trace` and `Repair map` remain visible future tools but disabled/inert.
- Board Canvas remains read-only with board-normalized placements, selection/tap-to-select, read-only inspector, measurement summary/count metadata, visual-trace/photo-alignment metadata, pan/zoom/fit, compact chrome, and focus mode.
- `renderer writes: none` remains part of the accepted runtime context.

## Not accepted in this route

- No inline value/unit/Save or Workbench write-flow integration is accepted by this pass.
- No writer, materializer, validator, projection, schema, Project ZIP, fact/event, runtime, test, sample, generated, or `_incoming` behavior changes are in scope.
- `_incoming/ui_redesign/2026-06-14_workbench_home/` remains design-input-only and is not accepted runtime behavior.

## Canonical owners

- Core invariants: `docs/TRUTH_INDEX.md`
- Stable product truth and architecture memory: `docs/PROJECT_MEMORY.md`
- Helper/model role ownership: `docs/MODEL_ROUTING.md`
- Prompt shape and contract-by-reference guidance: `docs/PROMPTING_PROTOCOL.md`
- Current/next pass sequencing: `docs/PASS_QUEUE.md`
- Completed queue history: `docs/PASS_QUEUE_ARCHIVE.md`
- Active surface allowlist: `docs/ACTIVE_SCOPE_LOCK.md`
- Provenance and pass evidence: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`
- Memory/intake rules: `docs/MEMORY_PROTOCOL.md`
- Protected-surface boundaries: `docs/PROTECTED_SURFACES.md`

## Current scope

- This pass is docs-only and trims `docs/CURRENT_STATE.md` for operational handoff clarity.
- Allowed route docs are defined by `docs/ACTIVE_SCOPE_LOCK.md`.
- Keep history as pointers only here; do not duplicate pass-by-pass archaeology in this file.

## Validation baseline

- `git diff --check`
- `py -3 tools/validate_all.py`

## Pointers

- Current pass / next route: `docs/PASS_QUEUE.md`
- Active allowed/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Audit provenance: `docs/AUDIT_INDEX.md`
- Historical queue rows: `docs/PASS_QUEUE_ARCHIVE.md`
