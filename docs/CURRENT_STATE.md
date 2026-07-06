# CURRENT_STATE.md

Operational handoff for the active TraceBench / BenchBeep / BoardFact route.

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only product scope revision is active.

The pushed abort closeout `120808a` (`docs: close out aborted board canvas components actions implementation`) returned the route to `NEEDS_USER_DECISION` after the rejected navigation-only Komponendid actions implementation was reverted.

## Product decision being locked

Prior rejected direction:

- Board Canvas Komponendid hub actions such as "Ava loomine", "Ava muutmine", and "Ava mõõtmine".
- Navigation from Board Canvas to old standalone pages as the primary Komponendid UX.

Revised direction:

- Board Canvas is the primary technician-facing board/workbench surface.
- Komponendid work should happen beside/on the board canvas where practical.
- The Komponendid panel should evolve toward contextual in-panel workflows, not a navigation-only gateway.
- Old standalone Add/Edit/Measure pages may remain transitional/backstage routes for now.
- No route hiding, screen deletion, writer merge, or implementation is authorized by this pass.

## Canonical split to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Phased future direction

Likely first implementation slice, if separately armed later:

- Convert the current read-only Komponendid hub into an in-panel mode selector / contextual panel shell.
- Keep `Paiguta` as the first real in-panel action because the Board Canvas placement draft/prefill/save flow already exists.
- Keep `Uus komponent`, `Muuda andmeid`, and `Mõõda` as planned/future in-panel modes unless a later pass safely implements them.
- Avoid routing out to legacy standalone pages as the primary behavior.

Later slices may separately scope in-panel identity creation, metadata editing, measurement entry, backstage handling of old standalone routes, and test migration.

## Active implementation status

No implementation allowlist is armed by this pass. The next active-lock sync must inspect live code and arm exact files.

## Binding workflow safety

- Never use `git add .`.
- Never use `git add -A`.
- Never use `git commit -am`.
- Stage exact files only when the user explicitly asks for staging.

## Canonical owners / evidence ledgers

- Route state: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`.
- Stable architecture truth: `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`.
- Protected surfaces: `docs/PROTECTED_SURFACES.md`.
- Audit provenance: `docs/AUDIT_INDEX.md`, `docs/audit/*.md`.