# Current State

## Current pass

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed closeout verified: `ed45dbcf` (`docs: close out add component panel local draft controls`).
- Accepted writer/Confirm scope-lock: `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`.
- Active pass: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Next route: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`.

## Active scope summary

Docs-only active-lock sync for the protected placement writer and explicit Confirm/Salvesta implementation.

- Implementation pass armed: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`.
- Implementation allowlist:
  - `lib/features/components/services/v2_placement_writer.dart`
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/unit/v2_placement_writer_test.dart`
  - `test/widget/board_canvas_screen_test.dart`
- No runtime, test, writer, schema, tool, materializer, validator, router, event, known-facts, sample, or `_incoming` edits are made by this sync pass.

## Locked implementation direction

Future implementation may wire explicit human Confirm/Salvesta for visual placement only.

- Confirm requires explicit human action.
- Writer emits only `component_visual_placement_confirmed`.
- Writer uses V2/human envelope semantics and `client_operation_id` precedent.
- Placement payload remains visual envelope only: component, coordinate space, board side, center, rotation, width, height, optional template/source photo/notes.
- Placement write does not create component identity.
- Placement write does not create pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, visual contact layout, or repair conclusions.
- AI never authors canonical placement events.
- Board Canvas renderer/painter remains read-only; only the explicit UI Confirm path may call the writer in the next implementation pass.
- `Salvesta` may become wired only in `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`, not in this sync pass.

## Canonical owners and evidence ledgers

- Active/near-future route queue: `docs/PASS_QUEUE.md`.
- Current scope boundary: `docs/ACTIVE_SCOPE_LOCK.md`.
- Completed pass provenance: `docs/AUDIT_INDEX.md` and `docs/audit/`.
- Stable architecture memory: `docs/PROJECT_MEMORY.md`.
- Core invariants and protected truth: `docs/TRUTH_INDEX.md`.
- Board vector and footprint architecture: `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`.
- Protected boundaries: `docs/PROTECTED_SURFACES.md`.
- Documentation classification/read priority: `docs/FILE_MAP.md`.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use `git add .`, `git add -A`, or `git commit -am`.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
