# Current State

## Current pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Baseline HEAD verified for this active-lock sync: `62853c674790bb82469d65497a7b6e7d569e22ce` (`docs: record placement event V2 regime audit`).
- Accepted scope-lock commit: `df6a64329544e5966847ff9c8b56818046259885` (`docs: lock placement event V2 regime`).
- Scope-lock audit recorded: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.
- Route before this pass: current `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`, next `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- This pass arms the protected implementation allowlist for `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`.

## Implementation pass armed

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`

## Implementation goal

Migrate `component_visual_placement_confirmed` to the V2/human event regime and prevent materializer drop of V2 human-authored placement events.

## Implementation allowlist

- `schemas/events.schema.json`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `tests/test_validate_events_jsonl.py`
- `tests/test_materialize_known_facts.py`

## Implementation boundaries

- Event-regime/projection plumbing only.
- No placement writer service.
- No placement Confirm UI.
- No Board Canvas renderer behavior change.
- Visual contact layout remains separate future scope.
- AI never authors canonical placement events.
- `component_visual_placement_confirmed` must not represent electrical connectivity, net identity, measurement pin identity, confirmed contact layout, AI-authored fact, or visual contact/pad layout.

## Forbidden surfaces

- No Dart runtime edits.
- No Board Canvas UI edits.
- No Add Component writer edits.
- No placement writer service.
- No Confirm/Edit UI.
- No router edits.
- No visual contact layout.
- No AI marker implementation.
- No `_incoming` staging.
- No sample/project fixture edits unless separately approved.
- No `known_facts` schema change unless separately justified and stopped for human approval.

## Canonical owners and evidence ledgers

- Active/near-future route queue: docs/PASS_QUEUE.md.
- Current scope boundary: docs/ACTIVE_SCOPE_LOCK.md.
- Completed pass provenance: docs/AUDIT_INDEX.md and docs/audit/.
- Stable architecture memory: docs/PROJECT_MEMORY.md.
- Core invariants and protected truth: docs/TRUTH_INDEX.md.
- Board vector and footprint architecture: docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md.
- Protected boundaries: docs/PROTECTED_SURFACES.md.
- Prompt and audit rules: docs/PROMPTING_PROTOCOL.md, docs/AUDIT_CONTRACT.md, docs/MODEL_ROUTING.md, and docs/PASS_LIFECYCLE.md.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use git add ., git add -A, or git commit -am.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
- No runtime, Board Canvas UI, Add Component writer, placement writer service, Confirm/Edit UI, router, sample, asset, pubspec, Project ZIP, events.jsonl, known_facts.json schema, visual contact layout, or AI marker implementation changes are authorized by this active-lock sync.
