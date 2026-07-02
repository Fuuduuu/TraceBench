# Current State

## Current pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed scope-lock commit verified for this active-lock sync: `5cbf3b5174d062e716aa0c31d73420716fff7964` (`docs: lock placement projection ordering`).
- Route before this pass: current `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS`, next `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Scope-lock audit verified: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.

## Active-lock sync summary

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS` is a docs-only active-lock sync.

This pass arms the protected implementation allowlist for `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`.

Implementation allowlist:

- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`

## Implementation goal armed

Implement locked `component_visual_placements` projection semantics:

- Cross-regime latest-wins uses deterministic `events.jsonl` stream order, not V1 `sequence` alone.
- Later valid placement event supersedes earlier placement for the same component.
- V1 and V2 placement confirmations both remain first-class when valid.
- `event_invalidated` retracts targeted confirmed placement event from `component_visual_placements`.
- Invalidating older placement does not remove newer valid placement.
- Invalidating newest placement falls back to previous valid placement, or removes projection if none remains.

## Implementation test requirements armed

The implementation must add focused materializer tests proving:

- Later V2 placement beats earlier V1 placement for same component.
- Later V1 placement beats earlier V2 placement by stream order.
- `event_invalidated` retracts a targeted placement event.
- Invalidating an older placement does not remove a newer valid placement.
- Invalidating newest placement falls back to previous valid placement.
- Invalidating only placement removes projected placement.
- Contact/layout/electrical/net/pin/AI fields remain outside placement projection.

## Boundary confirmation

- No runtime Dart files are authorized by this sync.
- No Board Canvas UI edits are authorized by this sync.
- No placement writer or Confirm/Edit UI is authorized by this sync.
- No router, schema, validator, known_facts schema, visual-contact layout, contacts/pads/legs rendering, AI marker implementation, sample/project fixture, or `_incoming` edits are authorized by this sync.
- This sync does not implement the materializer behavior; it only arms the next implementation pass.

## Canonical owners and evidence ledgers

- Active/near-future route queue: docs/PASS_QUEUE.md.
- Current implementation allowlist: docs/ACTIVE_SCOPE_LOCK.md.
- Completed pass provenance: docs/AUDIT_INDEX.md and docs/audit/.
- Stable architecture memory: docs/PROJECT_MEMORY.md.
- Core invariants and protected truth: docs/TRUTH_INDEX.md.
- Board vector and footprint architecture: docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md.
- Protected boundaries: docs/PROTECTED_SURFACES.md.
- Documentation classification/read priority: docs/FILE_MAP.md.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use git add ., git add -A, or git commit -am.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
- Implementation must remain inside the armed allowlist unless a later pass expands scope.
