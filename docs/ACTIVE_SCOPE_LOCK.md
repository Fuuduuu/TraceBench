# Active Scope Lock

## Current pass

`V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_PROTECTED_SCOPE_LOCK

## Goal

Create a docs-only protected/foundational scope-lock for the future BenchBeep token foundation pass.

## Baseline

- Latest accepted/pushed design-direction source-index sync: `V2_BENCHBEEP_DESIGN_DIRECTION_SOURCE_INDEX_SYNC_PASS` at `79fa908` (`docs: sync BenchBeep design source index`).
- Current route before this pass: `V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS`.

## Status labels to record

- `ROUTE_EFFECT: PROTECTED_FOUNDATIONAL_SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS.md`

## Locked future work

- Future implementation may introduce a minimal Flutter token foundation for the accepted BenchBeep design direction.
- Future implementation may define app-level semantic visual tokens for surface/panel/rule colors.
- Future implementation may define app-level semantic visual tokens for text hierarchy colors.
- Token semantics are:
- teal/copper = selected/confirmed/save;
- amber = measuring/armed/measured;
- purple/unknown = draft/unsaved/unknown.
- Future implementation may prepare a small `ThemeExtension` or equivalent local token structure.
- Future implementation may replace clearly scoped hardcoded Workbench/Add Component canvas colors only if covered by the future implementation pass.
- Existing behavior must be preserved.

## Explicitly deferred

- Home launcher implementation.
- Menu system implementation.
- Command menu.
- Context menus.
- Audio/save beep.
- High-pin selector UX.
- Dual-primary visual restyling.
- Broad typography/font asset bundling unless separately scoped.
- Full app redesign.
- Any data/canonical/write behavior.

## Boundary

- This pass only locks the future token foundation scope.
- Design sources and `_incoming` remain design input only, never runtime.
- No runtime files are edited.
- No test files are edited.
- No untracked scratch files are touched or staged.
- No product behavior is changed.
- No ThemeExtension / token migration is implemented.
- No Home screen is implemented.
- No menu system or command menu is implemented.
- No audio/beep behavior is implemented.
- No event/fact/write/persistence.
- Token work must not alter canonical board data, events, facts, writer, schema, materializer, validator, projection, Project ZIP, placement records, Confirm/write, or Edit Layout.
- No canonical placement.
- No canonical coordinates.
- No `schema/writer/materializer/validator/projection/Project ZIP` changes.
- No Confirm/write.
- No Edit Layout.
- No Measure Sheet changes.
- No Project Overview deep-link.
- No committed placement.
- No moving existing confirmed placements.
- No snap/grid/magnet behavior.
- No rotation draft.
- No resize draft.
- No designator policy acceptance.
- No identity/package/electrical semantics.
- No `_incoming`, screenshots, docs/sources, mockups, or design artifacts are treated as runtime.

## Route

- Current pass: `V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS`
- Next route: `V2_BENCHBEEP_TOKEN_FOUNDATION_IMPL_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
