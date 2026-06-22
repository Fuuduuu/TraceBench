# Active Scope Lock

## Current pass

`V2_BENCHBEEP_DESIGN_DIRECTION_SOURCE_INDEX_SYNC_PASS`

## Type

CODEX / DOCS_SYNC

## Goal

Adopt the existing `docs/SOURCES_INDEX_CURRENT.md` design-direction carryover into a tiny forward-only docs sync pass before rerunning the token-foundation scope-lock.

## Baseline

- Latest accepted/pushed design-direction intake: `V2_BENCHBEEP_DESIGN_DIRECTION_INTAKE_PASS` at `369eb77` (`docs: record BenchBeep design direction intake`).
- Existing tracked carryover: `docs/SOURCES_INDEX_CURRENT.md` records the BenchBeep design-direction intake in the source/design index.
- Current route before this pass: `NEEDS_USER_DECISION`.

## Status labels to record

- `ROUTE_EFFECT: SOURCE_INDEX_SYNC`
- `ROUTE_EFFECT_NEXT: V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS`
- `LANE_A`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/V2_BENCHBEEP_DESIGN_DIRECTION_SOURCE_INDEX_SYNC_PASS.md`

## Source-index sync record

- `docs/SOURCES_INDEX_CURRENT.md` design-direction update is intentional for this sync pass.
- It records BenchBeep as the user-facing app/product name.
- It records TraceBench as the repo/platform/project name.
- It records BoardFact as a data-fact/subsystem name.
- It records bench-instrument design direction and semantic colors.
- It records accepted Add Component draft ghost purple/unknown-draft application.
- It records future order: token foundation -> Home launcher -> menus.
- It records `_incoming` / docs/sources as design input only, not runtime truth.

## Boundary

- This pass is docs-only source-index sync.
- No runtime files are edited.
- No test files are edited.
- No untracked scratch files are touched or staged.
- No product behavior is changed.
- No ThemeExtension / token migration is implemented.
- No Home screen is implemented.
- No menu system or command menu is implemented.
- No audio/beep behavior is implemented.
- No event/fact/write/persistence.
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

- Current pass: `V2_BENCHBEEP_DESIGN_DIRECTION_SOURCE_INDEX_SYNC_PASS`
- Next route: `V2_BENCHBEEP_TOKEN_FOUNDATION_SCOPE_LOCK_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
