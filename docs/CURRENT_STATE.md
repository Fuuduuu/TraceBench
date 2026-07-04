# CURRENT_STATE

## Current pass
`PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS`

## Next recommended pass
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status
Docs-only scope-lock for placement-save projection stale/truthfulness behavior.

## Baseline
Latest closed pass:
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS`

Pushed closeout recorded:
`eea1353` (`docs: close out placement rotation normalization`)

Implementation recorded by that closeout:
`ca8d152a1b5105a576a2cb0d215628afb7dc9855` (`fix: normalize placement rotation before write`)

## Current scope summary
Lock a future implementation pass for truthful post-save state after Board Canvas placement `Salvesta` succeeds.

Live-code findings to preserve:
- `ProjectState.isProjectionStale` is the existing UI truth flag for stale projections.
- Add/Edit Component and measurement save flows append the returned event to in-memory `projectState.events` when missing and set `isProjectionStale: true`.
- Board Canvas placement save currently calls the placement writer and reports success, but the local project state is not updated to include the returned placement event and the projection-stale flag is not set by that flow.
- `known_facts.json` remains projection/cache and must not be mutated directly by Flutter UI.

## Boundary record
- This is docs-only; no runtime or test implementation is authorized yet.
- Future implementation must not mutate `known_facts.json` directly.
- Future implementation must not run materialization automatically from the placement save path unless separately scoped.
- Event type remains `component_visual_placement_confirmed`.
- No identity, pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions may be created by this future fix.
- Board Canvas renderer/painter remains read-only.
- The next active-lock sync must inspect live code and arm exact implementation files; no implementation allowlist is armed in this scope-lock pass.

## Binding workflow safety
- Never use `git add .`.
- Never use `git add -A`.
- Never use `git commit -am`.
- Stage exact files only when explicitly requested by the user.

## Canonical owners / evidence ledgers
- Current route: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Stable invariants: `docs/TRUTH_INDEX.md`
- Protected surfaces: `docs/PROTECTED_SURFACES.md`
- Audit provenance: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`
