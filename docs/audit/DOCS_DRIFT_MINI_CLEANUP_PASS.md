# DOCS_DRIFT_MINI_CLEANUP_PASS

## PASS_ID
`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only drift cleanup.

## Gate
- Branch confirmed: `main`.
- Remote confirmed: `origin https://github.com/Fuuduuu/TraceBench.git`.
- Working tree clean except known unrelated untracked paths (`.idea/`, `.metadata`, `assets/samples/pelle_pv20_minimal/metadata/`, `trace_bench_viewer.iml`, `windows/`).
- Current pass in docs sequencing is `DOCS_DRIFT_MINI_CLEANUP_PASS`.

## Scope cleanup summary
- Removed stale embedded active-pass duplication from `docs/SOURCES_INDEX_CURRENT.md` by replacing the “Current release/governance state” section with canonical doc pointers.
- Preserved compactness by pointing to:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md` + `docs/audit/*.md`
  - `docs/PROJECT_MEMORY.md`
  - `docs/PROTECTED_SURFACES.md`
  - `docs/PASS_LIFECYCLE.md`
  - `docs/ARCHITECTURE_BOUNDARIES.md`
  - `docs/MODEL_ROUTING.md`
- Re-aligned pass-routing docs for this cleanup:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
- Left other long-form historical specs and audit docs unchanged.

## Validation summary
- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`

## Boundary confirmation
- No implementation scope was modified.
- No `schemas/**`, `tools/**`, `lib/**`, `test/**`, artifacts, or runtime surfaces were changed.
- Canonical evidence boundaries remain unchanged:
  - `events.jsonl` is canonical event truth.
  - `known_facts.json` is the projection.
  - `board_graph.json` / `view_state.json` remain forbidden V1 artifacts.
- This pass did not alter behavior in any product surface.

## Routing decision
- Current pass outcome recorded as in-progress cleanup; next pass recommended:
  - `V1_1_POST_GOVERNANCE_CLEANUP_NEXT_ROUTE_REVIEW_PASS`
