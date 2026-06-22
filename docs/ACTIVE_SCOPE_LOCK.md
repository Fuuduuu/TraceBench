# Active Scope Lock

## Current pass

`V2_BENCHBEEP_DESIGN_DIRECTION_INTAKE_PASS`

## Type

CODEX / DOCS_DESIGN_INTAKE

## Goal

Record Claude design-direction recommendations as governed design intake only, without implementation or runtime acceptance.

## Baseline

- Latest accepted/pushed draft ghost semantic-color implementation: `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_PASS` at `772eb78` (`style: use draft semantic color for add component ghost`).
- Latest accepted/pushed draft ghost semantic-color closeout: `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_POST_AUDIT_PASS` at `1f30841` (`docs: record add component draft ghost semantic color`).
- Current route before this pass: `NEEDS_USER_DECISION`.

## Status labels to record

- `ROUTE_EFFECT: DESIGN_INTAKE_ONLY`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_A`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/V2_BENCHBEEP_DESIGN_DIRECTION_INTAKE_PASS.md`

## Design-intake record

- BenchBeep is the user-facing app/product name.
- TraceBench remains the repo/platform/project name.
- BoardFact is a data-fact/subsystem name, not the primary user-facing app name unless a specific surface earns it.
- Design direction is bench instrument identity, not generic SaaS.
- Direction favors dark instrument-like UI.
- Direction favors restrained panels/hairlines, not glassmorphism.
- Typography direction is IBM Plex Mono/Sans.
- Semantic color direction:
- teal/copper = selected/confirmed/save;
- amber = measuring/armed/measured;
- purple/unknown = draft/unsaved/unknown.

## Accepted recent application

- Add Component draft/ghost now uses purple/unknown-draft semantics rather than amber/measured semantics.

## Proposed future order

1. Token foundation / ThemeExtension scope-lock.
2. Home launcher / board-selection scope-lock.
3. Menu system scope-lock.

## Explicitly deferred

- Home implementation.
- Menu implementation.
- Command menu implementation.
- Audio/save beep.
- Full token migration.
- High-pin selector UX.
- Dual-primary restyling.
- Accessibility contrast polish.

## Preserve boundary

- This pass is docs-only design intake.
- No runtime files are edited.
- No test files are edited.
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

- Current pass: `V2_BENCHBEEP_DESIGN_DIRECTION_INTAKE_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
