# Current State

## Current pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed docs commit verified for this scope lock: `dd0024450deb674dbb55d7ec71103f366f02a313` (`docs: add TraceBench file map`).
- Route before this pass: `NEEDS_USER_DECISION`.
- FILE_MAP audit ledger sync in this pass records `TRACEBENCH_FILE_MAP_PASS` as accepted/pushed/audited with Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.

## Active scope summary

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS` is a docs-only protected-surface scope-lock.

The pass locks future `component_visual_placements` projection semantics before any placement writer, Confirm/Edit UI, edit-placement flow, visual-contact layout, or AI marker conversion is implemented.

Locked decisions:

- Legacy V1 placement events remain first-class legacy events.
- V1 and V2 placement confirmations must be interleaved deterministically by stream order, not by V1 `sequence` alone.
- A later valid placement event in `events.jsonl` supersedes an earlier placement for the same component.
- `event_invalidated` retracts the targeted placement event from `component_visual_placements` projection.
- Invalidating the newest placement falls back to the newest remaining valid placement, or removes projected placement if none remains.
- Placement correction remains append-only through newer `component_visual_placement_confirmed` events.
- No new placement-updated event type is introduced for this fix.

## Current accepted baseline

- V2 `component_visual_placement_confirmed` validator/materializer support is implemented.
- V2 placement events validate and materialize under `schema_version: 2.0-draft`, `actor.type: human`, `source.type: explicit_user_confirmation`, `confirmation.confirmed: true`, `client_operation_id`, and width + height as the primary visual envelope model.
- `schemas/events.schema.json` remains V1-envelope-only by design/current state.
- No Dart placement writer exists yet.
- No placement Confirm/Edit UI exists yet.
- Board Canvas remains read-only.
- Visual contact layout remains a separate future scope.
- AI never authors canonical placement events.

## Future implementation target

- Next route: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Later implementation target: projection/materializer only.
- Likely implementation allowlist:
  - `tools/materialize_known_facts.py`
  - `tests/test_materialize_known_facts.py`
- Optional validator/test owner only if a later implementation review proves validator behavior must change.

## Boundary confirmation

- No runtime Dart files are authorized by this scope-lock pass.
- No Board Canvas UI edits are authorized by this scope-lock pass.
- No placement writer or Confirm/Edit UI is authorized by this scope-lock pass.
- No schema, validator, known_facts schema, visual-contact layout, contacts/pads/legs rendering, AI marker implementation, sample/project fixture, or `_incoming` edits are authorized by this scope-lock pass.

## Canonical owners and evidence ledgers

- Active/near-future route queue: docs/PASS_QUEUE.md.
- Current scope boundary: docs/ACTIVE_SCOPE_LOCK.md.
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
- Protected implementation requires active-lock sync before code changes.
