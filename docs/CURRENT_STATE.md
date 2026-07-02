# Current State

## Current pass

`PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Baseline route before this pass: `NEEDS_USER_DECISION`.
- Latest closeout commit verified for baseline: `05178a0be0523f780cf3b8c5a9157450fa40ad8c` (`docs: close out placement projection ordering`).
- Active scope: docs-only protected product/architecture scope-lock for placement editor and placement writer contract.
- Route after this scope-lock draft: current `PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS`, next `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Source context recorded

Accepted baseline decisions before implementation work:

- Add Component creates component identity/existence only through `component_created`.
- `component_created` must not carry position, rotation, size, board side, contacts, pins, nets, or visual layout.
- Board Canvas right-panel / ghost draft is the intended seed for the placement editor.
- Board Canvas renderer/painter remains read-only: `renderer writes: none`.
- Future placement Confirm must call a dedicated placement writer service.
- V2 `component_visual_placement_confirmed` validator/materializer support is implemented.
- Placement projection uses deterministic `events.jsonl` stream order across V1/V2.
- `event_invalidated` retracts targeted placement event from `component_visual_placements`.
- `width` + `height` is the primary confirmed visual envelope size model.
- Visual contact layout remains separate future scope.
- AI markers remain unconfirmed until human confirmation.
- AI never authors canonical placement events.
- `_incoming/ui_redesign` inventory is complete; do not deep-read it by default.

## Scope-lock summary

`PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS` locks the product and architecture contract before Board Canvas placement editor UI, placement writer service, Confirm placement action, edit-placement flow, visual-contact layout, or AI-marker conversion is implemented.

Locked direction:

- First implementation slice is Board Canvas placement editor shell only.
- Placement editor draft state is UI-local/in-memory until explicit Confirm.
- Open, drag, rotate, resize, shape/template change, side change, cancel, discard, and leaving the editor must not write canonical events.
- Future Confirm emits exactly one V2 `component_visual_placement_confirmed` event through a dedicated writer service.
- Placement writer and renderer remain separate; renderer/painter code does not write.
- Contact counts may exist only as UI-local visual draft controls until a separate visual-contact layout scope.
- Confirmed visual placement remains visual/documentation envelope data only, not connectivity, net, pin, pad, contact, measurement, AI fact, or repair evidence.

## Implementation sequence locked

1. `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `PLACEMENT_EDITOR_SHELL_IMPL_PASS`
3. `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`
4. Future active-lock + implementation for the dedicated writer/Confirm path.
5. `EDIT_PLACEMENT_FLOW_SCOPE_LOCK_PASS`
6. Future visual-contact layout and AI-marker conversion scopes only after explicit user decisions.

## Boundary confirmation

- No runtime files changed by this scope-lock.
- No test files changed.
- No schema/tool/materializer/validator/writer implementation changed.
- No placement writer exists yet.
- No Confirm/Edit UI exists yet.
- No visual contact layout exists yet.
- No AI marker conversion is implemented.
- No `_incoming` dependency is introduced.
- Board Canvas remains read-only until a future implementation pass explicitly scopes otherwise.
- Component identity and visual placement confirmation remain separate actions.

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
- Next implementation work requires accepted audit and active-lock sync.
