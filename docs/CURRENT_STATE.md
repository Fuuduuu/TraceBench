# Current State

## Current pass

`PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_EDITOR_SHELL_IMPL_PASS`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed audit-record commit verified: `c4f7f5687360b76f9000a7b50f7d7733c08cc193` (`docs: record placement editor contract audit`).
- Pushed scope-lock commit verified: `0ebcf433608c9691440d43c8aa3d212c693454b4` (`docs: lock placement editor and writer contract`).
- Scope-lock audit recorded: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.
- Route before this sync: current `PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS`, next `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after this sync: current `PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`, next `PLACEMENT_EDITOR_SHELL_IMPL_PASS`.

## Implementation pass armed

`PLACEMENT_EDITOR_SHELL_IMPL_PASS` is armed for the first UI-local Board Canvas placement editor shell.

Implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal recorded

The future implementation pass may evolve the existing Board Canvas right-panel / Add Component ghost/draft area into a clearer placement editor shell, while keeping all state UI-local/in-memory and preserving read-only renderer/painter behavior.

Allowed future shell controls include:

- component context / selected component
- board side
- shape/template family
- center position / drag, if already represented locally
- `rotation_deg` UI-local draft control
- `width` + `height` UI-local draft control
- optional `template_id` / visual family reference
- optional notes if low-risk

Required shell behavior:

- clearly label draft state as unsaved/session-only
- provide Cancel/Reset/Discard behavior that writes nothing
- preserve existing read-only renderer/painter behavior
- keep all draft state in memory only

## Forbidden implementation surfaces recorded

The future implementation pass must not create a placement writer, add Confirm canonical write, call `event_writer_service.py`, write `component_visual_placement_confirmed`, edit `known_facts.json`, edit `events.jsonl`, edit schema/tool/materializer/validator files, implement visual contact layout, treat per-side contact counts as confirmed contacts/pads/pins/nets, implement edit-placement from confirmed projection beyond shell preparation, or implement AI marker conversion.

## Boundary confirmation

- This active-lock sync does not implement runtime behavior.
- No runtime/test files changed by this sync.
- No schema/tool/materializer/validator/writer files changed.
- No router/sample/project fixture files changed.
- No `_incoming` files changed or staged.
- No implementation happened in this sync.

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
- Next work is implementation inside the exact active allowlist only.
