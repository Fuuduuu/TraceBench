# V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS

## Lane and type

- Lane: protected docs scope-lock.
- Type: `CLAUDE_CODE / DOCS_SCOPE_LOCK`.
- Scope: docs-only route/scope-lock pass.

## Baseline git state

- Git HEAD at pass start: `2270e0c` (`docs: record measurement navigation consolidation`), aligned with `origin/main`.
- Tracked diff at pass start: none.
- Cached/staged diff at pass start: none.
- Known untracked scratch files/directories existed and were left untouched.
- Current route before this pass: `NEEDS_USER_DECISION`.
- No runtime/test implementation pass was armed.

## Accepted baseline carried forward

- `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` accepted/pushed at `4a7ac96` (`feat(board-canvas): consolidate measurement navigation`).
- `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS` accepted/pushed at `2270e0c` (`docs: record measurement navigation consolidation`).
- Standalone Measure Sheet route remains accepted.
- `/project/measure-sheet` direct/fallback compatibility remains accepted.
- Board Canvas Measure navigation remains navigation-only and preserves Board Canvas as the back destination.
- Existing Measure Sheet save behavior remains accepted and unchanged.

## Future protected workflow intent

- Board Canvas should stay visible as much as practical during measurement workflow.
- Measure should eventually open as a right-side contextual panel on Board Canvas, similar to Add Component.
- Component selection should use user-defined component names when available.
- Hover/focus should highlight the component on Canvas as UI preview/focus only.
- Selecting a component should show component and visual-trace preview context.
- Selecting a pin/leg may reveal value/unit/save inputs under the visual context only in a separately armed implementation pass.
- The technician-facing flow should stay measure-first: `Koht -> Väärtus -> Ühik -> Salvesta`.

## Protected risks

- Integrated measurement UI can cross from read-only Board Canvas behavior into write-flow behavior.
- Pin/leg selection can be mistaken for identity, pin mapping, coordinate, or net confirmation.
- Visual trace preview can be mistaken for electrical net evidence.
- Save inputs can drift into new writer/schema/materializer/projection/event/fact semantics.
- Canvas hover/focus can drift into canonical placement or coordinate semantics.

## Scope locked by this pass

This pass locks only future direction and boundaries.

It does not implement:

- integrated measurement panel runtime;
- Measure Sheet UI changes;
- Board Canvas runtime changes;
- save/write behavior;
- canonical event/fact writes;
- schema/writer/materializer/validator/projection changes;
- Project ZIP changes;
- AI/OCR/CV fact creation;
- placement/coordinate/net/electrical/package/identity semantics;
- Confirm/write/Edit Layout behavior;
- command menu/context menu/audio/save beep/full redesign/canvas token migration.

## Future implementation gate

Runtime implementation may begin only after a later docs-only active-lock sync is accepted/pushed.

Required next decision:

- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

That future active-lock sync must:

- name the implementation pass explicitly;
- list exact runtime/test files;
- keep implementation narrow;
- preserve standalone Measure Sheet and `/project/measure-sheet` compatibility unless a separate accepted route migration preserves compatibility;
- preserve existing Measure Sheet save behavior or explicitly bind to accepted writer/service boundaries;
- require manual smoke before Claude audit because the work is product/UI surface work;
- forbid new writer/schema/materializer/projection/event/fact semantics unless separately scoped.

## Required preservation for future implementation

- Existing standalone Measure Sheet route.
- `/project/measure-sheet` direct/fallback route compatibility.
- Existing accepted Measure Sheet save behavior.
- Board Canvas renderer read-only baseline except separately authorized local UI focus/preview state.
- Visual traces remain visual-only and never measured nets.
- Component hover/focus/selection remains UI state only and does not confirm identity, pin mapping, coordinates, nets, faults, packages, or electrical facts.
- BenchBeep Home launcher.
- `Open existing`.
- `Import project`.
- Back/Home to BenchBeep Home.
- Menu System behavior.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior.

## Work performed

- Updated `docs/CURRENT_STATE.md` to set this protected scope-lock as current and route next to the docs-only active-lock sync decision.
- Updated `docs/PASS_QUEUE.md` to list the protected scope-lock, next active-lock sync, and future implementation as not armed.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with this docs-only scope-lock and explicit runtime/write/protected-surface prohibitions.
- Updated `docs/AUDIT_INDEX.md` with this audit artifact pointer.
- Added this audit artifact.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS.md`

## Validation

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; PowerShell reported existing LF-to-CRLF checkout warnings for edited Markdown files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
