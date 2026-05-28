# BOARD_CANVAS_READONLY_INSPECTOR_SCOPE_LOCK_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only scope lock

## MODEL_ROUTING_CHECK

Result: PASS

Reason:

- Scope is governance/docs-only lock.
- No runtime renderer/UI/schema/tool/test/sample/asset/generated-data surfaces were touched.

## Scope drift check

Result: PASS

Checks:

1. Gate status/log checks passed and expected accepted commits are present.
2. Changed files stay within this pass allowlist.
3. Protected boundaries remain unchanged.
4. Next routing is implementation-safe:
   - lock first, then implementation.

## Locked inspector scope summary

- `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS` is recorded as accepted.
- Next implementation direction is locked to:
  - `BOARD_CANVAS_READONLY_INSPECTOR_PASS`.
- Inspector is locked as read-only details for already-rendered board-canvas placements/components only.
- Inspector data path is locked to typed app projection only:
  - `ProjectState.knownFacts`
  - `KnownFacts.componentVisualPlacements`
  - `KnownFacts.components`
  - `VectorFootprintLibrary` metadata
- Required renderer chrome remains:
  - `renderer writes: none`.

## Selection model decision

- First inspector implementation must avoid canvas hit-testing unless a later scope pass explicitly permits it.
- First inspector selection must use non-mutating UI controls only (for example list/row/control selection).
- Selection state is volatile/in-memory only.
- No persisted selection.
- No `view_state.json`.

## Deferred surfaces

- canvas hit-testing
- right-click/context menu behavior
- multi-select
- drag/resize/rotate handles
- visual_trace inspector
- measurement inspector beyond safe existing summary
- damage/suspect inspector
- background photo inspector
- AI proposal inspector and Top-3 candidate UI
- report/export inclusion

## Future implementation allowlist

- `lib/features/board_canvas/**`
- board-canvas widget tests for inspector behavior
- docs ledger files

If future implementation needs shared helper expansion outside `lib/features/board_canvas/**`, it must stop and request allowlist expansion first.

## Locked no-write/evidence boundaries

- no event-writer imports/usages
- no direct `events.jsonl`/Project ZIP reads
- no raw `known_facts.json` parsing
- no known-facts canonical mutation
- no file writes
- no `board_graph.json` / `view_state.json`
- no schema/tool/materializer/registry changes
- no identity inference from `template_id`
- no `visual_trace` to electrical-net promotion
- no AI proposal canonicalization

## Next recommended pass

`BOARD_CANVAS_READONLY_INSPECTOR_PASS`

## Validation commands

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
