# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only scope-lock is active. No runtime/test implementation is armed in this pass.

## Active sequence

| Order | PASS_ID | Purpose |
|---|---|---|
| 1 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS` | Lock product policy and boundaries for guarding invalid placement draft canonical bounds before writer call. |
| 2 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS` | Docs-only sync that must re-read live code and arm the exact implementation allowlist. |
| 3 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Future implementation only after active-lock sync, expected to add pre-save invalid-bounds UI guard and tests. |

## Scope summary

Manual visual smoke found that Add Component placement draft can reach `Salvesta` with canonical `board_normalized` values outside schema bounds, such as `width > 1` or center outside `0..1`. The validator correctly rejects those invalid payloads. This scope-lock keeps validator/schema strict and routes a future UI guard so invalid draft state is not presented as saveable and raw validator output is not the user-facing experience.

## Locked behavior

- Placement draft editing may remain UI-local and visually permissive.
- Canonical confirmation must be blocked unless payload is schema-valid.
- Invalid draft edits remain UI-local and write nothing.
- No automatic silent clamp is accepted in this scope-lock.
- Validator/schema constraints must not be weakened.
- Writer contract remains `component_visual_placement_confirmed` only.
- Rotation normalization remains unchanged.
- Projection-stale policy remains unchanged.
- Project Open From Directory behavior remains unchanged.

## Future implementation boundary

The next active-lock sync must inspect live code and arm exact files. Likely candidate surfaces are Board Canvas screen/tests and, only if live code requires, placement writer/unit tests. This pass does not arm implementation files.

Forbidden future surfaces unless separately scoped:

- event schema changes
- validator/tool/materializer changes
- `known_facts.json` behavior changes or direct Flutter mutation
- component identity creation
- pins, contacts, pads, nets, traces, electrical facts
- measurements
- AI-authored facts
- Project Open From Directory changes
- rotation normalization changes
- projection-stale policy changes
- Board Canvas redesign
- `_incoming` edits or staging

## Scope gate rules

- One narrow pass at a time.
- Do not implement without an active implementation lock.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.