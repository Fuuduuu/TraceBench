# V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS

## Lane and type

- Lane: `B`
- Type: `CODEX / DOCS_PROTECTED_PRODUCT_SURFACE_SCOPE_LOCK`
- Scope: docs-only protected product-surface scope-lock.

## Baseline

- Latest accepted/pushed pass: `V2_BENCHBEEP_HOME_LAUNCHER_IMPL_POST_AUDIT_PASS` at `e5407d2` (`docs: record BenchBeep home launcher`).
- BenchBeep Home launcher implementation is accepted/pushed as `6758cfd` (`feat: add BenchBeep home launcher`).
- App opens to the new BenchBeep Home launcher.
- Home is a board/workbench launcher, not a marketing page.
- `Open existing` works.
- `Import project` works through the existing allowed import/open-project flow.
- Back/home navigation returns to the new BenchBeep Home.
- `Start new` remains deferred.
- Logo polish remains deferred.

## Locked future work

Future work may only define a restrained BenchBeep menu-system direction:

- App-level menu affordances needed after Home launcher.
- Technical/instrument-style menu surfaces, not generic SaaS navigation.
- Preservation of Home launcher and Workbench navigation.
- Preservation of BenchBeep as the user-facing app/product name.
- Preservation of TraceBench as the repo/platform/project name.
- Preservation of BoardFact as a data-fact/subsystem name unless a specific UI surface earns it.
- App bar / breadcrumb refinement if already present or needed for launcher/workbench flow.
- Context / overflow menu patterns where already appropriate.
- Command menu / Ctrl-K palette only as a future pro workflow surface.
- Clear disabled/future affordances for menu items not yet implemented.

## Explicitly deferred

- Actual menu implementation.
- Command menu / Ctrl-K implementation.
- Context menu implementation.
- Audio/save beep.
- Canvas token consumer migration.
- Full app redesign.
- Logo polish.
- High-pin selector UX.
- Dual-primary restyling.
- New project creation.
- Any canonical board/write behavior.
- Placement write / Confirm-write / Edit Layout.
- Schema/writer/materializer/validator/projection/Project ZIP/event/fact changes.

## Boundary confirmation

- This pass does not implement any menu runtime behavior.
- This pass does not edit runtime or tests.
- Home launcher remains accepted and is not reworked by this pass.
- Menu system remains a product-surface/navigation concern only.
- Menu work must not create or alter canonical project, board, component, or placement data.
- Menu work must not introduce Project ZIP import/export semantics.
- `_incoming`, screenshots, docs/sources, and mockups remain design input only, never runtime truth.
- Future implementation must be narrow and may require an active-lock sync / runtime allowlist before code changes.
- This pass records no accepted/pushed hash for itself.
- Untracked scratch files remain untouched and unstaged.

## Route

- Current pass: `V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS`.
- Next route if accepted: `V2_BENCHBEEP_MENU_SYSTEM_IMPL_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_MENU_SYSTEM_SCOPE_LOCK_PASS.md`

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
